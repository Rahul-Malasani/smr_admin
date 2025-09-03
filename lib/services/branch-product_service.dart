import 'package:smr_admin/models/branch_product.dart';

class BranchProductService {
  static final List<BranchProduct> _mappings = [];

  static List<BranchProduct> getAll() {
    return List<BranchProduct>.from(_mappings);
  }

  static void add(BranchProduct mapping) {
    // prevent duplicates: same branchId + productId
    final exists = _mappings.any((bp) =>
        bp.branchId == mapping.branchId && bp.productId == mapping.productId);
    if (!exists) {
      _mappings.add(mapping);
    }
  }

  static void update(int branchId, int productId, BranchProduct updatedMapping) {
    final index = _mappings.indexWhere(
        (bp) => bp.branchId == branchId && bp.productId == productId);
    if (index != -1) {
      _mappings[index] = updatedMapping;
    }
  }

  static void delete(int branchId, int productId) {
    _mappings.removeWhere(
        (bp) => bp.branchId == branchId && bp.productId == productId);
  }
}
