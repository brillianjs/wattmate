import 'data_models.dart';

class DummyData {
  // Boarding House Info
  static final boardingHouse = BoardingHouse(
    name: 'Kos Melati Residence',
    owner: 'Budi Santoso',
    location: 'Yogyakarta',
    totalRooms: 30,
    occupiedRooms: 26,
    availableRooms: 4,
  );

  // Dashboard Stats
  static final dashboardStats = DashboardStats(
    monthlyTransactionTotal: 8750000,
    monthlyTransactions: 124,
    mostActiveRoom: 'Room 103',
    highestUsageRoom: 'Room 103',
  );

  // Rooms
  static final rooms = [
    Room(
      roomNumber: '101',
      tenant: Tenant(
        name: 'Andi Pratama',
        phone: '081234567890',
        email: 'andi.pratama@email.com',
      ),
      meterID: '12345678901',
      tokenBalance: 35,
      estimatedDaysRemaining: 5,
      status: RoomStatus.warning,
      isOccupied: true,
    ),
    Room(
      roomNumber: '102',
      tenant: Tenant(
        name: 'Siti Rahma',
        phone: '082345678901',
        email: 'siti.rahma@email.com',
      ),
      meterID: '12345678902',
      tokenBalance: 85,
      estimatedDaysRemaining: 14,
      status: RoomStatus.active,
      isOccupied: true,
    ),
    Room(
      roomNumber: '103',
      tenant: Tenant(
        name: 'Raka Wijaya',
        phone: '083456789012',
        email: 'raka.wijaya@email.com',
      ),
      meterID: '12345678903',
      tokenBalance: 10,
      estimatedDaysRemaining: 1,
      status: RoomStatus.critical,
      isOccupied: true,
    ),
    Room(
      roomNumber: '104',
      tenant: Tenant(
        name: 'Dewi Kartika',
        phone: '084567890123',
        email: 'dewi.kartika@email.com',
      ),
      meterID: '12345678904',
      tokenBalance: 120,
      estimatedDaysRemaining: 20,
      status: RoomStatus.active,
      isOccupied: true,
    ),
    Room(
      roomNumber: '105',
      tenant: Tenant(
        name: 'Bima Sakti',
        phone: '085678901234',
        email: 'bima.sakti@email.com',
      ),
      meterID: '12345678905',
      tokenBalance: 45,
      estimatedDaysRemaining: 7,
      status: RoomStatus.active,
      isOccupied: true,
    ),
    Room(
      roomNumber: '106',
      isOccupied: false,
      tokenBalance: 0,
      estimatedDaysRemaining: 0,
      status: RoomStatus.inactive,
    ),
    Room(
      roomNumber: '107',
      tenant: Tenant(
        name: 'Lina Marlina',
        phone: '086789012345',
        email: 'lina.marlina@email.com',
      ),
      meterID: '12345678907',
      tokenBalance: 25,
      estimatedDaysRemaining: 3,
      status: RoomStatus.warning,
      isOccupied: true,
    ),
    Room(
      roomNumber: '108',
      tenant: Tenant(
        name: 'Ahmad Fauzi',
        phone: '087890123456',
        email: 'ahmad.fauzi@email.com',
      ),
      meterID: '12345678908',
      tokenBalance: 95,
      estimatedDaysRemaining: 16,
      status: RoomStatus.active,
      isOccupied: true,
    ),
  ];

  // Transactions
  static final transactions = [
    Transaction(
      id: 'TRX001',
      tenantName: 'Andi Pratama',
      roomNumber: '101',
      amount: 100000,
      status: TransactionStatus.paid,
      date: DateTime(2026, 6, 23),
      tokenCode: '1234-5678-9012-3456',
    ),
    Transaction(
      id: 'TRX002',
      tenantName: 'Siti Rahma',
      roomNumber: '102',
      amount: 50000,
      status: TransactionStatus.paid,
      date: DateTime(2026, 6, 20),
      tokenCode: '2345-6789-0123-4567',
    ),
    Transaction(
      id: 'TRX003',
      tenantName: 'Raka Wijaya',
      roomNumber: '103',
      amount: 100000,
      status: TransactionStatus.pending,
      date: DateTime(2026, 6, 23),
      tokenCode: '',
    ),
    Transaction(
      id: 'TRX004',
      tenantName: 'Dewi Kartika',
      roomNumber: '104',
      amount: 150000,
      status: TransactionStatus.paid,
      date: DateTime(2026, 6, 22),
      tokenCode: '3456-7890-1234-5678',
    ),
    Transaction(
      id: 'TRX005',
      tenantName: 'Bima Sakti',
      roomNumber: '105',
      amount: 75000,
      status: TransactionStatus.paid,
      date: DateTime(2026, 6, 21),
      tokenCode: '4567-8901-2345-6789',
    ),
    Transaction(
      id: 'TRX006',
      tenantName: 'Lina Marlina',
      roomNumber: '107',
      amount: 50000,
      status: TransactionStatus.paid,
      date: DateTime(2026, 6, 19),
      tokenCode: '5678-9012-3456-7890',
    ),
    Transaction(
      id: 'TRX007',
      tenantName: 'Ahmad Fauzi',
      roomNumber: '108',
      amount: 100000,
      status: TransactionStatus.paid,
      date: DateTime(2026, 6, 18),
      tokenCode: '6789-0123-4567-8901',
    ),
  ];

  // WhatsApp Templates
  static final whatsappTemplates = [
    WhatsAppTemplate(
      id: 'TPL001',
      name: 'Token Reminder',
      message:
          'Halo {name}, token listrik Anda diperk akan habis dalam {days} hari. Sisa {kwh} kWh. Apakah Anda ingin membeli token baru?',
      isActive: true,
    ),
    WhatsAppTemplate(
      id: 'TPL002',
      name: 'Token Critical',
      message:
          'URGENT! Halo {name}, token listrik Anda tinggal {kwh} kWh. Segera isi ulang untuk menghindari pemadaman.',
      isActive: true,
    ),
    WhatsAppTemplate(
      id: 'TPL003',
      name: 'Payment Confirmation',
      message:
          'Terima kasih {name}! Pembayaran token Rp{amount} telah diterima. Kode token: {code}',
      isActive: true,
    ),
  ];

  // Monthly Transaction Data (for chart)
  static final monthlyTransactionData = [
    {'month': 'Jan', 'amount': 7200000.0},
    {'month': 'Feb', 'amount': 7800000.0},
    {'month': 'Mar', 'amount': 8100000.0},
    {'month': 'Apr', 'amount': 8500000.0},
    {'month': 'May', 'amount': 8200000.0},
    {'month': 'Jun', 'amount': 8750000.0},
  ];

  // Daily Usage Data (for chart)
  static final dailyUsage = [
    {'day': 'Sen', 'kwh': 245.0},
    {'day': 'Sel', 'kwh': 280.0},
    {'day': 'Rab', 'kwh': 265.0},
    {'day': 'Kam', 'kwh': 290.0},
    {'day': 'Jum', 'kwh': 310.0},
    {'day': 'Sab', 'kwh': 275.0},
    {'day': 'Min', 'kwh': 250.0},
  ];
}
