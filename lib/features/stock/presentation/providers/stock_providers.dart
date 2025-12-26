import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/stock_repository.dart';
import '../../data/services/stock_firestore_service.dart';

final stockFirestoreServiceProvider = Provider<StockFirestoreService>((ref) {
  return StockFirestoreService();
});

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  return StockRepository(
    service: ref.read(stockFirestoreServiceProvider),
  );
});
