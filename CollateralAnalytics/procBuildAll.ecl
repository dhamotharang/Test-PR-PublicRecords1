EXPORT procBuildAll(string pVersion) := function
	return sequential(
				CollateralAnalytics.fSpray_CollateralAnalytics(pVersion),
				CollateralAnalytics.procBuildBase(pVersion),
				CollateralAnalytics.fnLoadFuzzyList(pversion)
				);
end;