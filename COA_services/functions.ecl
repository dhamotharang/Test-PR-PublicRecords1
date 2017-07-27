import ut, coa_services, iesp, Census_Data, autostandardI, autokeyI, Address;
export Functions := module
  
	export params := interface
	          export string120 unparsedfullname := '';
						export string30 firstname := '';
						export string30 middlename := '';
						export string30 lastname := '';				
						export string10 prim_range := '';
						export string28 prim_name := '';
						export string25 city := '';
						export string2 state := '';
						export string6 zip := '';
						export string2 predir := '';
						export string2 postdir := '';
						export string4 suffix := '';
						export string8 sec_range := '';
						export string200 addr := '';
  end;
													 										
	export unsigned1 region := address.Components.Country.US;

	export coaSearchVal(dataset(coa_services.Layouts.rawrec) in_recs, 
										  params in_mod,
	                    boolean populatePossibleAddress,
											unsigned3 inputFirstSeenDate,
											unsigned3 inputLastSeenDate,
											unsigned3 lastSeenDate,
											unsigned3 firstSeenDate
											) 
											:= function
																																											
    // pass in params and values from coa_services.SearchService_Records including
		// in_recs -- set of rec(s) to populate final structure from
		// populate possibleAddress -- boolean that will determine which structures to populate
		// and dates used in final population.

    // pass input params into address cleaner in order to populate input in the final output
		//
    addr1 := Address.Addr1FromComponents(in_mod.prim_range, in_mod.predir, in_mod.prim_name,
		                                     in_mod.suffix, in_mod.postdir, 
																				 '', in_mod.sec_range);
																				 
		addr2 := Address.Addr2FromComponents(in_mod.city, in_mod.state, in_mod.zip);
		
		addr1_final := if (addr1 = '', in_mod.addr, addr1);
		
		// obtain data fields (module) from "results" structure of address cleaner.
		inputData := Address.GetCleanAddress(addr1_final, addr2, region).results;
	
	  // put into dataset in order to pass into project statement.
    inputdatads :=	DATASET([{inputData.prim_name, inputData.prim_range,
                        inputData.predir, inputdata.postdir,
												inputData.suffix, inputdata.unit_desig,
												inputData.sec_range,
												inputData.v_city, inputData.state,
												inputData.zip, inputData.zip4}],							
													coa_services.layouts.coaInputAddrlayout);
			
    // project structure into layout in order	to use as input param in transform		
		inputDatads2 := project(inputdatads , transform 
		             (coa_services.layouts.coaInputAddrLayout,
								 self := left
								 ));
								 
								 
    fullName := Address.CleanNameFields(Address.CleanPerson73(in_mod.unparsedFullName));
		
	  unparsedFullNameNotFilled := if (trim(in_mod.unparsedFullName, left,right) = '', true, false);
	
		trim_firstname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.firstname,left,right)), 
		                                              StringLib.StringToUpperCase(trim(fullName.fname, left, right)));
		trim_lastname := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.lastname,left,right)),
		                                              StringLib.StringToUpperCase(trim(fullName.lname, left, right)));
		                                 
		trim_middlename := if (unparsedFullNameNotFilled, StringLib.StringToUpperCase(trim(in_mod.middlename,left,right)),
		                                               StringLib.StringToUpperCase(trim(fullName.mname, left, right)));								 
		
		// transform to populate set of possible addressses.
		// this is only populated if "new" address is not found
		// based on boolean passed into function.
	  iesp.changeofaddress.t_AddressChange	xformCOAAddress (COA_services.layouts.RawRec l,  
	                                                          inputData r, 
																														string countyName,
																														unsigned3 inputFirstSeenDate,
																														unsigned3 inputLastSeenDate) := TRANSFORM
																														
     self.Name := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, ''),									
		 self.PreviousAddress.Address := if (populatePossibleAddress, iesp.ECL2ESP.setAddress(
																		r.prim_name, r.prim_range, r.predir , r.postdir ,
																		r.suffix, r.unit_desig, r.sec_range, r.v_city,
																		r.state, r.zip, r.zip4, countyName), 
																		iesp.ECL2ESP.setAddress('','','','','','','','','','','','','','','')),
																		  
     self.PreviousAddress.DateFirstSeen.year := if (populatePossibleAddress, 
																											(Integer4) (((String6) (l.inputFirstSeenDate))[1..4]),0),																											
		
     self.PreviousAddress.DateFirstSeen.month := if (populatePossibleAddress, 
		                                                   (Integer4) (((String6) (l.inputFirstSeenDate))[5..6]),0),
																											 
		 self.PreviousAddress.DateFirstSeen.day := 0,
		 self.PreviousAddress.DateLastSeen.year := if (populatePossibleAddress, 
																											(Integer4) (((String6) (l.inputLastSeenDate))[1..4]), 0), 
		 self.PreviousAddress.DateLastSeen.month := if (populatePossibleAddress, 
																											(Integer4) (((String6) (l.inputLastSeenDate))[5..6]), 0),
		 self.PreviousAddress.DateLastSeen.day := 0,
		 self.CurrentAddress.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, 
		                                 l.predir, l.postdir, l.suffix,
			                              l.unit_desig, l.sec_range, l.city_name,
																		l.st, l.zip, l.zip4, l.county_name),
																		    															
		 self.CurrentAddress.DateFirstSeen.year := (Integer4) (((String6) (l.dt_first_seen))[1..4]),	                                               
		 self.CurrentAddress.DateFirstSeen.month := (Integer4) (((String6) (l.dt_first_seen))[5..6]),                                               
		 self.CurrentAddress.DateFirstSeen.day := 0, 
		 self.CurrentAddress.DateLastSeen.year := (Integer4) (((String6) (l.dt_last_seen))[1..4]),	                                             
		 self.CurrentAddress.DateLastSeen.month := (Integer4) (((String6) (l.dt_last_seen))[5..6]),		                                               
		 self.CurrentAddress.DateLastSeen.day := 0,
		 		 
		end;
		
		// transform to populate outermost structure and set the 
		// innermost structure (temp_address_changes)
		// which has already been defined.
		COA_services.Layouts.t_ChangeOfAddressRecord xform 
											( coa_services.layouts.coaInputaddrlayout l,
																						dataset (iesp.changeofaddress.t_AddressChange) temp_address_changes,
																						string countyName,
																						unsigned3 inputFirstSeenDate,
																						unsigned3 inputLastSeenDate) := transform
						self.InputName := iesp.ECL2ESP.setName(
																						trim_firstname, 
																						trim_middlename,
																						trim_lastname,
																						'',
																						'',
																						''
																						),	
																						
						self.InputAddress.Address := iesp.ECL2ESP.setAddress(
																				l.prim_name,l.prim_range,l.predir, l.postdir,
																				l.suffix,'', l.sec_range, l.v_city,
																		      l.state, l.zip,l.zip4,countyName),        
						
						self.InputAddress.DateFirstSeen.year := (Integer4) (((String6) (inputFirstSeenDate))[1..4]),
						
					
						self.InputAddress.DateFirstSeen.month := (Integer4) (((String6) (inputFirstSeenDate))[5..6]),
						
						self.InputAddress.DateFirstSeen.day := 0,
						
						self.InputAddress.DateLastSeen.year := (Integer4) (((String6) (inputLastSeenDate))[1..4]),
						self.InputAddress.DateLastSeen.month := (Integer4) (((String6) (inputLastSeenDate))[5..6]),
					  self.InputAddress.DateLastSeen.day := 0,
						self.AddressChanges := temp_address_changes;
			end;
				
		// get county name and use it to echo input data in the output.
		county_name := Census_data.Key_Fips2County(keyed(in_mod.state = state_code AND
                                              inputData.county[3..5] = county_fips))[1].county_name;
		
		// first populate the innermost structure
		temp_address_changes := project(in_recs, xformCOAAddress(left, 
																				inputdata, 
																				county_name, 
																				inputFirstSeenDate,
																				inputLastSeenDate));	

     // now populate the outermost structure.
		 final_structure:= project (inputdatads2, xform(left,  
		 temp_address_changes, 
		 county_name,
		 inputFirstSeenDate,
		 inputLastSeenDate));
																								
			// sort and dedup on temp_filter.
		
			filter := dedup(sort(final_structure,record), record);		
			
			// output(in_recs,named('functions_in_recs'));
		 // output(inputFirstSeenDate,named('functions_inputFirstSeenDate'));
			// output(inputLastSeenDate,named('functions_inputLastSeenDate'));
			
			//output(inputdatads,named('inputdatads'));
			//output(inputdata,named('inputdata'));									 
	    return(filter);         
	end;
	
end;

