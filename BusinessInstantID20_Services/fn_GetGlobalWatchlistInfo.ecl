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
				SELF.acctNo := 'Company';//+le.AcctNo;
			END;

		patriot.Layout_batch_in PrepPatriotAuthReps(ds_input le, INTEGER c) :=
			TRANSFORM
				SELF.seq := le.seq;
				SELF.name_first := le.AuthReps[c].FirstName;
				SELF.name_middle := le.AuthReps[c].MiddleName;
				SELF.name_last := le.AuthReps[c].LastName;
				SELF.name_unparsed := le.AuthReps[c].FullName;;
				SELF.country := '';
				SELF.search_type := 'I';
				SELF.dob :=  le.AuthReps[c].DateOfBirth;
				SELF.acctNo := 'AuthRep_' + le.AuthReps[c].Rep_WhichOne; //le.AcctNo;
			END;  	
			
		inForm_Company  := GROUP(PROJECT(ds_input, PrepPatriot(LEFT)),SEQ);
		inForm_AuthReps := NORMALIZE(ds_input, COUNT(LEFT.AuthReps), PrepPatriotAuthReps(LEFT,COUNTER));
		inForm_All_pre := SORT(inForm_Company+inForm_AuthReps, seq, acctNo);
		inForm_Group := GROUP(inForm_All_pre,seq);
		//************************************************** ofac_version = 1,2,3 **************************************************
		
    // Get Patriot base records
		patOut   := Patriot.Search_Base_Function(inForm_Group,  ofac_only, Options.Global_Watchlist_Threshold, true, Options.ofac_version,Options.include_ofac,Options.include_additional_watchlists,Options.Watchlists_Requested);
		// Sort by best match, OFAC and non-OFAC
		layout_patParent := RECORD
		  Patriot.Layout_Base_Results.parent;
		  STRING entitydate;
		  STRING publisheddate;
		END;
		patOutSorted  := PROJECT(patOut,  TRANSFORM(layout_patparent,SELF := LEFT, SELF := []));

		layout_patParent sorter(layout_patParent le) :=
			TRANSFORM
				SELF.pty_keys := 
            CHOOSEN(SORT(le.pty_keys(pty_key[1..4]  = 'OFAC'), -score, pty_key),7) + 
            CHOOSEN(SORT(le.pty_keys(pty_key[1..4] <> 'OFAC'), -score, pty_key),7);
				SELF := le;
			END;

		patPref  := PROJECT(patOutSorted,  sorter(LEFT));
    
    // Normalize the pty_keys child dataset records so we're working with a single, flat dataset.
    layout_patPref_normed := RECORD
      string10 acctno;
      unsigned4 seq := 0; 
      Patriot.Layout_Base_Results.Layout_keys;
      STRING entitydate;
      STRING publisheddate;
    END;
    
    patPref_normalized :=
      NORMALIZE(
        patPref, LEFT.pty_keys,
        TRANSFORM( layout_patPref_normed,
          SELF.acctno         := LEFT.acctno;
          SELF.seq            := LEFT.seq; 
          SELF.score          := RIGHT.score;
          SELF.pty_key        := RIGHT.pty_key;
          SELF.first_name     := RIGHT.first_name;
          SELF.last_name      := RIGHT.last_name;
          SELF.cname          := RIGHT.cname;
          SELF.country        := RIGHT.country;
          SELF.search_type    := RIGHT.search_type;
          SELF.entitydate     := LEFT.entitydate;
          SELF.publisheddate  := LEFT.publisheddate;
        )
      );
	
    // Go get the GWL payload data.
    layout_Patriot_Payload := RECORD
     	string10 acctno;
      unsigned4 seq := 0;
      GlobalWatchLists.Layout_GlobalWatchLists;
      string entitydate;
      string publisheddate;
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
          
          self.entitydate := left.entitydate;
          self.publisheddate := left.publisheddate;
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
      STRING bus_watchlist_entitydate;
      STRING bus_watchlist_publisheddate;
		END;
    
		pat_all_recs := 
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
            SELF.bus_watchlist_zip   := if(nocleanaddr, left.address_postal_code   , left.zip),
            
            SELF.bus_watchlist_entitydate := left.entitydate,
            SELF.bus_watchlist_publisheddate := left.publisheddate
           )
         );
    pat_recs := pat_all_recs;
    // Load payload records into OFAC and Watchlists child datasets:
		temp_OFACLayout := { layout_watchlist_temp AND NOT [ seq, acctno ] };
		
		temp_OFACLayoutDS := RECORD // OFAC
			UNSIGNED4 Seq;
			DATASET(temp_OFACLayout) OFAC;
			DATASET(temp_OFACLayout) Watchlists;
      DATASET(temp_OFACLayout) AuthRep1Watchlists;
      DATASET(temp_OFACLayout) AuthRep2Watchlists;
      DATASET(temp_OFACLayout) AuthRep3Watchlists;
      DATASET(temp_OFACLayout) AuthRep4Watchlists;
      DATASET(temp_OFACLayout) AuthRep5Watchlists;

		END;

    // ...create seed record...
    ds_input_denormed := 
       PROJECT( ds_input, TRANSFORM( temp_OFACLayoutDS, SELF.seq := LEFT.seq, SELF := [] ) );
    
    // ...bolt on Watchlists child dataset...
		SearchOut_pre := 
      DENORMALIZE(
        ds_input_denormed, pat_recs(NOT isOFAC AND AcctNo='Company'), 
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
		SearchOutCompanyOFAC := 
      DENORMALIZE(
        SearchOut_pre, pat_recs(isOFAC AND AcctNo='Company'), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.OFAC := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
      
    // ...and bolt on AuthRep1 child datasets.
		SearchOut_AuthRep1 := 
      DENORMALIZE(
        SearchOutCompanyOFAC, pat_recs(AcctNo='AuthRep_1'), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep1Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep2 child datasets.
		SearchOut_AuthRep2 := 
      DENORMALIZE(
        SearchOut_AuthRep1, pat_recs(AcctNo='AuthRep_2'), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep2Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep3 child datasets.
		SearchOut_AuthRep3 := 
      DENORMALIZE(
        SearchOut_AuthRep2, pat_recs(AcctNo='AuthRep_3'), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep3Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep4 child datasets.
		SearchOut_AuthRep4 := 
      DENORMALIZE(
        SearchOut_AuthRep3, pat_recs(AcctNo='AuthRep_4'), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep4Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep5 child datasets.
		SearchOut := 
      DENORMALIZE(
        SearchOut_AuthRep4, pat_recs(AcctNo='AuthRep_5'), 
        LEFT.seq = RIGHT.seq,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep5Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );  
      

		//************************************************** ofac_version = 4 **************************************************

    // Much of the following logic was copied from OFAC_XG5.FormatXG5_BIIDWatchlist2( ) and modified.
    
    // Kill an unnecessary Bridger gateway call if OFACVersion isn't 4.
    gateways_param := IF( Options.OFAC_Version = 4, Options.Gateways, DATASET( [], Gateway.Layouts.Config ) );
    
    OFAC_XG5.Layout.InputLayout prep_ds_input(BusinessInstantID20_Services.layouts.InputCompanyAndAuthRepInfo le, INTEGER c ) :=
			TRANSFORM
				SELF.seq        := le.seq * 10 + c,
				// Overloading the bdid field to identify authorized reps
				SELF.bdid				:= c,
				self.acctno     := le.acctno,
				SELF.searchType := GlobalWatchLists.Constants.individual_code,
				SELF.firstName  := le.AuthReps[c].FirstName,
				SELF.middleName := le.AuthReps[c].MiddleName,
				SELF.lastName   := le.AuthReps[c].LastName,
				SELF.FullName   := IF(c=0,le.CompanyName,le.AuthReps[c].FullName),
				SELF.dob        := le.AuthReps[c].DateOfBirth,
				SELF := []
			END;
		
    prep_XG5_Company 	:= PROJECT(ds_input,prep_ds_input(LEFT,0));
		prep_XG5_AuthRep1	:= PROJECT(ds_input,prep_ds_input(LEFT,1));
		prep_XG5_AuthRep2	:= PROJECT(ds_input,prep_ds_input(LEFT,2));
		prep_XG5_AuthRep3	:= PROJECT(ds_input,prep_ds_input(LEFT,3));
		prep_XG5_AuthRep4	:= PROJECT(ds_input,prep_ds_input(LEFT,4));
		prep_XG5_AuthRep5	:= PROJECT(ds_input,prep_ds_input(LEFT,5));
		
		prep_XG5 := prep_XG5_Company+prep_XG5_AuthRep1+prep_XG5_AuthRep2+prep_XG5_AuthRep3+prep_XG5_AuthRep4+prep_XG5_AuthRep5;

    INTEGER2 default_dobRadius := -1;
    
		XG5_ptys := OFAC_XG5.OFACXG5call(prep_XG5((firstName<>'' AND lastName<>'') OR FullName<>''), 
                                     ofac_only,
                                     Options.Global_Watchlist_Threshold * 100, 
                                     Options.include_ofac,
                                     Options.include_additional_watchlists,
                                     default_dobRadius,
                                     Options.Watchlists_Requested,
                                     gateways_param);
																	
    // Fail immediately as we don't want customers to think there was no hit on OFAC.
		validXG5_ptys_Company   := XG5_ptys(bdid=0 AND IF(errorMessage <> '',ERROR('Bridger Gateway Error'), true));
    validXG5_ptys_AuthRep1  := XG5_ptys(bdid=1);
    validXG5_ptys_AuthRep2  := XG5_ptys(bdid=2);
    validXG5_ptys_AuthRep3  := XG5_ptys(bdid=3);
    validXG5_ptys_AuthRep4  := XG5_ptys(bdid=4);
    validXG5_ptys_AuthRep5  := XG5_ptys(bdid=5);

		XG5Parsed_Company   := OFAC_XG5.OFACXG5_Watchlist2_Response(validXG5_ptys_Company);
    XG5Parsed_AuthRep1  := OFAC_XG5.OFACXG5_Watchlist2_Response(validXG5_ptys_AuthRep1);
    XG5Parsed_AuthRep2  := OFAC_XG5.OFACXG5_Watchlist2_Response(validXG5_ptys_AuthRep2);
    XG5Parsed_AuthRep3  := OFAC_XG5.OFACXG5_Watchlist2_Response(validXG5_ptys_AuthRep3);
    XG5Parsed_AuthRep4  := OFAC_XG5.OFACXG5_Watchlist2_Response(validXG5_ptys_AuthRep4);
    XG5Parsed_AuthRep5  := OFAC_XG5.OFACXG5_Watchlist2_Response(validXG5_ptys_AuthRep5);
    
		NonErrorRecsXG5_Company   := XG5Parsed_Company(errormessage = '');
    NonErrorRecsXG5_AuthRep1  := XG5Parsed_AuthRep1(errormessage = '');
    NonErrorRecsXG5_AuthRep2  := XG5Parsed_AuthRep2(errormessage = '');
    NonErrorRecsXG5_AuthRep3  := XG5Parsed_AuthRep3(errormessage = '');
    NonErrorRecsXG5_AuthRep4  := XG5Parsed_AuthRep4(errormessage = '');
    NonErrorRecsXG5_AuthRep5  := XG5Parsed_AuthRep5(errormessage = '');

    layout_EntityMatchesXG5 := RECORD
      string10 acctno;
      unsigned4 seq := 0;
			unsigned6 bdid;
      string ErrorMessage;
      OFAC_XG5.Layout.EntityMatch;
      OFAC_XG5.Layout.AKABestMatches AND NOT [blockid, EntitySeq];
      OFAC_XG5.Layout.AddressMatches AND NOT [blockid, EntitySeq];
      OFAC_XG5.Layout.ResultMatchFile AND NOT [blockid, EntitySeq];
    END;

		layout_EntityMatchesXG5 prep_NonErrorRecsXG5(OFAC_XG5.Layout.ResponseRec le) :=
			TRANSFORM
				self.ErrorMessage := le.ErrorMessage,
        self.entitydate := le.entityRec[1].entitydate,
        self.publisheddate := le.fileRec[1].publisheddate,
        self := le.entityRec[1],
        self := le.akaRec(bestId = akaID)[1],
        self := le.fileRec[1],        
        self := [];
			END;
		PrepEntityXG5_Company		:= PROJECT(NonErrorRecsXG5_Company, prep_NonErrorRecsXG5(LEFT));
		PrepEntityXG5_AuthRep1	:= PROJECT(NonErrorRecsXG5_AuthRep1,prep_NonErrorRecsXG5(LEFT));
		PrepEntityXG5_AuthRep2	:= PROJECT(NonErrorRecsXG5_AuthRep2,prep_NonErrorRecsXG5(LEFT));
		PrepEntityXG5_AuthRep3	:= PROJECT(NonErrorRecsXG5_AuthRep3,prep_NonErrorRecsXG5(LEFT));
		PrepEntityXG5_AuthRep4	:= PROJECT(NonErrorRecsXG5_AuthRep4,prep_NonErrorRecsXG5(LEFT));
		PrepEntityXG5_AuthRep5	:= PROJECT(NonErrorRecsXG5_AuthRep5,prep_NonErrorRecsXG5(LEFT));
		fn_AddAddrXG5(ds1, ds2) := FUNCTIONMACRO
			result := join(	
        ds1, ds2,  //only want 1 address
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
		  RETURN result;
		ENDMACRO;
		
		AddAddrXG5_Company 	:= fn_AddAddrXG5(PrepEntityXG5_Company,  NonErrorRecsXG5_Company.addrRec(AddressID = 1));
		AddAddrXG5_AuthRep1 := fn_AddAddrXG5(PrepEntityXG5_AuthRep1, NonErrorRecsXG5_AuthRep1.addrRec(AddressID = 1));
		AddAddrXG5_AuthRep2 := fn_AddAddrXG5(PrepEntityXG5_AuthRep2, NonErrorRecsXG5_AuthRep2.addrRec(AddressID = 1));
		AddAddrXG5_AuthRep3 := fn_AddAddrXG5(PrepEntityXG5_AuthRep3, NonErrorRecsXG5_AuthRep3.addrRec(AddressID = 1));
		AddAddrXG5_AuthRep4 := fn_AddAddrXG5(PrepEntityXG5_AuthRep4, NonErrorRecsXG5_AuthRep4.addrRec(AddressID = 1));
		AddAddrXG5_AuthRep5 := fn_AddAddrXG5(PrepEntityXG5_AuthRep5, NonErrorRecsXG5_AuthRep5.addrRec(AddressID = 1));
    fn_AddFileXG5(ds1, ds2) := FUNCTIONMACRO
			result := join(	
        ds1, ds2,  //only want 1 address
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
		  RETURN result;
		ENDMACRO;			
		
		AddFileXG5_Company 	:= fn_AddFileXG5(AddAddrXG5_Company,  NonErrorRecsXG5_Company.FileRec);
		AddFileXG5_AuthRep1	:= fn_AddFileXG5(AddAddrXG5_AuthRep1, NonErrorRecsXG5_AuthRep1.FileRec);
		AddFileXG5_AuthRep2	:= fn_AddFileXG5(AddAddrXG5_AuthRep2, NonErrorRecsXG5_AuthRep2.FileRec);
		AddFileXG5_AuthRep3	:= fn_AddFileXG5(AddAddrXG5_AuthRep3, NonErrorRecsXG5_AuthRep3.FileRec);
		AddFileXG5_AuthRep4	:= fn_AddFileXG5(AddAddrXG5_AuthRep4, NonErrorRecsXG5_AuthRep4.FileRec);
		AddFileXG5_AuthRep5	:= fn_AddFileXG5(AddAddrXG5_AuthRep5, NonErrorRecsXG5_AuthRep5.FileRec);

    dedupRespXG5_Company  := dedup(sort(NonErrorRecsXG5_Company,  blockid, entityseq), blockid);
    dedupRespXG5_AuthRep1 := dedup(sort(NonErrorRecsXG5_AuthRep1, blockid, entityseq), blockid);
    dedupRespXG5_AuthRep2 := dedup(sort(NonErrorRecsXG5_AuthRep2, blockid, entityseq), blockid);
    dedupRespXG5_AuthRep3 := dedup(sort(NonErrorRecsXG5_AuthRep3, blockid, entityseq), blockid);
    dedupRespXG5_AuthRep4 := dedup(sort(NonErrorRecsXG5_AuthRep4, blockid, entityseq), blockid);
    dedupRespXG5_AuthRep5 := dedup(sort(NonErrorRecsXG5_AuthRep5, blockid, entityseq), blockid);

		fn_CurrentMatchesXG5(ds1, ds2) := FUNCTIONMACRO
			result := join(
        ds1, ds2,
        left.BlockID = right.blockid, 
        transform(layout_EntityMatchesXG5, self.seq := left.seq, self.bdid := left.bdid, self := right)
      ); 
		  RETURN result;
		ENDMACRO;
		CurrentMatchesXG5_Company		:= fn_CurrentMatchesXG5(dedupRespXG5_Company,  AddFileXG5_Company( TRIM(BestName) != '' ));
		CurrentMatchesXG5_AuthRep1	:= fn_CurrentMatchesXG5(dedupRespXG5_AuthRep1, AddFileXG5_AuthRep1( TRIM(BestName) != '' ));
		CurrentMatchesXG5_AuthRep2	:= fn_CurrentMatchesXG5(dedupRespXG5_AuthRep2, AddFileXG5_AuthRep2( TRIM(BestName) != '' ));
		CurrentMatchesXG5_AuthRep3	:= fn_CurrentMatchesXG5(dedupRespXG5_AuthRep3, AddFileXG5_AuthRep3( TRIM(BestName) != '' ));
		CurrentMatchesXG5_AuthRep4	:= fn_CurrentMatchesXG5(dedupRespXG5_AuthRep4, AddFileXG5_AuthRep4( TRIM(BestName) != '' ));
		CurrentMatchesXG5_AuthRep5	:= fn_CurrentMatchesXG5(dedupRespXG5_AuthRep5, AddFileXG5_AuthRep5( TRIM(BestName) != '' ));  

    CurrentMatchesXG5_Company_sorted  := SORT( CurrentMatchesXG5_Company, blockid, -entitymatchscore, EntityPartyKey, RECORD);
    CurrentMatchesXG5_AuthRep1_sorted := SORT( CurrentMatchesXG5_AuthRep1, blockid, -entitydate, -publisheddate, -entitymatchscore, EntityPartyKey, RECORD);
    CurrentMatchesXG5_AuthRep2_sorted := SORT( CurrentMatchesXG5_AuthRep2, blockid, -entitydate, -publisheddate, -entitymatchscore, EntityPartyKey, RECORD);
    CurrentMatchesXG5_AuthRep3_sorted := SORT( CurrentMatchesXG5_AuthRep3, blockid, -entitydate, -publisheddate, -entitymatchscore, EntityPartyKey, RECORD);
    CurrentMatchesXG5_AuthRep4_sorted := SORT( CurrentMatchesXG5_AuthRep4, blockid, -entitydate, -publisheddate, -entitymatchscore, EntityPartyKey, RECORD);
    CurrentMatchesXG5_AuthRep5_sorted := SORT( CurrentMatchesXG5_AuthRep5, blockid, -entitydate, -publisheddate, -entitymatchscore, EntityPartyKey, RECORD);

    // Transform data into what's needed for BIID 2.0. 
		fn_XG5_recs(ds1) := FUNCTIONMACRO
			result := project(
        ds1, 	
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
            SELF.bus_watchlist_zip   := if(noaddr, '', left.PostalCode),
            
            SELF.bus_watchlist_entitydate := left.entitydate,
            SELF.bus_watchlist_publisheddate := left.publisheddate
           )
         );
		  RETURN result;
		ENDMACRO;
		XG5_recs_Company	:= fn_XG5_recs(CurrentMatchesXG5_Company_sorted);
		XG5_recs_AuthRep1 := fn_XG5_recs(CurrentMatchesXG5_AuthRep1_sorted);
		XG5_recs_AuthRep2 := fn_XG5_recs(CurrentMatchesXG5_AuthRep2_sorted);
		XG5_recs_AuthRep3 := fn_XG5_recs(CurrentMatchesXG5_AuthRep3_sorted);
		XG5_recs_AuthRep4 := fn_XG5_recs(CurrentMatchesXG5_AuthRep4_sorted);
		XG5_recs_AuthRep5 := fn_XG5_recs(CurrentMatchesXG5_AuthRep5_sorted);
         
    // Seed record is created already; bolt on XG5 Watchlists child dataset...
		SearchOutXG5_pre := 
      DENORMALIZE(
        ds_input_denormed, XG5_recs_Company(NOT isOFAC), 
        LEFT.seq = RIGHT.seq / 10,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := [];
        ), 
        LEFT OUTER
      );

    // ...and bolt on XG5 OFAC child dataset.
		SearchOutXG5_OFAC := 
      DENORMALIZE(
        SearchOutXG5_pre, XG5_recs_Company(isOFAC), 
        LEFT.seq = RIGHT.seq / 10,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.OFAC := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
      
    // ...and bolt on AuthRep1 child datasets.
		SearchOutXG5_AuthRep1 := 
      DENORMALIZE(
        SearchOutXG5_OFAC, XG5_recs_AuthRep1, 
        LEFT.seq = (RIGHT.seq-(RIGHT.seq%10))/10,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep1Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep2 child datasets.
		SearchOutXG5_AuthRep2 := 
      DENORMALIZE(
        SearchOutXG5_AuthRep1, XG5_recs_AuthRep2, 
        LEFT.seq = (RIGHT.seq-(RIGHT.seq%10))/10,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep2Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep3 child datasets.
		SearchOutXG5_AuthRep3 := 
      DENORMALIZE(
        SearchOutXG5_AuthRep2, XG5_recs_AuthRep3, 
        LEFT.seq = (RIGHT.seq-(RIGHT.seq%10))/10,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep3Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep4 child datasets.
		SearchOutXG5_AuthRep4 := 
      DENORMALIZE(
        SearchOutXG5_AuthRep3, XG5_recs_AuthRep4, 
        LEFT.seq = (RIGHT.seq-(RIGHT.seq%10))/10,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep4Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
          SELF := LEFT;
        ), 
        LEFT OUTER
      );
    // ...and bolt on AuthRep5 child datasets.
		SearchOutXG5 := 
      DENORMALIZE(
        SearchOutXG5_AuthRep4, XG5_recs_AuthRep5, 
        LEFT.seq = (RIGHT.seq-(RIGHT.seq%10))/10,
        GROUP,
				TRANSFORM( temp_OFACLayoutDS,
          SELF.seq := LEFT.seq,
          SELF.AuthRep5Watchlists := PROJECT( ROWS(RIGHT), temp_OFACLayout ),
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
					SELF.bus_ofac_entitydate_1        := le.OFAC[1].bus_watchlist_entitydate;
          SELF.bus_ofac_publisheddate_1		  := le.OFAC[1].bus_watchlist_publisheddate;
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
          SELF.bus_ofac_entitydate_2 	      := le.OFAC[2].bus_watchlist_entitydate;
          SELF.bus_ofac_publisheddate_2		  := le.OFAC[2].bus_watchlist_publisheddate;
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
          SELF.bus_ofac_entitydate_3        := le.OFAC[3].bus_watchlist_entitydate;
          SELF.bus_ofac_publisheddate_3		  := le.OFAC[3].bus_watchlist_publisheddate;
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
          SELF.bus_ofac_entitydate_5        := le.OFAC[5].bus_watchlist_entitydate;
          SELF.bus_ofac_publisheddate_5		  := le.OFAC[5].bus_watchlist_publisheddate;
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
          SELF.bus_ofac_entitydate_6        := le.OFAC[6].bus_watchlist_entitydate;
          SELF.bus_ofac_publisheddate_6		  := le.OFAC[6].bus_watchlist_publisheddate;
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
          SELF.bus_ofac_entitydate_7        := le.OFAC[7].bus_watchlist_entitydate;
          SELF.bus_ofac_publisheddate_7		  := le.OFAC[7].bus_watchlist_publisheddate;
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
          SELF.bus_watchlist_entitydate_1     := le.Watchlists[1].bus_watchlist_entitydate;
          SELF.bus_watchlist_publisheddate_1  := le.Watchlists[1].bus_watchlist_publisheddate;
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
          SELF.bus_watchlist_entitydate_2     := le.Watchlists[2].bus_watchlist_entitydate;
          SELF.bus_watchlist_publisheddate_2  := le.Watchlists[2].bus_watchlist_publisheddate;
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
          SELF.bus_watchlist_entitydate_3     := le.Watchlists[3].bus_watchlist_entitydate;
          SELF.bus_watchlist_publisheddate_3  := le.Watchlists[3].bus_watchlist_publisheddate;
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
          SELF.bus_watchlist_entitydate_4     := le.Watchlists[4].bus_watchlist_entitydate;
          SELF.bus_watchlist_publisheddate_4  := le.Watchlists[4].bus_watchlist_publisheddate;
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
          SELF.bus_watchlist_entitydate_5     := le.Watchlists[5].bus_watchlist_entitydate;
          SELF.bus_watchlist_publisheddate_5  := le.Watchlists[5].bus_watchlist_publisheddate;
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
          SELF.bus_watchlist_entitydate_6     := le.Watchlists[6].bus_watchlist_entitydate;
          SELF.bus_watchlist_publisheddate_6  := le.Watchlists[6].bus_watchlist_publisheddate;
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
          SELF.bus_watchlist_entitydate_7     := le.Watchlists[7].bus_watchlist_entitydate;
          SELF.bus_watchlist_publisheddate_7  := le.Watchlists[7].bus_watchlist_publisheddate;
          //AuthRep1-1
          SELF.authrep_watchlist_table_1    		:= le.AuthRep1Watchlists[1].bus_watchlist_table;
					SELF.authrep_watchlist_program_1 			:= le.AuthRep1Watchlists[1].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_1:= le.AuthRep1Watchlists[1].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_1  := le.AuthRep1Watchlists[1].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_1    := le.AuthRep1Watchlists[1].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_1     := le.AuthRep1Watchlists[1].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_1     	:= le.AuthRep1Watchlists[1].bus_watchlist_address;
					SELF.authrep_watchlist_city_1    			:= le.AuthRep1Watchlists[1].bus_watchlist_city;
					SELF.authrep_watchlist_state_1 				:= le.AuthRep1Watchlists[1].bus_watchlist_state;
					SELF.authrep_watchlist_zip_1  				:= le.AuthRep1Watchlists[1].bus_watchlist_zip;
					SELF.authrep_watchlist_country_1      := le.AuthRep1Watchlists[1].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_1  := le.AuthRep1Watchlists[1].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_1     := le.AuthRep1Watchlists[1].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_1     := le.AuthRep1Watchlists[1].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_1  := le.AuthRep1Watchlists[1].bus_watchlist_publisheddate;
          //AuthRep1-2
          SELF.authrep_watchlist_table_2    		:= le.AuthRep1Watchlists[2].bus_watchlist_table;
					SELF.authrep_watchlist_program_2 			:= le.AuthRep1Watchlists[2].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_2:= le.AuthRep1Watchlists[2].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_2  := le.AuthRep1Watchlists[2].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_2    := le.AuthRep1Watchlists[2].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_2     := le.AuthRep1Watchlists[2].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_2     	:= le.AuthRep1Watchlists[2].bus_watchlist_address;
					SELF.authrep_watchlist_city_2    			:= le.AuthRep1Watchlists[2].bus_watchlist_city;
					SELF.authrep_watchlist_state_2 				:= le.AuthRep1Watchlists[2].bus_watchlist_state;
					SELF.authrep_watchlist_zip_2  				:= le.AuthRep1Watchlists[2].bus_watchlist_zip;
					SELF.authrep_watchlist_country_2      := le.AuthRep1Watchlists[2].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_2  := le.AuthRep1Watchlists[2].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_2     := le.AuthRep1Watchlists[2].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_2     := le.AuthRep1Watchlists[2].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_2  := le.AuthRep1Watchlists[2].bus_watchlist_publisheddate;
          //AuthRep1-3
          SELF.authrep_watchlist_table_3    		:= le.AuthRep1Watchlists[3].bus_watchlist_table;
					SELF.authrep_watchlist_program_3 			:= le.AuthRep1Watchlists[3].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_3:= le.AuthRep1Watchlists[3].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_3  := le.AuthRep1Watchlists[3].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_3    := le.AuthRep1Watchlists[3].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_3     := le.AuthRep1Watchlists[3].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_3     	:= le.AuthRep1Watchlists[3].bus_watchlist_address;
					SELF.authrep_watchlist_city_3    			:= le.AuthRep1Watchlists[3].bus_watchlist_city;
					SELF.authrep_watchlist_state_3 				:= le.AuthRep1Watchlists[3].bus_watchlist_state;
					SELF.authrep_watchlist_zip_3  				:= le.AuthRep1Watchlists[3].bus_watchlist_zip;
					SELF.authrep_watchlist_country_3      := le.AuthRep1Watchlists[3].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_3  := le.AuthRep1Watchlists[3].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_3     := le.AuthRep1Watchlists[3].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_3     := le.AuthRep1Watchlists[3].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_3  := le.AuthRep1Watchlists[3].bus_watchlist_publisheddate;
          //AuthRep1-4
          SELF.authrep_watchlist_table_4    		:= le.AuthRep1Watchlists[4].bus_watchlist_table;
					SELF.authrep_watchlist_program_4 			:= le.AuthRep1Watchlists[4].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_4:= le.AuthRep1Watchlists[4].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_4  := le.AuthRep1Watchlists[4].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_4    := le.AuthRep1Watchlists[4].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_4     := le.AuthRep1Watchlists[4].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_4     	:= le.AuthRep1Watchlists[4].bus_watchlist_address;
					SELF.authrep_watchlist_city_4    			:= le.AuthRep1Watchlists[4].bus_watchlist_city;
					SELF.authrep_watchlist_state_4 				:= le.AuthRep1Watchlists[4].bus_watchlist_state;
					SELF.authrep_watchlist_zip_4  				:= le.AuthRep1Watchlists[4].bus_watchlist_zip;
					SELF.authrep_watchlist_country_4      := le.AuthRep1Watchlists[4].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_4  := le.AuthRep1Watchlists[4].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_4     := le.AuthRep1Watchlists[4].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_4     := le.AuthRep1Watchlists[4].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_4  := le.AuthRep1Watchlists[4].bus_watchlist_publisheddate;
          //AuthRep1-5
          SELF.authrep_watchlist_table_5    		:= le.AuthRep1Watchlists[5].bus_watchlist_table;
					SELF.authrep_watchlist_program_5 			:= le.AuthRep1Watchlists[5].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_5:= le.AuthRep1Watchlists[5].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_5  := le.AuthRep1Watchlists[5].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_5    := le.AuthRep1Watchlists[5].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_5     := le.AuthRep1Watchlists[5].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_5     	:= le.AuthRep1Watchlists[5].bus_watchlist_address;
					SELF.authrep_watchlist_city_5    			:= le.AuthRep1Watchlists[5].bus_watchlist_city;
					SELF.authrep_watchlist_state_5 				:= le.AuthRep1Watchlists[5].bus_watchlist_state;
					SELF.authrep_watchlist_zip_5  				:= le.AuthRep1Watchlists[5].bus_watchlist_zip;
					SELF.authrep_watchlist_country_5      := le.AuthRep1Watchlists[5].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_5  := le.AuthRep1Watchlists[5].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_5     := le.AuthRep1Watchlists[5].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_5     := le.AuthRep1Watchlists[5].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_5  := le.AuthRep1Watchlists[5].bus_watchlist_publisheddate;
          //AuthRep1-6
          SELF.authrep_watchlist_table_6    		:= le.AuthRep1Watchlists[6].bus_watchlist_table;
					SELF.authrep_watchlist_program_6 			:= le.AuthRep1Watchlists[6].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_6:= le.AuthRep1Watchlists[6].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_6  := le.AuthRep1Watchlists[6].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_6    := le.AuthRep1Watchlists[6].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_6     := le.AuthRep1Watchlists[6].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_6     	:= le.AuthRep1Watchlists[6].bus_watchlist_address;
					SELF.authrep_watchlist_city_6    			:= le.AuthRep1Watchlists[6].bus_watchlist_city;
					SELF.authrep_watchlist_state_6 				:= le.AuthRep1Watchlists[6].bus_watchlist_state;
					SELF.authrep_watchlist_zip_6  				:= le.AuthRep1Watchlists[6].bus_watchlist_zip;
					SELF.authrep_watchlist_country_6      := le.AuthRep1Watchlists[6].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_6  := le.AuthRep1Watchlists[6].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_6     := le.AuthRep1Watchlists[6].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_6     := le.AuthRep1Watchlists[6].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_6  := le.AuthRep1Watchlists[6].bus_watchlist_publisheddate;
          //AuthRep1-7
          SELF.authrep_watchlist_table_7    		:= le.AuthRep1Watchlists[7].bus_watchlist_table;
					SELF.authrep_watchlist_program_7 			:= le.AuthRep1Watchlists[7].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_7:= le.AuthRep1Watchlists[7].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_7  := le.AuthRep1Watchlists[7].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_7    := le.AuthRep1Watchlists[7].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_7     := le.AuthRep1Watchlists[7].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_7     	:= le.AuthRep1Watchlists[7].bus_watchlist_address;
					SELF.authrep_watchlist_city_7    			:= le.AuthRep1Watchlists[7].bus_watchlist_city;
					SELF.authrep_watchlist_state_7 				:= le.AuthRep1Watchlists[7].bus_watchlist_state;
					SELF.authrep_watchlist_zip_7  				:= le.AuthRep1Watchlists[7].bus_watchlist_zip;
					SELF.authrep_watchlist_country_7      := le.AuthRep1Watchlists[7].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_7  := le.AuthRep1Watchlists[7].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_7     := le.AuthRep1Watchlists[7].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_7     := le.AuthRep1Watchlists[7].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_7  := le.AuthRep1Watchlists[7].bus_watchlist_publisheddate;          
          //AuthRep2-1
					SELF.authrep_watchlist_table_8    		:= le.AuthRep2Watchlists[1].bus_watchlist_table;
					SELF.authrep_watchlist_program_8 			:= le.AuthRep2Watchlists[1].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_8:= le.AuthRep2Watchlists[1].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_8  := le.AuthRep2Watchlists[1].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_8    := le.AuthRep2Watchlists[1].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_8     := le.AuthRep2Watchlists[1].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_8     	:= le.AuthRep2Watchlists[1].bus_watchlist_address;
					SELF.authrep_watchlist_city_8    			:= le.AuthRep2Watchlists[1].bus_watchlist_city;
					SELF.authrep_watchlist_state_8 				:= le.AuthRep2Watchlists[1].bus_watchlist_state;
					SELF.authrep_watchlist_zip_8  				:= le.AuthRep2Watchlists[1].bus_watchlist_zip;
					SELF.authrep_watchlist_country_8      := le.AuthRep2Watchlists[1].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_8  := le.AuthRep2Watchlists[1].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_8     := le.AuthRep2Watchlists[1].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_8     := le.AuthRep2Watchlists[1].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_8  := le.AuthRep2Watchlists[1].bus_watchlist_publisheddate;
          //AuthRep2-2
          SELF.authrep_watchlist_table_9    		:= le.AuthRep2Watchlists[2].bus_watchlist_table;
					SELF.authrep_watchlist_program_9 			:= le.AuthRep2Watchlists[2].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_9:= le.AuthRep2Watchlists[2].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_9  := le.AuthRep2Watchlists[2].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_9    := le.AuthRep2Watchlists[2].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_9     := le.AuthRep2Watchlists[2].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_9     	:= le.AuthRep2Watchlists[2].bus_watchlist_address;
					SELF.authrep_watchlist_city_9    			:= le.AuthRep2Watchlists[2].bus_watchlist_city;
					SELF.authrep_watchlist_state_9 				:= le.AuthRep2Watchlists[2].bus_watchlist_state;
					SELF.authrep_watchlist_zip_9  				:= le.AuthRep2Watchlists[2].bus_watchlist_zip;
					SELF.authrep_watchlist_country_9      := le.AuthRep2Watchlists[2].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_9  := le.AuthRep2Watchlists[2].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_9     := le.AuthRep2Watchlists[2].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_9     := le.AuthRep2Watchlists[2].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_9  := le.AuthRep2Watchlists[2].bus_watchlist_publisheddate;
          //AuthRep2-3
          SELF.authrep_watchlist_table_10    		:= le.AuthRep2Watchlists[3].bus_watchlist_table;
					SELF.authrep_watchlist_program_10 			:= le.AuthRep2Watchlists[3].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_10:= le.AuthRep2Watchlists[3].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_10  := le.AuthRep2Watchlists[3].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_10    := le.AuthRep2Watchlists[3].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_10     := le.AuthRep2Watchlists[3].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_10     	:= le.AuthRep2Watchlists[3].bus_watchlist_address;
					SELF.authrep_watchlist_city_10    			:= le.AuthRep2Watchlists[3].bus_watchlist_city;
					SELF.authrep_watchlist_state_10 				:= le.AuthRep2Watchlists[3].bus_watchlist_state;
					SELF.authrep_watchlist_zip_10  				:= le.AuthRep2Watchlists[3].bus_watchlist_zip;
					SELF.authrep_watchlist_country_10      := le.AuthRep2Watchlists[3].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_10  := le.AuthRep2Watchlists[3].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_10     := le.AuthRep2Watchlists[3].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_10     := le.AuthRep2Watchlists[3].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_10  := le.AuthRep2Watchlists[3].bus_watchlist_publisheddate;
          //AuthRep2-4
          SELF.authrep_watchlist_table_11    		:= le.AuthRep2Watchlists[4].bus_watchlist_table;
					SELF.authrep_watchlist_program_11 			:= le.AuthRep2Watchlists[4].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_11:= le.AuthRep2Watchlists[4].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_11  := le.AuthRep2Watchlists[4].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_11    := le.AuthRep2Watchlists[4].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_11     := le.AuthRep2Watchlists[4].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_11     	:= le.AuthRep2Watchlists[4].bus_watchlist_address;
					SELF.authrep_watchlist_city_11    			:= le.AuthRep2Watchlists[4].bus_watchlist_city;
					SELF.authrep_watchlist_state_11 				:= le.AuthRep2Watchlists[4].bus_watchlist_state;
					SELF.authrep_watchlist_zip_11  				:= le.AuthRep2Watchlists[4].bus_watchlist_zip;
					SELF.authrep_watchlist_country_11      := le.AuthRep2Watchlists[4].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_11  := le.AuthRep2Watchlists[4].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_11     := le.AuthRep2Watchlists[4].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_11     := le.AuthRep2Watchlists[4].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_11  := le.AuthRep2Watchlists[4].bus_watchlist_publisheddate;
          //AuthRep2-5
          SELF.authrep_watchlist_table_12    		:= le.AuthRep2Watchlists[5].bus_watchlist_table;
					SELF.authrep_watchlist_program_12 			:= le.AuthRep2Watchlists[5].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_12:= le.AuthRep2Watchlists[5].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_12  := le.AuthRep2Watchlists[5].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_12    := le.AuthRep2Watchlists[5].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_12     := le.AuthRep2Watchlists[5].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_12     	:= le.AuthRep2Watchlists[5].bus_watchlist_address;
					SELF.authrep_watchlist_city_12    			:= le.AuthRep2Watchlists[5].bus_watchlist_city;
					SELF.authrep_watchlist_state_12 				:= le.AuthRep2Watchlists[5].bus_watchlist_state;
					SELF.authrep_watchlist_zip_12  				:= le.AuthRep2Watchlists[5].bus_watchlist_zip;
					SELF.authrep_watchlist_country_12      := le.AuthRep2Watchlists[5].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_12  := le.AuthRep2Watchlists[5].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_12     := le.AuthRep2Watchlists[5].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_12     := le.AuthRep2Watchlists[5].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_12  := le.AuthRep2Watchlists[5].bus_watchlist_publisheddate;
          //AuthRep2-6
          SELF.authrep_watchlist_table_13    		:= le.AuthRep2Watchlists[6].bus_watchlist_table;
					SELF.authrep_watchlist_program_13 			:= le.AuthRep2Watchlists[6].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_13:= le.AuthRep2Watchlists[6].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_13  := le.AuthRep2Watchlists[6].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_13    := le.AuthRep2Watchlists[6].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_13     := le.AuthRep2Watchlists[6].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_13     	:= le.AuthRep2Watchlists[6].bus_watchlist_address;
					SELF.authrep_watchlist_city_13    			:= le.AuthRep2Watchlists[6].bus_watchlist_city;
					SELF.authrep_watchlist_state_13 				:= le.AuthRep2Watchlists[6].bus_watchlist_state;
					SELF.authrep_watchlist_zip_13  				:= le.AuthRep2Watchlists[6].bus_watchlist_zip;
					SELF.authrep_watchlist_country_13      := le.AuthRep2Watchlists[6].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_13  := le.AuthRep2Watchlists[6].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_13     := le.AuthRep2Watchlists[6].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_13     := le.AuthRep2Watchlists[6].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_13  := le.AuthRep2Watchlists[6].bus_watchlist_publisheddate;
          //AuthRep2-7
          SELF.authrep_watchlist_table_14    		:= le.AuthRep2Watchlists[7].bus_watchlist_table;
					SELF.authrep_watchlist_program_14 			:= le.AuthRep2Watchlists[7].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_14:= le.AuthRep2Watchlists[7].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_14  := le.AuthRep2Watchlists[7].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_14    := le.AuthRep2Watchlists[7].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_14     := le.AuthRep2Watchlists[7].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_14     	:= le.AuthRep2Watchlists[7].bus_watchlist_address;
					SELF.authrep_watchlist_city_14    			:= le.AuthRep2Watchlists[7].bus_watchlist_city;
					SELF.authrep_watchlist_state_14 				:= le.AuthRep2Watchlists[7].bus_watchlist_state;
					SELF.authrep_watchlist_zip_14  				:= le.AuthRep2Watchlists[7].bus_watchlist_zip;
					SELF.authrep_watchlist_country_14      := le.AuthRep2Watchlists[7].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_14  := le.AuthRep2Watchlists[7].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_14     := le.AuthRep2Watchlists[7].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_14     := le.AuthRep2Watchlists[7].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_14  := le.AuthRep2Watchlists[7].bus_watchlist_publisheddate;  
          //AuthRep3-1
					SELF.authrep_watchlist_table_15    		:= le.AuthRep3Watchlists[1].bus_watchlist_table;
					SELF.authrep_watchlist_program_15 			:= le.AuthRep3Watchlists[1].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_15:= le.AuthRep3Watchlists[1].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_15  := le.AuthRep3Watchlists[1].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_15    := le.AuthRep3Watchlists[1].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_15     := le.AuthRep3Watchlists[1].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_15     	:= le.AuthRep3Watchlists[1].bus_watchlist_address;
					SELF.authrep_watchlist_city_15    			:= le.AuthRep3Watchlists[1].bus_watchlist_city;
					SELF.authrep_watchlist_state_15 				:= le.AuthRep3Watchlists[1].bus_watchlist_state;
					SELF.authrep_watchlist_zip_15  				:= le.AuthRep3Watchlists[1].bus_watchlist_zip;
					SELF.authrep_watchlist_country_15      := le.AuthRep3Watchlists[1].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_15  := le.AuthRep3Watchlists[1].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_15     := le.AuthRep3Watchlists[1].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_15     := le.AuthRep3Watchlists[1].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_15  := le.AuthRep3Watchlists[1].bus_watchlist_publisheddate;
          //AuthRep3-2
          SELF.authrep_watchlist_table_16    		:= le.AuthRep3Watchlists[2].bus_watchlist_table;
					SELF.authrep_watchlist_program_16 			:= le.AuthRep3Watchlists[2].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_16:= le.AuthRep3Watchlists[2].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_16  := le.AuthRep3Watchlists[2].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_16    := le.AuthRep3Watchlists[2].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_16     := le.AuthRep3Watchlists[2].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_16     	:= le.AuthRep3Watchlists[2].bus_watchlist_address;
					SELF.authrep_watchlist_city_16    			:= le.AuthRep3Watchlists[2].bus_watchlist_city;
					SELF.authrep_watchlist_state_16 				:= le.AuthRep3Watchlists[2].bus_watchlist_state;
					SELF.authrep_watchlist_zip_16  				:= le.AuthRep3Watchlists[2].bus_watchlist_zip;
					SELF.authrep_watchlist_country_16      := le.AuthRep3Watchlists[2].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_16  := le.AuthRep3Watchlists[2].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_16     := le.AuthRep3Watchlists[2].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_16     := le.AuthRep3Watchlists[2].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_16  := le.AuthRep3Watchlists[2].bus_watchlist_publisheddate;
          //AuthRep3-3
          SELF.authrep_watchlist_table_17    		:= le.AuthRep3Watchlists[3].bus_watchlist_table;
					SELF.authrep_watchlist_program_17 			:= le.AuthRep3Watchlists[3].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_17:= le.AuthRep3Watchlists[3].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_17  := le.AuthRep3Watchlists[3].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_17    := le.AuthRep3Watchlists[3].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_17     := le.AuthRep3Watchlists[3].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_17     	:= le.AuthRep3Watchlists[3].bus_watchlist_address;
					SELF.authrep_watchlist_city_17    			:= le.AuthRep3Watchlists[3].bus_watchlist_city;
					SELF.authrep_watchlist_state_17 				:= le.AuthRep3Watchlists[3].bus_watchlist_state;
					SELF.authrep_watchlist_zip_17  				:= le.AuthRep3Watchlists[3].bus_watchlist_zip;
					SELF.authrep_watchlist_country_17      := le.AuthRep3Watchlists[3].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_17  := le.AuthRep3Watchlists[3].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_17     := le.AuthRep3Watchlists[3].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_17     := le.AuthRep3Watchlists[3].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_17  := le.AuthRep3Watchlists[3].bus_watchlist_publisheddate;
          //AuthRep3-4
          SELF.authrep_watchlist_table_18    		:= le.AuthRep3Watchlists[4].bus_watchlist_table;
					SELF.authrep_watchlist_program_18 			:= le.AuthRep3Watchlists[4].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_18:= le.AuthRep3Watchlists[4].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_18  := le.AuthRep3Watchlists[4].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_18    := le.AuthRep3Watchlists[4].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_18     := le.AuthRep3Watchlists[4].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_18     	:= le.AuthRep3Watchlists[4].bus_watchlist_address;
					SELF.authrep_watchlist_city_18    			:= le.AuthRep3Watchlists[4].bus_watchlist_city;
					SELF.authrep_watchlist_state_18 				:= le.AuthRep3Watchlists[4].bus_watchlist_state;
					SELF.authrep_watchlist_zip_18  				:= le.AuthRep3Watchlists[4].bus_watchlist_zip;
					SELF.authrep_watchlist_country_18      := le.AuthRep3Watchlists[4].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_18  := le.AuthRep3Watchlists[4].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_18     := le.AuthRep3Watchlists[4].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_18     := le.AuthRep3Watchlists[4].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_18  := le.AuthRep3Watchlists[4].bus_watchlist_publisheddate;
          //AuthRep3-5
          SELF.authrep_watchlist_table_19    		:= le.AuthRep3Watchlists[5].bus_watchlist_table;
					SELF.authrep_watchlist_program_19 			:= le.AuthRep3Watchlists[5].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_19:= le.AuthRep3Watchlists[5].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_19  := le.AuthRep3Watchlists[5].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_19    := le.AuthRep3Watchlists[5].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_19     := le.AuthRep3Watchlists[5].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_19     	:= le.AuthRep3Watchlists[5].bus_watchlist_address;
					SELF.authrep_watchlist_city_19    			:= le.AuthRep3Watchlists[5].bus_watchlist_city;
					SELF.authrep_watchlist_state_19 				:= le.AuthRep3Watchlists[5].bus_watchlist_state;
					SELF.authrep_watchlist_zip_19  				:= le.AuthRep3Watchlists[5].bus_watchlist_zip;
					SELF.authrep_watchlist_country_19      := le.AuthRep3Watchlists[5].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_19  := le.AuthRep3Watchlists[5].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_19     := le.AuthRep3Watchlists[5].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_19     := le.AuthRep3Watchlists[5].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_19  := le.AuthRep3Watchlists[5].bus_watchlist_publisheddate;
          //AuthRep3-6
          SELF.authrep_watchlist_table_20    		:= le.AuthRep3Watchlists[6].bus_watchlist_table;
					SELF.authrep_watchlist_program_20 			:= le.AuthRep3Watchlists[6].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_20:= le.AuthRep3Watchlists[6].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_20  := le.AuthRep3Watchlists[6].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_20    := le.AuthRep3Watchlists[6].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_20     := le.AuthRep3Watchlists[6].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_20     	:= le.AuthRep3Watchlists[6].bus_watchlist_address;
					SELF.authrep_watchlist_city_20    			:= le.AuthRep3Watchlists[6].bus_watchlist_city;
					SELF.authrep_watchlist_state_20 				:= le.AuthRep3Watchlists[6].bus_watchlist_state;
					SELF.authrep_watchlist_zip_20  				:= le.AuthRep3Watchlists[6].bus_watchlist_zip;
					SELF.authrep_watchlist_country_20      := le.AuthRep3Watchlists[6].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_20  := le.AuthRep3Watchlists[6].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_20     := le.AuthRep3Watchlists[6].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_20     := le.AuthRep3Watchlists[6].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_20  := le.AuthRep3Watchlists[6].bus_watchlist_publisheddate;
          //AuthRep3-7
          SELF.authrep_watchlist_table_21    		:= le.AuthRep3Watchlists[7].bus_watchlist_table;
					SELF.authrep_watchlist_program_21 			:= le.AuthRep3Watchlists[7].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_21:= le.AuthRep3Watchlists[7].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_21  := le.AuthRep3Watchlists[7].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_21    := le.AuthRep3Watchlists[7].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_21     := le.AuthRep3Watchlists[7].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_21     	:= le.AuthRep3Watchlists[7].bus_watchlist_address;
					SELF.authrep_watchlist_city_21    			:= le.AuthRep3Watchlists[7].bus_watchlist_city;
					SELF.authrep_watchlist_state_21 				:= le.AuthRep3Watchlists[7].bus_watchlist_state;
					SELF.authrep_watchlist_zip_21  				:= le.AuthRep3Watchlists[7].bus_watchlist_zip;
					SELF.authrep_watchlist_country_21      := le.AuthRep3Watchlists[7].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_21  := le.AuthRep3Watchlists[7].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_21     := le.AuthRep3Watchlists[7].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_21     := le.AuthRep3Watchlists[7].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_21  := le.AuthRep3Watchlists[7].bus_watchlist_publisheddate;  
          //AuthRep4-1
					SELF.authrep_watchlist_table_22    		:= le.AuthRep4Watchlists[1].bus_watchlist_table;
					SELF.authrep_watchlist_program_22 			:= le.AuthRep4Watchlists[1].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_22:= le.AuthRep4Watchlists[1].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_22  := le.AuthRep4Watchlists[1].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_22    := le.AuthRep4Watchlists[1].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_22     := le.AuthRep4Watchlists[1].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_22     	:= le.AuthRep4Watchlists[1].bus_watchlist_address;
					SELF.authrep_watchlist_city_22    			:= le.AuthRep4Watchlists[1].bus_watchlist_city;
					SELF.authrep_watchlist_state_22 				:= le.AuthRep4Watchlists[1].bus_watchlist_state;
					SELF.authrep_watchlist_zip_22  				:= le.AuthRep4Watchlists[1].bus_watchlist_zip;
					SELF.authrep_watchlist_country_22      := le.AuthRep4Watchlists[1].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_22  := le.AuthRep4Watchlists[1].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_22     := le.AuthRep4Watchlists[1].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_22     := le.AuthRep4Watchlists[1].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_22  := le.AuthRep4Watchlists[1].bus_watchlist_publisheddate;
          //AuthRep4-2
          SELF.authrep_watchlist_table_23    		:= le.AuthRep4Watchlists[2].bus_watchlist_table;
					SELF.authrep_watchlist_program_23 			:= le.AuthRep4Watchlists[2].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_23:= le.AuthRep4Watchlists[2].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_23  := le.AuthRep4Watchlists[2].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_23    := le.AuthRep4Watchlists[2].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_23     := le.AuthRep4Watchlists[2].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_23     	:= le.AuthRep4Watchlists[2].bus_watchlist_address;
					SELF.authrep_watchlist_city_23    			:= le.AuthRep4Watchlists[2].bus_watchlist_city;
					SELF.authrep_watchlist_state_23 				:= le.AuthRep4Watchlists[2].bus_watchlist_state;
					SELF.authrep_watchlist_zip_23  				:= le.AuthRep4Watchlists[2].bus_watchlist_zip;
					SELF.authrep_watchlist_country_23      := le.AuthRep4Watchlists[2].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_23  := le.AuthRep4Watchlists[2].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_23     := le.AuthRep4Watchlists[2].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_23     := le.AuthRep4Watchlists[2].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_23  := le.AuthRep4Watchlists[2].bus_watchlist_publisheddate;
          //AuthRep4-3
          SELF.authrep_watchlist_table_24    		:= le.AuthRep4Watchlists[3].bus_watchlist_table;
					SELF.authrep_watchlist_program_24 			:= le.AuthRep4Watchlists[3].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_24:= le.AuthRep4Watchlists[3].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_24  := le.AuthRep4Watchlists[3].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_24    := le.AuthRep4Watchlists[3].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_24     := le.AuthRep4Watchlists[3].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_24     	:= le.AuthRep4Watchlists[3].bus_watchlist_address;
					SELF.authrep_watchlist_city_24    			:= le.AuthRep4Watchlists[3].bus_watchlist_city;
					SELF.authrep_watchlist_state_24 				:= le.AuthRep4Watchlists[3].bus_watchlist_state;
					SELF.authrep_watchlist_zip_24  				:= le.AuthRep4Watchlists[3].bus_watchlist_zip;
					SELF.authrep_watchlist_country_24      := le.AuthRep4Watchlists[3].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_24  := le.AuthRep4Watchlists[3].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_24     := le.AuthRep4Watchlists[3].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_24     := le.AuthRep4Watchlists[3].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_24  := le.AuthRep4Watchlists[3].bus_watchlist_publisheddate;
          //AuthRep4-4
          SELF.authrep_watchlist_table_25    		:= le.AuthRep4Watchlists[4].bus_watchlist_table;
					SELF.authrep_watchlist_program_25 			:= le.AuthRep4Watchlists[4].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_25:= le.AuthRep4Watchlists[4].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_25  := le.AuthRep4Watchlists[4].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_25    := le.AuthRep4Watchlists[4].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_25     := le.AuthRep4Watchlists[4].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_25     	:= le.AuthRep4Watchlists[4].bus_watchlist_address;
					SELF.authrep_watchlist_city_25    			:= le.AuthRep4Watchlists[4].bus_watchlist_city;
					SELF.authrep_watchlist_state_25 				:= le.AuthRep4Watchlists[4].bus_watchlist_state;
					SELF.authrep_watchlist_zip_25  				:= le.AuthRep4Watchlists[4].bus_watchlist_zip;
					SELF.authrep_watchlist_country_25      := le.AuthRep4Watchlists[4].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_25  := le.AuthRep4Watchlists[4].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_25     := le.AuthRep4Watchlists[4].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_25     := le.AuthRep4Watchlists[4].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_25  := le.AuthRep4Watchlists[4].bus_watchlist_publisheddate;
          //AuthRep4-5
          SELF.authrep_watchlist_table_26    		:= le.AuthRep4Watchlists[5].bus_watchlist_table;
					SELF.authrep_watchlist_program_26 			:= le.AuthRep4Watchlists[5].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_26:= le.AuthRep4Watchlists[5].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_26  := le.AuthRep4Watchlists[5].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_26    := le.AuthRep4Watchlists[5].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_26     := le.AuthRep4Watchlists[5].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_26     	:= le.AuthRep4Watchlists[5].bus_watchlist_address;
					SELF.authrep_watchlist_city_26    			:= le.AuthRep4Watchlists[5].bus_watchlist_city;
					SELF.authrep_watchlist_state_26 				:= le.AuthRep4Watchlists[5].bus_watchlist_state;
					SELF.authrep_watchlist_zip_26  				:= le.AuthRep4Watchlists[5].bus_watchlist_zip;
					SELF.authrep_watchlist_country_26      := le.AuthRep4Watchlists[5].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_26  := le.AuthRep4Watchlists[5].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_26     := le.AuthRep4Watchlists[5].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_26     := le.AuthRep4Watchlists[5].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_26  := le.AuthRep4Watchlists[5].bus_watchlist_publisheddate;
          //AuthRep4-6
          SELF.authrep_watchlist_table_27    		:= le.AuthRep4Watchlists[6].bus_watchlist_table;
					SELF.authrep_watchlist_program_27 			:= le.AuthRep4Watchlists[6].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_27:= le.AuthRep4Watchlists[6].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_27  := le.AuthRep4Watchlists[6].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_27    := le.AuthRep4Watchlists[6].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_27     := le.AuthRep4Watchlists[6].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_27     	:= le.AuthRep4Watchlists[6].bus_watchlist_address;
					SELF.authrep_watchlist_city_27    			:= le.AuthRep4Watchlists[6].bus_watchlist_city;
					SELF.authrep_watchlist_state_27 				:= le.AuthRep4Watchlists[6].bus_watchlist_state;
					SELF.authrep_watchlist_zip_27  				:= le.AuthRep4Watchlists[6].bus_watchlist_zip;
					SELF.authrep_watchlist_country_27      := le.AuthRep4Watchlists[6].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_27  := le.AuthRep4Watchlists[6].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_27     := le.AuthRep4Watchlists[6].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_27     := le.AuthRep4Watchlists[6].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_27  := le.AuthRep4Watchlists[6].bus_watchlist_publisheddate;
          //AuthRep4-7
          SELF.authrep_watchlist_table_28    		:= le.AuthRep4Watchlists[7].bus_watchlist_table;
					SELF.authrep_watchlist_program_28 			:= le.AuthRep4Watchlists[7].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_28:= le.AuthRep4Watchlists[7].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_28  := le.AuthRep4Watchlists[7].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_28    := le.AuthRep4Watchlists[7].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_28     := le.AuthRep4Watchlists[7].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_28     	:= le.AuthRep4Watchlists[7].bus_watchlist_address;
					SELF.authrep_watchlist_city_28    			:= le.AuthRep4Watchlists[7].bus_watchlist_city;
					SELF.authrep_watchlist_state_28 				:= le.AuthRep4Watchlists[7].bus_watchlist_state;
					SELF.authrep_watchlist_zip_28  				:= le.AuthRep4Watchlists[7].bus_watchlist_zip;
					SELF.authrep_watchlist_country_28      := le.AuthRep4Watchlists[7].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_28  := le.AuthRep4Watchlists[7].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_28     := le.AuthRep4Watchlists[7].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_28     := le.AuthRep4Watchlists[7].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_28  := le.AuthRep4Watchlists[7].bus_watchlist_publisheddate;  
          //AuthRep5-1
					SELF.authrep_watchlist_table_29    		:= le.AuthRep5Watchlists[1].bus_watchlist_table;
					SELF.authrep_watchlist_program_29 			:= le.AuthRep5Watchlists[1].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_29:= le.AuthRep5Watchlists[1].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_29  := le.AuthRep5Watchlists[1].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_29    := le.AuthRep5Watchlists[1].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_29     := le.AuthRep5Watchlists[1].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_29     	:= le.AuthRep5Watchlists[1].bus_watchlist_address;
					SELF.authrep_watchlist_city_29    			:= le.AuthRep5Watchlists[1].bus_watchlist_city;
					SELF.authrep_watchlist_state_29 				:= le.AuthRep5Watchlists[1].bus_watchlist_state;
					SELF.authrep_watchlist_zip_29  				:= le.AuthRep5Watchlists[1].bus_watchlist_zip;
					SELF.authrep_watchlist_country_29      := le.AuthRep5Watchlists[1].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_29  := le.AuthRep5Watchlists[1].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_29     := le.AuthRep5Watchlists[1].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_29     := le.AuthRep5Watchlists[1].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_29  := le.AuthRep5Watchlists[1].bus_watchlist_publisheddate;
          //AuthRep5-2
          SELF.authrep_watchlist_table_30    		:= le.AuthRep5Watchlists[2].bus_watchlist_table;
					SELF.authrep_watchlist_program_30 			:= le.AuthRep5Watchlists[2].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_30:= le.AuthRep5Watchlists[2].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_30  := le.AuthRep5Watchlists[2].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_30    := le.AuthRep5Watchlists[2].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_30     := le.AuthRep5Watchlists[2].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_30     	:= le.AuthRep5Watchlists[2].bus_watchlist_address;
					SELF.authrep_watchlist_city_30    			:= le.AuthRep5Watchlists[2].bus_watchlist_city;
					SELF.authrep_watchlist_state_30 				:= le.AuthRep5Watchlists[2].bus_watchlist_state;
					SELF.authrep_watchlist_zip_30  				:= le.AuthRep5Watchlists[2].bus_watchlist_zip;
					SELF.authrep_watchlist_country_30      := le.AuthRep5Watchlists[2].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_30  := le.AuthRep5Watchlists[2].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_30     := le.AuthRep5Watchlists[2].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_30     := le.AuthRep5Watchlists[2].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_30  := le.AuthRep5Watchlists[2].bus_watchlist_publisheddate;
          //AuthRep5-3
          SELF.authrep_watchlist_table_31    		:= le.AuthRep5Watchlists[3].bus_watchlist_table;
					SELF.authrep_watchlist_program_31 			:= le.AuthRep5Watchlists[3].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_31:= le.AuthRep5Watchlists[3].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_31  := le.AuthRep5Watchlists[3].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_31    := le.AuthRep5Watchlists[3].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_31     := le.AuthRep5Watchlists[3].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_31     	:= le.AuthRep5Watchlists[3].bus_watchlist_address;
					SELF.authrep_watchlist_city_31    			:= le.AuthRep5Watchlists[3].bus_watchlist_city;
					SELF.authrep_watchlist_state_31 				:= le.AuthRep5Watchlists[3].bus_watchlist_state;
					SELF.authrep_watchlist_zip_31  				:= le.AuthRep5Watchlists[3].bus_watchlist_zip;
					SELF.authrep_watchlist_country_31      := le.AuthRep5Watchlists[3].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_31  := le.AuthRep5Watchlists[3].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_31     := le.AuthRep5Watchlists[3].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_31     := le.AuthRep5Watchlists[3].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_31  := le.AuthRep5Watchlists[3].bus_watchlist_publisheddate;
          //AuthRep5-4
          SELF.authrep_watchlist_table_32    		:= le.AuthRep5Watchlists[4].bus_watchlist_table;
					SELF.authrep_watchlist_program_32 			:= le.AuthRep5Watchlists[4].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_32:= le.AuthRep5Watchlists[4].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_32  := le.AuthRep5Watchlists[4].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_32    := le.AuthRep5Watchlists[4].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_32     := le.AuthRep5Watchlists[4].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_32     	:= le.AuthRep5Watchlists[4].bus_watchlist_address;
					SELF.authrep_watchlist_city_32    			:= le.AuthRep5Watchlists[4].bus_watchlist_city;
					SELF.authrep_watchlist_state_32 				:= le.AuthRep5Watchlists[4].bus_watchlist_state;
					SELF.authrep_watchlist_zip_32  				:= le.AuthRep5Watchlists[4].bus_watchlist_zip;
					SELF.authrep_watchlist_country_32      := le.AuthRep5Watchlists[4].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_32  := le.AuthRep5Watchlists[4].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_32     := le.AuthRep5Watchlists[4].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_32     := le.AuthRep5Watchlists[4].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_32  := le.AuthRep5Watchlists[4].bus_watchlist_publisheddate;
          //AuthRep5-5
          SELF.authrep_watchlist_table_33    		:= le.AuthRep5Watchlists[5].bus_watchlist_table;
					SELF.authrep_watchlist_program_33 			:= le.AuthRep5Watchlists[5].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_33:= le.AuthRep5Watchlists[5].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_33  := le.AuthRep5Watchlists[5].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_33    := le.AuthRep5Watchlists[5].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_33     := le.AuthRep5Watchlists[5].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_33     	:= le.AuthRep5Watchlists[5].bus_watchlist_address;
					SELF.authrep_watchlist_city_33    			:= le.AuthRep5Watchlists[5].bus_watchlist_city;
					SELF.authrep_watchlist_state_33 				:= le.AuthRep5Watchlists[5].bus_watchlist_state;
					SELF.authrep_watchlist_zip_33  				:= le.AuthRep5Watchlists[5].bus_watchlist_zip;
					SELF.authrep_watchlist_country_33      := le.AuthRep5Watchlists[5].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_33  := le.AuthRep5Watchlists[5].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_33     := le.AuthRep5Watchlists[5].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_33     := le.AuthRep5Watchlists[5].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_33  := le.AuthRep5Watchlists[5].bus_watchlist_publisheddate;
          //AuthRep5-6
          SELF.authrep_watchlist_table_34    		:= le.AuthRep5Watchlists[6].bus_watchlist_table;
					SELF.authrep_watchlist_program_34 			:= le.AuthRep5Watchlists[6].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_34:= le.AuthRep5Watchlists[6].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_34  := le.AuthRep5Watchlists[6].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_34    := le.AuthRep5Watchlists[6].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_34     := le.AuthRep5Watchlists[6].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_34     	:= le.AuthRep5Watchlists[6].bus_watchlist_address;
					SELF.authrep_watchlist_city_34    			:= le.AuthRep5Watchlists[6].bus_watchlist_city;
					SELF.authrep_watchlist_state_34 				:= le.AuthRep5Watchlists[6].bus_watchlist_state;
					SELF.authrep_watchlist_zip_34  				:= le.AuthRep5Watchlists[6].bus_watchlist_zip;
					SELF.authrep_watchlist_country_34      := le.AuthRep5Watchlists[6].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_34  := le.AuthRep5Watchlists[6].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_34     := le.AuthRep5Watchlists[6].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_34     := le.AuthRep5Watchlists[6].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_34  := le.AuthRep5Watchlists[6].bus_watchlist_publisheddate;
          //AuthRep5-7
          SELF.authrep_watchlist_table_35    		:= le.AuthRep5Watchlists[7].bus_watchlist_table;
					SELF.authrep_watchlist_program_35 			:= le.AuthRep5Watchlists[7].bus_watchlist_program;
					SELF.authrep_watchlist_record_number_35:= le.AuthRep5Watchlists[7].bus_watchlist_record_number;
					SELF.authrep_watchlist_companyname_35  := le.AuthRep5Watchlists[7].bus_watchlist_companyname;
					SELF.authrep_watchlist_firstname_35    := le.AuthRep5Watchlists[7].bus_watchlist_firstname;
					SELF.authrep_watchlist_lastname_35     := le.AuthRep5Watchlists[7].bus_watchlist_lastname;
					SELF.authrep_watchlist_address_35     	:= le.AuthRep5Watchlists[7].bus_watchlist_address;
					SELF.authrep_watchlist_city_35    			:= le.AuthRep5Watchlists[7].bus_watchlist_city;
					SELF.authrep_watchlist_state_35 				:= le.AuthRep5Watchlists[7].bus_watchlist_state;
					SELF.authrep_watchlist_zip_35  				:= le.AuthRep5Watchlists[7].bus_watchlist_zip;
					SELF.authrep_watchlist_country_35      := le.AuthRep5Watchlists[7].bus_watchlist_country;
					SELF.authrep_watchlist_entity_name_35  := le.AuthRep5Watchlists[7].bus_watchlist_entity_name;
					SELF.authrep_watchlist_sequence_35     := le.AuthRep5Watchlists[7].bus_watchlist_sequence;
          SELF.authrep_watchlist_entitydate_35     := le.AuthRep5Watchlists[7].bus_watchlist_entitydate;
          SELF.authrep_watchlist_publisheddate_35  := le.AuthRep5Watchlists[7].bus_watchlist_publisheddate;  
          
          
          
          SELF := [];
          
				END;

    watchlist_results := IF( Options.OFAC_Version = 4, SearchOutXG5, SearchOut );
    
		ds_businesses_watchlist := PROJECT( watchlist_results, xfm_toFinalLayout(LEFT) );		
    
		// OUTPUT( ds_input, NAMED('ds_input') );
		// OUTPUT( ds_input_denormed, NAMED('ds_input_denormed') );
		// OUTPUT( inForm_Company, NAMED('inForm_Company') );
		// OUTPUT( inForm_AuthReps, NAMED('inForm_AuthReps') );
		// OUTPUT( inForm_All_pre, NAMED('inForm_All_pre') );
		// OUTPUT( inForm_Group, NAMED('inForm_Group') );
		// OUTPUT( patOut, NAMED('patOut') );
		// OUTPUT( pat_recs_pre, NAMED('pat_recs_pre') );
		// OUTPUT( pat_recs, NAMED('pat_recs') );
		// OUTPUT( SearchOut_pre, NAMED('SearchOut_withWLs') );
		// OUTPUT( SearchOut, NAMED('SearchOut_ofac') );
		// OUTPUT( prep_XG5, NAMED('prep_XG5') );
		// OUTPUT( XG5_ptys, NAMED('XG5_ptys') );
		// OUTPUT( XG5Parsed_Company, NAMED('XG5Parsed_Company') );
		// OUTPUT( XG5Parsed_AuthRep1, NAMED('XG5Parsed_AuthRep1') );
		// OUTPUT( XG5Parsed_AuthRep2, NAMED('XG5Parsed_AuthRep2') );
		// OUTPUT( XG5Parsed_AuthRep3, NAMED('XG5Parsed_AuthRep3') );
		// OUTPUT( NonErrorRecsXG5_Company, NAMED('NonErrorRecsXG5_Company') );
		// OUTPUT( NonErrorRecsXG5_AuthRep1, NAMED('NonErrorRecsXG5_AuthRep1') );
		// OUTPUT( NonErrorRecsXG5_AuthRep2, NAMED('NonErrorRecsXG5_AuthRep2') );
		// OUTPUT( NonErrorRecsXG5_AuthRep3, NAMED('NonErrorRecsXG5_AuthRep3') );
		// OUTPUT( dedupRespXG5_Company, NAMED('dedupRespXG5_Company') );
		// OUTPUT( dedupRespXG5_AuthRep1, NAMED('dedupRespXG5_AuthRep1') );
		// OUTPUT( dedupRespXG5_AuthRep2, NAMED('dedupRespXG5_AuthRep2') );
		// OUTPUT( dedupRespXG5_AuthRep3, NAMED('dedupRespXG5_AuthRep3') );
		// OUTPUT( AddFileXG5, NAMED('AddFileXG5') );
		// OUTPUT( CurrentMatchesXG5_Company, NAMED('CurrentMatchesXG5_Company') );
		// OUTPUT( CurrentMatchesXG5_AuthRep1, NAMED('CurrentMatchesXG5_AuthRep1') );
		// OUTPUT( CurrentMatchesXG5_AuthRep2, NAMED('CurrentMatchesXG5_AuthRep2') );
		// OUTPUT( CurrentMatchesXG5_AuthRep3, NAMED('CurrentMatchesXG5_AuthRep3') );
		// OUTPUT( CurrentMatchesXG5_AuthRep4, NAMED('CurrentMatchesXG5_AuthRep4') );
		// OUTPUT( CurrentMatchesXG5_AuthRep5, NAMED('CurrentMatchesXG5_AuthRep5') );
		// OUTPUT( CurrentMatchesXG5_sorted, NAMED('CurrentMatchesXG5_sorted') );
		// OUTPUT( CurrentMatchesXG5_Company_sorted, NAMED('CurrentMatchesXG5_Company_sorted') );
		// OUTPUT( CurrentMatchesXG5_AuthRep1_sorted, NAMED('CurrentMatchesXG5_AuthRep1_sorted') );
		// OUTPUT( CurrentMatchesXG5_AuthRep2_sorted, NAMED('CurrentMatchesXG5_AuthRep2_sorted') );
		// OUTPUT( CurrentMatchesXG5_AuthRep3_sorted, NAMED('CurrentMatchesXG5_AuthRep3_sorted') );
		// OUTPUT( CurrentMatchesXG5_AuthRep4_sorted, NAMED('CurrentMatchesXG5_AuthRep4_sorted') );
		// OUTPUT( CurrentMatchesXG5_AuthRep5_sorted, NAMED('CurrentMatchesXG5_AuthRep5_sorted') );
		// OUTPUT( XG5_recs_Company, NAMED('XG5_recs_Company') );
		// OUTPUT( XG5_recs_AuthRep1, NAMED('XG5_recs_AuthRep1') );
		// OUTPUT( XG5_recs_AuthRep2, NAMED('XG5_recs_AuthRep2') );
		// OUTPUT( XG5_recs_AuthRep3, NAMED('XG5_recs_AuthRep3') );
		// OUTPUT( XG5_recs_AuthRep4, NAMED('XG5_recs_AuthRep4') );
		// OUTPUT( XG5_recs_AuthRep5, NAMED('XG5_recs_AuthRep5') );
		// OUTPUT( SearchOutXG5_pre, NAMED('SearchOutXG5_pre') );
		// OUTPUT( SearchOutXG5_OFAC, NAMED('SearchOutXG5_OFAC') );
		// OUTPUT( SearchOutXG5_AuthRep1, NAMED('SearchOutXG5_AuthRep1') );
		// OUTPUT( SearchOutXG5_AuthRep2, NAMED('SearchOutXG5_AuthRep2') );
		// OUTPUT( SearchOutXG5_AuthRep3, NAMED('SearchOutXG5_AuthRep3') );
		// OUTPUT( SearchOutXG5_AuthRep4, NAMED('SearchOutXG5_AuthRep4') );
		// OUTPUT( SearchOutXG5, NAMED('SearchOutXG5') );
		// OUTPUT( watchlist_results, NAMED('watchlist_resultsDS') );
		RETURN ds_businesses_watchlist;

	END;
		
