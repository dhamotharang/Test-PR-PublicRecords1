IMPORT  Advo,AutoStandardI,iesp,doxie,suppress,ut,LN_PropertyV2,TeaserSearchServices;

EXPORT ReverseAddressTeaserRecords := MODULE

EXPORT params := INTERFACE(
      AutoStandardI.InterfaceTranslator.dob_mask_value.params,
			AutoStandardI.InterfaceTranslator.industry_class_value.params)		
      export string32 applicationType	:= suppress.Constants.ApplicationTypes.Consumer;
			END;

EXPORT val(params in_mod,
           AutoStandardI.DataRestrictionI.params RestrictMod) := FUNCTION
             	
	dob_mask_value       := AutoStandardI.InterfaceTranslator.dob_mask_value.val(PROJECT(in_mod,	               
									          AutoStandardI.InterfaceTranslator.dob_mask_value.params));
								 									   
  industry_class_value := AutoStandardI.InterfaceTranslator.industry_class_val.val(PROJECT(in_mod,                         
													  AutoStandardI.InterfaceTranslator.industry_class_val.params)); 									 
	
	dppa_ok := AutoStandardI.PermissionI_Tools.val(RestrictMod).DPPA.ok(RestrictMod.DPPAPurpose);
  glb_ok :=  AutoStandardI.PermissionI_Tools.val(RestrictMod).GLB.ok(RestrictMod.GLBPurpose);	
	DRM := RestrictMod.DataRestrictionMask;

	// make this call get_dids_HHID call and now everything read via stored from being set
	// in this call:  iesp.ECL2ESP.SetInputAddress
  // from top level service.
  dids := doxie.get_dids(forceLocal := TRUE, noFail := FALSE);
  
	// suppress by did and ssn is done within this call so not needed after this call
	// for header records.
  all_header_recs := doxie.header_records_byDID(dids,
                                                include_dailies := TRUE, 
																								allow_wildcard := FALSE, 
                                                IncludeAllRecords := FALSE, 
																								isrollup:= TRUE);
  
   headerRecs := PROJECT(all_header_recs, TeaserSearchServices.Layouts.ReverseAddress.rec_header);
 
  STRING8 mask_dob (INTEGER4 dob) := FUNCTION
    dob_corrected := MAP (dob < 10000 => dob *10000, // year only
                          dob > 10000 AND dob < 1000000 => dob * 100 ,// year and month
                          dob);
    dob_str := (STRING8) dob_corrected;

	  dob_masked := CASE(dob_mask_value,		             
      suppress.constants.datemask.DAY   =>	dob_str[1..6] + 'XX',
      suppress.constants.datemask.MONTH => dob_str[1..4] + 'XX' + dob_str[7..8],
		  suppress.constants.datemask.YEAR  => 'XXXX' + dob_str[5..8],
		  suppress.constants.datemask.ALL   => 'XXXXXXXX',
      dob_str);
    RETURN dob_masked;
  END;
	
	// grp by address added the DOB <> 0 filter since need to calculate age farther down.
	dsHeaderGrouped := GROUP(SORT(headerRecs(DOB <> 0), penalt, zip,prim_name, prim_range, sec_range, hhid, -dt_last_seen),
	                         zip, prim_name, prim_range, sec_range, hhid, -dt_last_seen);

  // Getting address information from the LEFT and name information from the right.
	// Also getting penalty and rawaid, hhid (household id) and dt_last_seen from left
  TeaserSearchServices.Layouts.ReverseAddress.recRolled 
	          rollit (TeaserSearchServices.Layouts.ReverseAddress.rec_header L,
	                  DATASET (TeaserSearchServices.Layouts.ReverseAddress.rec_header) R) := TRANSFORM    
		SELF.rawaid := L.rawaid;
    SELF.penalt := L.penalt; 
		SELF.dt_last_seen := L.dt_last_seen;
		SELF.HHId := L.HHID;    
    		
		// ok since already grouped by address parts. 
    SELF.addresses := PROJECT (L, TRANSFORM (TeaserSearchServices.Layouts.ReverseAddress.rec_addr, 
		                          SELF.prim_name := LEFT.prim_name,
															SELF.predir := LEFT.predir,
															SELF.prim_range := LEFT.prim_range,
															SELF.addr_suffix := LEFT.suffix,
															SELF.postdir := LEFT.postdir;
															SELF.sec_range := LEFT.sec_range,
															self.v_city_name := LEFT.city_name,
		                          SELF.city_name := LEFT.city_name, 
                              SELF.st := LEFT.st, 
															SELF.zip5 := LEFT.zip;
                              SELF.dt_last_seen := LEFT.dt_last_seen, 															
														  SELF := []));
    
    name_slim := PROJECT (R ((fname != '' OR lname != '') AND (DOB > TeaserSearchServices.Constants.AddressTeaser.StartDOB
		                                                            AND DID <> 0)),
                         TRANSFORM (TeaserSearchServices.Layouts.ReverseAddress.rec_name, 
												           SELF.fname := LEFT.fname, 
																	 SELF.lname := LEFT.lname, 
												           SELF.DOB := mask_dob(LEFT.DOB),																	 
																	 SELF.DID := LEFT.DID;
																	 SELF := []));
    name_ddp := DEDUP (SORT (name_slim, fname, lname, dob,did), fname, lname, dob,did);
		name_ddp_slim := DEDUP(name_ddp, did);
    SELF.names := CHOOSEN (name_ddp_slim, doxie.rollup_limits.names);   
	 SELF := [];
  END;
		
  dsHeaderRolled := ROLLUP (dsHeaderGrouped(dt_last_seen <> 0 AND penalt < 2),
                            GROUP, 
                            Rollit (LEFT, ROWS (LEFT)));
													           
  dsHeaderRolledSorted := SORT(dsHeaderRolled,rawaid,-dt_last_seen); 
	
  dsHeaderRolledSlimGroupByRawAid := GROUP(dsHeaderRolledSorted, rawAid);

  // grp by addresshash and then pick off top 5 of each address	
	// resulting set is still sorted by dt_last_seen descending within each rawAid Grp.
	dsTopAddressHits := TOPN(dsHeaderRolledSlimGroupByRawAid, 
	                         iesp.Constants.ThinReverseAddress.MaxAddresses, rawAid);
	
	// set boolean flag to default for now....
	dsTopAddressHitsWithFlag := PROJECT(dsTopAddressHits, TRANSFORM({RECORDOF(LEFT);BOOLEAN CUR;},
																		SELF.cur := FALSE;
																		SELF := LEFT));
  // run through list and mark 1st one in each address grp as being
	// current since its sorted by -dt_last_seen
	// this iterate is necessary because input maybe 123 main street, columbus, OH as well as
  //                                      123 main street, cincinnati, OH since minimum input is just
	//                                      streetNumber, streetName, and state.
  dsTopAddressHitsFinal := ITERATE(GROUP(dsTopAddressHitsWithFlag, rawaid),
	                                   TRANSFORM(RECORDOF(LEFT),
																		    // as iterate goes through list, the 1st row in each  grouped
																				// dataset will have LEFT = 0 so essentially setting 1st
																				// row in each grp'd set to true
																		    SELF.Cur := LEFT.RAWAID = 0;
																				SELF := RIGHT));	                                     																
    														 
	ds_TmpResidence := PROJECT(dsTopAddressHitsFinal,
	           TRANSFORM(TeaserSearchServices.Layouts.ReverseAddress.personResidenceRawAid,
											 SELF.rawAid := LEFT.rawAid;
											 SELF.cur := LEFT.cur;						          				                     														                       																											
						           SELF.address := PROJECT(LEFT.addresses[1],
																				 TRANSFORM(iesp.share.t_address, 
																				         SELF.StreetPreDirection := LEFT.predir;
																								 SELF.StreetPostDirection := LEFT.postdir;
																				         SELF.StreetNumber := LEFT.prim_range;
																								 SELF.StreetName := LEFT.prim_name;
																								 SELF.StreetSuffix := LEFT.Addr_suffix;
																								 SELF.UnitDesignation := LEFT.unit_desig;
																								 SELF.unitNumber := LEFT.Sec_range;
																								 SELF.city := LEFT.v_city_name;
																								 SELF.state := LEFT.st;
																								 SELF.zip5 := LEFT.zip5;
																								 
																								 SELF := []; 
																								 ));
									
						           Persons := CHOOSEN(PROJECT(LEFT.Names, TRANSFORM(
											                  TeaserSearchServices.Layouts.ReverseAddress.PersonPlus,																																
											                  SELF.Name.first  := LEFT.fname;
																				SELF.Name.Last   := LEFT.Lname;
																				tmpDID        :=  DATASET([{LEFT.DID}], doxie.layout_references);
																									// if we can calculate age do so otherwise return 0														
																				SELF.age         := IF (dob_mask_value = suppress.constants.datemask.NONE,
																				                      ut.Age((UNSIGNED4)(LEFT.dob)),0
																															);											
                                        doxie.mac_best_records(tmpDid, did,tmpDIDOut,dppa_ok,glb_ok,,DRM);	
																				tmpPhone10 := tmpDIDOut[1].Phone;
                                        self.maskedPhone := IF (tmpPhone10 <> '', '(' + tmpphone10[1..3] + ') ' + TeaserSearchServices.Constants.PhoneMaskString,'');
																																	
																				dids_grpd := GROUP(SORT(tmpDID, did), did);
																				rels := doxie.relative_names(dids_grpd,glb_ok, industry_class_value = TeaserSearchServices.Constants.CONSUMER_IND_CLASS);
																				                                             //in_mod.industry_class_value = 'CNSMR');
																				                                             // ^^^^ consumer flag
																				
																				relsSuppressed := PROJECT(rels, TRANSFORM(RECORDOF(LEFT),
																						tmpNames := PROJECT(LEFT.Names, TRANSFORM(LEFT));
																						Suppress.MAC_Suppress(tmpNames,tmpNamesSuppressed,
																								//application_type_value,
																								in_mod.applicationType,Suppress.Constants.LinkTypes.DID,DID);	
																						SELF.Names := PROJECT(TmpNamesSuppressed, TRANSFORM(RECORDOF(LEFT),
												                   SELF := LEFT));
																					SELF := LEFT;
																					));
																				SELF.relatives := CHOOSEN(PROJECT(
																										DEDUP(SORT(PROJECT(relsSuppressed.Names, 
																										         TRANSFORM({unsigned6 did; iesp.share.t_name;},																				                 
																												 SELF.did := LEFT.DID;
																				                 SELF.First := LEFT.fname;
																												 SELF.Last  := LEFT.Lname;
																												 SELF       := [];
																												 )), did, Last, First), did),																												 
																												 TRANSFORM(iesp.share.t_name,
																												        SELF := LEFT,
																																SELF := [];
																																)), iesp.Constants.ThinReverseAddress.MaxRelatives);                                      
                                         																					 
																	SELF := LEFT;
																	SELF := []; // as we don't fill out entire t_name structure
																	)), iesp.Constants.ThinReverseAddress.MaxPreviousResidents);
												 																																							                       
                       SELF.Persons := CHOOSEN(PROJECT(Persons, TRANSFORM(iesp.thinreverseaddressteaser.t_ThinReverseAddressTeaserPerson,
											                     SELF := LEFT)), iesp.Constants.ThinReverseAddress.MaxPreviousResidents);
																					 
                       SELF := [];																					 
											 ));
											 
    dsResidence := Rollup(GROUP(ds_TmpResidence, rawAid), GROUP, TRANSFORM(
		                         iesp.thinreverseaddressteaser.t_ThinReverseAddressTeaserRecord,														 
											  SELF.Address := LEFT.address;																															 													 														 														 
												// this project should only be ever just 1 row set from Iterate above
												SELF.currentResidents := Project(CHOOSEN(ROWS(LEFT),iesp.Constants.ThinReverseAddress.MaxCurrentResidents)(cur), 
														 TRANSFORM(iesp.thinreverseaddressteaser.t_ThinReverseAddressTeaserPersonResidence,																	            
																SELF.Address := iesp.ecl2esp.setAddress('','','','',
																								  '','','',LEFT.address.city,
																									left.address.state,'','','','','','','');																								  
															  SELF := LEFT));
																// this could be multiple rows																								
												SELF.PreviousResidents := Project(CHOOSEN(ROWS(LEFT),iesp.Constants.ThinReverseAddress.MaxPreviousResidents)(NOT(cur)),
														 TRANSFORM(iesp.thinreverseaddressteaser.t_ThinReverseAddressTeaserPersonResidence,
                                SELF.Address := iesp.ecl2esp.setAddress('','','','',
																					         '','','',LEFT.address.city,
																					         left.address.state,'','','','','','','');																																			
																SELF := LEFT
																));
															SELF := [];
                              ));
  // slim before 2 joins to get address metadata.															
  dsResidenceSlim := CHOOSEN(dsResidence,	iesp.Constants.ThinReverseAddress.MaxAddresses);												
															
  dsResidenceRorB := JOIN(dsResidenceSlim, Advo.Key_Addr1,	                            
											KEYED(LEFT.Address.zip5 = RIGHT.zip) AND
										  KEYED(LEFT.Address.streetNumber = RIGHT.prim_range) AND
												KEYED(LEFT.Address.StreetName = RIGHT.prim_name), 
												TRANSFORM(iesp.thinreverseaddressteaser.t_ThinReverseAddressTeaserRecord,
													 BusOrRes := RIGHT.Residential_or_business_ind;
													 SELF.BusinessOrResidential := 
																MAP(busOrRes	= 'A' =>TeaserSearchServices.Constants.AddressTeaser.Residential,
											              busOrRes  = 'B' => TeaserSearchServices.Constants.AddressTeaser.Business,
																		'');																									 
														SELF := LEFT,
														SELF := [];), // fill in yearBuilt field below
												LEFT OUTER, LIMIT(0),KEEP(1));
												
  dsResidenceFinal := PROJECT(dsResidenceRorB, 
	                      TRANSFORM(iesp.thinreverseaddressteaser.t_ThinReverseAddressTeaserRecord,
												 tmpAddr := LEFT.address;	
												 Fids := limit(PROJECT(LN_PropertyV2.key_addr_fid()
											                       (KEYED(prim_name = tmpaddr.StreetName)    AND
											                        KEYED(prim_range = tmpaddr.StreetNumber) AND
																						  KEYED(zip = tmpaddr.zip5)),
																							TRANSFORM(LEFT)),
																	TeaserSearchServices.Constants.AddressTeaser.KeepLimitProperty);
                       
                         fidsSlim := DEDUP(SORT(fids(ln_fares_id <> ''), ln_fares_id), ln_fares_id);																																		
                         yearBuiltList := JOIN(fidsSlim, ln_propertyv2.key_assessor_fid(),
																							LEFT.ln_fares_id = RIGHT.ln_fares_id,
																							TRANSFORM(RIGHT), limit(0), 
																						KEEP(TeaserSearchServices.Constants.AddressTeaser.KeepLimitYearBuilt))(year_built <> '');																																		                       
                         SELF.yearBuilt := yearBuiltList[1].year_built;
												 SELF := LEFT
												  )
												 );
		
	// output(headerRecs, named('headerRecs'));
	// output(dsHeaderGrouped, named('dsHeaderGrouped'));
	// output(dsHeaderRolled, named('dsHeaderRolled'));
	// output(dsHeaderRolledSorted, named('dsHeaderRolledSorted'));

	// output(dsHeaderRolledSlim, named('dsHeaderRolledSlim'));
	// output(dsHeaderRolledSlimGroupByRawAid, named('dsHeaderRolledSlimGroupByRawAid'));	
	// output(dsTopAddressHits, named('dsTopAddressHits'));
	// output(dsTopAddressHitsWithFlag, named('dsTopAddressHitsWithFlag'));
  // output(dsTopAddressHitsFinal, named('dsTopAddressHitsFinal'));
	 // output(ds_TmpResidence, named('ds_TmpResidence'));
	 //output(dsResidence, named('dsResidence'));
  // only return top 5 addresses in list	
	RETURN (CHOOSEN(dsResidenceFinal, iesp.Constants.ThinReverseAddress.MaxAddresses));	
	END;
END;						 