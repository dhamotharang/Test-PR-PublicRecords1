﻿// This service created to add Web Service fields for DueDiligence.DueDiligence_Batch_Service

EXPORT MAC_DueDiligence_Batch_Service := MACRO

  #WEBSERVICE(FIELDS(	
                    /*---- Due Diligence Request Fields ----*/
                    'batch_in',
                    'attributesVersion',
                    /*---- Due Diligence FBOP Fields ----*/
                    'FBOP_DateTolerance',
                    'FBOP_DateToleranceYearsPrior',
                    'FBOP_IncludeExactInputLastName',
                    'FBOP_IncludeNicknames',
                    'FBOP_NameOrderSearched',
                    'FBOP_IncludeLexIDPrimaryDOBYear',
                    'FBOP_IncludeDOBYearRadius',
                    'FBOP_DOBNumberOfYearsRadius',                  
                    /*---- Citizenship Request Fields ----*/
                    'modelName',
                    /*---- Compliance Fields ----*/
                    'glbPurpose',
                    'dppaPurpose',
                    'dataRestrictionMask',
                    'dataPermissionMask',
                    /*---- CCPA ----*/
                    'LexIdSourceOptout',
                    '_TransactionId',
                    '_BatchUID',
                    '_GCID',
                    /*---- Debug ----*/
                    'debugMode',
                    'modelValidation'
					));
ENDMACRO;