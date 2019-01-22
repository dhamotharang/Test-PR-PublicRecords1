IMPORT BIPV2, Business_Risk, Business_Risk_BIP, BusinessInstantID20_Services, Gateway, ut, OFAC_XG5, Patriot, iesp, GlobalWatchLists, Risk_Indicators, STD;

EXPORT fn_GetGlobalWatchlistInfo( DATASET(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo) ds_input,
                                  Business_Risk_BIP.LIB_Business_Shell_LIBIN Options
																) := 	FUNCTION
		UCase := STD.Str.ToUpperCase;
		
		ofac_only := FALSE;

		patriot.Layout_batch_in PrepPatriot(ds_input le) :=
			TRANSFORM
				SELF.seq := le.seq;
				SELF.name_first := '';
				SELF.name_middle := '';
				SELF.name_last := '';
				SELF.name_unparsed := le.CompanyName;
				SELF.country := '';
				SELF.search_type := 'B';
				SELF.dob :=  '';
				SELF.acctNo := le.AcctNo;
			END;
		
		inForm_single := GROUP(PROJECT(ds_input, PrepPatriot(LEFT)),SEQ);

		//************************************************** ofac_version = 1,2,3 **************************************************
		
    // Get Patriot base records
		patOut := Patriot.Search_Base_Function(inForm_single, ofac_only, Options.Global_Watchlist_Threshold, true, Options.ofac_version,Options.include_ofac,Options.include_additional_watchlists,Options.Watchlists_Requested);

		// Sort by best match, OFAC and non-OFAC
		Patriot.Layout_Base_Results.parent sorter(Patriot.Layout_Base_Results.parent le) :=
			TRANSFORM
				SELF.pty_keys := 
            CHOOSEN(SORT(le.pty_keys(pty_key[1..4]  = 'OFAC'), -score, pty_key),7) + 
            CHOOSEN(SORT(le.pty_keys(pty_key[1..4] <> 'OFAC'), -score, pty_key),7);
				SELF := le;
			END;

		patPref := PROJECT(patOut, sorter(LEFT));
    
    // Normalize the pty_keys child dataset records so we're working with a single, flat dataset.
    layout_patPref_normed := RECORD
      string10 acctno;
      unsigned4 seq := 0; 
      Patriot.Layout_Base_Results.Layout_keys;
    END;
    
    patPref_normalized :=
      NORMALIZE(
        patPref, LEFT.pty_keys,
        TRANSFORM( layout_patPref_normed,
          SELF.acctno      := LEFT.acctno;
          SELF.seq         := LEFT.seq; 
          SELF.score       := RIGHT.score;
          SELF.pty_key     := RIGHT.pty_key;
          SELF.first_name  := RIGHT.first_name;
          SELF.last_name   := RIGHT.last_name;
          SELF.cname       := RIGHT.cname;
          SELF.country     := RIGHT.country;
          SELF.search_type := RIGHT.search_type;         
        )
      );
	
    // Go get the GWL payload data.
    layout_Patriot_Payload := RECORD
     	string10 acctno;
      unsigned4 seq := 0;
      GlobalWatchLists.Layout_GlobalWatchLists;
    END;

    pat_recs_pre := 
      join(
        patPref_normalized, GlobalWatchLists.Key_GlobalWatchLists_Key, 
        left.pty_key <> '' and
        keyed(right.pty_key = left.pty_key),
        transform( layout_Patriot_Payload, 
          name_matches      := right.first_name=left.first_name AND ut.NBEQ(right.last_name,left.last_name);
          cmpy_matches      := ut.NBEQ(right.cname,left.cname);
          country_matches   := UCase(right.name_type)='COUNTRY' AND ut.NBEQ(right.address_country, left.country);
          something_matched := name_matches or cmpy_matches or country_matches;
          
          self.acctno     := left.acctno,
          self.seq        := left.seq,
          self.first_name := if(something_matched, right.first_name, skip);
          self := right
         ), 
         atmost(5000), keep(1)
       );

    // Transform data into what's needed for BIID 2.0.
		layout_watchlist_temp := RECORD
      string10 acctno;
      unsigned4 seq := 0; 
      BOOLEAN isOFAC := FALSE;
			STRING60 bus_watchlist_table;
			STRING120 bus_watchlist_program;
			STRING10 bus_watchlist_record_number;
			STRING120 bus_watchlist_companyname;
			STRING20 bus_watchlist_firstname;
			STRING20 bus_watchlist_lastname;
			STRING50 bus_watchlist_address;
			STRING30 bus_watchlist_city;
			STRING2 bus_watchlist_state;
			STRING9 bus_watchlist_zip;
			STRING30 bus_watchlist_country;
			STRING200 bus_watchlist_entity_name;
			STRING4 bus_watchlist_sequence;
		END;
    
    pat_recs := 
      project(
        pat_recs_pre, 	
          transform(layout_watchlist_temp,
            nocleanaddr := left.prim_range = '' and left.prim_name = '' and left.zip = '';

            SELF.acctno     := left.acctno,
            SELF.seq        := left.seq,
            SELF.isOFAC     := left.pty_key[1..4]  = 'OFAC',
            SELF.bus_watchlist_sequence      := '',
            SELF.bus_watchlist_table         := left.source,
            SELF.bus_watchlist_program       := GlobalWatchLists.program_lookup(left.sanctions_program_1),
            SELF.bus_watchlist_record_number := left.pty_key,
            SELF.bus_watchlist_country       := left.address_country,
            SELF.bus_watchlist_entity_name   := left.orig_pty_name,
            SELF.bus_watchlist_companyname   := left.cname,
            SELF.bus_watchlist_firstname     := left.fname,
            SELF.bus_watchlist_lastname      := left.lname,
            SELF.bus_watchlist_address := 
              if(nocleanaddr,
                trim(left.address_line_1) + ' ' + trim(left.address_line_2) + ' ' + trim(left.address_line_3),
                Risk_Indicators.MOD_AddressClean.street_address('',left.prim_range, left.predir, left.prim_name, left.suffix, left.postdir, left.unit_desig, left.sec_range)
              ),
            // parsed watchlist address
            SELF.bus_watchlist_city  := if(nocleanaddr, left.address_city          , left.v_city_name),
            SELF.bus_watchlist_state := if(nocleanaddr, left.address_state_province, left.st),
            SELF.bus_watchlist_zip   := if(nocleanaddr, left.address_postal_code   , left.zip)
           )
         );
    
    // Load payload records into OFAC and Watchlists child datasets:
		temp_OFACLayout := { layout_watchlist_temp AND NOT [ seq, acctno ] };
		
		temp_OFACLayoutDS := RECORD // OFAC
			UNSIGNED4 Seq;
			DATASET(temp_OFACLayout) OFAC;
			DATASET(temp_OFACLayout) Watchlists;
		END;

    // ...create seed record...
    ds_input_denormed := 
       PROJECT( ds_input, TRANSFORM( temp_OFACLayoutDS, SELF.seq := LEFT.seq, SELF := [] ) );
    
    // ...bolt on Watchlists child dataset...
		SearchOut_pre := 
      DENORMALIZE(
        ds_input_denormed, pat_recs(NOT isOFAC), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := [];
        ), 
        LEFT OUTER
      );

    // ...and bolt on OFAC child dataset.
		SearchOut := 
      DENORMALIZE(
        SearchOut_pre, pat_recs(isOFAC), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.OFAC := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
      

		//************************************************** ofac_version = 4 **************************************************

    // Much of the following logic was copied from OFAC_XG5.FormatXG5_BIIDWatchlist2( ) and modified.
    
    // Kill an unnecessary Bridger gateway call if OFACVersion isn't 4.
    gateways_param := IF( Options.OFAC_Version = 4, Options.Gateways, DATASET( [], Gateway.Layouts.Config ) );
    
    OFAC_XG5.Layout.InputLayout XG5prep(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo le) := TRANSFORM
      SELF.seq := le.seq;
      self.acctno := le.acctno;
      SELF.FullName := le.CompanyName;
      SELF.searchType := 'B'; // Use instead: GlobalWatchLists.Constants.non_individual_code; // 'N'
      SELF := [];
    END;
     
    prep_XG5 := 
      PROJECT(
        ds_input, 
        TRANSFORM( OFAC_XG5.Layout.InputLayout,
          SELF.seq        := LEFT.seq,
          self.acctno     := LEFT.acctno,
          SELF.FullName   := LEFT.CompanyName,
          SELF.searchType := GlobalWatchLists.Constants.non_individual_code;
          SELF := []
        )
      ); 

    INTEGER2 default_dobRadius := -1;
    
    XG5_ptys := OFAC_XG5.OFACXG5call(prep_XG5, 
                                     ofac_only,
                                     Options.Global_Watchlist_Threshold * 100, 
                                     Options.include_ofac,
                                     Options.include_additional_watchlists,
                                     default_dobRadius,
                                     Options.Watchlists_Requested,
                                     gateways_param);
																	
    // Fail immediately as we don't want customers to think there was no hit on OFAC.
    // if(exists(XG5_ptys(errorMessage <> '')), FAIL('Bridger Gateway Error'));
    validXG5_ptys := XG5_ptys(IF(errorMessage <> '',ERROR('Bridger Gateway Error'), true));
    
    XG5Parsed := OFAC_XG5.OFACXG5_Watchlist2_Response(validXG5_ptys);

    NonErrorRecsXG5 := XG5Parsed(errormessage = '');

    layout_EntityMatchesXG5 := RECORD
      string10 acctno;
      unsigned4 seq := 0;
      string ErrorMessage;
      OFAC_XG5.Layout.EntityMatch;
      OFAC_XG5.Layout.AKABestMatches AND NOT [blockid, EntitySeq];
      OFAC_XG5.Layout.AddressMatches AND NOT [blockid, EntitySeq];
      OFAC_XG5.Layout.ResultMatchFile AND NOT [blockid, EntitySeq];
    END;

    PrepEntityXG5 := 
      project(
        NonErrorRecsXG5, 
        transform( layout_EntityMatchesXG5, 
        self.ErrorMessage := left.ErrorMessage,
        self := left.entityRec[1],
        self := left.akaRec(bestId = akaID)[1],
        self := [];
        ));
                                
    AddAddrXG5 := 
      join(	
        PrepEntityXG5, NonErrorRecsXG5.addrRec(AddressID = 1),  //only want 1 address
        left.BlockID = right.blockid and
        left.EntitySeq = right.EntitySeq,
        transform( layout_EntityMatchesXG5,
          self.ErrorMessage := left.ErrorMessage,
          self.BlockID := left.blockid,
          self.EntitySeq := left.EntitySeq,
          self := right,
          self := left,
          self := []
         ), 
         left outer
       );
                                                          
    AddFileXG5 := 
      join(	
        AddAddrXG5, NonErrorRecsXG5.FileRec,
        left.BlockID = right.blockid and
        left.EntitySeq = right.EntitySeq,
        transform( layout_EntityMatchesXG5,
          self.ErrorMessage := left.ErrorMessage,
          self.BlockID := left.blockid,
          self.EntitySeq := left.EntitySeq,
          self.EntityTypeDesc := if(left.EntityTypeDesc ='', 'Unknown', left.EntityTypeDesc);
          self := right,
          self := left
        ), 
        left outer
      );		
                              
    dedupRespXG5 := dedup(sort(NonErrorRecsXG5, blockid, entityseq), blockid);

    CurrentMatchesXG5 :=  
      join(
        dedupRespXG5, AddFileXG5( TRIM(BestName) != '' ),
        left.BlockID = right.blockid, 
        transform(layout_EntityMatchesXG5, self.seq := left.seq, self := right)
      ); 

    CurrentMatchesXG5_sorted := SORT( CurrentMatchesXG5, blockid, -entitymatchscore, EntityPartyKey, RECORD);

    // Transform data into what's needed for BIID 2.0. 
    XG5_recs := 
      project(
        CurrentMatchesXG5_sorted, 	
          transform(layout_watchlist_temp, 
            sourceLength := length(left.FileName);
            noaddr := left.StreetAddress1 = '';

            SELF.acctno     := left.acctno,
            SELF.seq        := left.seq,
            SELF.isOFAC     := left.EntityPartyKey[1..4]  = 'OFAC',
            SELF.bus_watchlist_sequence      := '',
            SELF.bus_watchlist_table         := if(left.errormessage <> '', 'ERR', left.FileName[1..(sourceLength - 4)]),
            SELF.bus_watchlist_program       := OFAC_XG5.Program_lookup(UCase(trim(left.EntityReason))),
            SELF.bus_watchlist_record_number := left.EntityPartyKey;
            SELF.bus_watchlist_country       := left.country;
            SELF.bus_watchlist_entity_name   := left.BestName,
            SELF.bus_watchlist_companyname   := left.EntityName,
            SELF.bus_watchlist_firstname     := If(left.BestID = 0, left.EntityNamefirst, left.FirstName);
            SELF.bus_watchlist_lastname      := If(left.BestID = 0, left.EntityNameLast , left.LastName);
            SELF.bus_watchlist_address       := trim(left.StreetAddress1),
            // parsed watchlist address
            SELF.bus_watchlist_city  := trim(left.city),
            SELF.bus_watchlist_state := if(noaddr, '', left.state),
            SELF.bus_watchlist_zip   := if(noaddr, '', left.PostalCode)
           )
         );
           
    // Seed record is created already; bolt on XG5 Watchlists child dataset...
		SearchOutXG5_pre := 
      DENORMALIZE(
        ds_input_denormed, XG5_recs(NOT isOFAC), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := [];
        ), 
        LEFT OUTER
      );

    // ...and bolt on XG5 OFAC child dataset.
		SearchOutXG5 := 
      DENORMALIZE(
        SearchOutXG5_pre, XG5_recs(isOFAC), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.OFAC := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
  
    // End of XG5 logic

    // ---------------[ Transform to output layout ]---------------
    					
		BusinessInstantID20_Services.Layouts.OFACAndWatchlistLayoutFlat xfm_toFinalLayout(temp_OFACLayoutDS le) := 
				TRANSFORM
					SELF.seq 													:= le.seq;
					//1
					SELF.bus_ofac_table_1    					:= le.OFAC[1].bus_watchlist_table;
					SELF.bus_ofac_program_1 					:= le.OFAC[1].bus_watchlist_program;
					SELF.bus_ofac_record_number_1     := le.OFAC[1].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_1  			:= le.OFAC[1].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_1  			  := le.OFAC[1].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_1  			  := le.OFAC[1].bus_watchlist_lastname;
					SELF.bus_ofac_address_1     			:= le.OFAC[1].bus_watchlist_address;
					SELF.bus_ofac_city_1    					:= le.OFAC[1].bus_watchlist_city;
					SELF.bus_ofac_state_1 						:= le.OFAC[1].bus_watchlist_state;
					SELF.bus_ofac_zip_1  							:= le.OFAC[1].bus_watchlist_zip;
					SELF.bus_ofac_country_1       		:= le.OFAC[1].bus_watchlist_country;
					SELF.bus_ofac_entity_name_1       := le.OFAC[1].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_1       		:= le.OFAC[1].bus_watchlist_sequence;
					//2	
					SELF.bus_ofac_table_2    					:= le.OFAC[2].bus_watchlist_table;
					SELF.bus_ofac_program_2 					:= le.OFAC[2].bus_watchlist_program;
					SELF.bus_ofac_record_number_2     := le.OFAC[2].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_2  			:= le.OFAC[2].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_2  			  := le.OFAC[2].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_2  			  := le.OFAC[2].bus_watchlist_lastname;
					SELF.bus_ofac_address_2     			:= le.OFAC[2].bus_watchlist_address;
					SELF.bus_ofac_city_2    					:= le.OFAC[2].bus_watchlist_city;
					SELF.bus_ofac_state_2 						:= le.OFAC[2].bus_watchlist_state;
					SELF.bus_ofac_zip_2  							:= le.OFAC[2].bus_watchlist_zip;
					SELF.bus_ofac_country_2       		:= le.OFAC[2].bus_watchlist_country;
					SELF.bus_ofac_entity_name_2       := le.OFAC[2].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_2       		:= le.OFAC[2].bus_watchlist_sequence;
					//3
					SELF.bus_ofac_table_3    					:= le.OFAC[3].bus_watchlist_table;
					SELF.bus_ofac_program_3 					:= le.OFAC[3].bus_watchlist_program;
					SELF.bus_ofac_record_number_3     := le.OFAC[3].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_3  			:= le.OFAC[3].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_3  			  := le.OFAC[3].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_3  			  := le.OFAC[3].bus_watchlist_lastname;
					SELF.bus_ofac_address_3     			:= le.OFAC[3].bus_watchlist_address;
					SELF.bus_ofac_city_3    					:= le.OFAC[3].bus_watchlist_city;
					SELF.bus_ofac_state_3 						:= le.OFAC[3].bus_watchlist_state;
					SELF.bus_ofac_zip_3  							:= le.OFAC[3].bus_watchlist_zip;
					SELF.bus_ofac_country_3       		:= le.OFAC[3].bus_watchlist_country;
					SELF.bus_ofac_entity_name_3       := le.OFAC[3].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_3       		:= le.OFAC[3].bus_watchlist_sequence;
					//4
					SELF.bus_ofac_table_4    					:= le.OFAC[4].bus_watchlist_table;
					SELF.bus_ofac_program_4 					:= le.OFAC[4].bus_watchlist_program;
					SELF.bus_ofac_record_number_4     := le.OFAC[4].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_4  			:= le.OFAC[4].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_4  			  := le.OFAC[4].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_4  			  := le.OFAC[4].bus_watchlist_lastname;
					SELF.bus_ofac_address_4     			:= le.OFAC[4].bus_watchlist_address;
					SELF.bus_ofac_city_4    					:= le.OFAC[4].bus_watchlist_city;
					SELF.bus_ofac_state_4 						:= le.OFAC[4].bus_watchlist_state;
					SELF.bus_ofac_zip_4  							:= le.OFAC[4].bus_watchlist_zip;
					SELF.bus_ofac_country_4       		:= le.OFAC[4].bus_watchlist_country;
					SELF.bus_ofac_entity_name_4       := le.OFAC[4].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_4       		:= le.OFAC[4].bus_watchlist_sequence;
					//5
					SELF.bus_ofac_table_5    					:= le.OFAC[5].bus_watchlist_table;
					SELF.bus_ofac_program_5 					:= le.OFAC[5].bus_watchlist_program;
					SELF.bus_ofac_record_number_5     := le.OFAC[5].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_5  			:= le.OFAC[5].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_5  			  := le.OFAC[5].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_5  			  := le.OFAC[5].bus_watchlist_lastname;
					SELF.bus_ofac_address_5     			:= le.OFAC[5].bus_watchlist_address;
					SELF.bus_ofac_city_5    					:= le.OFAC[5].bus_watchlist_city;
					SELF.bus_ofac_state_5 						:= le.OFAC[5].bus_watchlist_state;
					SELF.bus_ofac_zip_5  							:= le.OFAC[5].bus_watchlist_zip;
					SELF.bus_ofac_country_5       		:= le.OFAC[5].bus_watchlist_country;
					SELF.bus_ofac_entity_name_5       := le.OFAC[5].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_5       		:= le.OFAC[5].bus_watchlist_sequence;
					//6
					SELF.bus_ofac_table_6    					:= le.OFAC[6].bus_watchlist_table;
					SELF.bus_ofac_program_6 					:= le.OFAC[6].bus_watchlist_program;
					SELF.bus_ofac_record_number_6     := le.OFAC[6].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_6  			:= le.OFAC[6].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_6  			  := le.OFAC[6].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_6  			  := le.OFAC[6].bus_watchlist_lastname;
					SELF.bus_ofac_address_6     			:= le.OFAC[6].bus_watchlist_address;
					SELF.bus_ofac_city_6    					:= le.OFAC[6].bus_watchlist_city;
					SELF.bus_ofac_state_6 						:= le.OFAC[6].bus_watchlist_state;
					SELF.bus_ofac_zip_6  							:= le.OFAC[6].bus_watchlist_zip;
					SELF.bus_ofac_country_6       		:= le.OFAC[6].bus_watchlist_country;
					SELF.bus_ofac_entity_name_6       := le.OFAC[6].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_6       		:= le.OFAC[6].bus_watchlist_sequence;
					//7
					SELF.bus_ofac_table_7    					:= le.OFAC[7].bus_watchlist_table;
					SELF.bus_ofac_program_7 					:= le.OFAC[7].bus_watchlist_program;
					SELF.bus_ofac_record_number_7     := le.OFAC[7].bus_watchlist_record_number;
					SELF.bus_ofac_companyname_7  			:= le.OFAC[7].bus_watchlist_companyname;
					SELF.bus_ofac_firstname_7  			  := le.OFAC[7].bus_watchlist_firstname;
					SELF.bus_ofac_lastname_7  			  := le.OFAC[7].bus_watchlist_lastname;
					SELF.bus_ofac_address_7     			:= le.OFAC[7].bus_watchlist_address;
					SELF.bus_ofac_city_7    					:= le.OFAC[7].bus_watchlist_city;
					SELF.bus_ofac_state_7 						:= le.OFAC[7].bus_watchlist_state;
					SELF.bus_ofac_zip_7  							:= le.OFAC[7].bus_watchlist_zip;
					SELF.bus_ofac_country_7       		:= le.OFAC[7].bus_watchlist_country;
					SELF.bus_ofac_entity_name_7       := le.OFAC[7].bus_watchlist_entity_name;
					SELF.bus_ofac_sequence_7       		:= le.OFAC[7].bus_watchlist_sequence;
					//1
					SELF.bus_watchlist_table_1    		:= le.Watchlists[1].bus_watchlist_table;
					SELF.bus_watchlist_program_1 			:= le.Watchlists[1].bus_watchlist_program;
					SELF.bus_watchlist_record_number_1:= le.Watchlists[1].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_1  := le.Watchlists[1].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_1    := le.Watchlists[1].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_1     := le.Watchlists[1].bus_watchlist_lastname;
					SELF.bus_watchlist_address_1     	:= le.Watchlists[1].bus_watchlist_address;
					SELF.bus_watchlist_city_1    			:= le.Watchlists[1].bus_watchlist_city;
					SELF.bus_watchlist_state_1 				:= le.Watchlists[1].bus_watchlist_state;
					SELF.bus_watchlist_zip_1  				:= le.Watchlists[1].bus_watchlist_zip;
					SELF.bus_watchlist_country_1      := le.Watchlists[1].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_1  := le.Watchlists[1].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_1     := le.Watchlists[1].bus_watchlist_sequence;
					//2
					SELF.bus_watchlist_table_2    		:= le.Watchlists[2].bus_watchlist_table;
					SELF.bus_watchlist_program_2 			:= le.Watchlists[2].bus_watchlist_program;
					SELF.bus_watchlist_record_number_2:= le.Watchlists[2].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_2  := le.Watchlists[2].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_2    := le.Watchlists[2].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_2     := le.Watchlists[2].bus_watchlist_lastname;
					SELF.bus_watchlist_address_2     	:= le.Watchlists[2].bus_watchlist_address;
					SELF.bus_watchlist_city_2    			:= le.Watchlists[2].bus_watchlist_city;
					SELF.bus_watchlist_state_2 				:= le.Watchlists[2].bus_watchlist_state;
					SELF.bus_watchlist_zip_2  				:= le.Watchlists[2].bus_watchlist_zip;
					SELF.bus_watchlist_country_2      := le.Watchlists[2].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_2  := le.Watchlists[2].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_2     := le.Watchlists[2].bus_watchlist_sequence;
					//3
					SELF.bus_watchlist_table_3    		:= le.Watchlists[3].bus_watchlist_table;
					SELF.bus_watchlist_program_3 			:= le.Watchlists[3].bus_watchlist_program;
					SELF.bus_watchlist_record_number_3:= le.Watchlists[3].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_3  := le.Watchlists[3].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_3    := le.Watchlists[3].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_3     := le.Watchlists[3].bus_watchlist_lastname;
					SELF.bus_watchlist_address_3     	:= le.Watchlists[3].bus_watchlist_address;
					SELF.bus_watchlist_city_3    			:= le.Watchlists[3].bus_watchlist_city;
					SELF.bus_watchlist_state_3 				:= le.Watchlists[3].bus_watchlist_state;
					SELF.bus_watchlist_zip_3  				:= le.Watchlists[3].bus_watchlist_zip;
					SELF.bus_watchlist_country_3      := le.Watchlists[3].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_3  := le.Watchlists[3].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_3     := le.Watchlists[3].bus_watchlist_sequence;
					//4
					SELF.bus_watchlist_table_4    		:= le.Watchlists[4].bus_watchlist_table;
					SELF.bus_watchlist_program_4 			:= le.Watchlists[4].bus_watchlist_program;
					SELF.bus_watchlist_record_number_4:= le.Watchlists[4].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_4  := le.Watchlists[4].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_4    := le.Watchlists[4].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_4     := le.Watchlists[4].bus_watchlist_lastname;
					SELF.bus_watchlist_address_4     	:= le.Watchlists[4].bus_watchlist_address;
					SELF.bus_watchlist_city_4    			:= le.Watchlists[4].bus_watchlist_city;
					SELF.bus_watchlist_state_4 				:= le.Watchlists[4].bus_watchlist_state;
					SELF.bus_watchlist_zip_4  				:= le.Watchlists[4].bus_watchlist_zip;
					SELF.bus_watchlist_country_4      := le.Watchlists[4].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_4  := le.Watchlists[4].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_4     := le.Watchlists[4].bus_watchlist_sequence;
					//5
					SELF.bus_watchlist_table_5    		:= le.Watchlists[5].bus_watchlist_table;
					SELF.bus_watchlist_program_5 			:= le.Watchlists[5].bus_watchlist_program;
					SELF.bus_watchlist_record_number_5:= le.Watchlists[5].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_5  := le.Watchlists[5].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_5    := le.Watchlists[5].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_5     := le.Watchlists[5].bus_watchlist_lastname;
					SELF.bus_watchlist_address_5     	:= le.Watchlists[5].bus_watchlist_address;
					SELF.bus_watchlist_city_5    			:= le.Watchlists[5].bus_watchlist_city;
					SELF.bus_watchlist_state_5 				:= le.Watchlists[5].bus_watchlist_state;
					SELF.bus_watchlist_zip_5  				:= le.Watchlists[5].bus_watchlist_zip;
					SELF.bus_watchlist_country_5      := le.Watchlists[5].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_5  := le.Watchlists[5].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_5     := le.Watchlists[5].bus_watchlist_sequence;
					//6
					SELF.bus_watchlist_table_6    		:= le.Watchlists[6].bus_watchlist_table;
					SELF.bus_watchlist_program_6 			:= le.Watchlists[6].bus_watchlist_program;
					SELF.bus_watchlist_record_number_6:= le.Watchlists[6].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_6  := le.Watchlists[6].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_6    := le.Watchlists[6].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_6     := le.Watchlists[6].bus_watchlist_lastname;
					SELF.bus_watchlist_address_6     	:= le.Watchlists[6].bus_watchlist_address;
					SELF.bus_watchlist_city_6    			:= le.Watchlists[6].bus_watchlist_city;
					SELF.bus_watchlist_state_6 				:= le.Watchlists[6].bus_watchlist_state;
					SELF.bus_watchlist_zip_6  				:= le.Watchlists[6].bus_watchlist_zip;
					SELF.bus_watchlist_country_6      := le.Watchlists[6].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_6  := le.Watchlists[6].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_6     := le.Watchlists[6].bus_watchlist_sequence;
					//7
					SELF.bus_watchlist_table_7    		:= le.Watchlists[7].bus_watchlist_table;
					SELF.bus_watchlist_program_7 			:= le.Watchlists[7].bus_watchlist_program;
					SELF.bus_watchlist_record_number_7:= le.Watchlists[7].bus_watchlist_record_number;
					SELF.bus_watchlist_companyname_7  := le.Watchlists[7].bus_watchlist_companyname;
					SELF.bus_watchlist_firstname_7    := le.Watchlists[7].bus_watchlist_firstname;
					SELF.bus_watchlist_lastname_7     := le.Watchlists[7].bus_watchlist_lastname;
					SELF.bus_watchlist_address_7     	:= le.Watchlists[7].bus_watchlist_address;
					SELF.bus_watchlist_city_7    			:= le.Watchlists[7].bus_watchlist_city;
					SELF.bus_watchlist_state_7 				:= le.Watchlists[7].bus_watchlist_state;
					SELF.bus_watchlist_zip_7  				:= le.Watchlists[7].bus_watchlist_zip;
					SELF.bus_watchlist_country_7      := le.Watchlists[7].bus_watchlist_country;
					SELF.bus_watchlist_entity_name_7  := le.Watchlists[7].bus_watchlist_entity_name;
					SELF.bus_watchlist_sequence_7     := le.Watchlists[7].bus_watchlist_sequence;

					SELF := [];
				END;

    watchlist_results := IF( Options.OFAC_Version = 4, SearchOutXG5, SearchOut );
    
		ds_businesses_watchlist := PROJECT( watchlist_results, xfm_toFinalLayout(LEFT) );		
    
		// OUTPUT( ds_input, NAMED('CompanyAndAuthRepInfoInput_ofac') );
		// OUTPUT( inForm_single, NAMED('inForm_single_ofac') );
		// OUTPUT( patOut, NAMED('patOut_ofac') );
		// OUTPUT( patPref, NAMED('patPrefy_ofac') );
    // OUTPUT( patPref_normalized, NAMED('patPref_normalized') );
    // OUTPUT( pat_recs_pre, NAMED('pat_recs_pre') );
    // OUTPUT( pat_recs, NAMED('pat_recs') );
    // OUTPUT( SearchOut_pre, NAMED('SearchOut_withWLs') );
		// OUTPUT( SearchOut, NAMED('SearchOut_ofac') );
		
    // OUTPUT( XG5_ptys, NAMED('XG5_ptys') );
    // OUTPUT( XG5Parsed, NAMED('XG5Parsed') );
    // OUTPUT( XG5Formatted, NAMED('XG5Formatted') );
    // OUTPUT( XG5AddInData, NAMED('XG5AddInData') );
    // OUTPUT( dedupRespXG5, NAMED('dedupRespXG5') );
    // OUTPUT( CurrentMatchesXG5_sorted, NAMED('CurrentMatchesXG5_sorted') );
    // OUTPUT( XG5_recs, NAMED('XG5_recs') );
    // OUTPUT( SearchOutXG5, NAMED('SearchOutXG5') );

		RETURN ds_businesses_watchlist;
	END;
		
