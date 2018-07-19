import Address, AutokeyB2,AutoStandardI,BatchServices, BatchShare, Doxie, Doxie_Raw, MX_Services,  ut, VehicleV2_Services;

export Functions := module
	// re: PENALIZATION
	// NOTE: input to header penalization performed by a call to AutoStandardI.LIBCALL_PenaltyI.val(penMod);
	// According to the requirements (Sections 4.1-3, 4.1-4, 4.1-7, 4.1-9, 4.1-10), penalization
	// must take place to reveal the record that matches the search subject best. The query must
	// also compare an input DL or VIN (if present) against those DL or VIN values belonging to 
	// the matching records:

	// re: ADDITIONAL PENALIZATION
	// NOTE: fn_penalize_dl and fn_penalize_plate attribute were created, the default penalty increase used was 2
	// -------------------------------------------------------------------------------------------------------------
	// "For each possible subject, conduct a Driver's License search.  If input DL does not match 
	// any DLs for a subject, then increase the penalty score for that subject" (Section 4.1-9).
	//
	// And, "[f]or each possible subject, conduct an in-house MVR search.  If the input plate and 
	// state do not match any vehicle registrations for a subject, then increase the penalty score 
	// for that subject" (Section 4.1-10).
	//=====================================================================================
	export penalize_records(ERO_Services.Layouts.layout_batch_in_for_penalties input_rec, 
		                      ERO_Services.Layouts.Subject_out_temp match_rec,
													ERO_Services.IParam.searchParams aInputData) :=		
													
	  FUNCTION
		  // this function returns a penalty score based on comparing the input and header record
		  
		  //input values from aInputData +   header record values from match_rec
			
		  penMod := module(project(aInputData, AutoStandardI.LIBIN.PenaltyI.full,opt))			
		  // penMod := module(AutoStandardI.LIBIN.PenaltyI.full)			
		  	// Options
				EXPORT BOOLEAN noFail := true;
				//EXPORT BOOLEAN workHard := true;
		    //EXPORT BOOLEAN isdeepDive := FALSE;
		    EXPORT UNSIGNED2 	penalty_threshold := 10;
		    EXPORT UNSIGNED2 	max_results := 10;
				EXPORT allow_wildcard := FALSE;
				EXPORT isPRP := FALSE;
				EXPORT scorethreshold := 10;
				EXPORT useGlobalScope := FALSE;
				
				//SPII
				EXPORT DOB := (UNSIGNED8)input_rec._dob;
				EXPORT SSN := input_rec._ssn;
				// name
				EXPORT fname := input_rec._name_first;
				EXPORT mname := input_rec._name_middle;
				EXPORT Lname := input_rec._name_last;
				// Address
				EXPORT addr := '';
				EXPORT prim_range := input_rec._prim_range;
				EXPORT primrange := '';
				EXPORT predir := input_rec._predir;
				EXPORT prim_name := input_rec._prim_name;
				EXPORT primname := '';
				EXPORT street_name := '';
				EXPORT suffix := input_rec._addr_suffix;
				EXPORT postdir := input_rec._postdir;
				EXPORT sec_range := input_rec._sec_range;
				EXPORT secrange := '';
				EXPORT statecityzip := '';
				EXPORT city := input_rec._p_city_name;
				EXPORT othercity1 := '';
				EXPORT st := input_rec._st;
				EXPORT st_orig := '';
				EXPORT state := '';
				EXPORT otherstate1 := '';
				EXPORT otherstate2 := '';
				EXPORT z5 := input_rec._z5;
				EXPORT zip := '';
	
				export did_field := (STRING)match_rec.did;
  			export ssn_field := match_rec.subject_ssn;  
				
				//takes string mm/dd/YYYY and created ,YYYYmmdd
		    year := match_rec.subject_dob[7..10];
			  month := match_rec.subject_dob[1..2];
			  day := match_rec.subject_dob[4..5];
		    export dob_field := year+month+day;
				                                                        
  			export fname_field := match_rec.subject_first_name;
				export lname_field := match_rec.subject_last_name;
				export mname_field := match_rec.subject_middle_name;
				export pname_field := match_rec.header_addr.prim_name;
				export postdir_field := match_rec.header_addr.postdir;
				export prange_field := match_rec.header_addr.prim_range;
				export predir_field := match_rec.header_addr.predir;
				export suffix_field := match_rec.header_addr.addr_suffix;
				export sec_range_field := match_rec.header_addr.sec_range;
				export city_field := match_rec.header_addr.p_city_name;
				export state_field := match_rec.header_addr.st;
				export zip_field := match_rec.header_addr.z5;
				export city2_field := '';
				export bdid_field := '';
				export phone_field := '';
				export county_field := '';
				export cname_field := '';
				export fein_field := '';
				export agehigh := 0;
				export agelow := 0;
		  END;
			record_penalty:= AutoStandardI.LIBCALL_PenaltyI.val(penMod);
			return record_penalty ;
	end;				


