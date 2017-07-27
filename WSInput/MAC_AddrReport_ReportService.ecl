// This service created to add Web Service fields for AddressReport_Services.ReportService

EXPORT MAC_AddrReport_ReportService := MACRO

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
										'DID',
										'Addr',
                    'City',
                    'State',
                    'Zip',
                    'IncludeCensusData',
                    'IncludeProperties',
                    'IncludeDriversLicenses',
                    'IncludeMotorVehicles',
                    'IncludeBusinesses',
                    'IncludeNeighbors',
                    'NeighborCount',
                    'IncludeBankruptcies',
                    'IncludeResidentialPhones',
                    'IncludeBusinessPhones',									
                    'IncludeLiensJudgments',										
                    'IncludeCriminalRecords',									
                    'IncludeSexualOffenses',										
                    'IncludeHuntingFishingLicenses',										
                    'IncludeWeaponPermits',										
                    'LocationReportOnly',
										'MaxResidents',
                    'MaxProperties',
                    'MaxDriversLicenses',
                    'MaxMotorVehicles',
                    'MaxBusinesses',
                    'MaxNeighbors',
                    'MaxBankruptcies',
                    'MaxResidentialPhones',
                    'MaxBusinessPhones',
                    'MaxLiens',
                    'MaxCriminalRecords',
                    'MaxSexualOffenses',
                    'MaxHuntingAndFishingLicenses',
                    'MaxWeaponPermits',
                    'AddressReportRequest',
                    /*---- Gateways ----*/
										'Gateways'
									));
ENDMACRO;	