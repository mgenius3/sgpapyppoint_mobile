class User {
  String username;
  String name;
  String email;
  String id;
  String naira_Wallet_Balance;
  String bonus_wallet_Balance;
  String? date_created;
  String? bank;
  String? acctno;
  String? acctname;

  User(
      {required this.username,
      required this.email,
      required this.name,
      required this.naira_Wallet_Balance,
      required this.bonus_wallet_Balance,
      required this.id,
      this.acctno,
      this.acctname,
      this.bank,
      this.date_created});
}