export sn_dob_match_records(ERO_Services.Layouts.IntermediateData input_rec, 
		                      ERO_Services.Layouts.Subject_out_temp match_rec) := 
	function
	  // this function returns a string list of matching codes based on a comparison of the input and header record found
	  ssnMatch := if (ut.NBEQ(input_rec.ssn,match_rec.subject_ssn) ,ERO_Services.Constants.SubjectMatch.ssnMatch,'');
		NBFirst := input_rec.name_first <> '' and match_rec.subject_First_Name <> '';
		NBMiddle := input_rec.name_middle <> '' and match_rec.subject_Middle_Name <> '';
		NBLast := input_rec.name_last <> '' and match_rec.subject_Last_Name <> '';
	  firstMatch := if (NBFirst and (input_rec.name_first in ut.StringSplit(match_rec.subject_first_Name) 
		               OR match_rec.subject_first_Name in ut.StringSplit( input_rec.name_first)),ERO_Services.Constants.SubjectMatch.firstMatch,'');
	  midMatch := if (NBMiddle and (input_rec.name_middle in ut.StringSplit(match_rec.subject_Middle_Name)
                   OR match_rec.subject_Middle_Name in ut.StringSplit(input_rec.name_middle)),ERO_Services.Constants.SubjectMatch.midMatch,'');	  
		lastMatch := if (NBLast and (input_rec.name_last in ut.StringSplit(match_rec.subject_last_Name)
                   OR match_rec.subject_last_Name in ut.StringSplit(input_rec.name_last)),ERO_Services.Constants.SubjectMatch.lastMatch,'');
	  dobMMMatch := if ( ut.NBEQ(input_rec.dob[5..6], match_rec.subject_dob[1..2]),ERO_Services.Constants.SubjectMatch.dobMMMatch,'');  //_dob=YYYYMMDD, subjectdob=mm/dd/yyyy
	  dobDDMatch := if ( ut.NBEQ(input_rec.dob[7..8], match_rec.subject_dob[4..5]),ERO_Services.Constants.SubjectMatch.dobDDMatch,'');
	  dobYYYYMatch := if ( ut.NBEQ(input_rec.dob[1..4], match_rec.subject_dob[7..10]),ERO_Services.Constants.SubjectMatch.dobYYYYMatch,'');
		return ssnMatch+firstMatch+midMatch+lastMatch+dobMMMatch+dobDDMatch+dobYYYYMatch;
	end;													

EXPORT get_aka_names(dataset(ERO_Services.Layouts.layout_for_akas) ds_hdr_recs) := FUNCTION
    // this function gets aka names from header and dedups a bit and adds all akas to a string.
		// this string list of akas is in the format L,F,M; L,F M; L,F,M
    slim_rec := record
      string100 subject_name;
		  BatchServices.Layouts.AKAs.rec_results_temp;
		end;
		slim_rec slimHeader(ds_hdr_recs l) := transform
			SELF.acctno      := '';
			SELF.subject_name := l.subject_name;
			SELF.dob         := if(l.dob=0,'',(string8) l.dob);
			// Fix bad suffixes (UNK, UN1, UN2, etc.) on some header file recs
			SELF.name_suffix := if(l.name_suffix[1..1]=ERO_Services.Constants.NameWords.BADSUFFIX,'',l.name_suffix);
	   // Match acctno to batch_in ds to get the input name parts for penalty checking
		  SELF.penalt      := 0;
			SELF             := l;
		end;
  	ds_hdr_recs_slim := project(ds_hdr_recs, slimHeader(left));
		ds_all := DEDUP(SORT(ds_hdr_recs_slim, did, lname, fname, -mname, -dt_last_seen),	did, lname, fname, mname);
		
		// fill akalist with name prior to rollup for DIDs with only 1 row that wont get processed by rollups transform.
		all_aka_layout := record
		   slim_rec;
			 string200 akaList := '';
		end;
		all_aka_layout fillAKAList(ds_all l) := transform
		 self.akaList := trim(l.lname+','+l.fname+','+l.mname, all);
     self := l; 		    
		end;
		ds_all_aka_sub := project(ds_all, fillAKAList(left));
		ds_all_aka := ds_all_aka_sub(akaList <> subject_name); //filter out the subjects primary name being returned in the subject section.
		all_aka_rolled := record
				unsigned6 did := 0;
		  	string200 akaList := '';
		end;
		all_aka_layout rollupAKAs(ds_all_aka l, ds_all_aka r) := transform
		   skipname := (trim(l.lname,all) = trim(r.lname,all) and  
			             trim(l.fname,all) = trim(r.fname,all))  and 
									 (trim(r.mname)= '' or trim(r.mname,all) = l.mname[1]);
			 self.akaList := trim(l.akalist,all) + if (skipname,'','~'+r.akaList);
			 self := r;
		end;

		aka_recs := rollup(ds_all_aka, left.did = right.did, rollupAKAs(left, right)); 	

		RETURN project(aka_recs,all_aka_rolled);
