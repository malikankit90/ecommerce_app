import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/stock_repository.dart';
import '../../data/services/stock_firestore_service.dart';

/// ---------------------------------------------------
/// Firestore Service Provider
/// Single source of truth for stock mutations
/// ---------------------------------------------------
final stockFirestoreServiceProvider = Provider<StockFirestoreService>((ref) {
  return StockFirestoreService();
});

/// ---------------------------------------------------
/// Stock Repository Provider
/// Thin abstraction over Firestore service
/// ---------------------------------------------------
final stockRepositoryProvider = Provider<StockRepository>((ref) {
  final service = ref.read(stockFirestoreServiceProvider);
  return StockRepository(service: service);
});
