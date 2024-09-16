enum CollectionName {
  users("users"),
  images("images");

  const CollectionName(this.value);
  final String value;
}

enum UserImageLimit {
  notVerified(2),
  verified(10),
  premium(25);

  const UserImageLimit(this.value);
  final int value;
}

enum AppFlavor {
  dev("dev"),
  production("production");

  const AppFlavor(this.value);
  final String value;
}
