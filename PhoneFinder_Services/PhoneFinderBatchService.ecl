// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
EXPORT PhoneFinderBatchService :=
MACRO

	IMPORT Gateway, PhoneFinder_Services, AutoheaderV2;
	 #constant('SearchLibraryVersion', AutoheaderV2.Constants.LibVersion.SALT);
   #stored('useOnlyBestDID',true); // used to determine the 1 "best" did for the input criteria
	// Batch input request
	dBatchReq := DATASET([],PhoneFinder_Services.Layouts.BatchIn) : STORED('BatchRequest');

	// Gateway configurations
	dGateways := Gateway.Configuration.Get();

 reportMod := PhoneFinder_Services.iParam.GetBatchParams();

	modBatchRecords := PhoneFinder_Services.PhoneFinder_BatchRecords(dBatchReq,reportMod,
   																																		IF(reportMod.TransactionType = PhoneFinder_Services.Constants.TransType.PHONERISKASSESSMENT,
   																																											dGateways(servicename IN PhoneFinder_Services.Constants.PhoneRiskAssessmentGateways),dGateways));

    royalties	 := modBatchRecords.dRoyalties;
   	dPhones   	:= modBatchRecords.dBatchOut;
   	Zumigo_Log	:= modBatchRecords.Zumigo_History_Recs;

		// Suppress records that have blank identitty name, identity address and carrier name if option is set
		// NOTE: Any changes to below non-blank logic will need to be communicated to the Batch team as well
    dNonblankRelevantRecs := dPhones(identity1_full != '' OR (identity1_first != '' AND identity1_last!= '')
													OR (identity1_streetname != '' AND ((identity1_city != '' AND identity1_state != '' ) OR identity1_zip5 != ''))
													OR carrier <>'');


		results := if(reportMod.SuppressNonRelevantRecs,dNonblankRelevantRecs,dPhones);

   OUTPUT(results,named('Results'));
   OUTPUT(royalties,named('RoyaltySet'));
   OUTPUT(Zumigo_Log,named('LOG_DELTA__PHONEFINDER_DELTA__PHONES__GATEWAY'));


ENDMACRO;
