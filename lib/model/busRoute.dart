class BusRoute{
  late String title;
  late String description;

  BusRoute({
    required this.title,
    required this.description
});

  BusRoute.fromMap(Map<String, dynamic>? map) {
    title = map?['title'] ?? "";
    description = map?['description'] ?? "";
  }
}