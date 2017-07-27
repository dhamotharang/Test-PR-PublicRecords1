#warning('This attribute has been deprecated.')

IMPORT AddrBest, BatchDatasets;

EXPORT fetch_BestAddress_recs( DATASET(BatchDatasets.Layouts.batch_in) ds_batch_in ) :=
	FUNCTION
		// 1. Transform for input to AddrBest.		
		data_in := PROJECT( ds_batch_in, BatchDatasets.Transforms.xfm_to_BestAddr_batchIn(LEFT) );
					
		// 2. Get Best Address records from AddrBest, along with other, historical addresses
		// (see above--'IncludeHistoricRecords := TRUE'). NOTE! This will get the most recent 
		// address, not the Best ('Best' = the address having the most prevalence during the 
		// last file update period).
		mod_bestAddr_params := module(AddrBest.Iparams.SearchParams) 
			EXPORT boolean 	Include_Military_Address  := FALSE;
			EXPORT boolean 	ReturnOverLimitIndicator  := FALSE;
			EXPORT boolean 	ReturnAddrPhone		  			:= FALSE;
			EXPORT boolean 	ReturnLatLong 						:= FALSE;
			EXPORT boolean 	ReturnCountyName  				:= FALSE;
			EXPORT boolean 	ReturnConfidenceFlag  		:= TRUE;
			EXPORT boolean 	ReturnUnServAddrIndicator	:= FALSE;
			EXPORT boolean 	UnServAddrDedup						:= FALSE;
			EXPORT boolean 	ReturnMultiADLIndicator		:= FALSE;
			EXPORT boolean 	ReturnPhoneNumber					:= FALSE;
			EXPORT boolean 	ReturnConfirmedMatchCode	:= FALSE;
			EXPORT boolean 	ReturnFlipFlopIndicator		:= FALSE;
			EXPORT boolean 	HistoricMatchCodes				:= TRUE; 
			EXPORT unsigned1 minNameScore 						:= 0; 		
			EXPORT unsigned1 maxNameScore 						:= 255; 	
			EXPORT boolean isV2Score                  := TRUE; // to include some of the new enhancements (e.g. name score) and preserve whatever is common to other services		
			EXPORT boolean IncludeHistoricRecords     := TRUE; 
			EXPORT unsigned1 MaxRecordsToReturn				:= 20;
			EXPORT boolean InputAddressDedup 					:= FALSE;
			EXPORT boolean ReturnDedupFlag						:= TRUE;
			EXPORT boolean IncludeBlankDateLastSeen		:= TRUE;
			EXPORT boolean OnlyReturnSuccessfullyCleanedAddresses	:= TRUE;
		end;
		
		AddrBest.Layout_BestAddr.batch_out_final
				ds_addr_history := AddrBest.Records(data_in, mod_bestAddr_params).best_records;
					
		RETURN ds_addr_history;
	END;
