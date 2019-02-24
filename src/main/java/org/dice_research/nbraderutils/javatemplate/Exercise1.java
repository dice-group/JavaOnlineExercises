package org.dice_research.nbraderutils.javatemplate;

/**
 * Exercise 1 - Numeric ASCII representation
 *
 * @author Adrian Wilke
 */
public class Exercise1 {

	/**
	 * Converts a String to the numeric ASCII representation of its single
	 * characters.
	 */
	public int[] toNumericAscii(String string) {
		int[] result = new int[string.length()];

		// BEGIN SOLUTION

		/*
		 * Notes for lecturers:
		 * 
		 * Insert your solution inside one or several marked solution blocks. These
		 * blocks will be removed for students.
		 *
		 * If possible, a return variable should be defined before this marked solution
		 * block. It avoids unnecessary error messages, if the solution block is removed
		 * for the students. A null value also works.
		 * 
		 * Please edit the JavaDoc class comment (exercise name, author) and method
		 * comment(s) as well.
		 * 
		 * Additionally to this solution, provide a markdown file describing the
		 * exercise task and a test file for auto-grading.
		 * 
		 * You can remove this comment.
		 */

		char[] chars = string.toCharArray();
		for (int i = 0; i < chars.length; i++) {
			result[i] = chars[i];
		}

		// END SOLUTION

		return result;
	}

}