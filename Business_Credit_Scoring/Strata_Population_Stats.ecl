IMPORT Strata, tools;

EXPORT Strata_Population_Stats(
	STRING																pVersion,
	BOOLEAN																pIsTesting		= FALSE,
	BOOLEAN																pOverwrite		= FALSE,
	DATASET(Layouts.rDBTAverage)					pDBTAverage		= Files().DBTAverage
) := MODULE

	Strata.mac_Pops(pDBTAverage		,	dDBTAverage);
	
	Strata.mac_CreateXMLStats(dDBTAverage, _Dataset().Name, 'DBTAverage', pVersion, Email_Notification_Lists().Stats,
	                             dDBTAveragePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(dDBTAveragePopsOut));

END;