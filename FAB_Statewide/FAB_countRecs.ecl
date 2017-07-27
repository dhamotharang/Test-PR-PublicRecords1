
IMPORT FAB_Statewide, FAP_Statewide, Statewide_Services;

EXPORT FAB_countRecs := MODULE
	
	STRING2 jurisdiction := '' : STORED('Jurisdiction');
	SHARED STRING2 input_juris := StringLib.StringToUpperCase(jurisdiction);
	SHARED DOC_TYPE            := Statewide_Services.Constants;
  shared boolean FAB_new_Style  := false :STORED('NewStyle');
	
	// The following function will take in a passed source dataset and
	// then performs some counting and loads the results into a dataset.
	EXPORT CountSourceDocs(STRING src_doc_type, DATASET(FAB_Statewide.layout_FAB_Statewide_out) all_recs) :=	FUNCTION		
			jusd_recs      := all_recs(TRIM(jurisdiction) = TRIM(input_juris) or TRIM(input_juris) = '');
			Count_AllRecs  := COUNT(all_recs);
			Count_JusdRecs := COUNT(jusd_recs);
			ds_NumRecs     := DATASET([{src_doc_type, Count_AllRecs - Count_JusdRecs, Count_JusdRecs}], Statewide_Services.layout_CountRecs);
				
			RETURN ds_NumRecs;			
		END;
		
	// Count all Statewide records from available single source search services. Note that we're passing 
	// a function as one of the parameters to CountSourceDocs().
	EXPORT count_records() := FUNCTION
		corp_recs    := CountSourceDocs(StateWide_Services.constants.constant('CO'), FAB_Statewide.FAB_raw.Search.FAB_SearchCorpData()); 
		ucc_recs     := CountSourceDocs(StateWide_Services.constants.constant('UC'), FAP_StateWide.FAP_raw.search.FAP_SearchUCC()); 
		prop_recs    := CountSourceDocs(StateWide_Services.constants.constant('PR'), FAP_StateWide.FAP_raw.search.FAP_SearchProperty());
		// hunting_recs := CountSourceDocs(StateWide_Services.constants.constant('HF'), FAP_StateWide.FAP_raw.search.FAP_SearchHunting());
		proflic_recs := CountSourceDocs(StateWide_Services.constants.constant('PL'), FAP_StateWide.FAP_raw.search.FAP_SearchProfLic());
		bankrpt_recs := CountSourceDocs(StateWide_Services.constants.constant('BK'), FAP_StateWide.FAP_raw.search.FAP_SearchBankruptcy());
		liens_recs   := CountSourceDocs(StateWide_Services.constants.constant('LI'), FAP_StateWide.FAP_raw.search.FAP_SearchLiens());
		fbn_recs     := CountSourceDocs(StateWide_Services.constants.constant('FB'), FAB_Statewide.FAB_raw.Search.FAB_SearchFBN());
		calbus_recs  := CountSourceDocs(StateWide_Services.constants.constant('CB'), FAB_Statewide.FAB_Raw.Search.FAB_SearchCALBUS());
		txbus_recs   := CountSourceDocs(StateWide_Services.constants.constant('TB'), FAB_Statewide.FAB_Raw.Search.FAB_SearchTXBUS());		
		Vehicles_recs     :=CountSourceDocs(StateWide_Services.constants.constant('VH'), FAP_StateWide.FAP_Raw.Search.FAP_SearchVeh());
		Watercraft_recs    := CountSourceDocs(StateWide_Services.constants.constant('WC'), FAP_StateWide.FAP_Raw.Search.FAP_SearchWC());		

    new_recs := 
		         Vehicles_recs
						 +
						 Watercraft_recs
						 ;
    recs := 
					corp_recs 
				 + ucc_recs
				 + prop_recs
				 + proflic_recs
				 + bankrpt_recs
				 + liens_recs
				 + fbn_recs
		     + calbus_recs 
				 + txbus_recs
				 + if(FAB_new_style,new_recs);
				 ;			
		
		RETURN recs(Source_type<>'');
	END;
	
	
END;