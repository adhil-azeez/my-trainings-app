import 'package:my_trainings_app/models/training_model.dart';

const dummyLocations = <String>[
  "Russia",
  "Canada",
  "United States",
  "China",
  "Brazil",
  "Australia",
  "India",
  "Argentina",
  "Kazakhstan",
  "Sudan",
];

const dummyTrainerNames = <String>[
  "John Stone",
  "Ponnappa Priya",
  "Mia Wong",
  "Peter Stanbridge",
  "Natalie Lee-Walsh",
  "Ang Li",
  "Nguta Ithya",
  "Tamzyn French",
  "Salome Simoes",
  "Trevor Virtue",
  "Tarryn Campbell-Gillies",
  "Eugenia Anders",
  "Andrew Kazantzis",
  "Verona Blair",
  "Jane Meldrum",
  "Maureen M. Smith",
  "Desiree Burch",
  "Daly Harry",
  "Hayman Andrews",
  "Ruveni Ellawala",
];

const dummyTrainingNames = <String>[
  "Top Notch Training",
  "Train And Maintain",
  "Maintain Training",
  "Train To Train",
  "Traded Training",
  "Train For A Trade",
  "Trade Training",
  "Trader Training",
  "Fitness Training",
  "Program Training",
];

final dummyTrainingModelList = List<TrainingModel>.generate(
  10,
  (index) => TrainingModel(
    location: dummyLocations[index],
    name: dummyTrainingNames[index],
    trainer: dummyTrainerNames[index],
  ),
);
