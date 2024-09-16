class ServiceModel {
  final String id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  ServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a Service object from JSON
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']).toString(),
      updatedAt: DateTime.parse(json['updatedAt']).toString(),
    );
  }

  // Method to convert a Service object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

ServiceModel serviceModel = ServiceModel(
    id: '', name: '', description: '', createdAt: '', updatedAt: '');

List<ServiceModel> services = [];
