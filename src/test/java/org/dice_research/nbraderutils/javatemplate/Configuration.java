package org.dice_research.nbraderutils.javatemplate;

public abstract class Configuration {

	// If true, it is checked if exercise points sum up to assignment points.
	public static final boolean EQUAL_POINTS_FOR_ASSIGNMENTS = true;

	// 12 or 24 overall points for an assignment are fine for equal points
	// distribution of 1/2/3/4 exercises.
	public static final int POINTS_PER_ASSIGNMENT = 24;
}