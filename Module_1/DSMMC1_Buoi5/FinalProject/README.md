# Grade the Exams

This Python script grades multiple exam papers and generates individual grade files for each student.

## Usage

1. Place the exam data files in the `data/` directory.
2. Run the script `grade_the_exams.py`.
3. Exam results will be saved in the `results/` directory.

## Requirements

- Python 3.x
- pandas
- numpy

## File Structure

project/
│
├── DataFiles/ # Directory containing input data files
│ ├── class1.txt
│ ├── class2.txt
│ └── ...
│
├── __MACOSX/DataFiles/ExpectedOutput # Directory containing output grade files
│ ├── class1_grades.txt
│ ├── class2_grades.txt
│ └── ...
├── grade_the_exams.py # Main script to grade exams
└── README.md # Instructions on how to use the project