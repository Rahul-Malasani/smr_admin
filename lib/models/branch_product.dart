class BranchProduct {
  final int branchId;            // BrID
  final int productId;           // PrdctID
  final DateTime createdDate;    // Crdt
  final bool isActive;

  BranchProduct({
    required this.branchId,
    required this.productId,
    required this.createdDate,
    required this.isActive,
  });
}
