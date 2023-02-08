class Customer {
  final String id;
  final String title;
  final String customerName;
  final String companyName;
  final String phone;
  final String email;
  final List<ContactPerson> contactPerson;

  Customer(
      {required this.id,
      required this.companyName,
      required this.customerName,
      required this.email,
      required this.phone,
      required this.title,
      required this.contactPerson});
}

class ContactPerson {}
