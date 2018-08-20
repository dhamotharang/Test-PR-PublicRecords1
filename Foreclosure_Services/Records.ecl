import AutoStandardI,Foreclosure_Services,doxie,Property,iesp,ut, BIPV2;

export Records := module
	export params := interface(
		Foreclosure_Services.SearchService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)
		export string6 ssnmask;
	end;
	export val(params in_mod, boolean isNodSearch=false) := function
		// Get the IDs, pull the payload records and add Foreclosure_id.
		ids := Foreclosure_services.SearchService_IDs.val(in_mod,isNodSearch);
																 
		recs:=Foreclosure_Services.Raw.GetRawRecs(ids,isNodSearch, in_mod.IndustryClass);
		// Calculate the penalty on the records

		recs_plus_pen := project(recs,transform(Foreclosure_Services.Layouts.rawrec,
			tempindvmod_1 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := left.situs1_p_city_name;
				export did_field := left.name1_did;
				export fname_field := left.name1_first;
				export lname_field := left.name1_last;
				export mname_field := left.name1_middle;
				export phone_field := '';
				export pname_field := left.situs1_prim_name;
				export postdir_field := left.situs1_postdir;
				export prange_field := left.situs1_prim_range;
				export predir_field := left.situs1_predir;
				export ssn_field := left.name1_ssn;  
				export state_field := left.situs1_st;
				export suffix_field := left.situs1_addr_suffix;
				export sec_range_field := left.situs1_sec_range;
				export zip_field := left.situs1_zip;
				export city2_field := left.situs1_v_city_name;
				export county_field := left.situs1_fipscounty;
				export dob_field := '';
				export dod_field := '';
			end;

			tempindvmod_2 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := left.situs2_p_city_name;
				export did_field := left.name2_did;
				export fname_field := left.name2_first;
				export lname_field := left.name2_last;
				export mname_field := left.name2_middle;
				export phone_field := '';
				export pname_field := left.situs2_prim_name;
				export postdir_field := left.situs2_postdir;
				export prange_field := left.situs2_prim_range;
				export predir_field := left.situs2_predir;
				export ssn_field := left.name2_ssn;  
				export state_field := left.situs2_st;
				export suffix_field := left.situs2_addr_suffix;
				export sec_range_field := left.situs2_sec_range;
				export zip_field := left.situs2_zip;
				export city2_field := left.situs2_v_city_name;
				export county_field := left.situs2_fipscounty;
				export dob_field := '';
				export dod_field := '';
			end;	
			
			tempindvmod_3 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := '';
				export did_field := left.name3_did;
				export fname_field := left.name3_first;
				export lname_field := left.name3_last;
				export mname_field := left.name3_middle;
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export ssn_field := left.name1_ssn;  
				export state_field := '';
				export suffix_field := '';
				export sec_range_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
			end;	
			
			tempindvmod_4 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := '';
				export did_field := left.name4_did;
				export fname_field := left.name4_first;
				export lname_field := left.name4_last;
				export mname_field := left.name4_middle;
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export ssn_field := left.name4_ssn;  
				export state_field := '';
				export suffix_field := '';
				export sec_range_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';
				export dob_field := '';
				export dod_field := '';
			end;
			
			tempbizmod_1 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				export cname_field := left.name1_company;
				export allow_wildcard := false;
				export bdid_field := left.name1_bdid;
				export city_field := '';
				export fein_field := '';
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export state_field := '';
				export suffix_field := '';
				export sec_range_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';
			end;

			tempbizmod_2 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				export cname_field := left.name2_company;
				export allow_wildcard := false;
				export bdid_field := left.name2_bdid;
				export city_field := '';
				export fein_field := '';
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export state_field := '';
				export suffix_field := '';
				export sec_range_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';

			end;
			
			tempbizmod_3 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				export cname_field := left.name3_company;
				export allow_wildcard := false;
				export bdid_field := left.name3_bdid;
				export city_field := '';
				export fein_field := '';
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export state_field := '';
				export suffix_field := '';
				export sec_range_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';
				
			end;

			tempbizmod_4 := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				export cname_field := left.name4_company;
				export allow_wildcard := false;
				export bdid_field := left.name4_bdid;
				export city_field := '';
				export fein_field := '';
				export phone_field := '';
				export pname_field := '';
				export postdir_field := '';
				export prange_field := '';
				export predir_field := '';
				export state_field := '';
				export suffix_field := '';
				export sec_range_field := '';
				export zip_field := '';
				export city2_field := '';
				export county_field := '';
				
			end;


				 pen_rec_tmp:=record
				 unsigned2 pen_calc;
				 end;

		     tempPenaltAddr1 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_addr(tempindvmod_1);
		     tempPenaltAddr2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_addr(tempindvmod_2);
			   tempPenaltAddr  := if(tempPenaltAddr1<tempPenaltAddr2,tempPenaltAddr1,tempPenaltAddr2);
				 
				 tempPenaltName1 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_indv_name(tempindvmod_1);
		     tempPenaltName2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_indv_name(tempindvmod_2);
				 tempPenaltName3 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_indv_name(tempindvmod_3);
		     tempPenaltName4 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_indv_name(tempindvmod_4);
				 tempPenaltName  := min(dataset([{tempPenaltName1},{tempPenaltName2},{tempPenaltName3},{tempPenaltName4}],pen_rec_tmp),pen_calc);
				
				 tempPenaltSSN1 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_ssn(tempindvmod_1);
		     tempPenaltSSN2 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_ssn(tempindvmod_2);
				 tempPenaltSSN3 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_ssn(tempindvmod_3);
		     tempPenaltSSN4 := AutoStandardI.LIBCALL_PenaltyI_Indv.val_ssn(tempindvmod_4);
				 tempPenaltSSN  := min(dataset([{tempPenaltSSN1},{tempPenaltSSN2},{tempPenaltSSN3},{tempPenaltSSN4}],pen_rec_tmp),pen_calc);

				tempPenaltIndv :=tempPenaltAddr+ tempPenaltName + tempPenaltSSN ;
				
				tempPenaltBiz1 := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod_1);
				tempPenaltBiz2 := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod_2);
				tempPenaltBiz3 := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod_3);
				tempPenaltBiz4 := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod_4);
				tempPenaltBiz  := min(dataset([{tempPenaltBiz1},{tempPenaltBiz2},{tempPenaltBiz3},{tempPenaltBiz4}],pen_rec_tmp),pen_calc);									

			// if its deepdive records don't apply the pentalty...
			 
			self.penalt := if (left.isDeepDive, 0, tempPenaltIndv + tempPenaltBiz),
			self := left));
    
		added_in_mod := project(in_mod, functions.params);
		
		recs_fmt := Foreclosure_Services.Functions.fnForeclosureSearchval(recs_plus_pen,added_in_mod);

    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		
		recs_sort := dedup(sort(recs_fmt(_penalty <= pthreshold_translated),if(AlsoFound,1,0),
						_penalty,-recordingdate,record),
						record);

		tempresults_slim := choosen(project(recs_sort,iesp.foreclosure.t_ForeclosureSearchRecord), iesp.Constants.MAX_COUNT_Foreclosure_SEARCH); 

		//for debugging purpose
		// output(ids,named('SSREcs_ids'));
		// output(ids_tmp,named('SSREcs_ids_tmp'));
		// output(recs,named('SSREcs_recs'));
		// output(recs_plus_pen,named('SSREcs_recs_plus_pen'));
		// output(recs_sort,named('SSREcs_recs_sort'));
		
		return if(not doxie.DataRestriction.Fares,tempresults_slim,dataset([],iesp.foreclosure.t_ForeclosureSearchRecord));
		
		end;
		
end;

