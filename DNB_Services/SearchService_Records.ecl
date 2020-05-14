import AutoStandardI, ut, dnb, iesp, Doxie;

export SearchService_Records := module
	export params := interface(
		DNB_Services.SearchService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params)
		export unsigned2 penaltThreshold;
	end;
	export val(params in_mod) := function
	
		ms(string70 a, string70 b, string70 c) :=
			map(a = '' => b,
					b = '' => a,
					ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b); 
					
		
		// Get the IDs, pull the payload records
		ids := dnb_services.SearchService_IDs.val(in_mod);
		// join to payload key.
		// added condition to limit our records coming back.
		recs := join(ids,DNB.key_DNB_DunsNum,
		             keyed(left.duns_number =  right.duns) and Doxie.DataPermission.use_DNB,
											transform(dnb_Services.Layouts.Rawrec,																									
																self:=right
																),limit(dnb_services.constants.max_recs_on_dnbNumber_join, skip));
	
    recs_alpha_sort := sort(recs, state, city, duns_number);												
    																
				
		// Calculate the penalty on the records
		recs_plus_pen := project(recs_alpha_sort,transform(dnb_Services.Layouts.rawrec,
			
			tempbizmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
				export allow_wildcard := false;
				export bdid_field := '';
				export city_field := trim(ms(left.p_city_name, left.v_city_name, left.city),left,right);
				export cname_field := left.business_name;
				export fein_field := '';
				export phone_field := left.telephone_number;
				export pname_field := left.prim_name;
				export postdir_field := left.postdir;
				export prange_field := left.prim_range;
				export predir_field := left.predir;
				export state_field := left.st;
				export suffix_field := left.addr_suffix;
				export zip_field := left.zip;
				export city2_field := '';
				export county_field := left.county;
			end;
			
			// The business info will only ever use the business address.
			tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val(tempbizmod);
									
			// if its deepdive records don't apply the pentalty...
			 
			self.penalt := if (left.isDeepDive, 0, tempPenaltBiz),
			self := left));
    
		// Format for output
				
		added_in_mod := project(in_mod, functions.params);
		
		recs_fmt := dnb_Services.Functions.dnbSearchval(recs_plus_pen, added_in_mod);
		recs_sort_tmp := dedup(sort(recs_fmt(penalt <= in_mod.penaltThreshold or isDeepDive),if(isDeepDive,1,0),penalt,BusinessId,companyname,-tradename,-datelastseen),
						BusinessId);

		recs_sort := sort(recs_sort_tmp, if(isDeepDive,1,0),penalt,companyname,-tradename,-datelastseen,record);	
						
		tempresults_slim := choosen(project(recs_sort, iesp.dunandbradstreet.t_DunAndBradstreetRecord),iesp.Constants.DNB_MAX_COUNT_SEARCH_RECORDS); 
		//(This is the sort order decided after Vladimir had a discussion with Lisa.)
		//for debugging purpose
		// output(ids,named('SSR_ids'));
		// output(recs,named('SSR_recs'));
		// output(recs_plus_pen,named('SSR_recs_plus_pen'));
		// output(recs_sort,named('SSR_recs_sort'));
		// output(tempresults_slim,named('SSR_tempresults_slim'));
		
		return tempresults_slim;
		
		end;
end;
