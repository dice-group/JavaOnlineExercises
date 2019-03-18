package org.dice_research.nbraderutils.javatemplate;

import org.junit.platform.runner.JUnitPlatform;
import org.junit.platform.suite.api.SelectPackages;
import org.junit.runner.RunWith;

// Alternative to set order of tests:
// import org.junit.platform.suite.api.SelectClasses;

@RunWith(JUnitPlatform.class)
@SelectPackages({ "org.dice_research.nbraderutils.javatemplate" })

// Alternative to set order of tests:
// @SelectClasses({ Exercise1Test.class, OverallPointsTest.class })

public class AllTestsSuite {
}