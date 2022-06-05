class Server {
  final String ipAddress;
  final String? alias;
  final String token;

  const Server({
    required this.ipAddress,
    this.alias,
    required this.token
  });
}