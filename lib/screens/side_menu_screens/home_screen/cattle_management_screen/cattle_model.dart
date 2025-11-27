// models/cattle_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class AutoFeederProfile {
  final String feedType;
  final int totalFeedKg;
  final int hayPercent;
  final int binolaPercent;
  final int chokarPercent;
  final int makaiLeavesPercent;
  final int waterPercent;

  AutoFeederProfile({
    required this.feedType,
    required this.totalFeedKg,
    required this.hayPercent,
    required this.binolaPercent,
    required this.chokarPercent,
    required this.makaiLeavesPercent,
    required this.waterPercent,
  });

  Map<String, dynamic> toMap() {
    return {
      'feedType': feedType,
      'totalFeedKg': totalFeedKg,
      'hayPercent': hayPercent,
      'binolaPercent': binolaPercent,
      'chokarPercent': chokarPercent,
      'makaiLeavesPercent': makaiLeavesPercent,
      'waterPercent': waterPercent,
    };
  }

  factory AutoFeederProfile.fromMap(Map<String, dynamic>? map) {
    if (map == null || map.isEmpty) {
      return AutoFeederProfile(
        feedType: 'Dry Feed',
        totalFeedKg: 0,
        hayPercent: 0,
        binolaPercent: 0,
        chokarPercent: 0,
        makaiLeavesPercent: 0,
        waterPercent: 0,
      );
    }

    return AutoFeederProfile(
      feedType: map['feedType']?.toString() ?? 'Dry Feed',
      totalFeedKg: _toInt(map['totalFeedKg']),
      hayPercent: _toInt(map['hayPercent']),
      binolaPercent: _toInt(map['binolaPercent']),
      chokarPercent: _toInt(map['chokarPercent']),
      makaiLeavesPercent: _toInt(map['makaiLeavesPercent']),
      waterPercent: _toInt(map['waterPercent']),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

class CattleModel {
  final String id;
  final String name;
  final String tagId;
  final String breed;
  final int ageMonths;
  final int weightKg;
  final String healthStatus;
  final AutoFeederProfile feederProfile;

  CattleModel({
    required this.id,
    required this.name,
    required this.tagId,
    required this.breed,
    required this.ageMonths,
    required this.weightKg,
    required this.healthStatus,
    required this.feederProfile,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'tagId': tagId,
      'breed': breed,
      'ageMonths': ageMonths,
      'weightKg': weightKg,
      'healthStatus': healthStatus,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  factory CattleModel.fromFirestore(
    DocumentSnapshot doc,
    AutoFeederProfile feederProfile,
  ) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception("Document data is null for cattle ${doc.id}");
    }

    return CattleModel(
      id: doc.id,
      name: data['name']?.toString() ?? 'Unknown',
      tagId: data['tagId']?.toString() ?? 'N/A',
      breed: data['breed']?.toString() ?? 'Unknown',
      ageMonths: _toInt(data['ageMonths']),
      weightKg: _toInt(data['weightKg']),
      healthStatus: data['healthStatus']?.toString() ?? 'Unknown',
      feederProfile: feederProfile,
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  CattleModel copyWith({
    String? id,
    String? name,
    String? tagId,
    String? breed,
    int? ageMonths,
    int? weightKg,
    String? healthStatus,
    AutoFeederProfile? feederProfile,
  }) {
    return CattleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      tagId: tagId ?? this.tagId,
      breed: breed ?? this.breed,
      ageMonths: ageMonths ?? this.ageMonths,
      weightKg: weightKg ?? this.weightKg,
      healthStatus: healthStatus ?? this.healthStatus,
      feederProfile: feederProfile ?? this.feederProfile,
    );
  }
}
