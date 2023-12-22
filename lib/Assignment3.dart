class Animal {
  String name;
  int age;
  String healthStatus;

  Animal({required this.name, required this.age, required this.healthStatus});

  void displayDetails() {
    print('$name (${this.runtimeType}) - Age: $age, Health: $healthStatus');
  }
}

class FeedingSchedule {
  String animalName;
  String time;
  String foodType;
  String quantity;

  FeedingSchedule({
    required this.animalName,
    required this.time,
    required this.foodType,
    required this.quantity,
  });
}

class Exhibit {
  String name;
  var animals = [];
  var feedingSchedules = [];

  Exhibit({required this.name});

  void addAnimalToExhibit(Animal a) {
    animals.add(a);
  }

  void addFeedingSchedule(FeedingSchedule b) {
    feedingSchedules.add(b);
  }

  void displayDetails() {
    print('$name: ${animals.map((animal) => animal.name).join(', ')}');
  }
}

class Visitor {
  String name;
  int age;
  var visitedExhibits = [];

  Visitor({
    required this.name,
    required this.age,
  });

  void visitExhibit(Zoo myZoo, String a) {
    visitedExhibits.add(a);
    myZoo.visitors.add(this); // Add the visitor to the visitors list in the Zoo
  }
}

class Zoo {
  var animals = [];
  var exhibits = [];
  var feedingSchedules = [];
  var visitors = [];

  void addAnimal(Animal a) {
    animals.add(a);
  }

  void addExhibit(Exhibit b) {
    exhibits.add(b);
  }

  void transferAnimal(String animalName, String fromExhibit, String toExhibit) {
    Exhibit from = exhibits.firstWhere((exhibit) => exhibit.name == fromExhibit,
        orElse: () => Exhibit(name: ''));
    Exhibit to = exhibits.firstWhere((exhibit) => exhibit.name == toExhibit,
        orElse: () => Exhibit(name: ''));

    Animal animal = animals.firstWhere((animal) => animal.name == animalName);

    to.animals.add(animal);
  }

  void moveAnimalToExhibit(String animalName, String toExhibit) {
    Exhibit to = exhibits.firstWhere((exhibit) => exhibit.name == toExhibit);
    Animal animal = animals.firstWhere((animal) => animal.name == animalName);
    to.animals.add(animal);
  }

  void addFeedingSchedule(String animalName, String time,
      {String foodType = '', String quantity = ''}) {
    feedingSchedules.add(FeedingSchedule(
        animalName: animalName,
        time: time,
        foodType: foodType,
        quantity: quantity));
  }

  void updateFeedingSchedule(String animalName, String time,
      {String foodType = '', String quantity = ''}) {
    try {
      FeedingSchedule schedule = feedingSchedules.firstWhere(
        (schedule) =>
            schedule.animalName == animalName && schedule.time == time,
      );

      schedule.foodType = foodType;
      schedule.quantity = quantity;
    } catch (e) {}
  }

  void displayAllAnimals() {
    print('Details of All Animals:');
    animals.forEach((animal) => animal.displayDetails());
    print(' ');
  }

  void displayExhibits() {
    print('Details of All Exhibits:');
    exhibits.forEach((exhibit) => exhibit.displayDetails());
    print(' ');
  }

  void displayFeedingSchedule() {
    print('Details of All Feeding Schedules:');
    feedingSchedules.forEach((schedule) {
      print(
          '${schedule.animalName} - ${schedule.time} - ${schedule.foodType} - ${schedule.quantity}');
    });
    print(' ');
  }

  void displayVisitors() {
    print('Details of All Visitors:');
    visitors.forEach((visitor) {
      print(
          '${visitor.name} (Age: ${visitor.age}) - Visited Exhibits: ${visitor.visitedExhibits.join(', ')}');
    });
  }
}

class Lion extends Animal {
  Lion({required String name, required int age, required String healthStatus})
      : super(name: name, age: age, healthStatus: healthStatus);
}

class Giraffe extends Animal {
  Giraffe(
      {required String name, required int age, required String healthStatus})
      : super(name: name, age: age, healthStatus: healthStatus);
}

class InteractiveExhibit extends Exhibit {
  InteractiveExhibit({required String name}) : super(name: name);
}

class StaticExhibit extends Exhibit {
  StaticExhibit({required String name}) : super(name: name);
}

void main() {
  Zoo myZoo = Zoo();

  myZoo.addAnimal(
      Lion(name: 'Simba', age: 5, healthStatus: 'Under Observation'));
  myZoo.addAnimal(Giraffe(name: 'Gerald', age: 3, healthStatus: 'Good'));

  myZoo.addExhibit(InteractiveExhibit(name: 'Savannah Exhibit'));
  myZoo.addExhibit(StaticExhibit(name: 'Rainforest Exhibit'));

  myZoo.addFeedingSchedule('Simba', '10:00 AM',
      foodType: 'Meat', quantity: '2 kg');
  myZoo.addFeedingSchedule('Gerald', '12:30 PM',
      foodType: 'Leaves', quantity: '5 kg');

  myZoo.transferAnimal('Simba', 'Rainforest Exhibit', 'Savannah Exhibit');

  myZoo.moveAnimalToExhibit('Gerald', 'Rainforest Exhibit');

  myZoo.updateFeedingSchedule('Simba', '10:00 AM',
      foodType: 'Meat', quantity: '3 kg');

  Visitor johnDoe = Visitor(name: 'John Doe', age: 25);
  johnDoe.visitExhibit(myZoo, 'Savannah Exhibit');

  myZoo.displayAllAnimals();
  myZoo.displayExhibits();
  myZoo.displayFeedingSchedule();
  myZoo.displayVisitors();
}
