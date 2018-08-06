package org.dice_research.nbgraderutils;

/**
 * Methods for automatically graded answers and tests.
 */
public class AutograderUtils {

	/**
	 * Throws an error, if the given statement is not true.
	 * 
	 * @param statement
	 *            Statement to check.
	 * @param errorMessage
	 *            Message, which is supplied, if the statement is false.
	 */
	public static void assertTrue(boolean statement, String errorMessage) {
		if (!statement) {
			throw new Error(errorMessage);
		}
	}
}