import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawmatch/app/modules/home/controllers/petfinder_controller.dart';
import 'package:pawmatch/app/modules/home/models/petfinder_model.dart'
    as models;

class ProductListView extends GetView<PetfinderController> {
  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.animals.isEmpty) {
        return const Center(child: Text('No animals found'));
      }

      return RefreshIndicator(
        onRefresh: () async {
          await controller.refreshData();
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.animals.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final models.Animal animal = controller.animals[index];

            final String imageUrl = (animal.photos != null &&
                    animal.photos!.isNotEmpty &&
                    animal.photos!.first.medium != null)
                ? animal.photos!.first.medium!
                : 'https://via.placeholder.com/150';

            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () {
                  // Aksi saat diklik (bisa diarahkan ke detail)
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        imageUrl,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        animal.name ?? 'Unknown',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      child: Text(
                        animal.breeds?.primary ?? 'Unknown Breed',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.pets,
                              size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 4),
                          Text(
                            animal.age ?? '',
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
