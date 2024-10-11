class CreateUserCommandResponse {
  final String id;
  final String name;
  final String email;

  CreateUserCommandResponse({
    required this.id,
    required this.name,
    required this.email,
  });

  factory CreateUserCommandResponse.fromJson(Map<String, String> json) {
    return CreateUserCommandResponse(
      id: json['id']!,
      name: json['name']!,
      email: json['email']!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
