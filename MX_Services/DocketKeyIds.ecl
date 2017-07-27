import doxie,MXD_MXDocket,ut;

export DocketKeyIds(
										IParam.DocketSearchParams input, 
										boolean noFail=false, 
										dataset(MX_Services.Layouts.MXNameVariant) name_variants = dataset([], MX_Services.Layouts.MXNameVariant)
										) := function

	docket_key 				:= MXD_MXDocket.Key_DocketSearch;	
	docket_key_mph 		:= MXD_MXDocket.Key_DocketMPHSearch;	
	docket_key_docnum	:= MXD_MXDocket.Key_DocketNum;	

	SearchType 			:= Constants.SearchType;	
	
	in_fname 				:= input.sFirstName;
	in_lname 				:= input.sPaternalName;
	in_mname				:= input.sMiddleName;
	in_matronymic 	:= input.sMaternalName;	
  in_statecodes 	:= input.DocketStateCodes;
	in_gender 			:= input.InputGender;
	in_docket_type 	:= Constants.MapToNatureType(input.DocketType);
	in_year 				:= input.DocketPubYear;
	in_docnum				:= input.DocketNumber;

	in_search_type  := map(
											in_lname='' and in_fname<>'' and in_matronymic<>'' => SearchType.FMX, // search
											in_fname='' and in_lname<>'' and in_matronymic<>'' => SearchType.LMX,
											Constants.SearchType.FLM);	

	// R2 enhancement: Using vendor provided synonym table for name matching.
	// We're pulling in *ALL* provided name variants/synonyms. Average number of variants: 1.6, max variants: 23 (VELAZQUEZ).
	fname_variants 			:= set(name_variants(namematch=1), variant);
	lname_variants 			:= set(name_variants(namematch=2), variant);
	matronymic_variants := set(name_variants(namematch=3), variant);
	
  in_n1_variants 			:= if(in_search_type=SearchType.LMX, lname_variants, fname_variants);
  in_n2_variants 			:= if(in_search_type=SearchType.FLM, lname_variants, matronymic_variants);
  in_n3_variants 			:= if(in_search_type=SearchType.FLM, matronymic_variants, []);
	
	// Index read is based on search type, which is determined by the input criteria.
	// 		search_type=FLM, n1=first, 		n2=paternal, n3=maternal
	// 		search_type=LMX, n1=paternal, n2=maternal, n3=*
	// 		search_type=FMX, n1=first, 		n2=maternal, n3=*		
	in_n1  := if(in_search_type=SearchType.LMX, in_lname, in_fname);
	in_n2  := if(in_search_type=SearchType.FLM, in_lname, in_matronymic);
	in_n3  := if(in_search_type=SearchType.FLM, in_matronymic, '');
	len_n1 := length(trim(in_n1));
	boolean fname_prefix_match := in_search_type!=SearchType.LMX and len_n1>=3;	
	
	srch_ids_with_variants := project(limit(
														docket_key(in_n1<>'' and in_n2<>'',
															 keyed(search_type=in_search_type),
															 keyed(n1=in_n1 or (n1 in in_n1_variants) or (fname_prefix_match and (n1[1..len_n1] = in_n1[1..len_n1]))),
															 keyed(n2=in_n2 or (n2 in in_n2_variants)),
															 keyed(in_n3='' or n3=in_n3 or (n3 in in_n3_variants)),										 
															 keyed(in_mname='' or in_mname[1]=minit[1]),
															 keyed(in_docket_type=0 or (in_docket_type=nature_type)),
															 keyed(in_year=0 or (year=in_year)),
															 keyed(count(in_statecodes)=0 or state in in_statecodes),
															 keyed(in_gender='' or in_gender=gender)), MX_Services.Constants.Limits.MAX_FETCH, skip),
														 Layouts.MXEntityIds); 
														
	srch_ids_novariants := project(docket_key(in_n1<>'' and in_n2<>'',
													 keyed(search_type=in_search_type),
													 keyed(n1=in_n1 or (fname_prefix_match and (n1[1..len_n1] = in_n1[1..len_n1]))),
													 keyed(n2=in_n2),
													 keyed(in_n3='' or n3=in_n3),										 
													 keyed(in_mname='' or in_mname[1]=minit[1]),
													 keyed(in_docket_type=0 or (in_docket_type=nature_type)),
													 keyed(in_year=0 or (year=in_year)),
													 keyed(count(in_statecodes)=0 or state in in_statecodes),
													 keyed(in_gender='' or in_gender=gender)),
													Layouts.MXEntityIds);									

	// trying to avoid too many matches due to name variants.
	srch_ids := if(exists(srch_ids_with_variants), srch_ids_with_variants, srch_ids_novariants);

	n1m1 := MetaphoneLib.DMetaphone1(in_n1);
	n1m2 := MetaphoneLib.DMetaphone2(in_n1);
	n2m1 := MetaphoneLib.DMetaphone1(in_n2);
	n2m2 := MetaphoneLib.DMetaphone2(in_n2);
	n3m1 := MetaphoneLib.DMetaphone1(in_n3);
	n3m2 := MetaphoneLib.DMetaphone2(in_n3);

	// ***********************************************************************************************
	// Regarding phonetic matching logic below:
	//
	// Double metaphone returns a primary and secondary code for a string. Secondary code accounts for 
	// multiple variants of surnames with common ancestry. For example, encoding the name "Smith" yields 
	// a primary code of SM0 and a secondary code of XMT, while the name "Schmidt" yields a primary code 
	// of XMT and a secondary code of SMT--both have XMT in common -- (Source: wikipedia).
	//
	// ***********************************************************************************************

	mph_ids := project(docket_key_mph(in_n1<>'' and in_n2<>'',
										 keyed(search_type=in_search_type),				
										 keyed(n1_m1[1..6] = n1m1[1..6]),	
										 keyed(n1_m2[1..6] = n1m2[1..6]),											 
										 keyed(n2_m1[1..6] = n2m1[1..6]),	
										 keyed(n2_m2[1..6] = n2m2[1..6]),	
										 keyed(in_n3='' or n3_m1[1..6] = n3m1[1..6]),	
										 keyed(in_n3='' or n3_m2[1..6] = n3m2[1..6]),		
										 keyed(in_mname='' or in_mname[1]=minit[1]),
										 keyed(in_docket_type=0 or (in_docket_type=nature_type)),
										 keyed(in_year=0 or (year=in_year)),
										 keyed(count(in_statecodes)=0 or state in in_statecodes),
										 keyed(in_gender='' or in_gender=gender)),
										Layouts.MXEntityIds);

	ids := if(~input.phoneticmatch, srch_ids, mph_ids); 	
		
	// ***********************************************************************************************
	// Search by Document number
	// ***********************************************************************************************
	
	len_docnum := length(trim(in_docnum));
	doc_ids := project(docket_key_docnum(len_docnum >= 3,
										 keyed(docket_num = in_docnum),
										 keyed(count(in_statecodes)=0 or state in in_statecodes),
										 keyed(in_year=0 or (docket_year=in_year))
										 ), Layouts.MXEntityIds);	
	
	all_ids := if(len_docnum > 0, doc_ids, ids);
	
	ids_fail := limit(all_ids, MX_Services.Constants.Limits.MAX_FETCH, FAIL(203,doxie.ErrorCodes(203)));	
	ids_skip := limit(all_ids, MX_Services.Constants.Limits.MAX_FETCH, skip);	
	ids_skiporfail := if(noFail, ids_skip, ids_fail);	

	return dedup(sort(ids_skiporfail, rec_id, entity_id)); 

end;