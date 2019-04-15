import didville, Address, ut, Std, iesp;
	
	export dataset(MemberPoint.Layouts.BestExtended) getBest
																								(dataset(MemberPoint.Layouts.BatchInter) BatchInter, 
																								MemberPoint.IParam.BatchParams BParams)  := function
	
		didville.Layout_Did_OutBatch 
										xformInterToBest(MemberPoint.Layouts.BatchInter L) := transform
					dgSet								:=	[MemberPoint.Constants.LNSearchNameType.Derived, MemberPoint.Constants.LNSearchNameType.Guardian];
					dgmSet							:=	dgSet + [MemberPoint.Constants.LNSearchNameType.Minor];
					
					self.seq						:=	(integer)L.acctno;
					self.did						:=	L.did;
					self.ssn						:=	if(L.LN_search_name_type IN dgSet, L.guardian_ssn,L.ssn);
					currDOB							:=	if(L.LN_search_name_type IN dgSet, L.guardian_dob,L.dob);
					dobDate							:= iesp.ECL2ESP.toDatestring8(currDOB);
					self.dob						:=	iesp.ECL2ESP.DateToString(dobDate);
					self.phone10				:=	L.primary_phone_number;
					self.fname					:=	if(L.LN_search_name_type IN dgSet, L.guardian_name_first,L.name_first);
					self.mname					:=	if(L.LN_search_name_type IN dgSet, '',L.name_middle);
					self.lname					:=	if(L.LN_search_name_type IN dgSet, L.guardian_name_last,L.name_last);
					self.suffix					:=	if(L.LN_search_name_type IN dgSet, '',L.name_suffix);
					self.prim_range			:=	L.prim_range;
					self.predir 				:=	L.predir;
					self.prim_name 			:=	L.prim_name;
					self.addr_suffix 		:=	L.addr_suffix;
					self.postdir 				:=	L.postdir;
					self.unit_desig 		:=	L.unit_desig;
					self.sec_range 			:=	L.sec_range;
					self.p_city_name 		:=	L.p_city_name;
					self.st 						:=	L.st;
					self.z5 						:=	L.z5;
					self.zip4 					:=	L.zip4;
					self.email					:= 	if(L.LN_search_name_type IN dgmSet, '',L.email);
					self								:=  []; 
			end; 
			
		BestBatch := project(BatchInter,xformInterToBest(left));

		GLB := BParams.isValidGLB();
    
    STRING5 industryClass := BParams.industry_class;
		STRING120 appends:= Std.Str.ToUpperCase(BParams.Appends);
		UNSIGNED2 appendThreshold:= (UNSIGNED2)BParams.AppendThreshold;
		BOOLEAN deduped:= BParams.Deduped;
		STRING120 fuzzies:= BParams.Fuzzies;
		BOOLEAN patriotProcess:= BParams.PatriotProcess;
		STRING120 verify:= Std.Str.ToUpperCase(BParams.Verify);
		
		dsBestPre := DidVille.did_service_common_function(file_in := BestBatch,
																											appends_value := appends,
																											verify_value := verify,
																											fuzzy_value := fuzzies,
																											dedup_flag := deduped,
																											threshold_value := appendThreshold,
																											glb_flag := GLB,
																											patriot_flag := patriotProcess,
																											lookups_flag := false,
																											livingsits_flag := true,
																											hhidplus_value := false,
																											edabest_value := true,
																											glb_purpose_value := BParams.glb,
																											include_minors := false,
																											LMaxScores := DidVille.MaxScores.MMax,
																											UseNonBlankKey := FALSE,
																											appType := BParams.application_type,
																											IndustryClass_val := industryClass);
		// join back the email
				
		 
		 MemberPoint.Layouts.BestExtended xformAddress(BatchInter l , dsBestPre r ) := transform
						self.seq 					:= r.seq;
	
						addr1					:= r.best_addr1;
						addr2 				:= Address.Addr2FromComponents(r.best_city, r.best_state, r.best_zip);
						clean_addr1 	:= address.GetCleanAddress(addr1,addr2,address.Components.country.US);
						ca1						:= clean_addr1.results;
						
						self.c_best_prim_range 	:= 	ca1.prim_range;	
						self.c_best_predir			:=	ca1.predir;
						self.c_best_prim_name		:=	ca1.prim_name;
						self.c_best_addr_suffix	:=	ca1.suffix;
						self.c_best_postdir			:=	ca1.postdir;
						self.c_best_unit_desig 	:=	ca1.unit_desig;
						self.c_best_sec_range 	:=	ca1.sec_range;
						self.c_best_latitude    := 	ca1.latitude;  
						self.c_best_longitude   := 	ca1.longitude; 
						
						self.c_best_p_city_name	:=  ca1.p_city;
						
						state  									:=  ca1.state;
						self.c_best_st					:= 	state;
						self.c_best_z5					:=  ca1.zip;
						self.c_best_zip4				:=  ca1.zip4;
						
						full_county_code				:=  ca1.county;
						
						county_name 						:= 	Address.County_Names(state_alpha=state AND county_code = full_county_code[3..5] )[1].county_name;
						self.c_best_county			:= county_name;
						self.input_email 					:= 	l.email;
						self.primary_phone_number	:=	l.primary_phone_number;
						self := r;
		 end;
		 
		dsBestEPre := join(BatchInter ,dsBestPre, left.acctno = (string)right.seq,xformAddress(left,right));
						
						dsBestE1 := MemberPoint.appendLatitudeLongitude(dsBestEPre(c_best_latitude = ''));
						dsBestE	 := dsBestE1 + dsBestEPre(c_best_latitude <> '');
						dsBestEDedup := dedup(sort(dsBestE,seq,-score),seq);
    return dsBestEDedup;
	 end;