EXPORT MAC_PersonReports_FinderReportService := MACRO
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
                    'SSNMask',
                    'ResellerType',
                    /*---- Other search fields ----*/
                    'DID',
                    'SSN',
                    'UnparsedFullName',
                    'FirstName',
                    'MiddleName',
                    'LastName',
                    'AllowNickNames',
                    'Addr',
                    'City',
                    'State',
                    'Zip',
                    'DOB',
                    'Phone',
                    /*---- Misc Input Options	----*/
                    '_n_phones',
                    'AddressesWithoutPhones',
                    'AddressRecencyDays',
                    'ExcludeDMVPII',
                    'IndicateUnpub',
                    'LnBranded',
                    'PhoneticMatch',
                    'ReturnAllImposters',
                    'ReturnAlsoFound',
                    'UnverifiedAddresses',
                    /*---- Boolean Include Options	----*/
                    'IncludeCriminalIndicators',
                    'IncludeDriversLicenses',
                    'IncludeMotorVehicles',
                    'IncludePeopleAtWork',
                    'IncludePhonesFeedback',
                    'IncludePhonesPlus',
                    'IncludeProfessionalLicenses',
                    'IncludeEmailAddresses',
                    /*----  Pagination Fields ----*/
                    'MaxResults',
                    'MaxResultsThisTime',
                    'SkipRecords',
                    /*----  iesp form ----*/
                    'PeopleReportRequest',
                    'gateways'
                ));

ENDMACRO;
