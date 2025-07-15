// models/petfinder_models.dart

class PetfinderToken {
  final String tokenType;
  final int expiresIn;
  final String accessToken;

  PetfinderToken({
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
  });

  factory PetfinderToken.fromJson(Map<String, dynamic> json) {
    return PetfinderToken(
      tokenType: json['token_type'] ?? '',
      expiresIn: json['expires_in'] ?? 0,
      accessToken: json['access_token'] ?? '',
    );
  }
}

class Animal {
  final int id;
  final String? organizationId;
  final String? url;
  final String? type;
  final String? species;
  final Breeds? breeds;
  final Colors? colors;
  final String? age;
  final String? gender;
  final String? size;
  final String? coat;
  final Attributes? attributes;
  final Environment? environment;
  final List<String>? tags;
  final String? name;
  final String? description;
  final String? organizationAnimalId;
  final List<Photo>? photos;
  final List<Video>? videos;
  final String? status;
  final DateTime? statusChangedAt;
  final DateTime? publishedAt;
  final Contact? contact;
  final Links? links;

  Animal({
    required this.id,
    this.organizationId,
    this.url,
    this.type,
    this.species,
    this.breeds,
    this.colors,
    this.age,
    this.gender,
    this.size,
    this.coat,
    this.attributes,
    this.environment,
    this.tags,
    this.name,
    this.description,
    this.organizationAnimalId,
    this.photos,
    this.videos,
    this.status,
    this.statusChangedAt,
    this.publishedAt,
    this.contact,
    this.links,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      id: json['id'] ?? 0,
      organizationId: json['organization_id'],
      url: json['url'],
      type: json['type'],
      species: json['species'],
      breeds: json['breeds'] != null ? Breeds.fromJson(json['breeds']) : null,
      colors: json['colors'] != null ? Colors.fromJson(json['colors']) : null,
      age: json['age'],
      gender: json['gender'],
      size: json['size'],
      coat: json['coat'],
      attributes: json['attributes'] != null
          ? Attributes.fromJson(json['attributes'])
          : null,
      environment: json['environment'] != null
          ? Environment.fromJson(json['environment'])
          : null,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      name: json['name'],
      description: json['description'],
      organizationAnimalId: json['organization_animal_id'],
      photos: json['photos'] != null
          ? (json['photos'] as List)
              .map((photo) => Photo.fromJson(photo))
              .toList()
          : null,
      videos: json['videos'] != null
          ? (json['videos'] as List)
              .map((video) => Video.fromJson(video))
              .toList()
          : null,
      status: json['status'],
      statusChangedAt: json['status_changed_at'] != null
          ? DateTime.parse(json['status_changed_at'])
          : null,
      publishedAt: json['published_at'] != null
          ? DateTime.parse(json['published_at'])
          : null,
      contact:
          json['contact'] != null ? Contact.fromJson(json['contact']) : null,
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }
}

class Breeds {
  final String? primary;
  final String? secondary;
  final bool? mixed;
  final bool? unknown;

  Breeds({this.primary, this.secondary, this.mixed, this.unknown});

  factory Breeds.fromJson(Map<String, dynamic> json) {
    return Breeds(
      primary: json['primary'],
      secondary: json['secondary'],
      mixed: json['mixed'],
      unknown: json['unknown'],
    );
  }
}

class Colors {
  final String? primary;
  final String? secondary;
  final String? tertiary;

  Colors({this.primary, this.secondary, this.tertiary});

  factory Colors.fromJson(Map<String, dynamic> json) {
    return Colors(
      primary: json['primary'],
      secondary: json['secondary'],
      tertiary: json['tertiary'],
    );
  }
}

class Attributes {
  final bool? spayedNeutered;
  final bool? houseTrained;
  final bool? declawed;
  final bool? specialNeeds;
  final bool? shotsCurrent;

  Attributes({
    this.spayedNeutered,
    this.houseTrained,
    this.declawed,
    this.specialNeeds,
    this.shotsCurrent,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      spayedNeutered: json['spayed_neutered'],
      houseTrained: json['house_trained'],
      declawed: json['declawed'],
      specialNeeds: json['special_needs'],
      shotsCurrent: json['shots_current'],
    );
  }
}

class Environment {
  final bool? children;
  final bool? dogs;
  final bool? cats;

