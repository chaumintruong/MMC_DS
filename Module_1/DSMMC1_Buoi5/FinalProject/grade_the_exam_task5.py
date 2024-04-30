import os
import pandas as pd
import numpy as np

def open_file(filename):
    try:
        with open(filename) as f:
            lines = [line.strip() for line in f.readlines() if len(line.strip().split(',')) == 26 and line.strip().startswith('N') and line.strip()[1:9].isdigit()]
        data = pd.DataFrame(lines)
        print("Successfully opened", filename)
        return data
    except FileNotFoundError:
        print("File", filename, "cannot be found.")
        raise

def analyze_data(data):
    valid_lines = data.apply(lambda row: len(row[0].split(',')) == 26 and row[0].startswith('N') and row[0][1:9].isdigit(), axis=1).sum()
    invalid_lines = len(data) - valid_lines
    return valid_lines, invalid_lines

def grade_exams(data, answer_key):
    scores = []
    for _, row in data.iterrows():
        student_id, *answers = row[0].split(',')
        score = sum(4 if ans == key else -1 for ans, key in zip(answers, answer_key))
        scores.append((student_id, score))
    return scores

def generate_report(scores):
    scores = np.array([score for _, score in scores])
    mean_score = np.mean(scores)
    highest_score = np.max(scores)
    lowest_score = np.min(scores)
    score_range = np.ptp(scores)
    median_score = np.median(scores)

    print("**** REPORT ****")
    print("Mean (average) score:", round(mean_score, 2))
    print("Highest score:", highest_score)
    print("Lowest score:", lowest_score)
    print("Range of scores:", score_range)
    print("Median score:", median_score)

    return scores

def save_grades(scores, filename):
    with open(filename, "w") as f:
        for student_id, score in scores:
            f.write(f"{student_id},{score}\n")

def main():
    answer_key = "B,A,D,D,C,B,D,A,C,C,D,B,A,B,A,C,B,D,A,C,A,A,B,D,D"
    input_folder = "/content/DataFiles"
    output_folder = "/content/__MACOSX/DataFiles/Task5Output"
    
    # Scan input folder
    for filename in os.listdir(input_folder):
        if filename.endswith(".txt"):
            print("\nProcessing file:", filename)
            try:
                data = open_file(os.path.join(input_folder, filename))
                valid_lines, invalid_lines = analyze_data(data)
                scores = grade_exams(data, answer_key.split(','))
                grades_filename = os.path.join(output_folder, filename.split('.')[0] + "_grades.txt")
                generate_report(scores)
                save_grades(scores, grades_filename)
                print("Grades saved to", grades_filename)
            except FileNotFoundError:
                print("Skipping file", filename)

if __name__ == "__main__":
    main()
