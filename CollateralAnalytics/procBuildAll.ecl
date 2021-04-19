import _Control,

EXPORT procBuildAll(string pVersion) := function
	return sequential(
				CollateralAnalytics.fSpray_CollateralAnalytics(pVersion),
				CollateralAnalytics.procBuildBase(pVersion),
				CollateralAnalytics.fnLoadFuzzyList(pversion),
				output(CollateralAnalytics.file_FuzzyMatch,,'~thor_data400::collateral_analytics::FuzzyListCSV',__compressed__,overwrite,csv(separator(','),terminator('\r\n'),QUOTE('"'))),
				fileservices.Despray('~thor_data400::collateral_analytics::FuzzyListCSV'
													,_Control.IPAddress.bctlpedata11
												  , '/data/Builds/builds/collateral_analytics/despray/CollateralAnalyticsFuzzyList'+pVersion+'.csv',,,,true)
				);
end;