  Environment({this.children, this.dogs, this.cats});

  factory Environment.fromJson(Map<String, dynamic> json) {
    return Environment(
      children: json['children'],
      dogs: json['dogs'],
      cats: json['cats'],
    );
  }
}

class Photo {
  final String? small;
  final String? medium;
  final String? large;
  final String? full;

  Photo({this.small, this.medium, this.large, this.full});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      small: json['small'],
      medium: json['medium'],
      large: json['large'],
      full: json['full'],
    );
  }
}

class Video {
  final String? embed;

  Video({this.embed});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      embed: json['embed'],
    );
  }
}

class Contact {
  final String? email;
  final String? phone;
  final Address? address;

  Contact({this.email, this.phone, this.address});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'],
      phone: json['phone'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }
}

class Address {
  final String? address1;
  final String? address2;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;

  Address({
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address1: json['address1'],
      address2: json['address2'],
      city: json['city'],
      state: json['state'],
      postcode: json['postcode'],
      country: json['country'],
    );
  }
}

class Links {
  final Link? self;
  final Link? type;
  final Link? organization;

  Links({this.self, this.type, this.organization});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'] != null ? Link.fromJson(json['self']) : null,
      type: json['type'] != null ? Link.fromJson(json['type']) : null,
      organization: json['organization'] != null
          ? Link.fromJson(json['organization'])
          : null,
    );
  }
}

class Link {
  final String? href;

  Link({this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      href: json['href'],
    );
  }
}

class AnimalsResponse {
  final List<Animal> animals;
  final Pagination pagination;

  AnimalsResponse({required this.animals, required this.pagination});

  factory AnimalsResponse.fromJson(Map<String, dynamic> json) {
    return AnimalsResponse(
      animals: (json['animals'] as List)
          .map((animal) => Animal.fromJson(animal))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Pagination {
  final int countPerPage;
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final Links? links;

  Pagination({
    required this.countPerPage,
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    this.links,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      countPerPage: json['count_per_page'] ?? 0,
      totalCount: json['total_count'] ?? 0,
      currentPage: json['current_page'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }
}

class AnimalType {
  final String name;
  final List<String> coats;
  final List<String> colors;
  final List<String> genders;
  final Links? links;

  AnimalType({
    required this.name,
    required this.coats,
    required this.colors,
    required this.genders,
    this.links,
  });

  factory AnimalType.fromJson(Map<String, dynamic> json) {
    return AnimalType(
      name: json['name'] ?? '',
      coats: json['coats'] != null ? List<String>.from(json['coats']) : [],
      colors: json['colors'] != null ? List<String>.from(json['colors']) : [],
      genders:
          json['genders'] != null ? List<String>.from(json['genders']) : [],
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }
}

class Organization {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final Address? address;
  final Hours? hours;
  final String? url;
  final String? website;
  final String? missionStatement;
  final String? adoption;
  final List<Photo>? photos;
  final double? distance;
  final Links? links;

  Organization({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.hours,
    this.url,
    this.website,
    this.missionStatement,
    this.adoption,
    this.photos,
    this.distance,
    this.links,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'],
      phone: json['phone'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      hours: json['hours'] != null ? Hours.fromJson(json['hours']) : null,
      url: json['url'],
      website: json['website'],
      missionStatement: json['mission_statement'],
      adoption: json['adoption'],
      photos: json['photos'] != null
          ? (json['photos'] as List)
              .map((photo) => Photo.fromJson(photo))
              .toList()
          : null,
      distance: json['distance']?.toDouble(),
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
    );
  }
}

class Hours {
  final String? monday;
  final String? tuesday;
  final String? wednesday;
  final String? thursday;
  final String? friday;
  final String? saturday;
  final String? sunday;

  Hours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory Hours.fromJson(Map<String, dynamic> json) {
    return Hours(
      monday: json['monday'],
      tuesday: json['tuesday'],
      wednesday: json['wednesday'],
      thursday: json['thursday'],
      friday: json['friday'],
      saturday: json['saturday'],
      sunday: json['sunday'],
    );
  }
}