END;

EXPORT add_input_names(dataset(ERO_Services.Layouts.IntermediateData) batch_in) := FUNCTION
     // this fuction will add additional input rows for each name variation

		//only perform parsing on input where either the last first or middle name have multiple words.																										 
		//first fixed multi-word first name by moving everything that isn't the first word into middle name only if middle name is blank.
     ERO_Services.Layouts.IntermediateData fixFirst(batch_in l) := transform, skip(stringlib.StringWordCount(l.name_first) <= 1 and
		                                                                          stringlib.StringWordCount(l.name_middle) <= 1 and
			                                                                        stringlib.StringWordCount(l.name_last) <= 1)
			fnameMultiWord := stringlib.StringWordCount(l.name_first) > 1;
			firstSpace := stringlib.stringfind(l.name_first,' ',1);//find first space
			firstLength := length(trim(l.name_first));
			fnameWord1 := if (fnameMultiWord, l.name_first[1..firstspace], l.name_first);
			fnameRemainder := if (fnameMultiWord, l.name_first[firstSpace..firstLength], '');
			self.name_first :=  if (fnameMultiWord, fnameWord1, l.name_first);
			self.name_middle :=  if (fnameMultiWord and l.name_middle = '',fnameRemainder ,l.name_middle);
			self := l;
		end;

		//first name fix is needed because MACROS below for compoundNames dont work with first name the way we need it to work.
		in_names_fixed := project(batch_in, fixFirst(left)) ;
    
		//create name combinations using middle and last name 
		AutokeyB2.MAC_NormalizeCompoundNames(in_names_fixed, ds_out_mname, name_middle)
		AutokeyB2.MAC_NormalizeCompoundNames(ds_out_mname, in_names_new, name_last)

   //combine original names and new names and depup them.
	   in_names_new_filtered := in_names_new(name_last <> '' and name_first <> '');
		 out_recs := dedup(sort(batch_in + in_names_new_filtered, acctno, name_first, name_middle, name_last),acctno, name_first, name_middle, name_last);
		 return out_recs;
