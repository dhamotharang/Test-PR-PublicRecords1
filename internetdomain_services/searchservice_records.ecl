import AutoStandardI,internetDomain_services,iesp,suppress;

export SearchService_Records := module
	export params := interface(
		internetDomain_services.SearchService_IDs.params,
		AutoStandardI.LIBIN.PenaltyI_Indv.base,		
		AutoStandardI.InterfaceTranslator.glb_purpose.params,
		AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)
	end;
	
	export val(params in_mod) := function
	
		ids := InternetDomain_services.SearchService_IDs.val(in_mod);
				
		// supress certain DIDs.  Set ofDID is all together in one keyfile
		// under field 'did'.  Macro takes ids - in dataset
		                             // did name of did field
																 // ids_tmp out dataset
																 
		Suppress.MAC_Suppress(ids,ids_tmp,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
		
		//this returns entire payload here so available for penalty calculation
		recs := internetDomain_services.raw.ByIDs(ids_tmp);
		
			// Calculate the penalty on the records
			// use either name from fname, lname, prim_name, zip etc or from 
			// tech.fname, tech.lname, tech.prim_name, tech.zip
			// based on logic in autokey process build for this query.
			
		recs_plus_pen := project(recs,transform(internetdomain_services.Layouts.rawRec,
			tempindvmod_tech := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
						
				export allow_wildcard := false;
				export city_field := left.tech_v_city_name;
				export did_field :=  (string12) left.did;
				export fname_field   := left.tech_fname;				                          
				export lname_field   := left.tech_lname;																
				export mname_field   := left.tech_mname;															
				export phone_field   := '';
				export pname_field   := 	left.tech_prim_name;																
				export postdir_field := left.tech_postdir;																	
				export prange_field  := left.tech_prim_range;																	
				export predir_field  := left.tech_predir;																
				// ssn penalty will always be 0 since ssn is not an input.
				export ssn_field     := '';  
				export state_field   := left.tech_state;																
				export suffix_field  := left.tech_suffix;
				export sec_range_field := left.tech_sec_range;
				export zip_field     := left.tech_zip;																
				export city2_field   := '';
				export county_field  := left.county;
				export dob_field     := '';
				export dod_field     := '';
			end;
						
			tempindvmod_admin := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
			 
				export allow_wildcard := false;
				export city_field := left.Admin_v_city_name; 
				export did_field :=  (string12) left.did;
				export fname_field   := left.admin_fname;				                           
				export lname_field   := left.admin_lname;
				export mname_field   := left.Admin_mname;															
				export phone_field   := '';
				export pname_field   := 	left.admin_prim_name;															
				export postdir_field := left.Admin_postdir;																	
				export prange_field  := left.Admin_prim_range;																
				export predir_field  := left.Admin_predir;
				// ssn penalty will always be 0 since ssn is not an input.
				export ssn_field     := '';  
				export state_field   := left.Admin_state;																
				export suffix_field  := left.Admin_suffix;
				export sec_range_field := left.Admin_sec_range;
				export zip_field     := left.Admin_zip;															
				export city2_field   := '';
				export county_field  := left.county;
				export dob_field     := '';
				export dod_field     := '';
			end;
			
			
			tempindvmod_registrant := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
			 
				 export allow_wildcard := false;
				 export city_field := left.registrant_v_city_name; 
				export did_field :=  (string12) left.did;   
				export fname_field   := left.Registrant_fname;
				export lname_field   := left.Registrant_lname;																	
				export mname_field   := left.Registrant_mname;															
				export phone_field   := '';
				export pname_field   := left.Registrant_prim_name;																
				export postdir_field := left.Registrant_postdir;																	
				export prange_field  := left.Registrant_prim_range;																	
				export predir_field  := left.Registrant_predir;
				//ssn penalty will always be 0 since ssn is not an input.
				export ssn_field     := '';  
				export state_field   := left.registrant_state;																
				export suffix_field  := left.registrant_suffix;
				export sec_range_field := left.registrant_sec_range;
				export zip_field     := left.registrant_zip;																
				export city2_field   := '';
				export county_field  := left.county;
				export dob_field     := '';
				 export dod_field     := '';
			 end;
				
			tempbizmodAdmin := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))							
				export allow_wildcard := false;
				export bdid_field := (string12) left.bdid;
				export city_field := left.v_city_name;  
				export cname_field := left.admin_name;
				export fein_field := '';
				export phone_field := '';
				export pname_field := left.admin_prim_name;
				export postdir_field := left.admin_postdir;
				export prange_field := left.admin_prim_range;
				export predir_field := left.admin_predir;
				export state_field := left.admin_state;
				export suffix_field := left.admin_suffix;
				export sec_range_field := left.Admin_sec_range;
				export zip_field := left.admin_zip;
				export city2_field := '';
				export county_field := left.county;
			end;
			
			tempbizmodRegistrant := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))							
				export allow_wildcard := false;
				export bdid_field := (string12) left.bdid;
				export city_field := stringlib.StringToUpperCase(left.Registrant_prim_name);
				export cname_field := stringlib.StringToUpperCase(left.registrant_name);
				export fein_field := '';
				export phone_field := '';
				export pname_field := stringlib.StringToUpperCase(left.Registrant_prim_name);
				export postdir_field := stringlib.StringToUpperCase(left.Registrant_postdir);
				export prange_field := stringlib.StringToUpperCase(left.Registrant_prim_range);
				export predir_field := stringlib.StringToUpperCase(left.Registrant_predir);
				export state_field := stringlib.StringToUpperCase(left.Registrant_state);
				export suffix_field := stringlib.StringToUpperCase(left.Registrant_suffix);
				export sec_range_field := stringlib.StringToUpperCase(left.Registrant_sec_range);
				export zip_field := stringlib.StringToUpperCase(left.Registrant_zip);
				export city2_field := '';
				export county_field := left.county;
			end;
			
			   pen_rec_tmp:=record
				     unsigned2 pen_calc;
				 end;
				  				 
         tempPenaltAdmin      := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod_admin);
		     tempPenaltTech       := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod_tech);
				 tempPenaltRegistrant := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod_registrant);
				 tempPenaltIndv       := min(dataset([{tempPenaltAdmin},
				                                      {tempPenaltTech},
																				      {tempPenaltRegistrant}
																							],
																				        pen_rec_tmp),pen_calc);				 
																								
          tmpBizAdminName      := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmodAdmin);
					tmpBizRegistrantName := AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmodRegistrant);
					tempPenaltBiz := min(dataset([{tmpBizAdminName},{tmpBizRegistrantName}], pen_rec_tmp), pen_calc);
					

			// The business info will only ever use the business address.
			// tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
						
			// did it this way cause address penalty (val_county and val_addr) 
			// was getting double counted if previous line above was used.
																					
			// if its deepdive records don't apply the pentalty...			 
			self.penalt := if (left.isDeepDive, 0, tempPenaltIndv + tempPenaltBiz),
			self := left));
    
		// Format for output
				
		added_in_mod := project(in_mod, functions.params);
		
		recs_fmt := InternetDomain_services.Functions.fnInternetServicesSearchVal(recs_plus_pen, added_in_mod);
				
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
		recs_pen := recs_fmt (_penalty <= pthreshold_translated);
		
		recs_pen_sorted := sort(recs_pen, _penalty, domainname, 
		                         -datelastseen.year, -datelastseen.month, -datelastSeen.Day, record);
		
		tempresults := project(recs_pen_sorted, iesp.internetdomain.t_InetDomainRecord); 
		
		 //output(recs_plus_pen, named('recs_plus_pen'));
		//output(in_mod.firstname,named('fname'));
		return tempresults;
		
	end; // function
end; // module	