
import FAB_Statewide, Statewide_Services,doxie;

EXPORT FAP_CountRecs := MODULE
	
	shared STRING2 jurisdiction_st := '' : STORED('Jurisdiction');
	shared boolean FAP_new_Style  := false : STORED('NewStyle');
	shared STRING2 input_jurisdiction := StringLib.StringToUpperCase(TRIM(jurisdiction_st));
		
	EXPORT CountSourceDocs(STRING src_doc_type, DATASET(FAB_Statewide.layout_FAB_Statewide_out) all_recs) :=	FUNCTION		
			jusd_recs      := all_recs(input_jurisdiction = '' or jurisdiction = input_jurisdiction);
			Count_AllRecs  := COUNT(all_recs);
			Count_JusdRecs := COUNT(jusd_recs);
			NumRecs        := DATASET([{src_doc_type, Count_AllRecs - Count_JusdRecs, Count_JusdRecs}],Statewide_Services.layout_CountRecs);
			RETURN NumRecs;			
		END;
		
	//*****  Count all FAB working/non-error-throwing Statewide Records ******
	EXPORT count_records() := FUNCTION	
		voters_recs    := CountSourceDocs(StateWide_Services.constants.constant('VO'), FAP_raw.Search.FAP_SearchVoters()); 
		ucc_recs       := CountSourceDocs(StateWide_Services.constants.constant('UC'), FAP_raw.Search.FAP_SearchUCC());
		property_recs  := CountSourceDocs(StateWide_Services.constants.constant('PR'), FAP_Raw.Search.FAP_SearchProperty());
		HF_recs        := CountSourceDocs(StateWide_Services.constants.constant('HF'), FAP_Raw.Search.FAP_SearchHunting());
		ProfLic_recs   := CountSourceDocs(StateWide_Services.constants.constant('PL'), FAP_Raw.Search.FAP_SearchProfLic());
		bankrup_recs   := CountSourceDocs(StateWide_Services.constants.constant('BK'), FAP_raw.Search.FAP_SearchBankruptcy()); 
		liens_recs     := CountSourceDocs(StateWide_Services.constants.constant('LI'), FAP_Raw.Search.FAP_SearchLiens());
		MD_recs        := CountSourceDocs(StateWide_Services.constants.constant('MD'), FAP_Raw.Search.FAP_SearchMD());		
		Deaths_recs    := CountSourceDocs(StateWide_Services.constants.constant('DE'), FAP_Raw.Search.FAP_SearchDeaths());		
		Targus_recs    := CountSourceDocs(StateWide_Services.constants.constant('WP'), FAP_Raw.Search.FAP_SearchTargusWhitePages());		
		Vehicles_recs  := CountSourceDocs(StateWide_Services.constants.constant('VH'), FAP_Raw.Search.FAP_SearchVeh());
		DL_recs        := CountSourceDocs(StateWide_Services.constants.constant('DL'), FAP_Raw.Search.FAP_SearchDL());		
		Watercraft_recs    := CountSourceDocs(StateWide_Services.constants.constant('WC'), FAP_Raw.Search.FAP_SearchWC());		
		Crim_recs    := CountSourceDocs(StateWide_Services.constants.constant('CR'), FAP_Raw.Search.FAP_SearchCrim());		
		EQ_recs    := CountSourceDocs(StateWide_Services.constants.constant('EQ'), FAP_Raw.Search.FAP_SearchHeaderEQ());		
		EN_recs    := CountSourceDocs(StateWide_Services.constants.constant('EN'), FAP_Raw.Search.FAP_SearchHeaderEN());		
		TN_recs    := CountSourceDocs(StateWide_Services.constants.constant('TN'), FAP_Raw.Search.FAP_SearchHeaderTN());		

    new_recs := 
		         Vehicles_recs
						 +
						 DL_recs
						 +
						 Watercraft_recs
						 +
						 Crim_recs
						 +
						 EQ_recs
						 +
						 if(not doxie.DataRestriction.ECH, EN_recs)
						 						 +
						 if(not doxie.DataRestriction.TCH, TN_recs)
						 ;
		
		recs :=
		       voters_recs 
		       + 
					 ucc_recs 
					 +
					 property_recs 
					 + 
					 HF_recs
					 +
					 ProfLic_recs
					 +
					 bankrup_recs 
					 + 
					 liens_recs 
					 + 
					 MD_recs 
					 + 
					 Deaths_Recs
					 +
					 Targus_recs
					 +
					 if(FAP_new_Style,new_recs)
           ;	

	RETURN recs;
	
	END;
	
	
END;