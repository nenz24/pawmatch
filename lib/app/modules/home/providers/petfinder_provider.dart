// providers/petfinder_provider.dart

import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/models/petfinder_model.dart';

class PetfinderProvider extends GetConnect {
  // Rename static baseUrl to avoid conflict
  static const String apiBaseUrl = 'https://api.petfinder.com/v2';
  static const String clientId = 'YOUR_CLIENT_ID';
  static const String clientSecret = 'YOUR_CLIENT_SECRET';

  // Token management
  String? _accessToken;
  DateTime? _tokenExpiry;

  @override
  void onInit() {
    super.onInit();
    // Set the base URL for GetConnect
    baseUrl = apiBaseUrl;

    // Configure timeout and headers
    timeout = const Duration(seconds: 30);

    // Add default headers
    httpClient.defaultContentType = 'application/json';

    // Add request interceptor for authentication
    httpClient.addRequestModifier<dynamic>((request) async {
      await _ensureValidToken();
      if (_accessToken != null) {
        request.headers['Authorization'] = 'Bearer $_accessToken';
      }
      return request;
    });

    // Add response interceptor for error handling
    httpClient.addResponseModifier((request, response) {
      if (response.statusCode == 401) {
        // Token expired, clear it
        _accessToken = null;
        _tokenExpiry = null;
      }
      return response;
    });
  }

