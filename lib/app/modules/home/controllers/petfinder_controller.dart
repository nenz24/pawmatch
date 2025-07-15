// controllers/petfinder_controller.dart

import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/models/petfinder_model.dart';
import 'package:pawmatch/app/modules/home/providers/petfinder_provider.dart';

class PetfinderController extends GetxController {
  final PetfinderProvider _provider = Get.find<PetfinderProvider>();

  // Observable variables
  final RxList<Animal> animals = <Animal>[].obs;
  final RxList<AnimalType> animalTypes = <AnimalType>[].obs;
  final RxList<String> breeds = <String>[].obs;
  final RxList<Organization> organizations = <Organization>[].obs;
  final Rx<Pagination?> pagination = Rx<Pagination?>(null);

  // Loading states
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool isLoadingTypes = false.obs;
  final RxBool isLoadingBreeds = false.obs;
  final RxBool isLoadingOrganizations = false.obs;

  // Error states
  final RxString errorMessage = ''.obs;

  // Filter states
  final RxString selectedType = ''.obs;
  final RxString selectedBreed = ''.obs;
  final RxString selectedSize = ''.obs;
  final RxString selectedGender = ''.obs;
  final RxString selectedAge = ''.obs;
  final RxString searchLocation = ''.obs;
  final RxInt currentPage = 1.obs;

  // Favorites
  final RxList<Animal> favoriteAnimals = <Animal>[].obs;
  final RxList<int> favoriteIds = <int>[].obs;

