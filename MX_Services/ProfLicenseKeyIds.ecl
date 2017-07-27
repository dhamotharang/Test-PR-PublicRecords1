import doxie,ut;
export ProfLicenseKeyIds(IParam.ProfLicenseSearchParams input, boolean noFail=false) := function

	SearchType 			:= Constants.SearchType;	
	
	in_fname 				:= input.sFirstName;
	in_lname 				:= input.sPaternalName;
	in_mname				:= input.sMiddleName;
	in_matronymic 	:= input.sMaternalName;	
	in_gender 			:= input.InputGender;
	in_category			:= input.Category;
	in_search_type  := map(
											in_lname='' and in_fname<>'' and in_matronymic<>'' => SearchType.FMX, // search
											in_fname='' and in_lname<>'' and in_matronymic<>'' => SearchType.LMX,
											Constants.SearchType.FLM);	
	
	plic_key 			:= Keys.Key_ProfLicenseSearch;	
	plic_key_mph	:= Keys.Key_ProfLicenseMPHSearch;	

	// Index read is based on search type, which is determined by the input criteria.
	// 		search_type=FLM, n1=first, 		n2=paternal, n3=maternal
	// 		search_type=LMX, n1=paternal, n2=maternal, n3=*
	// 		search_type=FMX, n1=first, 		n2=maternal, n3=*		
	in_n1  := if(in_search_type=SearchType.LMX, in_lname, in_fname);
	in_n2  := if(in_search_type=SearchType.FLM, in_lname, in_matronymic);
	in_n3  := if(in_search_type=SearchType.FLM, in_matronymic, '');
	len_n1 := length(trim(in_n1));
	boolean fname_prefix_match := in_search_type!=SearchType.LMX and len_n1>=3;
	
	all_ids := project(plic_key(in_n1<>'' and in_n2<>'',
										 keyed(search_type=in_search_type),
										 keyed(n1=in_n1 or (fname_prefix_match and (n1[1..len_n1] = in_n1[1..len_n1]))),
										 keyed(n2=in_n2),
										 keyed(in_n3='' or n3=in_n3),										 
										 keyed(in_mname='' or in_mname[1]=minit[1]),
										 keyed(in_category=0 or in_category=prof_cat),
										 keyed(in_gender='' or in_gender=gender)),
										Layouts.MXEntityIds);

	n1m1 := MetaphoneLib.DMetaphone1(in_n1);
	n1m2 := MetaphoneLib.DMetaphone2(in_n1);
	n2m1 := MetaphoneLib.DMetaphone1(in_n2);
	n2m2 := MetaphoneLib.DMetaphone2(in_n2);
	n3m1 := MetaphoneLib.DMetaphone1(in_n3);
	n3m2 := MetaphoneLib.DMetaphone2(in_n3);

	mph_ids := project(plic_key_mph(in_n1<>'' and in_n2<>'',
										 keyed(search_type=in_search_type),										 
										 keyed(n1_m1[1..6] = n1m1[1..6]),	
										 keyed(n1_m2[1..6] = n1m2[1..6]),											 
										 keyed(n2_m1[1..6] = n2m1[1..6]),	
										 keyed(n2_m2[1..6] = n2m2[1..6]),	
										 keyed(in_n3='' or n3_m1[1..6] = n3m1[1..6]),	
										 keyed(in_n3='' or n3_m2[1..6] = n3m2[1..6]),										 										 
										 keyed(in_mname='' or in_mname[1]=minit[1]),
										 keyed(in_category=0 or in_category=prof_cat),
										 keyed(in_gender='' or in_gender=gender)),
										Layouts.MXEntityIds);
										
	ids0 := if(~input.phoneticmatch, all_ids, mph_ids); 	
	ids_fail := limit(ids0, MX_Services.Constants.Limits.MAX_FETCH, FAIL(203,doxie.ErrorCodes(203)));	
	ids_skip := limit(ids0, MX_Services.Constants.Limits.MAX_FETCH, skip);	
	ids_skiporfail := if(noFail, ids_skip, ids_fail);
	ids := project(ids_skiporfail, transform(Layouts.MXEntityIds, self := left));
	
	return ids;

end;