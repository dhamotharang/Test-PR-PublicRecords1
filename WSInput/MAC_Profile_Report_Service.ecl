﻿EXPORT MAC_Profile_Report_Service := MACRO
#WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/
										'ApplicationType',
										'DataPermissionMask',
										'DataRestrictionMask',
										'DLMask',
										'dobMask',
										'DPPAPurpose',
										'GLBPurpose',
										'IndustryClass',
										'ssnMask',
										/*---- Other Fields ----*/
										'BDID',
										'JudgmentLienVersion',
										'UccVersion',
										'DisregardLimits',
										'SelectIndividually',
										'ShowPersonalData',
										'IncludeAssociatedBusinesses',
										'IncludeAssociatedPeople',
										'IncludeBankruptcies',
										'IncludeBBB',
										'IncludeBusinessesAtAddress',
										'IncludeBusinessRegistrations',
										'IncludeCompanyIDnumbers',
										'IncludeCorporationFilings',
										'IncludeDunBradstreetRecords', 
										'IncludeEBRHeader',
										'IncludeEBRSummary',
										'IncludeHRI',
										'IncludeInternetDomains',
										'IncludeJudgments',
										'IncludeLiens', 
										'IncludeNameVariations',
										'IncludeParentChild',
										'IncludePatriotAct',
										'IncludeProfessionalLicenses',
										'IncludeProperties',
										'IncludeReversePhone',
										'IncludeUCCFilings',
										'IncludeYellowPages',
										'MaxAssociatedBusinesses',
										'MaxAssociatedPeople',
										'MaxBankruptcies',
										'MaxBBB',
										'MaxBusinessesAtAddress',
										'MaxBusinessRegistrations',
										'MaxCorporationFilings',
										'MaxEBRHeader',
										'MaxEBRSummary',
										'MaxInternetDomains',
										'MaxJudgments',
										'MaxLiens',
										'MaxNameVariations',
										'MaxPatriotAct',
										'MaxProfessionalLicenses',
										'MaxProperties',
										'MaxReverseLookup',
										'MaxSupergroup',
										'MaxUCCFilings',
										'MaxYellowPages'
								));
ENDMACRO;