import ut, Census_Data, codes, CourtSearch_services, iesp, doxie,
          Doxie_Raw, autostandardI, deathv2_services, header, courtSearch, ut, Risk_Indicators, suppress, lib_date;
					
export Functions := module

		export params := interface(
			AutoStandardI.InterfaceTranslator.ssn_mask_value.params
		)

		end;
		
	// General flow is read in header recs and use the persons address and the state 
	// of residence to join and populate the output structures for district (federal), 
	// state and county search information.  This information about pricing and amount of \
	// days to return the search is stored in the key information.  Fairly straightforward
	// projects and joins and transforms to populate the output structures
	// several places had to use combinations of temporary layouts as information
	// to populate final structure was obtained from multiple keys
	//
				
	export fnCourtSearchSearchVal( dataset(courtsearch_services.layouts.layout_header_extra)   recs_in,
																
																 params in_mod,
																 dataset(iesp.CourtSearchAdviser.t_courtSearchCompany) CompanyNameSet
																 ) := function

		  /////////////////////////////////////////////////////////																				 
			///// iesp.courtSearchAdviser.t_CourtSearchAddress    ///
			/////////////////////////////////////////////////////////
			

		 
      countySearch_courtSearchAddresses_tmp := join(recs_in, Census_Data.Key_Fips2County,
			                                     keyed(left.st = right.state_code) and
																					 keyed(left.county = right.county_fips), 
																					 transform( courtSearch_services.layouts.headerLayoutPlusCourtSearch,
																					 self.st     := left.st,
																					 self.county := left.county,
																					 self.CoName := right.County_name,
																					 self        := left,
																					 self        := []), LEFT OUTER, keep(1));
   
	    countySearch_courtSearchAddresses := join(countySearch_courtSearchAddresses_tmp, courtSearch.key_st,
		                                    keyed(left.st = right.st) and
																				keyed(left.county = right.jurisdiction),																			
																	transform (courtSearch_services.layouts.headerLayoutPlusCourtSearch,																	  
                                       self.Cocode               := left.st,
																			 self.CoDescription        := right.searchDescription,
																			 self.CoSummaryDescription := right.SearchDescription,
																			 self.Coprice              := (real) right.misc,
																			 self.CoCompleteDays       := right.turnaround,																																				                         																			 
																			 self.CoFipsCode           := left.st,
																			 self.CoSurcharge          :=   (real) right.price,
																			 self := left,
																			 self := []),LEFT OUTER, KEEP(1));
																   
						
																
      stateSearch_courtSearchAddresses := join(countySearch_courtSearchAddresses, courtSearch.key_st,
			                                keyed(left.st = right.st) and
																		  right.jurisdiction = courtSearch_services.constants.CS_STATE, 
																	  transform( courtSearch_services.layouts.headerLayoutPlusCourtSearch,
																			self.Stcode                := right.searchCode,
																			self.stDescription         := right.searchDescription,
																			self.stSummaryDescription  := right.summaryDescription,
																			self.stprice               := (real) CourtSearch_services.constants.StateBasePrice,
																			self.stsurcharge             := (real) right.price,
																			self.stCompleteDays        := right.turnaround,
																			self.stFipscode            := left.st + right.jurisdiction,																			
																			 self.DiCode 							 := '',																			
																			 self.DiName               := '',
																			 self.DiFipsCode           := '',																		
																			 self := left,
																			), LEFT OUTER, KEEP(1));
																			
     districtSearch_courtSearchAddresses := join(stateSearch_courtSearchAddresses, courtSearch.key_dist_st,
		                                             keyed(left.st = right.st) AND
																								 keyed(left.county = right.fips_county),
																								 transform( courtSearch_services.layouts.headerLayoutPlusCourtSearch,   
																								 self.DiCode          := right.district_code,																								 
																								 self.DiName          := right.district_name,
																								 self.DiFipsCode      := left.st + right.county_code,																							
																								 self.stFipscode      := left.st + right.county_code,
																								 self.CoCode          := left.st + right.county_code,
																								 self.CoFipsCode      := left.st +  right.county_code,
																								 self                 := left,
																								 ), left outer, keep(1), limit(iesp.constants.CtSearchAdviser.maxStates, skip));
																								 
    
     districtSearch_CourtSearchAddresses_dedup := dedup(sort(districtSearch_courtSearchAddresses,
		                                              st, city_name, prim_name, prim_range, suffix,predir, -dt_last_seen),
																									st, city_name, prim_name, prim_range, suffix,predir);
     districtSearch_CourtSearchAddresses_dedup_filter
		                                           := districtSearch_CourtSearchAddresses_dedup(zip<> '');
		                                                        																								 
		  iesp.courtSearchAdviser.t_CourtSearchAddress  
			    xform_t_CourtSearchAddress(			                           
						 courtSearch_services.layouts.headerLayoutPlusCourtSearch l
						 ) := transform
			self.Address.StreetName     := l.prim_name,
			self.Address.StreetNumber   := l.prim_range,
			self.Address.StreetPreDirection  := l.predir,
			self.Address.StreetPostDirection := l.postdir,
			self.Address.StreetSuffix    := l.suffix,
			self.Address.UnitDesignation := l.unit_desig,
			self.Address.UnitNumber     := l.sec_range,
			self.Address.StreetAddress1 := '',
			self.Address.StreetAddress2 := '',
			self.Address.city           := l.city_name,
			self.Address.state          := l.st,
			self.Address.zip5           := l.zip,
			 self.Address.zip4          := l.zip4,
			 self.Address.County        := '',
			 self.Address.PostalCode    := '',
			 self.Address.StateCityZip  := '',
			 self.Verified           := false, 
			 self.stateName          := l.st,
			 self.DateFirstSeen.Year := (integer4)((STRING)l.dt_first_seen)[1..4];
			 self.DateFirstSeen.Month:= (integer2)((STRING)l.dt_first_seen)[5..6];
			 self.DateFirstSeen.Day  := 0;
			 self.DateLastSeen.Year  := (integer4)((STRING)l.dt_last_seen)[1..4];
			 self.DateLastSeen.Month := (integer2)((STRING)l.dt_last_seen)[5..6];
			 self.DatelastSeen.Day   := 0;
			    			 
			 self.StateSearch.Code  := l.StCode,
			 self.StateSearch.Description         := l.StDescription, 
			 self.StateSearch.Summarydescription  := l.stSummaryDescription, 
			 self.StateSearch.Price        := l.stPrice, 
			 self.stateSearch.Surcharge    := l.stSurcharge,
			 self.StateSearch.CompleteDays := l.stCompleteDays,
			 self.StateSearch.FipsCode     :=  l.stFipsCode,			 			 
       self.CountySearch.Code        := l.Cocode, //'county search misc', //CountySearch_in.Code,
					// For county searches, the <miscellaneous> tag will contain
					// "NOT AVAILABLE", "STATEWIDE ONLY" or a price in the form N.NN.  If a price is present, it represents the surcharge to be applied to civil court searches. 
					// In this case, the criminal surcharge will be contained in the <surcharge> tag.			
			 self.CountySearch.Description        := l.CoDescription,  
			 self.CountySearch.SummaryDescription := l.CoDescription, 
			 self.CountySearch.Price        :=  l.Coprice, 
			 self.CountySearch.CompleteDays := l.CoCompleteDays, 
			                            
			 self.CountySearch.Name         := l.CoName, 
			 self.CountySearch.FipsCode     := l.CoFipsCode,     
			 self.CountySearch.surcharge    := l.CoSurcharge, 
			 			 
			 self.DistrictSearch.Code       := l.DiCode,
			
			 self.DistrictSearch.Name       := l.DiName,
			 self.DistrictSearch.FipsCode   := l.DiFipsCode,
			end;
																																						
       CourtSearchAddresses_unsorted := project(districtSearch_CourtSearchAddresses_dedup_filter,xform_t_courtSearchAddress(left));
       CourtSearchAddresses := sort(courtSearchAddresses_unsorted,-DateLastSeen.Year, -DateLastSeen.Month);						
																					 																				 																	 																
       DistrictData := join(choosen(recs_in,1), courtSearch.key_jurisdiction,
				                  keyed(right.jurisdiction = courtSearch_services.constants.CS_FEDERAL) 												
													, transform(
														iesp.courtSearchAdviser.t_courtSearchDistrict,
														 self.Code        := right.searchcode;
														 self._type       := right.misc,
														 self.description := right.searchDescription,
														 self.summaryDescription := right.summaryDescription,
														 self.price              := (real) right.price,
														 self.Surcharge          := (real) right.misc,
														 self.civilSurcharge     := (real) right.misc,
														 self.CompleteDays       := right.turnaround
														 ), limit(iesp.constants.CtSearchAdviser.MaxDistricts , skip));
														 												 																					
        iesp.CourtSearchAdviser.t_addressItem xform_addressSearchCounty
				                           (courtsearch_services.layouts.layout_header_extra l)				                        
																    := transform																					
																		self.Address.StreetName     := l.prim_name,
																		self.Address.StreetNumber   := l.prim_range,
																		self.Address.StreetPreDirection := l.predir,
																		self.Address.StreetPostDirection := l.postdir,
																		self.Address.StreetSuffix    := l.suffix,
																		self.Address.UnitDesignation := l.unit_desig,
																		self.Address.UnitNumber      := l.sec_range,
																		self.Address.StreetAddress1  := '',
																		self.Address.StreetAddress2  := '',
																		self.Address.city         := l.city_name,
																		self.Address.state        := l.st,
																		self.Address.zip5         := l.zip,
																		self.Address.zip4         := l.zip4,
																		self.Address.County       := '',
																		self.Address.PostalCode   := '',
																		self.Address.StateCityZip := '',
																		self.Verified             := false;
																		self.StateName            := l.st;
																		self.DateFirstSeen.Year   := (integer4) l.dt_first_seen[1..4];
																		self.DateFirstSeen.Month  := (integer2) l.dt_first_seen[5..6];
																		self.DateFirstSeen.Day    := 0;
																		self.DateLastSeen.Year    := (integer4) l.dt_last_seen[1..4];
																		self.DateLastSeen.Month   := (integer2) l.dt_last_seen[5..6];
																		self.DatelastSeen.Day     := 0;
																								
																			end;
																					
       AddressItem_SearchCounty := project(recs_in,
				                                     xform_addressSearchCounty(left));			
 				 																	 
        CountyData := join(choosen(recs_in,1), courtSearch.key_jurisdiction,
												  keyed(right.jurisdiction= courtSearch_services.constants.CS_COUNTY), transform(													
														courtSearch_services.layouts.t_CourtSearchCountyExtra,
													   	self.code               := right.SearchCode,
														  self._type              := right.misc, 
														  self.description        := right.SearchDescription,
														  self.SummaryDescription := right.SearchDescription,
														  self.Price          := (real) right.price,
														  self.Surcharge      := (real) right.misc,
														  self.CivilSurcharge := (real) right.misc,
														  self.CompleteDays   := right.turnaround, 
															self.jurisdiction   := left.county, // needed for later then dropped
															self.st             := left.st), // needed for later and then dropped
															limit(iesp.constants.CtSearchAdviser.MaxCounties, skip));
																																																																							
        iesp.CourtSearchAdviser.t_addressItem xform_addressCounty(
				                   courtsearch_services.layouts.layout_header_extra l				                  
													) := transform																					
															self.Address.StreetName          := l.prim_name,
															self.Address.StreetNumber        := l.prim_range,
															self.Address.StreetPreDirection  := l.predir,
															self.Address.StreetPostDirection := l.postdir,
															self.Address.StreetSuffix        := l.suffix,
															self.Address.UnitDesignation     := l.unit_desig,
															self.Address.UnitNumber          := l.sec_range,
															self.Address.StreetAddress1      := '',
															self.Address.StreetAddress2      := '',
															self.Address.city         := l.city_name,
															self.Address.state        := l.st,
															self.Address.zip5         := l.zip,
															self.Address.zip4         := l.zip4,
															self.Address.County       := '',
															self.Address.PostalCode   := '',
															self.Address.StateCityZip := '',
															self.Verified             := false;
															self.StateName            := l.st,
															self.DateFirstSeen.Year   := (integer4) l.dt_first_seen[1..4];
															self.DateFirstSeen.Month  := (integer2) l.dt_first_seen[5..6];
															self.DateFirstSeen.Day    := 0;
															self.DateLastSeen.Year    := (integer4) l.dt_last_seen[1..4];
															self.DateLastSeen.Month   := (integer2) l.dt_last_seen[5..6];
															self.DateLastSeen.Day     := 0;
										        end;
																					
       AddressItem_County := project(recs_in,xform_addressCounty(left));			
								
				iesp.courtSearchAdviser.t_CourtSearchCounty
				         xform_t_CourtSearchCounty(
								   courtSearch_services.layouts.t_CourtSearchCountyExtra l) := transform
									
						self.Code               := l.Code;
						self._Type              := l._type;
						self.Description        := l.description;
					  self.SummaryDescription := l.summaryDescription;
						self.Price              := l.price;
						self.Surcharge          := l.surcharge;
						self.CivilSurcharge     := l.civilSurcharge;
						self.CompleteDays       := l.completeDays;
				end;
															
        tmp_civil :=  CourtSearch_services.Constants.CS_CIVIL;
				tmp_criminal := CourtSearch_services.Constants.CS_CRIMINAL;
				
        Counties_StateRecs := join(countyData, courtSearch.key_jurisdiction,
				                       keyed(left.jurisdiction = right.jurisdiction AND
																	   left.st = right.st),
																	 transform(iesp.courtSearchAdviser.t_courtSearchCounty,
																			self.Surcharge := if (left._type = tmp_civil, (real) right.misc, 
																			                       if (left._type = tmp_criminal, (real) right.price, (real) '')),
																			                           // IF _type is CIVIL use misc col OTHERWISE 
																																 // use price col.
																			self := left), 
																			left OUTER, keep(1));
																																						
        Counties_StateRecs_dedup := dedup(sort(Counties_stateRecs, code, _type), code, _type);																			
																			
        iesp.CourtSearchAdviser.t_addressItem xform_addressState
				                         (courtsearch_services.layouts.layout_header_extra l):= transform																					
																		self.Address.StreetName          := l.prim_name,
																		self.Address.StreetNumber        := l.prim_range,
																		self.Address.StreetPreDirection  := l.predir,
																		self.Address.StreetPostDirection := l.postdir,
																		self.Address.StreetSuffix        := l.suffix,
																		self.Address.UnitDesignation     := l.unit_desig,
																		self.Address.UnitNumber          := l.sec_range,
																		self.Address.StreetAddress1      := '',
																		self.Address.StreetAddress2      := '',
																		self.Address.city         := l.city_name,
																		self.Address.state        := l.st,
																		self.Address.zip5         := l.zip,
																		self.Address.zip4         := l.zip4,
																		self.Address.County       := '',
																		self.Address.PostalCode   := '',
																		self.Address.StateCityZip := '',
																		self.Verified             := false;
																		self.StateName            := ut.St2Name(l.st),
																		self.DateFirstSeen.Year  := (integer4)((STRING)l.dt_first_seen)[1..4];
																		self.DateFirstSeen.Month := (integer2)((STRING)l.dt_first_seen)[5..6];
																		self.DateFirstSeen.Day   := 0;
																		self.DateLastSeen.Year   := (integer4)((STRING)l.dt_last_seen)[1..4];
																		self.DateLastSeen.Month  := (integer2)((STRING)l.dt_last_seen)[5..6];
																		self.DateLastSeen.Day    := 0;																								
															end;
        
			 recs_in_slim := dedup(sort(recs_in, zip, st, city_name, prim_name, prim_range, predir, postdir,  sec_range, -dt_last_seen),
			                                     zip, st, city_name, prim_name, prim_range, predir, postdir,  sec_range);																		 
																					
       AddressItem_State := project(recs_in_slim,xform_addressState(left));																								
																		 
        StateCounty_Recs_tmp1 := join(recs_in, courtSearch.key_jurisdiction,
				                         keyed(left.st = right.st) AND
																 keyed(left.county = right.jurisdiction),
																   transform (  courtsearch_services.layouts.t_stateCountyExtra,
																	 
										             self.Name         := '', // populated later.
																 self.Code         := '', // populated later,
																 self.Surcharge    := (real) right.price, 
																 self.CompleteDays := right.turnaround, 
																 self.Addresses    := AddressItem_State(Address.state = right.st),					
																 self.st           := left.st,
																 self.county       := left.county															
																 ), LEFT OUTER, keep(1));
    
	 
	 StateCounty_Recs_tmp2 := join (stateCounty_Recs_tmp1, Census_Data.Key_Fips2County,
                           keyed(left.st = right.state_code) and
                           keyed(left.county = right.county_fips), 
													    transform( courtsearch_services.layouts.t_stateCountyExtra,
														self.Name := right.county_name,
														self.Code := right.county_fips; 
														self.st   := left.st,
														self      := left), LEFT OUTER, keep(1));
														
    stateCounty_recs := join(StateCounty_Recs_tmp2, courtSearch.key_dist_st,
		                         keyed(left.st = right.st) AND
														 keyed(left.code = right.fips_county),
														 transform( 
														 courtsearch_services.layouts.t_stateCountyExtra,
														   self.Code := right.county_code,
															 self.st   := left.st,
															 self      := left),
															 limit(iesp.constants.CtSearchAdviser.maxStates, skip));

    stateCounty_recs_dedup := dedup(sort(stateCounty_recs, st, code), st, code);															 
				
				stateDistrict_recs_tmp := join(recs_in, Census_Data.Key_Fips2County,
				                             keyed(left.st = right.state_code) AND
																		 keyed(left.county = right.county_fips),
																		 
																		 transform( courtSearch_services.layouts.t_stateDistrictExtra,
																		 self.Counties := dataset([{right.county_name}], iesp.share.t_StringArrayItem),
																		 self.st       := left.st,
																		 self.county   := left.county,
																		 self          := []
																		 ), LEFT OUTER, keep(1));
				
				StateDistrict_recs := join(stateDistrict_recs_tmp, courtSearch.key_dist_st,
				                         keyed(left.st = right.st) AND
																 keyed(left.county= right.fips_county),				                        
				                         transform( courtSearch_services.layouts.t_stateDistrictExtra,																 
																  self.Name := right.district_name,
																	self.Code := right.district_code, 																	
																	self.st   := left.st,
																	self      := left),
																	 limit(iesp.constants.CtSearchAdviser.MaxDistricts, skip));
																	 
        StateDistrict_recs_dedup := dedup(sort(StateDistrict_recs, st, county), st, county);																	 

				recs_in_dedup_by_st_only := dedup(sort(recs_in, st), st);	 // used to be recs_in_tmp
				
				 
        t_CourtSearchState_searches := join(recs_in_dedup_by_st_only, courtsearch.key_st,
												keyed(left.st = right.st) and
												right.jurisdiction = courtSearch_services.constants.CS_STATE,								
											
										transform(courtSearch_services.layouts.t_searchInfoExExtra,
				
											self._Type              := right.misc,
											self.Code               := right.SearchCode,
											self.Description        := right.SearchDescription,
											self.SummaryDescription := right.summarydescription,
											self.surcharge          := (real) right.price,
											self.Price              := (real) CourtSearch_services.constants.StateBasePrice,
											self.CompleteDays       := right.turnaround,
											self.st                 := right.st
											), KEEP(1)); 
																									 		     			               
		iesp.courtSearchAdviser.t_CourtSearchState xform_t_courtSearchState(		                              
																	courtsearch_services.layouts.layout_header_extra l) := transform
																	self.Name      := ut.St2Name(l.st),				
																	self.Code      := l.st,
																	// need to filter on the particular state address so
																	
																	self.searches  := project (t_CourtSearchState_searches(st= l.st), 
					                                iesp.courtsearchadviser.t_CSSearchInfoEx),																					       
																	Self.Counties  := project (StateCounty_recs_dedup(st=l.st),
					                                 iesp.courtSearchAdviser.t_StateCounty),																					         
																	Self.Districts := project (StateDistrict_recs_dedup(st=l.st),
					                                 iesp.CourtSearchAdviser.t_stateDistrict)
																	end;
															
          searches_staterecs := project(recs_in_dedup_by_st_only, xform_t_courtSearchState(left));																						
				
					iesp.courtSearchAdviser.t_CourtSearchEntry
				                     xform_t_CourtSearchEntry(				
               					
															)  := transform
									self.Districts := DistrictData,
									self.Counties  := Counties_stateRecs_dedup, //CountyData,
									self.States    := searches_StateRecs
					end;
												 
         t_courtSearchEntry_rec  := dataset ([xform_t_CourtSearchEntry ()]);																	 
																	 																	 				
				courtSearch_services.layouts.ssnInfo ssn_info_xform(                   
										courtsearch_services.layouts.layout_header_extra l,
                    Risk_Indicators.Key_SSN_Table_v4_2 r) := transform

							self.SSN             := l.ssn,
							self.IssuedLocation  := ut.St2Name(r.issue_state);
							//Since 2 date fields below are only yyyymm, multiple by 100 to shift left 2 places 
							// then add the appropriate number for the dd part.
							self.IssuedStartDate := (unsigned4) r.official_first_seen*100 + 1,
							self.IssuedEndDate   := (unsigned4) r.official_last_seen*100+31,
      
							end;					
							
							recs_in2 := dedup(sort(recs_in, ssn,lname, fname, mname, st, city_name, prim_name, prim_range),
					                                ssn, lname, fname, mname, st, city_name, prim_name, prim_range);
							recs_in2_sortedbySSN := sort(recs_in2, -dt_last_seen);	
					
							SSNInfo := join(recs_in2_sortedbySSN, Risk_Indicators.Key_SSN_Table_v4_2,
			                         keyed(left.ssn = right.ssn),
			                           ssn_info_xform(left,right),
																 limit(iesp.constants.CtSearchAdviser.MaxAKAs, skip));
																 
          string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(in_mod,
                             AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 
				
				Suppress.MAC_Mask(ssnInfo, ssnInfo_out, ssn, blank, true, false);																 
					
					
					courtSearch_services.layouts.rawRecPlusExtraDeathInfo  xform_rawRecPlusExtraDeathInfo
		                             ( courtsearch_services.layouts.layout_header_extra l,
																   integer4 dob) := transform
               self.IssuedLocation  := ssnInfo_out[1].IssuedLocation,																	
               self.IssuedStartDate := (string8) SSNInfo_out[1].IssuedStartDate,
							 self.IssuedEndDate   := (string8) SSNInfo_out[1].IssuedEndDate,
							 self.ssn := if (ssnInfo_out[1].ssn = '', l.ssn, ssnInfo_out[1].ssn),
							 self.dob :=  dob;
  						 self := l,							
							 self := [];
					end;			
																
					//
					// share.t_Identity
					//

					iesp.share.t_Identity  xform_t_Identity(
							courtSearch_services.layouts.rawRecPlusExtraDeathInfo l,
							deathv2_services.layouts.report_external r
							)
				                          := transform																					
							self.UniqueID := (string) l.did;
							self.Name := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, l.title),
							self.Gender := '';                                  		                     					
							IssuedStart := iesp.ECL2ESP.toDateYM ((unsigned4) l.IssuedStartDate);
							IssuedEnd   := iesp.ECL2ESP.toDateYM ((unsigned4) l.IssuedEndDate);
							Self.SSNInfo := iesp.ECL2ESP.SetSSNInfo (L.ssn, l.valid, l.issuedLocation, IssuedStart, IssuedEnd);
							Self.SSNInfoEx := iesp.ECL2ESP.SetSSNInfoEx (L.ssn, l.valid, l.issuedLocation, IssuedStart, IssuedEnd);
