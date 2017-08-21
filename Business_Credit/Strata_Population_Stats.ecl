IMPORT Strata, tools;

EXPORT Strata_Population_Stats(
	STRING																pVersion,
	BOOLEAN																pIsTesting				= FALSE,
	BOOLEAN																pOverwrite				= FALSE,
	DATASET(Layouts.SBFEAccountLayout)		pLinkIDs					= Files().LinkIDs,
	DATASET(Layouts.rBIClassification)		pBIClassification	= Files().BIClassification,
	DATASET(Layouts.rBusinessOwner)				pBusinessOwner		= Files().BusinessOwner,
	DATASET(Layouts.rCollateral)					pCollateral				= Files().Collateral,
	DATASET(Layouts.rHistory)							pHistory					= Files().History,
	DATASET(Layouts.rIndividualOwner)			pIndividualOwner	= Files().IndividualOwner,
	DATASET(Layouts.rMasterAccount)				pMasterAccount		= Files().MasterAccount,
	DATASET(Layouts.rMemberSpecific)			pMemberSpecific		= Files().MemberSpecific) := MODULE

	Strata.mac_Pops(pLinkIDs					,	dLinkIDsPops);
	Strata.mac_Pops(pBIClassification	,	dBIClassificationPops);
	Strata.mac_Pops(pBusinessOwner		,	dBusinessOwnerPops);
	Strata.mac_Pops(pCollateral		    , dCollateralPops);
	Strata.mac_Pops(pHistory				  , dHistoryPops);
	Strata.mac_Pops(pIndividualOwner	,	dIndividualOwnerPops);
	Strata.mac_Pops(pMasterAccount		,	dMasterAccountPops);
	Strata.mac_Pops(pMemberSpecific	  , dMemberSpecificPops);
	
	Strata.mac_CreateXMLStats(dLinkIDsPops, _Dataset().Name, 'LinkIDs', pVersion, Email_Notification_Lists().Stats,
	                             dLinkIDsPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dBIClassificationPops, _Dataset().Name, 'BIClassification', pVersion, Email_Notification_Lists().Stats,
	                             dBIClassificationPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dBusinessOwnerPops, _Dataset().Name, 'BusinessOwner', pVersion, Email_Notification_Lists().Stats,
	                             dBusinessOwnerPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dCollateralPops, _Dataset().Name, 'Collateral', pVersion, Email_Notification_Lists().Stats,
	                             dCollateralPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dHistoryPops, _Dataset().Name, 'History', pVersion, Email_Notification_Lists().Stats,
	                             dHistoryPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dIndividualOwnerPops, _Dataset().Name, 'IndividualOwner', pVersion, Email_Notification_Lists().Stats,
	                             dIndividualOwnerPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dMasterAccountPops, _Dataset().Name, 'MasterAccount', pVersion, Email_Notification_Lists().Stats,
	                             dMasterAccountPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dMemberSpecificPops, _Dataset().Name, 'MemberSpecific', pVersion, Email_Notification_Lists().Stats,
	                             dMemberSpecificPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pVersion),
									 SEQUENTIAL(dLinkIDsPopsOut,
															dBIClassificationPopsOut,
															dBusinessOwnerPopsOut,
															dCollateralPopsOut,
															dHistoryPopsOut,
															dIndividualOwnerPopsOut,
															dMasterAccountPopsOut,
															dMemberSpecificPopsOut));

END;