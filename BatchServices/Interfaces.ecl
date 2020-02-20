IMPORT BatchServices, BatchShare;

EXPORT Interfaces := MODULE

	export Res_config := interface
		export unsigned1 MaxCurrRes := 20;
		export unsigned1 MaxPriorRes := 20;
	// any last seen date more current than this date is considered current
		export unsigned4 ThresholdDateForCurrentResidency := BatchServices.constants.Residents.ThresholdDateForCurrentResidency;
		export boolean ReturnAddrPhone := false;
		export boolean MultiUnitSearch := false;
	end;
	
	//used in BatchServices.STR_BatchService
	export str_config := interface (BatchShare.IParam.BatchParams);
		export unsigned2 	PenaltThreshold;
		export unsigned2 	ShortTermThreshold;
		export boolean 		ExcludeDropIndCheck;
		export boolean 		ReturnDeceased;
		export boolean 		GetSSNBest:=true;
		export unsigned8  MaxResultsPerAcct;
	end;
	
	export i_AK_Config := Interface
	
		// Preferential matching:
		export BOOLEAN MatchName     := FALSE : STORED('Match_Name');
		export BOOLEAN MatchCompName := FALSE : STORED('Match_Comp_Name');
		export BOOLEAN MatchStrAddr  := FALSE : STORED('Match_Street_Address');     
		export BOOLEAN MatchCity     := FALSE : STORED('Match_City');
		export BOOLEAN MatchState    := FALSE : STORED('Match_State');       
		export BOOLEAN MatchZip      := FALSE : STORED('Match_Zip');         
		export BOOLEAN MatchPhone    := FALSE : STORED('Match_Phone');          
		export BOOLEAN MatchSSN      := FALSE : STORED('Match_SSN');         
		export BOOLEAN MatchFEIN     := FALSE : STORED('Match_FEIN');           
		export BOOLEAN MatchDOB      := FALSE : STORED('Match_DOB'); 
		export BOOLEAN MatchDID      := FALSE : STORED('Match_LinkID');

	/*
		// Used in AutokeyI fetches:
		export boolean L_UseNewPreferredFirst := false; // ADD (for AutoKeyI.FetchI_Indv_Zip)
		export boolean noFail := false;                 // ok
		export boolean useAllLookups := false;          // ok
		export boolean workHard;                        // ok
		export set of string1 get_skip_set := [];       // see skip_set, below
		export string autokey_keyname_root;             // ADD
		export boolean nicknames;                       // ok
		export boolean phonetics;                       // ok
	*/	                                          
		// For fuzziness:
		export BOOLEAN phonetics := FALSE : STORED('Phonetics');  // remove from batch service interfaces
		export BOOLEAN nicknames := FALSE : STORED('Nicknames');  // remove from batch service interfaces
		export BOOLEAN workHard  := phonetics OR nicknames OR ( MatchName AND MatchCity AND NOT (MatchStrAddr AND MatchState AND MatchZip) ) OR (MatchStrAddr AND NOT MatchState) : STORED('workHard');

		export boolean L_UseNewPreferredFirst := false; // for AutoKeyI.FetchI_Indv_Zip only
		export boolean FuzzySecRange_value    := false; // for AutoKeyI.FetchI_Indv_Address
		export boolean do_primname_word_match := false; // for AutoKeyI.FetchI_Indv_Address
		
		export BOOLEAN isBareAddr    := FALSE; 
		export BOOLEAN addr_loose    := FALSE;
		export BOOLEAN addr_error_value := FALSE;

		export BOOLEAN nofail        := FALSE;
		export BOOLEAN useAllLookups := FALSE;	
		export BOOLEAN RunDeepDive   := FALSE : STORED('Run_Deep_Dive');
		
		/* ***** System flags and values ***** */
		export BOOLEAN isTestHarness       := FALSE;  // REMOVE FOREVER
		export UNSIGNED2 PenaltThreshold   := 10  : STORED('PenaltThreshold');
		
		export string autokey_keyname_root := '';
		export unsigned4 lookup_value      :=  0;
		export boolean isCRS               := FALSE;
		
		export useAutokeyI                 := FALSE;
		
		// Determine automatically any skip values based on match criteria. Used to help build skip_set.
		export SET OF STRING1 auto_skip := IF( ((MatchCompName OR MatchFEIN) AND NOT MatchName),['C'], ['']);
	
		// - Skip-set for proper service behavior.
		export SET OF STRING1 skip_set := [ ];

	END;
	
	EXPORT UCCV2 := MODULE
	
		EXPORT i_Query_Filters := INTERFACE
		
			SHARED MATCH_ANYTHING  := Constants.MATCH_ANYTHING;
			SHARED UCase           := StringLib.StringToUpperCase;
			
			// Requested additional search fields:
				// o Secured Party Name  -- * No. * Per discussion with George 6/2008
				// o Status  -------------- Only California supplies a Filing Status at all for their UCC Liens.
				// o Min Date  ------------ Minimum date in a range or 'all after' date.
				// o Max Date  ------------ Minimum date in a range or 'all before' date.
				//        Date filter should be flexible. It should be able to do greater than, less than, or between. 
				//        i.e. they should allow for date ranges and specific dates. If a customer wants a specific 
				//        month, they will need to enter 1/1/2008 ? 1/31/2008.				
				// o SIC  ----------------- * No. * Per discussion with George 6/2008
				// o State  --------------- i.e. Filing Jurisdiction--usually a state, but also:
				//        - 'TXD' = TEXAS DALLAS COUNTY RECORD
				//        - 'TXH' = TEXAS HARRIS COUNTY RECORD
				//        - 'NYC' = NEW YORK CITY RECORD	
				// o Zip (debtor)
				// o Collateral
				// o Amount  -------------- * No. * Per discussion with Rosemary 8/2008. Only IL Federal Tax Liens have amount values.
								
				SHARED STRING20  __filing_status_desc   := ''             : STORED('filing_status');				
				SHARED STRING3   __filing_jurisdiction  := ''             : STORED('filing_jurisdiction');
        SHARED STRING10  __debtor_zip           := ''             : STORED('debtor_zip');
				SHARED STRING128 __collateral           := ''             : STORED('collateral');
				SHARED UNSIGNED4 __max_results_per_acct := 100            : STORED('max_results_per_acct');
				
				EXPORT STRING10  min_date               := '01/01/1900'   : STORED('min_date'); 
				 
				EXPORT STRING10  max_date               := '12/31/3000'   : STORED('max_date'); 
				
				EXPORT STRING22  filing_status_desc     := IF( __filing_status_desc = '',
				                                               MATCH_ANYTHING,
				                                               '^' + UCase(TRIM(__filing_status_desc)) + '$'
				                                              );
				EXPORT STRING4   filing_jurisdiction    := IF( __filing_jurisdiction = '', 
				                                               MATCH_ANYTHING,
				                                               UCase(__filing_jurisdiction)
				                                              );																									
        EXPORT STRING10  debtor_zip             := IF( __debtor_zip = '',
				                                               MATCH_ANYTHING,
				                                               __debtor_zip
				                                              );
				EXPORT STRING128 collateral             := IF( __collateral = '',
				                                               MATCH_ANYTHING,
				                                               UCase(__collateral)
				                                              );
				EXPORT UNSIGNED4 max_results_per_acct   := IF( __max_results_per_acct > 1000, 
				                                               1000, 
				                                               __max_results_per_acct
				                                              ); // Cap the maximum # results at 1000 per acctno.
		END;
		
	END;
	
	export ReversePhoneHistory_config := interface
		export unsigned4 MaxRecordsPerPhone := 4;
		export string applicationType := '';
	end;
	
END;