/*
				                           // map(l.valid_ssn = 'O' => 'date-of-birth mismatch',
															      // l.valid_ssn = 'M' => 'manufactured',
														        // l.valid_ssn = 'S' => 'suppressed due to permissions',
															      // l.valid_ssn = 'B' => 'Bad (i.e. someone else’s best)',
																		// l.valid_ssn = 'F' => 'typo (aka fat finger)',
															      // l.valid_ssn = 'G' => 'good (i.e. best)',
																		// l.valid_ssn = 'R' => 'belongs to relative',
																		// l.valid_ssn);
				
*/		
							self.DOB         := iesp.ECL2ESP.toDate ((integer4) l.dob), 
							integer4 tempdod := if ((integer4)l.dod > 0,(integer4)l.dod,(integer4)r.dod8);
							self.DOD         := iesp.ECL2ESP.toDate (tempdod), 
							self.Age         := if (l.dob <> 0, lib_date.GetAge((string) l.dob),0);
							self.AgeAtDeath  := r.dead_age, 
							self.DeathState  := r.st,
							self.DeathCounty := r.county_name,
							self.DeathVerificationCode := '', 
         			self.Deceased := if (r.did != '' , 'Y','N');
							SELF.islimitedaccessdmf := r.islimitedaccessdmf;
  				end;		
									
					did_set_dod := project(recs_in, doxie.layout_references);					
	
			    // not all aka recs have DOB populated thus this extra param add here.
					tmp_AKAs_recs := project(recs_in2_sortedBySSN, xform_rawRecPlusExtraDeathInfo(left, recs_in2_sortedBySSN(dob <> 0)[1].dob));															
					
			courtSearch_services.layouts.rawRecPlusExtraDeathInfo  
				rollAKAs( courtSearch_services.layouts.rawRecPlusExtraDeathInfo  le,
									courtSearch_services.layouts.rawRecPlusExtraDeathInfo  ri
							  ) := transform
		
			     self.ssn  := if (le.did = ri.did AND
					                     ri.ssn = '', le.ssn, ri.ssn);
					 self := ri;
			 end;
			 			 
			 // add in SSN where needed.
			 // input to court search is only a single did so can sort on ssn here safely
			 //			 
			 aka_recs_rolled := iterate(sort(tmp_AKAs_recs, -ssn),
			                            //tmp_AKAs_recs_dedup, 
																	 rollAKAs(LEFT,RIGHT));       															 
        // added sort by -dt_last_seen so that as to keep correct ordering for display.																	 
				aka_recs_rolled_dedup := sort(dedup(sort(aka_recs_rolled,lname, fname, mname), lname, fname, mname), -dt_last_seen);				 
			
		  AKAs_DOD := deathv2_services.raw.get_report.FROM_DIDS(did_set_dod, ssn_mask_value);
			                            			 
			AKAs_recs := join(aka_recs_rolled_dedup,			                  
												akas_DOD, (left.did = (integer)right.did),
			              xform_t_identity(left, right), LEFT OUTER, keep(1));
																			 				 
			 //
			 // T_CourtSearchIndividual
			 //
			 												
		 courtSearch_services.layouts.CourtSearchAdvisorRecordWithPenalty format_rec_out () := transform
			   self.CourtSearch := t_courtSearchEntry_rec[1];
			   self.AKAs := AKAs_recs;
			   self.CourtSearchAddresses := CourtSearchAddresses;
				 self.Companies := CompanyNameSet;
		 end;
		
		final_recs := dataset ([format_rec_out ()]);
			                     		
		  //output(tmp_AKAs_recs,named('tmp_AKAs_recs'));
			//output(AKAs_DOD,named('AKAs_DOD'));
			
			filter := dedup(sort(final_recs,record), record);
		   // output(StateCounty_recs,named('StateCounty_recs'));
			// output(Searches_Staterecs,named('Searches_Staterecs'));
			// output(recs_in, named('recs_in'));
			// output(stateDistrict_recs_tmp, named('stateDistrict_recs_tmp'));
			// output(StateDistrict_recs, named('StateDistrict_recs'));
			//output(StateCounty_recs, named('StateCounty_recs'));
			// output(Searches_Staterecs, named('Searches_Staterecs'));
			//output(AKAs_recs, named('akas_recs'));
			// output(tmp_AKAs_recs, named('tmp_akas_recs'));
			// output(akas_DOD,named('akas_dod'));
			//output(CourtSearchAddresses, named('courtSearchAddresses'));
			//output(StateCounty_Recs,named('StateCounty_Recs'));
			//output(countySearch_courtSearchAddresses,named('countySearch_courtSearchAddresses'));
			// output(stateSearch_courtSearchAddresses,named('stateSearch_courtSearchAddresses'));
			//output(districtSearch_courtSearchAddresses,named('districtSearch_courtSearchAddresses'));
			//output(districtSearch_CourtSearchAddresses_dedup_filter, named('districtSearch_CourtSearchAddresses_dedup_filter'));
			// output(recs_in_tmp,named('recs_in_tmp'));
			// output(recs_in,named('recs_in'));
			//output(DistrictData,named('DistrictData'));
			//output(Searches_Staterecs,named('Searches_Staterecs'));
			// output(districtSearch_courtSearchAddresses, named('districtSearch_courtSearchAddresses'));
			// output(countyData, named('countyData'));
			// output(Counties_StateRecs, named('Counties_StateRecs'));
			// output(Counties_StateRecs_dedup, named('Counties_StateRecs_dedup'));
			// output(t_courtSearchEntry_rec, named('t_courtSearchEntry_rec'));
			// output(recs_in_dedup_by_st_only, named('recs_in_dedup_by_st_only'));
			// output(t_CourtSearchState_searches, named('t_CourtSearchState_searches'));
			// output(CountyData, named('CountyData'));
			// output(Counties_StateRecs, named('Counties_StateRecs'));
			//output(recs_in_tmp, named('recs_in_tmp'));
				// output(recs_in, named('recs_in'));
				//
				 // output(recs_in2, named('recs_in2'));
				 // output(recs_in2_sortedbySSN, named('recs_in2_sortedbySSN'));
		   // output(tmp_AKAs_recs, named('tmp_AKAs_recs'));
			 // output(aka_recs_rolled, named('aka_recs_rolled'));
			 // output(aka_recs_rolled_dedup, named('aka_recs_rolled_dedup'));	
			// output(AKAs_recs, named('AKAs_recs'));
			//
			//output(aka_recs_rolled, named('aka_recs_rolled'));
		
			//// output(CountyData, named('countyData_Counties'));
			// output(Counties_StateRecs, named('Counties_StateRecs_COUNTIES'));
			
		 // output(recs_in_tmp, named('recs_in_tmp'));		
		 // output(recs_in, named('recs_in'));		
		 // output(c_recs_in_tmp, named('c_recs_in_tmp'));
		 // output(c_recs_in, named('c_recs_in'));
		 // output(c_recs_in_slim, named('c_recs_in_slim'));
		 
			// output(countySearch_courtSearchAddresses_tmp, named('countySearch_courtSearchAddresses_tmp'));
			// output(countySearch_courtSearchAddresses, named('countySearch_courtSearchAddresses'));
			// output(stateSearch_courtSearchAddresses, named('stateSearch_courtSearchAddresses'));
			
			// output(districtSearch_courtSearchAddresses_dedup, named('districtSearch_courtSearchAddresses_dedup'));
			// output(aka_recs_rolled_dedup, named('aka_recs_rolled_dedup'));
			// output(aka_recs_rolled, named('aka_recs_rolled'));
			//output(recs_in2, named('recs_in2'));
			// output(tmp_AKAs_recs, named('tmp_AKAs_recs'));
			// output(SSNInfo, named('SSNInfo'));
			// output (stateCounty_Recs_tmp1, named('stateCounty_Recs_tmp1'));
			// output (StateCounty_Recs_tmp2, named('StateCounty_Recs_tmp2'));
						
	    return(filter);         
	end;
end;