  // Authenticate and get access token
  Future<void> _authenticate() async {
    try {
      final response = await post('/oauth2/token', {
        'grant_type': 'client_credentials',
        'client_id': clientId,
        'client_secret': clientSecret,
      });

      if (response.statusCode == 200) {
        final data = response.body;
        _accessToken = data['access_token'];
        final expiresIn = data['expires_in'] ?? 3600;
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));

        print('✅ PetFinder authentication successful');
      } else {
        throw Exception('Authentication failed: ${response.statusText}');
      }
    } catch (e) {
      print('❌ PetFinder authentication error: $e');
      throw Exception('Failed to authenticate with PetFinder API');
    }
  }

  // Ensure we have a valid token
  Future<void> _ensureValidToken() async {
    if (_accessToken == null ||
        _tokenExpiry == null ||
        DateTime.now()
            .isAfter(_tokenExpiry!.subtract(const Duration(minutes: 5)))) {
      await _authenticate();
    }
  }

  // Get animals with filters
  Future<AnimalsResponse> getAnimals({
    String? type,
    String? breed,
    String? size,
    String? gender,
    String? age,
    String? location,
    int page = 1,
    int limit = 20,
    String? status = 'adoptable',
  }) async {
    try {
      await _ensureValidToken();

      final Map<String, dynamic> params = {
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (type != null && type.isNotEmpty) params['type'] = type;
      if (breed != null && breed.isNotEmpty) params['breed'] = breed;
      if (size != null && size.isNotEmpty) params['size'] = size;
      if (gender != null && gender.isNotEmpty) params['gender'] = gender;
      if (age != null && age.isNotEmpty) params['age'] = age;
      if (location != null && location.isNotEmpty)
        params['location'] = location;
      if (status != null && status.isNotEmpty) params['status'] = status;

      final response = await get('/animals', query: params);

      if (response.statusCode == 200) {
        return AnimalsResponse.fromJson(response.body);
      } else {
        throw Exception('Failed to load animals: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting animals: $e');
      throw Exception('Failed to load animals: $e');
    }
  }

  // Get single animal by ID
  Future<Animal> getAnimal(int id) async {
    try {
      await _ensureValidToken();

      final response = await get('/animals/$id');

      if (response.statusCode == 200) {
        return Animal.fromJson(response.body['animal']);
      } else {
        throw Exception('Failed to load animal: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting animal: $e');
      throw Exception('Failed to load animal: $e');
    }
  }

  // Get animal types
  Future<List<AnimalType>> getAnimalTypes() async {
    try {
      await _ensureValidToken();

      final response = await get('/types');

      if (response.statusCode == 200) {
        final List<dynamic> typesJson = response.body['types'];
        return typesJson.map((json) => AnimalType.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load animal types: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting animal types: $e');
      throw Exception('Failed to load animal types: $e');
    }
  }

  // Get breeds for a specific animal type
  Future<List<String>> getBreeds(String animalType) async {
    try {
      await _ensureValidToken();

      final response = await get('/types/$animalType/breeds');

      if (response.statusCode == 200) {
        final List<dynamic> breedsJson = response.body['breeds'];
        return breedsJson.map((breed) => breed['name'] as String).toList();
      } else {
        throw Exception('Failed to load breeds: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting breeds: $e');
      throw Exception('Failed to load breeds: $e');
    }
  }

  // Get organizations
  Future<List<Organization>> getOrganizations({
    String? location,
    String? name,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      await _ensureValidToken();

      final Map<String, dynamic> params = {
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (location != null && location.isNotEmpty)
        params['location'] = location;
      if (name != null && name.isNotEmpty) params['name'] = name;

      final response = await get('/organizations', query: params);

      if (response.statusCode == 200) {
        final List<dynamic> orgsJson = response.body['organizations'];
        return orgsJson.map((json) => Organization.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load organizations: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting organizations: $e');
      throw Exception('Failed to load organizations: $e');
    }
  }

  // Get single organization by ID
  Future<Organization> getOrganization(String id) async {
    try {
      await _ensureValidToken();

      final response = await get('/organizations/$id');

      if (response.statusCode == 200) {
        return Organization.fromJson(response.body['organization']);
      } else {
        throw Exception('Failed to load organization: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting organization: $e');
      throw Exception('Failed to load organization: $e');
    }
  }

  // Search animals by name or description
  Future<AnimalsResponse> searchAnimals(
    String query, {
    String? type,
    String? location,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      await _ensureValidToken();

      final Map<String, dynamic> params = {
        'name': query,
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (type != null && type.isNotEmpty) params['type'] = type;
      if (location != null && location.isNotEmpty)
        params['location'] = location;

      final response = await get('/animals', query: params);

      if (response.statusCode == 200) {
        return AnimalsResponse.fromJson(response.body);
      } else {
        throw Exception('Failed to search animals: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error searching animals: $e');
      throw Exception('Failed to search animals: $e');
    }
  }

  // Get animals from specific organization
  Future<AnimalsResponse> getAnimalsByOrganization(
    String organizationId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      await _ensureValidToken();

      final Map<String, dynamic> params = {
        'organization': organizationId,
        'page': page.toString(),
        'limit': limit.toString(),
      };

      final response = await get('/animals', query: params);

      if (response.statusCode == 200) {
        return AnimalsResponse.fromJson(response.body);
      } else {
        throw Exception(
            'Failed to load organization animals: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting organization animals: $e');
      throw Exception('Failed to load organization animals: $e');
    }
  }

  // Get animals near a specific location
  Future<AnimalsResponse> getAnimalsNearLocation(
    double latitude,
    double longitude, {
    int distance = 25, // miles
    String? type,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      await _ensureValidToken();

      final Map<String, dynamic> params = {
        'location': '$latitude,$longitude',
        'distance': distance.toString(),
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (type != null && type.isNotEmpty) params['type'] = type;

      final response = await get('/animals', query: params);

      if (response.statusCode == 200) {
        return AnimalsResponse.fromJson(response.body);
      } else {
        throw Exception(
            'Failed to load nearby animals: ${response.statusText}');
      }
    } catch (e) {
      print('❌ Error getting nearby animals: $e');
      throw Exception('Failed to load nearby animals: $e');
    }
  }

  // Check if service is available
  Future<bool> checkServiceHealth() async {
    try {
      await _ensureValidToken();
      final response = await get('/animals', query: {'limit': '1'});
      return response.statusCode == 200;
    } catch (e) {
      print('❌ Service health check failed: $e');
      return false;
    }
  }
}
