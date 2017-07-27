EXPORT MAC_DriversV2_Services_Batch_Service := MACRO
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
											/*---- batch_in Field .----*/
											'batch_in',
											/*---- Other Fields ----*/
											'PenaltThreshold',
											'Return_Current_Only',
											'Run_Deep_Dive',
											'IncludeNonDMVSources',
											'Max_results_per_acct',
											'MaxResults')
							);								
ENDMACRO;