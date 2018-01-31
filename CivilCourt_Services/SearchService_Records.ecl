import AutoStandardI,doxie_cbrs,civilCourt_Services,civil_Court,iesp, ut, Address, doxie, NID, D2C;

export SearchService_Records := module
	export params := interface
	(
		civilCourt_Services.SearchService_IDs.params
		)
		 export string120 unparsedFullName := '';
		 export string30  firstname := '';
		 export string30  middlename := '';
		 export string30  lastname := '';
		 export string25 city_in :='';
		 export string2 state_in := '';
		 export string60 jurisdiction_in  := '';
		 export string120 CompanyName := '';
	end;
	export val(params in_mod) := function
	
		fullName := Address.CleanNameFields(Address.CleanPerson73(in_mod.unparsedFullName));
		
	  unparsedFullNameNotFilled := if (trim(in_mod.unparsedFullName, left,right) = '', true, false);
	
		trim_companyname := StringLib.StringToUpperCase(trim(in_mod.companyName,left,right));
		trim_firstname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.firstname,left,right)), 
		                                              StringLib.StringToUpperCase(trim(fullName.fname, left, right)));
		trim_lastname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.lastname,left,right)),
		                                              StringLib.StringToUpperCase(trim(fullName.lname, left, right)));
		                                 
		trim_middlename := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.middlename,left,right)),
		                                               StringLib.StringToUpperCase(trim(fullName.mname, left, right)));
																							 		                                             																							 
		trim_jurisdiction := StringLib.StringToUpperCase(trim(in_mod.jurisdiction_in,left,right));
		trim_state_tmp := StringLib.StringToUpperCase(trim(in_mod.state_in,left,right));
	  trim_state := if (trim_state_tmp = '', StringLib.StringToUpperCase(trim(in_mod.state,left,right)),trim_state_tmp);
		trim_city_tmp := StringLib.StringToUpperCase(trim(in_mod.city_in,left,right));	
		trim_city := if (trim_city_tmp = '', StringLib.StringToUpperCase(trim(in_mod.city,left,right)),trim_city_tmp);
		nicknamesON := AutoStandardI.InterfaceTranslator.nicknames.val(project(in_mod,
		                         AutoStandardI.InterfaceTranslator.nicknames.params)); 
    strictMatchOn := AutoStandardI.InterfaceTranslator.StrictMatch_value.val(project(in_mod,
		                         AutoStandardI.InterfaceTranslator.strictMatch_value.params));
 		phoneticsOn := AutoStandardI.InterfaceTranslator.Phonetics.val(project(in_mod,
		                         AutoStandardI.InterfaceTranslator.phonetics.params));
		industryclass := AutoStandardI.InterfaceTranslator.industry_class_value.val(project(in_mod,
														 AutoStandardI.InterfaceTranslator.industry_class_value.params));
		
		// Get the IDs, pull the payload records and add Aircraft_number (n_number to them.
		ids := civilCourt_Services.SearchService_IDs.val(in_mod);
		
		// join to payload key.
		recs := join(ids, civil_court.key_caseID,
		             keyed(left.case_key =  right.case_key) and
											(~ut.IndustryClass.is_Knowx OR right.vendor not in D2c.Constants.CivilCourtRestrictedSources),
											transform(civilCourt_Services.Layouts.PartyLayoutPlusSlim,																																								
																self:=right, // set for use later.	
																self := []), 															
																limit(iesp.constants.MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS, skip));
																  
   
	 recs_company_slim_rework := if (trim_companyName <> '', project(recs, transform(civilCourt_services.layouts.partyLayoutPlusSlim,
	                              self.e1_cname1 := if (left.e1_lname1 = '' AND left.e1_cname1 <> '', left.e1_cname1,
																                    if (left.v1_cname1 <> '' AND left.e1_lname1 = '', left.v1_cname1, left.e1_cname1)),
																self := left,)), recs);	                                  
   recs_slim := if (trim_companyName <> '', 
												recs_company_slim_rework(  (StringLib.StringFind(v1_cname1,trim_companyname,1) > 0) OR
												                           (StringLib.StringFind(e1_cname1,trim_companyname,1) > 0) OR
																									 (StringLib.StringFind(v2_cname1,trim_companyname,1) > 0) OR
																									 (StringLib.StringFind(e2_cname1,trim_companyname,1) > 0))
																									 , recs_company_slim_rework);
	  // in case just the v1_lname1 and v2_lname1 field are populated and not e.g. e1_lname1
		// then move info from that field into the e1_* field so filtering is easier farther down.
		recs_person_slim_rework := if (trim_lastname <> '', project(recs_slim, transform(civilCourt_services.layouts.partyLayoutPlusSlim,
		                              boolean v1_field_pop := if (left.v1_lname1 <> '', true, false);
																	boolean v2_field_pop := if (left.v2_lname1 <> '', true, false);
		                self.e1_lname1 := if (left.e1_lname1 = '' and left.e1_cname1 = '' AND v1_field_pop 
																				AND (StringLib.StringFind(left.v1_lname1, trim_lastname, 1) > 0) , left.v1_lname1, 
																	       if (left.e1_lname1 = '' and left.e1_cname1 = '' AND v2_field_pop 
																				 AND (stringlib.stringFind(left.v2_lname1, trim_lastname, 1) > 0) , left.v2_lname1, left.e1_lname1)),
										self.e1_mname1 := if (left.e1_mname1 = '' and left.e1_cname1 = '' AND v1_field_pop 
										                     AND (stringlib.stringFind(left.v1_lname1, trim_lastname, 1) > 0), left.v1_mname1,
																	       if (left.e1_mname1 = '' and left.e1_cname1 = '' AND v2_field_pop
																				   AND (stringlib.stringFind(left.v2_lname1, trim_lastname, 1) > 0), left.v2_mname1, left.e1_mname1)),
										self.e1_fname1 := if (left.e1_fname1 = '' and left.e1_cname1 = '' AND v1_field_pop 
										                      AND (stringlib.stringFind(left.v1_lname1, trim_lastname, 1) > 0) , left.v1_fname1,
																	       if (left.e1_fname1 = '' and left.e1_cname1 = '' AND v2_field_pop 
																				 AND (stringlib.stringFind(left.v2_lname1, trim_lastname, 1) > 0), left.v2_fname1, left.e1_fname1)),																	
										self.e1_suffix1 := if (left.e1_fname1 = '' and left.e1_cname1 = '' AND v1_field_pop
										                      AND (stringlib.stringFind(left.v1_lname1, trim_lastname, 1) > 0), left.v1_suffix1,
																				 if (left.e1_fname1 = '' and left.e1_cname1 = '' AND v2_field_pop
																				 AND (stringlib.stringFind(left.v2_lname1, trim_lastname, 1) > 0), left.v2_suffix1, left.e1_suffix1)),
																				self := left)), recs_slim); 
																	
    // filter out last names    																	
    recs_person_slim := if (trim_firstname <> '' OR trim_lastname <> '',
		                       recs_person_slim_rework((e1_lname1=trim_lastname) 
													                              OR 
																						(phoneticsOn AND (metaphonelib.DMetaPhone1(e1_lname1)[1..6] = 
															                       metaphonelib.DMetaPhone1(trim_lastname)[1..6]))), 
													    recs_person_slim_rework);
		
		// filter out first names
		recs_person_slim_fname := if (trim_firstname <> '', 
		                              recs_person_slim(e1_fname1=trim_firstname OR 
		                                ((nicknamesON AND NID.mod_PFirstTools.PFLeqPFR(trim(e1_fname1,left,right), trim_firstname)))),
																								        recs_person_slim);
   
		// filter out middle name
   recs_person_slim_mname := if (trim_middlename <> '' , 
	                                 recs_person_slim_fname((e1_mname1=trim_middlename AND strictMatchOn)
																	             OR (e1_mname1[1]=trim_middlename[1] AND (~(strictMatchOn)))
	                                             OR (v2_mname1=trim_middlename
	                                                   AND e1_mname1[1]=trim_middlename[1]
																										 AND (~(strictMatchOn))))
	                                   , recs_person_slim_fname);		
		
		// now get the other parties from each particular case and filter based on search criteria		
   function_recs := join(recs_person_slim_mname, civil_court.key_caseID,
	                          keyed(left.case_key = right.case_key) and
																	(~ut.IndustryClass.is_Knowx OR right.vendor not in D2c.Constants.CivilCourtRestrictedSources),
														 transform(civilCourt_Services.Layouts.PartyLayoutPlus,
														     self:=right), limit(iesp.constants.MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS, skip));
																 
   // name_filter := if (((in_mod.firstname <> '' OR in_mod.middlename <> '' OR in_mod.lastname <> '') AND in_mod.companyName = ''),
	                     // function_recs((e1_cname1  <> '' AND case_title = ''), function_recs);
											 
   // grab all the recs that do have a case_title											 
	 case_title_filter := function_recs(case_title <> '');
	 
	 // need to filter on any cases that do not have input in the case title and then look through
	 // that set and output just recs that have input criteria in the party name 
	  case_title_filter_slim_nocontain_fnamelname :=  if (trim_firstname <> '' AND trim_lastname <> '', 
	                                                case_title_filter(~((StringLib.StringFind(case_title, trim_firstname,1) > 0) AND
																									                    (StringLib.StringFind(case_title, trim_lastname, 1) > 0) 						
																																			 )),
																																			case_title_filter);
    // first filter the recs that DO NOT have input criteria in the title to see which ones to keep		use this attr later.																																
    case_title_filter_slim_nocontain_tmp := if (trim_firstname <> '' AND trim_lastname <> '', 
		      case_title_filter_slim_nocontain_fnamelname(((StringLib.StringFind(entity_1, trim_firstname, 1) > 0) AND
																											 (StringLib.StringFind(entity_1, trim_lastname, 1) > 0)) 
																												  OR
																											((nicknamesOn) AND 
																											 (stringLib.StringFind(entity_1, NID.PreferredFirstNew(trim_firstname),1) > 0 or 
																											  stringLib.StringFind(entity_1, NID.PreferredFirstNew(trim_firstname, false),1) > 0) AND
																											 (StringLib.StringFind(entity_1, trim_lastname, 1) > 0))
																													OR 
																													(PhoneticsOn AND
																													(StringLib.StringFind(entity_1, metaphonelib.DMetaPhone1(trim_lastname)[1..6],1) > 0) AND
																													(StringLib.StringFind(entity_1, trim_firstname, 1) > 0))
																												)
                                                        ,case_title_filter_slim_nocontain_fnamelname);
																																 
    // now get list of recs that do have fname/lname criteria in title 
		// and if its in title thus need to keep all parties (i.e. recs) for this particular case_id
		case_title_filter_slim_contain_fnamelastname  := if (trim_firstname <> '' AND trim_lastname <> '',
		                          case_title_filter(((StringLib.StringFind(case_title, trim_firstname, 1) > 0) AND
																								 (StringLib.StringFind(case_title, trim_lastname, 1) > 0)) 
																									  OR
																								 ((nicknamesOn) AND 
																									(stringLib.StringFind(case_title, NID.PreferredFirstNew(trim_firstname),1) > 0 or 
																									 stringLib.StringFind(case_title, NID.PreferredFirstNew(trim_firstname, false),1) > 0) AND
																									(StringLib.StringFind(case_title, trim_lastname, 1) > 0))
																										OR
																									(phoneticsOn AND (stringLib.StringFind(case_title, metaphonelib.DMetaPhone1(trim_lastname)[1..6],1) > 0) AND
																									(StringLib.StringFind(case_title, trim_firstname, 1) > 0))
																							   )
																								 ,case_title_filter);
    // now add recs without input crit in title +
		// recs that have input crit in title otherwise just use recs with some kind of title.
    case_title_filter_slim := if (trim_firstname <> '' AND trim_lastname <> '', 
		                               case_title_filter_slim_nocontain_tmp + case_title_filter_slim_contain_fnamelastname,
																	    case_title_filter);     		 
   																										
	 case_title_company_entity1_filter := if (strictMatchOn,
	                                       function_recs(StringLib.StringFind(ut.CleanCompany(e1_cname1), 
																				                              ut.cleanCompany(trim_companyName), 1) > 0),   
	                                       function_recs(StringLib.StringFind(entity_1, trim_companyName, 1) > 0)
																				 );
   // check for strict match and filter on company name if its on
	 // otherwise filter on case title
	 case_title_company_filter := if (strictMatchOn,
	                                          function_recs(StringLib.StringFind(e1_cname1,ut.cleanCompany(trim_companyName),1) > 0),
	                                          function_recs(StringLib.StringFind(case_title, trim_companyName, 1) > 0)
																		);
	 
	 // get the recs that do NOT have a case title and then futher filter on these.
	 case_title_blank_filter := function_recs(case_title = '');
	 
	 case_title_blank_filter_slim_firstname :=  if (trim_firstname <> '', 
	                                                case_title_blank_filter(( e1_fname1=trim_firstname) OR
																					        (nicknamesON AND (NID.mod_PFirstTools.PFLeqPFR(e1_fname1,trim_firstname)))),
	                                                case_title_blank_filter);
																									
	 case_title_blank_filter_slim_middlename := if (trim_middlename <> '', 
	                                  case_title_blank_filter_slim_firstname(
																		                                        (e1_mname1=trim_middlename 
																		                                           AND strictMatchOn )
																																						OR
																																						(e1_mname1[1]=trim_middlename[1] 
																																						   AND ~(strictMatchOn))
																																						)  
																		 , case_title_blank_filter_slim_firstname);
   case_title_blank_filter_slim_lastname := if (trim_lastname <> '', 
	                                          case_title_blank_filter_slim_middlename((e1_lname1=trim_lastname) OR
																						      (phoneticsOn AND (metaphonelib.DMetaPhone1(e1_lname1)[1..6] = 
																															metaphonelib.DMetaPhone1(trim_lastname)[1..6])))
																						, case_title_blank_filter_slim_middlename);
																													
   // case where there is company criteria in the search
	 // get recs that have no case title but do have company name in the record and it matches input criteria
	 // also check for strict match
   case_title_blank_filter_slim_companyname := 
	          if (trim_companyname <> '',  
						         if (StrictMatchOn, 
										   case_title_blank_filter(ut.CleanCompany(e1_cname1)=ut.CleanCompany(trim_companyName)),
											 case_title_blank_filter(e1_cname1=trim_companyName))
	                                ,case_title_blank_filter);
	 // 
   // 1st check for name criteria matching and then company criteria matching
	 //
	 // NOTE: doesn't ever return case of just case_title_filter as there 
	 //       will always be some kind of name search or company search
   // NOTE1: temp_function_set still could be just same as case_title_filter_slim 
	 //        cause case_title_filter_slim	might be same as case_title_filter
   temp_function_set := if ((trim_firstname <> '' OR trim_middlename <> '' OR trim_lastname <> ''),
	                         case_title_filter_slim + case_title_blank_filter_slim_lastname,
												if (trim_companyname <> '', 
														case_title_company_entity1_filter + case_title_company_filter + 
														case_title_blank_filter_slim_companyname, 
													  case_title_filter_slim));
 
   //make this a dummy value so that if not both state/city input it doesn't impact result set.
   zip_match := if (trim_state <> '' AND trim_city <> '',
	                     zipLib.CityToZip5(trim_state, trim_city), 'AAAAA');
                                                        
	 temp_function_slim_state := if (trim_state <> '', 
	                            temp_function_set(StringLib.StringToUpperCase(state_origin) = trim_state OR StringLib.StringToUpperCase(st1) = trim_state), 
	                           temp_function_set);
														 
   
   temp_function_slim_city := if (trim_city <> '', 
	                               temp_function_slim_state(StringLib.StringToUpperCase(v_city_name1) = trim_city OR zip1 = zip_match),
	                               temp_function_slim_state);
    
   
	 temp_function_jurisdiction_slim  := if (trim_jurisdiction <> '', 
	                                    temp_function_slim_city((Stringlib.StringFind(StringLib.StringToUpperCase(court), trim_jurisdiction,1) > 0)),
																			temp_function_slim_city);	
    		 
   temp_function_slim_dedup := dedup(sort(temp_function_jurisdiction_slim, 
	         e1_lname1, e1_fname1, state_origin, 
					 case_key, 
					 case_type, entity_type_description_1_orig, entity_1), 
	         e1_lname1, e1_fname1, state_origin, 
					 case_key, 
					 case_type, entity_type_description_1_orig, entity_1); 
		// Format for output
				
		added_in_mod := project(in_mod, functions.params);

		
	  recs_fmt := civilCourt_Services.Functions.fnCivilCourtSearchval(temp_function_slim_dedup, added_in_mod);	
		recs_final := project(choosen(recs_fmt,iesp.constants.MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS),
		                  iesp.civilcourt.t_CivilCourtSearchRecord);											
		//output(recs_fmt,named('recs_fmt'));
		// output(recs,named('SSR_recs'));
		// output(recs_person_slim_mname,named('SSR_recs_person_slim_mname'));
		
		////
		// output(recs,named('recs'));
		// output(recs_company_slim_rework,named('recs_company_slim_rework'));
		 // output(recs_slim, named('recs_slim'));
		// output(recs_person_slim, named('recs_person_slim'));
		// output(recs_person_slim_rework, named('recs_person_slim_rework'));
		// output(recs_person_slim_fname,named('recs_person_slim_fname'));
		 //output(recs_person_slim_mname,named('recs_person_slim_mname'));
		 // output(function_recs,named('function_recs'));
		 // output(temp_function_set,named('temp_function_set'));
		
		// output(case_title_filter,named('case_title_filter'));
		 // output(case_title_filter_slim_nocontain_fnamelname, named('case_title_filter_slim_nocontain_fnamelname'));
		 // output(case_title_filter_slim_nocontain_tmp, named('case_title_filter_slim_nocontain_tmp'));
		 // output(case_title_filter_slim_contain_fnamelastname, named('case_title_filter_slim_contain_fnamelastname'));
		
		// output(case_title_filter_slim,named('case_title_filter_slim'));
		
		 // output(case_title_company_entity1_filter,named('case_title_company_entity1_filter'));
		 // output(case_title_blank_filter_slim_companyname,named('case_title_blank_filter_slim_companyname'));
		// output(case_title_company_filter,named('case_title_company_filter'));
		
		// output(case_title_blank_filter,named('case_title_blank_filter'));
		// output(case_title_blank_filter_slim_lastname ,named('case_title_blank_filter_slim_lastname'));
		 //output(case_title_blank_filter_slim_companyname,named('case_title_blank_filter_slim_companyname'));
		// output(temp_function_slim_state, named('temp_function_slim_state'));
		// output(temp_function_slim_city, named('temp_function_slim_city'));
		
		// output(temp_function_slim_city,named('temp_function_slim_city'));
		// output(temp_function_jurisdiction_slim,named('temp_function_jurisdiction_slim'));
		//output(temp_function_slim_dedup, named('temp_function_slim_dedup'));
		//output(in_mod.state_in,named('inmodstatein'));
		//output(trim_state,named('trim_state'));
		
		// output(temp_function_slim_dedup, named('temp_function_slim_dedup'));
	    /////
		// output(case_title_filter_slim_lastname,named('case_title_filter_slim_lastname'));
		// output(case_title_filter_slim_firstname,named('case_title_filter_slim_firstname'));
		// output(case_title_filter_slim_middlename,named('case_title_filter_slim_middlename'));
		//output(function_recs_slim,named('function_recs_slim'));
		//output(name_filter,named('SSR_name_filter'));
		//output(nicknames,named('nicknames'));
		// output(fullName.fname);
		// output(fullName.mname);
		// output(fullName.lname);
		// output(fullName);
		// output(unparsedFullNameFilled);
		 // output(trim_jurisdiction,named('trim_jurisdiction'));
		 // output(trim_companyname,named('trim_companyname'));
		
		return recs_final;
		end;
end;