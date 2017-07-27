IMPORT Strata, tools;

EXPORT Strata_Population_Stats(
	STRING															 pversion,
	BOOLEAN															 pIsTesting 			        = FALSE,
	BOOLEAN															 pOverwrite		 	          = FALSE,
	DATASET(Layouts.Base.Main)					 pBaseMainBuilt					  = Files().Base.Main.Built,
	DATASET(Layouts.Base.Career)				 pBaseCareerBuilt		      = Files().Base.Career.Built,
	DATASET(Layouts.Base.Cert)					 pBaseCertBuilt				    = Files().Base.Cert.Built,
	DATASET(Layouts.Base.Education)			 pBaseEducationBuilt			= Files().Base.Education.Built,
	DATASET(Layouts.Base.Membership)		 pBaseMembershipBuilt	    = Files().Base.Membership.Built,
	DATASET(Layouts.Base.TypeOfPractice) pBaseTypeOfPracticeBuilt = Files().Base.TypeOfPractice.Built) := MODULE

	Strata.mac_Pops(pBaseMainBuilt					, dMainPops, 'state');
	Strata.mac_Pops(pBaseCareerBuilt		    , dCareerPops);
	Strata.mac_Pops(pBaseCertBuilt				  , dCertPops);
	Strata.mac_Pops(pBaseEducationBuilt			, dEducationPops);
	Strata.mac_Pops(pBaseMembershipBuilt	  , dMembershipPops);
	Strata.mac_Pops(pBaseTypeOfPracticeBuilt, dTypeOfPracticePops);
	
	Strata.mac_CreateXMLStats(dMainPops, _Dataset().Name, 'main', pversion, Email_Notification_Lists().Stats,
	                             dMainPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dCareerPops, _Dataset().Name, 'career', pversion, Email_Notification_Lists().Stats,
	                             dCareerPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dCertPops, _Dataset().Name, 'cert', pversion, Email_Notification_Lists().Stats,
	                             dCertPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dEducationPops, _Dataset().Name, 'education', pversion, Email_Notification_Lists().Stats,
	                             dEducationPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dMembershipPops, _Dataset().Name, 'membership', pversion, Email_Notification_Lists().Stats,
	                             dMembershipPopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	Strata.mac_CreateXMLStats(dTypeOfPracticePops, _Dataset().Name, 'typeofpractice', pversion, Email_Notification_Lists().Stats,
	                             dTypeOfPracticePopsOut, 'View', 'Population', , pIsTesting, pOverwrite);
	
	EXPORT ALL := IF(tools.fun_IsValidVersion(pversion),
									 SEQUENTIAL(dMainPopsOut,
															dCareerPopsOut,
															dCertPopsOut,
															dEducationPopsOut,
															dMembershipPopsOut,
														  dTypeOfPracticePopsOut));

END;