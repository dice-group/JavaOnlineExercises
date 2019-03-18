package org.dice_research.nbraderutils.javatemplate;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

class OverallPointsTest {

	private static Map<String, List<Integer>> pointsMap = new TreeMap<>();

	public static void addPoints(int points, Class<?> exerciseTestClass) {
		if (!pointsMap.containsKey(exerciseTestClass.getSimpleName())) {
			pointsMap.put(exerciseTestClass.getSimpleName(), new LinkedList<>());
		}
		pointsMap.get(exerciseTestClass.getSimpleName()).add(points);
	}

	@Test
	void test() {

		// Print point overview

		int pointsAssignment = 0;
		int pointsExercise;
		StringBuilder exerciseBuilder = new StringBuilder();
		StringBuilder testBuilder;
		for (Entry<String, List<Integer>> exercise : pointsMap.entrySet()) {
			pointsExercise = 0;
			testBuilder = new StringBuilder();
			for (int i = 0; i < exercise.getValue().size(); i++) {
				if (i != 0) {
					testBuilder.append(" + ");
				}
				testBuilder.append(exercise.getValue().get(i));
				pointsExercise += exercise.getValue().get(i);
			}
			exerciseBuilder.append("Points for ");
			exerciseBuilder.append(exercise.getKey());
			exerciseBuilder.append(": ");
			exerciseBuilder.append(pointsExercise);
			exerciseBuilder.append(" = ");
			exerciseBuilder.append(testBuilder);
			exerciseBuilder.append(System.lineSeparator());
			pointsAssignment += pointsExercise;
		}
		System.out.println(exerciseBuilder.toString());
		System.out.println("Overall points for assignment: " + pointsAssignment);

		// Check final points

		if (Configuration.EQUAL_POINTS_FOR_ASSIGNMENTS) {
			Assertions.assertEquals(Configuration.POINTS_PER_ASSIGNMENT, pointsAssignment,
					"Please check your point configuration.");
		}
	}

}