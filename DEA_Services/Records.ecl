import AutoStandardI,dea_Services,doxie,dea,iesp,ut,suppress;

export Records := module
	export params := interface(
		DEA_Services.SearchService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
		AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)
	end;
	export val(params in_mod) := function
	
		// Get the IDs, pull the payload records and add DEA_id.
		ids := DEA_services.SearchService_IDs.val(in_mod);
																 
		Suppress.MAC_Suppress(ids,ids_tmp,in_mod.applicationType,Suppress.Constants.LinkTypes.DID,did);

		recs := join(ids_tmp,DEA.Key_dea_reg_num,
		             keyed(left.Dea_Registration_Number =  right.Dea_Registration_Number),
											transform(DEA_Services.Layouts.Rawrec,	
													 self.bdid :=(string) left.bdid,
													 self.did :=(string) left.did,
													 self.Dea_Registration_Number :=left.Dea_Registration_Number,
													 self.isDeepDive:=left.isDeepDive;		
 													 self:=right,  // set for use later.
																),limit(ut.limits.DEA_MAX, skip));
		
	
			
		// Calculate the penalty on the records

		recs_plus_pen := project(recs,transform(DEA_Services.Layouts.rawrec,
			tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := left.p_city_name;
				export did_field := left.did;
				export fname_field := left.fname;
				export lname_field := left.lname;
				export mname_field := left.mname;
				export phone_field := '';
				export pname_field := left.prim_name;
				export postdir_field := left.postdir;
				export prange_field := left.prim_range;
				export predir_field := left.predir;
				export ssn_field := left.best_ssn;  
				export state_field := left.st;
				export suffix_field := left.addr_suffix;
				export sec_range_field := left.sec_range;
				export zip_field := left.zip;
				export city2_field := '';
				export county_field := left.county_name;
				export dob_field := '';
				export dod_field := '';
			end;

			
			tempbizmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				export allow_wildcard := false;
				export bdid_field := left.bdid;
				export city_field := left.p_city_name;
				export cname_field := left.cname;
				export fein_field := '';
				export phone_field := '';
				export pname_field := left.prim_name;
				export postdir_field := left.postdir;
				export prange_field := left.prim_range;
				export predir_field := left.predir;
				export state_field := left.st;
				export suffix_field := left.addr_suffix;
				export sec_range_field := left.sec_range;
				export zip_field := left.zip;
				export city2_field := '';
				export county_field := left.county_name;
			end;
			
			// The business info will only ever use the business address.
			tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
			tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val(tempbizmod);
									
			// if its deepdive records don't apply the pentalty...
			 
			self.penalt := if (left.isDeepDive, 0, tempPenaltIndv + tempPenaltBiz),
			self := left));
    
		// Format for output
						
		added_in_mod := project(in_mod, functions.params);
		
		recs_fmt := DEA_Services.Functions.fnDEASearchval(recs_plus_pen, added_in_mod);
		
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		recs_sort := dedup(sort(recs_fmt(_penalty <= pthreshold_translated),if(AlsoFound,1,0),
						_penalty,registrationnumber,-ExpirationDate,record),
						record);
		tempresults_slim := choosen(recs_sort, iesp.Constants.MAX_COUNT_DEA_SEARCH); 

		//for debugging purpose
		// output(ids,named('SSREcs_ids'));
		// output(ids_tmp,named('SSREcs_ids_tmp'));
		// output(recs,named('SSREcs_recs'));
		// output(recs_plus_pen,named('SSREcs_recs_plus_pen'));
		// output(recs_sort,named('SSREcs_recs_sort'));
		
		return tempresults_slim;
		
		end;
		
end;