END;

	export fn_inflate_ids_with_standardized_addrs(dataset(Layouts.LookupId) ids) := 
		function
			ids_with_standardized_addrs := 
				project(
					ids,
					transform( ERO_Services.Layouts.layout_LookupId_plus_standardized_addrs,
						self.ids_temp_address_1 :=
							StringLib.StringFilter(
											StringLib.StringToUpperCase(
												trim(left.addr1.prim_range) + 
												trim(left.addr1.prim_name) + 
												trim(left.addr1.z5)
											), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	),
						self.ids_temp_address_2 :=
							StringLib.StringFilter(
											StringLib.StringToUpperCase(
												trim(left.addr2.prim_range) + 
												trim(left.addr2.prim_name) + 
												trim(left.addr2.z5)
											), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	),
						self.ids_temp_dl_address :=
							StringLib.StringFilter(
											StringLib.StringToUpperCase(
												trim(left.dl_addr.prim_range) + 
												trim(left.dl_addr.prim_name) + 
												trim(left.dl_addr.z5)
											), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	),
						self := left
					) );
			
			return ids_with_standardized_addrs;
		end;
	
	export fn_format_date(string8 dt /* yyyymmdd */) := 
		function
			dt_trimmed := trim(dt,left,right);
			
			dt_formatted := 
				case( length(dt_trimmed),
					8 => dt[5..6] + '/' + dt[7..8] + '/' + dt[1..4],
					6 => dt[5..6] + '/00/' + dt[1..4],
					4 => '00/00/' + dt[1..4],
					/* default */ ''
				);
			
			dt_final := 
				if(
					dt_formatted = '00/00/0000', '', dt_formatted
				);
				
			return dt_final;
		end;

	export fn_format_name(string lname = '', string fname = '', string mname = '') :=
			lname + if( fname != '', ', ' + fname, '' ) + if( mname != '', ' ' + mname, '' );

	export fn_format_street_address(string prim_name, string prim_range, string predir, string postdir, string addr_suffix, string unit_desig, string sec_range) := 
			if( prim_range  != '',       prim_range, '' ) + 
			if( predir      != '', ' ' + predir, '' ) + 
			if( prim_name   != '', ' ' + prim_name, '' ) + 
			if( addr_suffix != '', ' ' + addr_suffix, '' ) + 
			if( postdir     != '', ' ' + postdir, '' ) + 
			if( unit_desig  != '', ' ' + unit_desig, '' ) + 
			if( sec_range   != '', ' ' + sec_range, '' ); 
				
	export fn_getMatchcode(ERO_Services.Layouts.layout_LookupId_plus_standardized_addrs le, 
	                       unsigned6 temp_did, string temp_address, string temp_lname, string temp_fname) :=
		function
			/*
				o   Match code:
						-  LexId related Match (L)
						-  Full Name, Address 1 match (F1)
						-  Full Name, Address 2 match (F2)
						-  Full Name, DL Address match (FDL)
						-  Last Name, Address 1 match (L1)
						-  Last Name, Address 2 match (L2)
						-  Last Name, DL Address match (LDL)  */	
			
			name_rec  := record
			   string40 nameval := '';
			end;
			
			// seed datasets with best L and F name and found L and F name
      ds_best_name_first := dataset([{le.best_name.name_first}], name_rec);			
      ds_fname           := dataset([{temp_fname}], name_rec);			
			ds_best_name_last  := dataset([{le.best_name.name_last}], name_rec);			
      ds_lname           := dataset([{temp_lname}], name_rec);			
			
			//use compound names macro to generate name variations.
			AutokeyB2.MAC_NormalizeCompoundNames(ds_best_name_first, ds_all_best_first, nameval)
			AutokeyB2.MAC_NormalizeCompoundNames(ds_fname, ds_all_fname, nameval)
   		AutokeyB2.MAC_NormalizeCompoundNames(ds_best_name_last, ds_all_best_last, nameval)
			AutokeyB2.MAC_NormalizeCompoundNames(ds_lname, ds_all_lname, nameval)

      //perform inner joins on datasets of name values 
			is_last_name_match  := exists(join(ds_all_best_last,ds_all_lname, left.nameval = right.nameval and left.nameval != ''));
			is_full_name_match  := is_last_name_match and exists(join(ds_all_best_first,ds_all_fname, left.nameval = right.nameval and left.nameval != ''));
			is_address_1_match  := le.ids_temp_address_1 = temp_address and le.ids_temp_address_1 != '';
			is_address_2_match  := le.ids_temp_address_2 = temp_address and le.ids_temp_address_2 != '';
			is_dl_address_match := le.ids_temp_dl_address = temp_address and le.ids_temp_dl_address != '';
			
			LexId_related_Match        := le.did = temp_did and le.did != 0;
			Full_Name_Address_1_match  := is_full_name_match and is_address_1_match;
			Full_Name_Address_2_match  := is_full_name_match and is_address_2_match;
			Full_Name_DL_Address_match := is_full_name_match and is_dl_address_match;
			Last_Name_Address_1_match  := is_last_name_match and is_address_1_match;
			Last_Name_Address_2_match  := is_last_name_match and is_address_2_match;
			Last_Name_DL_Address_match := is_last_name_match and is_dl_address_match;

			match_code_pre :=
					if( LexId_related_Match, 'L ', '' ) +
					if( Full_Name_Address_1_match, 'F1 ', '' ) + 
					if( Full_Name_Address_2_match, 'F2 ', '' ) +
					if( Full_Name_DL_Address_match, 'FDL ', '' ) +
					if( not Full_Name_Address_1_match and Last_Name_Address_1_match, 'L1 ', '' ) + 
					if( not Full_Name_Address_2_match and Last_Name_Address_2_match, 'L2 ', '' ) +
					if( not Full_Name_DL_Address_match and Last_Name_DL_Address_match, 'LDL ', '' );
			
			match_code_trimmed := trim(match_code_pre); // remove the trailing space.
			
			match_code := // convert space-delimited to comma-delimited
		    StringLib.StringFindReplace(match_code_trimmed, ' ', ',');
				
			return match_code;
		end;

	export fixDate(integer indate) := function
		//takes an integer date 19951203, 19951200, 19950000 or 199512, 199500 or 1995 and make a date mm/yy/yyyy
		sdob := (string)indate;
    fixdob := map ((sdob[5..8]='0000' or sdob[5..8]='00  ' or sdob[5..8]='    ') //need to also account for 6 digit yyyy00 & yyyy only dates from header
                               =>   sdob[1..4],
		           sdob[7..8]='00' =>   sdob[1..6],
		           sdob[1..8]);

    convDob :=  map (length(trim(fixdob))=4 => ut.ConvertDate(fixdob,'%Y','%m/%d/%Y'),
                 length(trim(fixdob))=6 => ut.ConvertDate(fixdob,'%Y%m','%m/%d/%Y'),
								 length(trim(fixdob))=8 => ut.ConvertDate(fixdob,'%Y%m%d','%m/%d/%Y'),
								 '');

    return convDob;				
    
  end;

	export fn_get_gender_desc(string1 genderLetter) := function
	   return map(genderLetter ='M' => 'Male', 
		            genderLetter ='F' => 'Female',
								'');
	end;
end;