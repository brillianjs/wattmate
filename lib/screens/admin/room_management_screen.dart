import 'package:flutter/material.dart';
import '../../models/dummy_data.dart';
import '../../models/data_models.dart';
import 'room_detail_screen.dart';

class RoomManagementScreen extends StatefulWidget {
  const RoomManagementScreen({super.key});

  @override
  State<RoomManagementScreen> createState() => _RoomManagementScreenState();
}

class _RoomManagementScreenState extends State<RoomManagementScreen> {
  String _selectedFilter = 'all';
  String _searchQuery = '';

  List<Room> get filteredRooms {
    var rooms = DummyData.rooms;

    // Apply status filter
    if (_selectedFilter != 'all') {
      final filterStatus = _selectedFilter == 'active'
          ? RoomStatus.active
          : _selectedFilter == 'warning'
          ? RoomStatus.warning
          : _selectedFilter == 'critical'
          ? RoomStatus.critical
          : RoomStatus.inactive;
      rooms = rooms.where((r) => r.status == filterStatus).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      rooms = rooms.where((r) {
        final roomNum = r.roomNumber.toLowerCase();
        final tenantName = r.tenant?.name.toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();
        return roomNum.contains(query) || tenantName.contains(query);
      }).toList();
    }

    return rooms;
  }

  @override
  Widget build(BuildContext context) {
    final rooms = filteredRooms;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009688),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Manajemen Kamar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Search and Filter
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF009688),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Cari kamar atau penghuni...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Semua', 'all'),
                      _buildFilterChip('Aktif', 'active'),
                      _buildFilterChip('Peringatan', 'warning'),
                      _buildFilterChip('Kritis', 'critical'),
                      _buildFilterChip('Kosong', 'inactive'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Room List
          Expanded(
            child: rooms.isEmpty
                ? const Center(child: Text('Tidak ada kamar yang ditemukan'))
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      return _buildRoomCard(rooms[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => setState(() => _selectedFilter = value),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.white,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected)
                const Padding(
                  padding: EdgeInsets.only(right: 6),
                  child: Icon(Icons.check, size: 16, color: Color(0xFF009688)),
                ),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF009688) : Colors.white,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomCard(Room room) {
    Color statusColor;
    String statusText;

    switch (room.status) {
      case RoomStatus.active:
        statusColor = Colors.green;
        statusText = 'Aktif';
        break;
      case RoomStatus.warning:
        statusColor = Colors.orange;
        statusText = 'Peringatan';
        break;
      case RoomStatus.critical:
        statusColor = Colors.red;
        statusText = 'Kritis';
        break;
      case RoomStatus.inactive:
        statusColor = Colors.grey;
        statusText = 'Kosong';
        break;
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RoomDetailScreen(room: room)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Room Number Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF009688).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    room.roomNumber,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF009688),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: statusColor.withOpacity(0.3)),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.chevron_right, color: Colors.grey[400]),
              ],
            ),

            if (room.isOccupied) ...[
              const Divider(height: 24),
              Row(
                children: [
                  const Icon(Icons.person, size: 20, color: Color(0xFF64748B)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      room.tenant!.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildInfoItem(
                      Icons.bolt,
                      '${room.tokenBalance} kWh',
                    ),
                  ),
                  Expanded(
                    child: _buildInfoItem(
                      Icons.timer,
                      '${room.estimatedDaysRemaining} hari',
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFF64748B)),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
        ),
      ],
    );
  }
}
