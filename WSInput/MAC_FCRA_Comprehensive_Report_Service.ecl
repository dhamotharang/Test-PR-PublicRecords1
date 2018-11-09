// This service created to add Web Service fields for FCRA.Comprehensive_Report_Service

EXPORT MAC_FCRA_Comprehensive_Report_Service() := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/
										'ApplicationType',
										'DataPermissionMask',
										'DataRestrictionMask',
										'DPPAPurpose',
										'GLBPurpose',
										'IndustryClass',
										'SSNMask',
										'DLMask',
										'LawEnforcement',										
										/*---- Search Fields ----*/
										'DID',	
										'FirstName',
										'MiddleName',
										'LastName',
										'Addr',
										'City',
										'State',										
										'Zip',
										'Phone',
										'DOB',
										'Zip',
										'SSN',
										/*---- Selectors ----*/
										'SelectIndividually',
										'IncludeAKAs',
										'IncludeOldPhones',
										'IncludeProperties',
										'IncludePriorProperties',
										'UseCurrentlyOwnedProperty',
										'IncludeBankruptcies',
										'BankruptcyVersion',
										'PartyTypeBK',
										'IncludeFirearmsAndExplosives',
										'IncludeLiensJudgments',
										'IncludeCorporateAffiliations',
										'IncludeUCCFilings',
										'IncludeDEARecords',
										'IncludeFAACertificates',
										'IncludeFAAAircrafts',										
										'IncludeCriminalRecords',
										'IncludeProfessionalLicenses',
										'IncludeHuntingFishingLicenses',
										'IncludeWeaponPermits',
										'IncludeSexualOffenses',										
										'IncludeWatercrafts',
										'IncludeHRI',
										'MaxHriPer',
										'IncludeForeclosures',
										'IncludeBlankDOD',
                    'IncludeEquifaxAcctDecisioning',
										/*---- Others ----*/
										'NonSubjectSuppression',
										'ApplyNonsubjectRestrictions',
										'SuppressWithdrawnBankruptcy',
										'VerifyUniqueID',
										'AllowNickNames',
										'PhoneticMatch',
										'gateways',
										'FFDOptionsMask'
									));
									
ENDMACRO;	

