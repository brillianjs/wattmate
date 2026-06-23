// Data models for WattMate application

class BoardingHouse {
  final String name;
  final String owner;
  final String location;
  final int totalRooms;
  final int occupiedRooms;
  final int availableRooms;

  BoardingHouse({
    required this.name,
    required this.owner,
    required this.location,
    required this.totalRooms,
    required this.occupiedRooms,
    required this.availableRooms,
  });
}

class Tenant {
  final String name;
  final String phone;
  final String email;

  Tenant({required this.name, required this.phone, required this.email});
}

class Room {
  final String roomNumber;
  final Tenant? tenant;
  final String? meterID;
  final double tokenBalance;
  final int estimatedDaysRemaining;
  final RoomStatus status;
  final bool isOccupied;

  Room({
    required this.roomNumber,
    this.tenant,
    this.meterID,
    required this.tokenBalance,
    required this.estimatedDaysRemaining,
    required this.status,
    required this.isOccupied,
  });
}

enum RoomStatus { active, warning, critical, inactive }

class Transaction {
  final String id;
  final String tenantName;
  final String roomNumber;
  final double amount;
  final TransactionStatus status;
  final DateTime date;
  final String tokenCode;

  Transaction({
    required this.id,
    required this.tenantName,
    required this.roomNumber,
    required this.amount,
    required this.status,
    required this.date,
    required this.tokenCode,
  });
}

enum TransactionStatus { paid, pending, failed }

class DashboardStats {
  final double monthlyTransactionTotal;
  final int monthlyTransactions;
  final String mostActiveRoom;
  final String highestUsageRoom;

  DashboardStats({
    required this.monthlyTransactionTotal,
    required this.monthlyTransactions,
    required this.mostActiveRoom,
    required this.highestUsageRoom,
  });
}

class WhatsAppTemplate {
  final String id;
  final String name;
  final String message;
  final bool isActive;

  WhatsAppTemplate({
    required this.id,
    required this.name,
    required this.message,
    required this.isActive,
  });
}