  // Search history
  final RxList<String> searchHistory = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
    loadFavorites();
  }

  // Load initial data
  Future<void> loadInitialData() async {
    await loadAnimalTypes();
    await loadAnimals();
  }

  // Load animals with current filters
  Future<void> loadAnimals({bool refresh = false}) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      errorMessage.value = '';

      final response = await _provider.getAnimals(
        type: selectedType.value.isEmpty ? null : selectedType.value,
        breed: selectedBreed.value.isEmpty ? null : selectedBreed.value,
        size: selectedSize.value.isEmpty ? null : selectedSize.value,
        gender: selectedGender.value.isEmpty ? null : selectedGender.value,
        age: selectedAge.value.isEmpty ? null : selectedAge.value,
        location: searchLocation.value.isEmpty ? null : searchLocation.value,
        page: currentPage.value,
        limit: 20,
      );

      if (refresh || currentPage.value == 1) {
        animals.value = response.animals;
      } else {
        animals.addAll(response.animals);
      }

      pagination.value = response.pagination;

      print('✅ Loaded ${response.animals.length} animals');
    } catch (e) {
      errorMessage.value = e.toString();
      print('❌ Error loading animals: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  // Load more animals (pagination)
  Future<void> loadMoreAnimals() async {
    if (isLoadingMore.value || pagination.value == null) return;

    if (currentPage.value < pagination.value!.totalPages) {
      currentPage.value++;
      await loadAnimals();
    }
  }

  // Load animal types
  Future<void> loadAnimalTypes() async {
    try {
      isLoadingTypes.value = true;
      final types = await _provider.getAnimalTypes();
      animalTypes.value = types;
      print('✅ Loaded ${types.length} animal types');
    } catch (e) {
      print('❌ Error loading animal types: $e');
    } finally {
      isLoadingTypes.value = false;
    }
  }

  // Load breeds for selected type
  Future<void> loadBreeds(String animalType) async {
    try {
      isLoadingBreeds.value = true;
      final breedList = await _provider.getBreeds(animalType);
      breeds.value = breedList;
      print('✅ Loaded ${breedList.length} breeds for $animalType');
    } catch (e) {
      print('❌ Error loading breeds: $e');
    } finally {
      isLoadingBreeds.value = false;
    }
  }

  // Get single animal
  Future<Animal?> getAnimal(int id) async {
    try {
      final animal = await _provider.getAnimal(id);
      print('✅ Loaded animal: ${animal.name}');
      return animal;
    } catch (e) {
      print('❌ Error loading animal: $e');
      return null;
    }
  }

  // Load organizations
  Future<void> loadOrganizations({String? location}) async {
    try {
      isLoadingOrganizations.value = true;
      final orgList = await _provider.getOrganizations(location: location);
      organizations.value = orgList;
      print('✅ Loaded ${orgList.length} organizations');
    } catch (e) {
      print('❌ Error loading organizations: $e');
    } finally {
      isLoadingOrganizations.value = false;
    }
  }

  // Search animals by location
  Future<void> searchByLocation(String location) async {
    searchLocation.value = location;
    addToSearchHistory(location);
    await loadAnimals(refresh: true);
  }

  // Apply filters
  Future<void> applyFilters({
    String? type,
    String? breed,
    String? size,
    String? gender,
    String? age,
  }) async {
    if (type != null) selectedType.value = type;
    if (breed != null) selectedBreed.value = breed;
    if (size != null) selectedSize.value = size;
    if (gender != null) selectedGender.value = gender;
    if (age != null) selectedAge.value = age;

    await loadAnimals(refresh: true);
  }

  // Clear filters
  Future<void> clearFilters() async {
    selectedType.value = '';
    selectedBreed.value = '';
    selectedSize.value = '';
    selectedGender.value = '';
    selectedAge.value = '';
    searchLocation.value = '';
    await loadAnimals(refresh: true);
  }

  // Refresh all data
  Future<void> refreshData() async {
    await loadAnimals(refresh: true);
  }

  // Check if there are more pages to load
  bool get hasMorePages {
    if (pagination.value == null) return false;
    return currentPage.value < pagination.value!.totalPages;
  }

  // Get active filters count
  int get activeFiltersCount {
    int count = 0;
    if (selectedType.value.isNotEmpty) count++;
    if (selectedBreed.value.isNotEmpty) count++;
    if (selectedSize.value.isNotEmpty) count++;
    if (selectedGender.value.isNotEmpty) count++;
    if (selectedAge.value.isNotEmpty) count++;
    if (searchLocation.value.isNotEmpty) count++;
    return count;
  }

  // Favorites functionality
  void toggleFavorite(Animal animal) {
    if (favoriteIds.contains(animal.id)) {
      favoriteIds.remove(animal.id);
      favoriteAnimals.removeWhere((a) => a.id == animal.id);
    } else {
      favoriteIds.add(animal.id);
      favoriteAnimals.add(animal);
    }
    saveFavorites();
  }

  bool isFavorite(int animalId) {
    return favoriteIds.contains(animalId);
  }

  // Save favorites to local storage
  Future<void> saveFavorites() async {
    try {
      // Implementation depends on your storage solution
      // Example with GetStorage:
      // GetStorage().write('favorite_animals', favoriteIds.toList());
      print('✅ Saved ${favoriteIds.length} favorites');
    } catch (e) {
      print('❌ Error saving favorites: $e');
    }
  }

  // Load favorites from local storage
  Future<void> loadFavorites() async {
    try {
      // Implementation depends on your storage solution
      // Example with GetStorage:
      // final saved = GetStorage().read('favorite_animals');
      // if (saved != null) {
      //   favoriteIds.value = List<int>.from(saved);
      // }
      print('✅ Loaded ${favoriteIds.length} favorites');
    } catch (e) {
      print('❌ Error loading favorites: $e');
    }
  }

  // Search history functionality
  void addToSearchHistory(String query) {
    if (query.isEmpty) return;

    // Remove if already exists
    searchHistory.remove(query);

    // Add to beginning
    searchHistory.insert(0, query);

    // Keep only last 10 searches
    if (searchHistory.length > 10) {
      searchHistory.removeRange(10, searchHistory.length);
    }

    saveSearchHistory();
  }

  void clearSearchHistory() {
    searchHistory.clear();
    saveSearchHistory();
  }

  Future<void> saveSearchHistory() async {
    try {
      // Implementation depends on your storage solution
      // GetStorage().write('search_history', searchHistory.toList());
      print('✅ Saved search history');
    } catch (e) {
      print('❌ Error saving search history: $e');
    }
  }

  Future<void> loadSearchHistory() async {
    try {
      // Implementation depends on your storage solution
      // final saved = GetStorage().read('search_history');
      // if (saved != null) {
      //   searchHistory.value = List<String>.from(saved);
      // }
      print('✅ Loaded search history');
    } catch (e) {
      print('❌ Error loading search history: $e');
    }
  }

  // Filter helpers
  void setAnimalType(String type) {
    selectedType.value = type;
    selectedBreed.value = ''; // Clear breed when type changes
    if (type.isNotEmpty) {
      loadBreeds(type);
    }
  }

  void setBreed(String breed) {
    selectedBreed.value = breed;
  }

  void setSize(String size) {
    selectedSize.value = size;
  }

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setAge(String age) {
    selectedAge.value = age;
  }

  // Get filtered animals count
  int get filteredAnimalsCount {
    return animals.length;
  }

  // Get total animals count from pagination
  int get totalAnimalsCount {
    return pagination.value?.totalCount ?? 0;
  }

  // Check if any filters are active
  bool get hasActiveFilters {
    return activeFiltersCount > 0;
  }

  // Get animals by specific criteria
  List<Animal> getAnimalsByType(String type) {
    return animals
        .where((animal) => animal.type?.toLowerCase() == type.toLowerCase())
        .toList();
  }

  List<Animal> getAnimalsBySize(String size) {
    return animals
        .where((animal) => animal.size?.toLowerCase() == size.toLowerCase())
        .toList();
  }

  List<Animal> getAnimalsByAge(String age) {
    return animals
        .where((animal) => animal.age?.toLowerCase() == age.toLowerCase())
        .toList();
  }

  // Error handling
  void clearError() {
    errorMessage.value = '';
  }

  bool get hasError {
    return errorMessage.value.isNotEmpty;
  }

  // Loading states helpers
  bool get isAnyLoading {
    return isLoading.value ||
        isLoadingMore.value ||
        isLoadingTypes.value ||
        isLoadingBreeds.value ||
        isLoadingOrganizations.value;
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}
