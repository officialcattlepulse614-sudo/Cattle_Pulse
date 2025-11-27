// services/cattle_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cattle_pulse/screens/side_menu_screens/home_screen/cattle_management_screen/cattle_model.dart';

class CattleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'cattle';

  // -----------------------------
  // Load AutoFeederProfile subcollection
  // -----------------------------
  Future<AutoFeederProfile> _loadFeederProfile(String cattleId) async {
    final doc = await _firestore
        .collection(_collectionName)
        .doc(cattleId)
        .collection('autoFeederProfiles')
        .doc('default')
        .get();

    return AutoFeederProfile.fromMap(doc.data());
  }

  // -----------------------------
  // Stream all cattle
  // -----------------------------
  Stream<List<CattleModel>> getCattleStream() {
    return _firestore.collection(_collectionName).snapshots().asyncMap(
      (snapshot) async {
        List<CattleModel> result = [];

        for (var doc in snapshot.docs) {
          try {
            final profile = await _loadFeederProfile(doc.id);
            final cattle = CattleModel.fromFirestore(doc, profile);
            result.add(cattle);
          } catch (e) {
            print("❌ Error parsing cattle ${doc.id}: $e");
          }
        }

        result.sort((a, b) => a.name.compareTo(b.name));
        return result;
      },
    );
  }

  // -----------------------------
  // Get by ID
  // -----------------------------
  Future<CattleModel?> getCattleById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (!doc.exists) return null;

      final profile = await _loadFeederProfile(id);
      return CattleModel.fromFirestore(doc, profile);
    } catch (e) {
      print('❌ Error loading cattle $id: $e');
      return null;
    }
  }

  // -----------------------------
  // Add cattle (FIXED)
  // -----------------------------
  Future<String?> addCattle(CattleModel cattle) async {
    try {
      // 1. Create the main cattle document
      final docRef =
          await _firestore.collection(_collectionName).add(cattle.toMap());

      // 2. Create the autoFeederProfiles subcollection with default profile
      await _firestore
          .collection(_collectionName)
          .doc(docRef.id)
          .collection('autoFeederProfiles')
          .doc('default')
          .set(cattle.feederProfile.toMap());

      return docRef.id;
    } catch (e) {
      print('❌ Error adding cattle: $e');
      return null;
    }
  }

  // -----------------------------
  // Update cattle
  // -----------------------------
  Future<bool> updateCattle(String id, Map<String, dynamic> updates) async {
    try {
      await _firestore.collection(_collectionName).doc(id).update(updates);
      return true;
    } catch (e) {
      print('❌ Error updating cattle: $e');
      return false;
    }
  }

  // -----------------------------
  // Update feeder profile in subcollection
  // -----------------------------
  Future<bool> updateFeedingProfile(
      String cattleId, AutoFeederProfile profile) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(cattleId)
          .collection('autoFeederProfiles')
          .doc('default')
          .set(profile.toMap(), SetOptions(merge: true));

      return true;
    } catch (e) {
      print('❌ Error updating feeder profile: $e');
      return false;
    }
  }

  // -----------------------------
  // Delete cattle (ENHANCED)
  // -----------------------------
  Future<bool> deleteCattle(String id) async {
    try {
      // Delete the autoFeederProfiles subcollection first
      await _firestore
          .collection(_collectionName)
          .doc(id)
          .collection('autoFeederProfiles')
          .doc('default')
          .delete();

      // Then delete the main cattle document
      await _firestore.collection(_collectionName).doc(id).delete();
      return true;
    } catch (e) {
      print('❌ Error deleting cattle: $e');
      return false;
    }
  }

  // -----------------------------
  // Search cattle
  // -----------------------------
  Stream<List<CattleModel>> searchCattle(String query) {
    return getCattleStream().map(
      (list) => list
          .where((cattle) =>
              cattle.name.toLowerCase().contains(query.toLowerCase()) ||
              cattle.tagId.toLowerCase().contains(query.toLowerCase()))
          .toList(),
    );
  }
}
