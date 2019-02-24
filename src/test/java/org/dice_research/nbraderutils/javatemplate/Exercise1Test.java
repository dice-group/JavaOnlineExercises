package org.dice_research.nbraderutils.javatemplate;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.opentest4j.AssertionFailedError;

/**
 * Feel free to change the parameters of the method test(...).
 * 
 * Overview of Assertions:
 * https://junit.org/junit5/docs/current/api/org/junit/jupiter/api/Assertions.html
 */
class Exercise1Test {

	void test(String inputString, int[] expectedResult, String testDescription) {
		try {
			long time = System.currentTimeMillis();

			Assertions.assertArrayEquals(expectedResult, new Exercise1().toNumericAscii(inputString), testDescription);

			time = System.currentTimeMillis() - time;
			System.out.println("Test(s) successfully completed. Calculation took " + time + " ms.");
		} catch (AssertionFailedError e) {
			System.err.println("Your solution returned an unexpected result. ");
			throw e;
		} catch (Throwable e) {
			System.err.println("Your solution caused an unexpected error. ");
			throw e;
		}
	}

	@Test
	void testVisible() {

		test("Hi", new int[] { 72, 105 }, "Testing 'Hi'");

	}

	@Test
	void testHidden1() {

		// The first hidden test should be similar to the visible test.
		test("Ho", new int[] { 72, 111 }, "Testing 'Ho'");

		// Set the points for this test.
		OverallPointsTest.addPoints(14, this.getClass());

	}

	@Test
	void testHidden2() {

		// An additional test.
		test("HiHo", new int[] { 72, 105, 72, 111 }, "Testing 'HiHo'");

		// Set the points for this test.
		OverallPointsTest.addPoints(10, this.getClass());

	}
}