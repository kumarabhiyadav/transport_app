class Customer {
  final String id;
  final String customerName;
  final String companyName;
  final String address;
  final String phone;
  final String email;

  Customer({
    required this.id,
    required this.companyName,
    required this.customerName,
    required this.address,
    required this.email,
    required this.phone,
  });

  static jsonToCustomer(value) => Customer(
        id: value['_id'],
        customerName: value['customerName'],
        companyName: value["companyName"],
        address: value['address'],
        email: value["email"],
        phone: value["phone"],
      );
}
