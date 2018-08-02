import AutoStandardI,doxie,SexOffender,Suppress,iesp,ut,AID_Build,
			 FCRA, BatchServices, FFD, Std, Address;

export Raw := module
	export byDIDs(dataset(SexOffender_Services.layouts.search_did) in_dids,
								boolean isFCRA = false) := function 
			deduped := dedup(sort(in_dids,did),did);
			joinup := join(deduped,SexOffender.Key_SexOffender_DID (isFCRA),
			               keyed(left.did=right.did),
								  transform(SexOffender_Services.layouts.search,
				                      self := left,
								  self := right),
								  LIMIT(SexOffender_Services.Constants.MAX_RECS_PERDID,skip)); 
			return joinup;
	end;

	export getDIDsbySPK(dataset(SexOffender_Services.layouts.search) in_spks,
											boolean isFCRA = false) := function 
			deduped := dedup(sort(in_spks,seisint_primary_key),seisint_primary_key);
			joinup := join(deduped,SexOffender.Key_SexOffender_SPK (isFCRA),
			               keyed(left.seisint_primary_key=right.sspk),
										 transform(SexOffender_Services.layouts.search_did,
												 self := right),
												 LIMIT(SexOffender_Services.Constants.MAX_RECS_PERSSPK,skip)); 
			return joinup;
	end;
	
	export GetRawOffenders(dataset(SexOffender_Services.layouts.search) in_spks, 
												 string32 ApplicationType = '',
												 boolean isFCRA = false,
												 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
												 dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
												 integer8 inFFDOptionsMask = 0) := function 
												 
			boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

			ds_flags := flagfile(file_id = FCRA.FILE_ID.SO_MAIN);
			so_correct_rec_id := set(ds_flags, record_id);
			so_key := SexOffender.key_SexOffender_SPK(isFCRA);
			
			deduped := dedup(sort(in_spks,seisint_primary_key),seisint_primary_key);
			 
			recs1 := join(deduped,so_key,
			               keyed(left.seisint_primary_key=right.sspk)
										 and (~isFCRA or (string)right.offender_persistent_id NOT IN so_correct_rec_id),
										 transform(SexOffender_Services.Layouts.raw_rec,
												 self := left,
												 self := right,
												 self.bestaddress := [], self.bestlocation := []),
												 LIMIT(SexOffender_Services.Constants.MAX_RECS_PERSSPK,skip));
			
			//overrides
			recs_over := join(ds_flags, FCRA.key_override_sexoffender.so_main,
												keyed(left.flag_file_id = right.flag_file_id),
												transform(SexOffender_Services.Layouts.raw_rec,self := right, self.bestaddress := [], self.bestlocation := []),
												limit(0), keep(1));
			recs_override_final := join(recs_over, in_spks,
																	left.seisint_primary_key = right.seisint_primary_key,
																	transform(SexOffender_Services.Layouts.raw_rec, self.acctno := right.acctno, self := left), limit(0), keep(1)); //we only want to keep the overrides that were in the original search records
			
			recs_fcra := (recs1 + recs_override_final) (FCRA.crim_is_ok((string8)Std.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
			
			//*****************FFD***************************************************************************************************
			SexOffender_Services.Layouts.raw_rec xformStatements( SexOffender_Services.Layouts.raw_rec l, 
																																FFD.Layouts.PersonContextBatchSlim r ) := transform,
			skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
					self.StatementIDs := r.StatementIds;
					self.IsDisputed   := r.isDisputed;
					self := l;
			end;
			
			recs_fcra_ds := join(recs_fcra,slim_pc_recs,
															 left.offender_persistent_id = (unsigned8)right.RecID1 and
															 ((left.acctno  =  right.acctno) OR 
														    (right.acctno = FFD.Constants.SingleSearchAcctno))and 
												         right.DataGroup = FFD.Constants.DataGroups.SO_MAIN,
															 xformStatements(left,right), 
															 left outer,
															 keep(1),
															 limit(0));
			
			recs := if(isFCRA, recs_fcra_ds, recs1);
			
			doxie.MAC_Filter_SexOffender(ApplicationType, recs, recs_final);		
			

			return recs_final;
	end;
	
	export GetRawOffenses(dataset(SexOffender_Services.Layouts.search) in_spks, 
												boolean isFCRA = false,
												dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
												dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
												integer8 inFFDOptionsMask = 0) := function 
												
			boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(inFFDOptionsMask);
			boolean showDisputedRecords := FFD.FFDMask.isShowDisputed(inFFDOptionsMask);

			ds_flags := flagfile(file_id = FCRA.FILE_ID.SO_OFFENSES);
			so_correct_rec_id := set(ds_flags, record_id);
			offenses_key := SexOffender.Key_SexOffender_offenses(isFCRA);
						
			recs1 := join(in_spks,offenses_key,
			               keyed(left.seisint_primary_key=right.sspk)
										 and (~isFCRA or (string)right.offense_persistent_id NOT IN so_correct_rec_id),
										 transform(SexOffender_Services.Layouts.rec_offense_raw, self.acctno := left.acctno, self := right),
												 LEFT OUTER, LIMIT(SexOffender_Services.Constants.MAX_OFFENSES_PERSSPK,skip));
												 							 
			//overrides
			recs_over := join(ds_flags, FCRA.key_override_sexoffender.so_offenses,
												keyed(left.flag_file_id = right.flag_file_id),
												transform(sexOffender_Services.Layouts.rec_offense_raw, //offense key layout
																	self := right),
												limit(0), keep(1));
			recs_override_final := join(recs_over, in_spks,
																	left.seisint_primary_key = right.seisint_primary_key,
																	transform(sexOffender_Services.Layouts.rec_offense_raw, self.acctno := right.acctno, self := left), limit(0), keep(1)); //we only want to keep the overrides that were in the original search records

			recs_fcra := (recs1 + recs_override_final) (FCRA.crim_is_ok((string8)Std.Date.Today(), fcra_date, fcra_conviction_flag, fcra_traffic_flag));
			
			//***************************************FFD****************************************************
			SexOffender_Services.Layouts.rec_offense_raw xformStatements( SexOffender_Services.Layouts.rec_offense_raw l, 
																																FFD.Layouts.PersonContextBatchSlim r ) := transform,
			skip((~ShowDisputedRecords and r.isDisputed) or (~ShowConsumerStatements and exists(r.StatementIDs)))
					self.StatementIDs := r.StatementIds;
					self.IsDisputed   := r.isDisputed;
					self := l;
			end;
			
			recs_fcra_ds := join(recs_fcra, slim_pc_recs,
			                        left.offense_persistent_id = (unsigned8)right.RecID1 and
															((left.acctno  =  right.acctno) OR 
														   (right.acctno = FFD.Constants.SingleSearchAcctno)) and
												       right.DataGroup = FFD.Constants.DataGroups.SO_OFFENSES,
															 xformStatements(left,right), 
															 left outer,
															 keep(1),
															 limit(0));
			
			
			recs_final := if(isFCRA, recs_fcra_ds, recs1);

			return recs_final;
	end;
	
	shared bestAddressInfo := record
		doxie.layout_best_ext.did;
		doxie.layout_best_ext.RawAID;		
		iesp.sexualoffender.t_OffenderBestAddress bestaddress;
		iesp.share.t_GeoLocationMatch bestlocation;
	end;
	
	export GetBestAddressRec(dataset(SexOffender_Services.Layouts.raw_rec) in_raw, unsigned dppa_purpose = 0, unsigned glb_purpose = 0) := function 
		
			GLB := ut.PermissionTools.glb.ok(glb_purpose);
			DPPA := ut.PermissionTools.dppa.ok(dppa_purpose);
			in_dids := dedup(sort(project(in_raw, doxie.layout_references), did), did);
			doxie.mac_best_records(in_raw, did, best_recs, DPPA, GLB, false, doxie.DataRestriction.fixed_DRM,,,doxie.layout_best_ext);	
			
			bestAddressInfo xform1(SexOffender_Services.Layouts.raw_rec l, doxie.layout_best_ext r):=transform
				self.bestaddress.AddressType := SexOffender_Services.Constants.address_type;
				self.bestaddress.DateLastSeen := iesp.ECL2ESP.toDateYM ((integer4) r.addr_dt_last_seen);
				scz := SexOffender_Services.Functions.stateCityZipValue(r.city_name, r.st, r.zip);
				self.bestaddress.Address := iesp.ECL2ESP.SetAddress (r.prim_name, r.prim_range, r.predir, r.postdir,
									r.suffix, r.unit_desig, r.sec_range, r.city_name,
									r.st, r.zip, r.zip4, '', '',
									SexOffender_Services.Functions.streetAddress1Value(r.prim_name, r.prim_range, r.predir, r.suffix, r.postdir),
									scz, scz);
			  //self.bestlocation := row({ r.geo_lat, r.geo_long, r.geo_match, ut.geo_desc(r.geo_match) }, iesp.share.t_GeoLocationMatch),
			  self.bestaddress.bestaddressisnewer := SexOffender_Services.Functions.fnBestIsNewer(l.dt_last_reported,l.addr_dt_last_seen,(String)r.addr_dt_last_seen),
			  self.bestaddress.bestaddressisdifferent := SexOffender_Services.Functions.fnBestIsDifferent(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix, l.unit_desig, l.sec_range,
																							l.st, l.p_city_name, l.zip5, l.zip4,
																							r.prim_name, r.prim_range, r.predir, r.postdir, r.suffix, r.unit_desig, r.sec_range,
																							r.st, r.city_name, r.zip, r.zip4);
				self.did := l.did; 
				self.RawAID := r.RawAID; 
				self.bestlocation := [];	
			end;
			
			best_data := join(in_raw, best_recs,
												left.did = right.did, 
												xform1(left, right), 
												keep(1), limit(0), left outer);
			
			bestAddressInfo xform2(bestAddressInfo l, AID_Build.Key_AID_Base r):=transform
				self.bestlocation := row({ r.geo_lat, r.geo_long, r.geo_match, Address.geo_desc(r.geo_match) }, iesp.share.t_GeoLocationMatch),
				self := l
			end;
			
			best_data_final := join(best_data, AID_Build.Key_AID_Base, 
															keyed(left.rawaid=right.rawaid),
															xform2(LEFT,RIGHT),
															keep(1), limit(0), left outer);
			
			return best_data_final;
	end;
	
	
	// ==========================================================================
  // Returns records of Sex offender data in search view
  // ==========================================================================
	export SEARCH_VIEW := module
		shared getParsedWord(String wordsStream) := Function
			rs := RECORD
				STRING200 line;
			END;
			ds := DATASET([{wordsStream}], rs);

				PATTERN Alpha := PATTERN('[A-Za-z]');
				PATTERN word := Alpha+;
				PATTERN compound := PATTERN('"[^"\r\n]*"');

				RULE NounPhraseComponent3 := word | compound;


				ps3 := RECORD
					out1 := MATCHTEXT(NounPhraseComponent3);
				END;

				p3 := PARSE(ds, line, NounPhraseComponent3, ps3, BEST, MANY);

				noQuotes := PROJECT (p3 , TRANSFORM(RECORDOF(P3), 
					SELF.OUT1 := stringlib.stringfilter(stringlib.stringtouppercase(left.out1), ' -0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
				));

				distinct := dedup(noQuotes, out1, All);	
				return distinct;
		end;
		
		//Returns records for Seisint Primary Keys
		export bySPK (dataset (SexOffender_Services.layouts.search) in_spks, 
									SexOffender_Services.IParam.search in_mod,
									boolean isFCRA = false,
									dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
									dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
									integer8 inFFDOptionsMask = 0) := function
					
			ds_raw_offenders := GetRawOffenders(in_spks, in_mod.ApplicationType, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
			
			//this affects penalty calculation. when the address is just the center of a circle instead of a target, you dont want to penalize on street, etc.
		  boolean SearchAroundAddress_value := AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.val(project(in_mod,AutoStandardI.InterfaceTranslator.SearchAroundAddress_value.params))
																					 or in_mod.zip_only_search; 
		  // Calculate the penalty on the records
			parsedSmt := getParsedWord(in_mod.SmtWords);
			smtSearchCount := count(parsedSmt);				
			
		  recs_plus_pen := project(ds_raw_offenders,transform(SexOffender_Services.Layouts.raw_rec,
			  tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				  export allow_wildcard := false;
				  export fname_field    := left.fname;
				  export mname_field    := left.mname;
				  export lname_field    := left.lname;
				  export prange_field   := left.prim_range;
				  export predir_field   := left.predir;
				  export pname_field    := left.prim_name;
				  export suffix_field   := left.addr_suffix;
				  export postdir_field  := left.postdir;
					export sec_range_field := left.sec_range;
				  export city_field     := left.p_city_name;
				  export city2_field    := left.v_city_name;
					// Need to account for when addr state not = orig state code and
					// orig state code matches what is being searched on; 
					// then orig state code should be used so penalty value is set properly.
					export state_field    := if (left.st<>left.orig_state_code or
					                             left.orig_state_code='',
		                                   if(left.orig_state_code=in_mod.state,
																			    left.orig_state_code,left.st),			
					                             left.st);
					export zip_field      := left.zip5;
				  export ssn_field      := left.ssn_appended;
				  export did_field      := (string) left.did;
					export dob_field      := left.dob; 
					// set fields not input to null
				  export phone_field    := ''; 
				  export county_field   := '';
			  end;
		    tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
        // if its deepdive or FCRA, don't apply the penalty
			  self.penalt := if (SearchAroundAddress_value or isFCRA, 0, tempPenaltIndv);				
				smtField := left.scars_marks_tattoos;				
				// for each word in the scars_marks_tattoos input field that are now stored in
				// parsedSmt will try to match in the scars_marks_tattoos in the result dataset.
				result := project(parsedSmt, TRANSFORM({string200 word, string200 field, boolean match}, 
					SELF.word := left.out1;
					SELF.field := smtField;
					SELF.match := StringLib.StringFind(TRIM(SMTfield), TRIM(left.out1), 1) > 0;));								
				// Scars marks and tattos penalty is the number of words search minus the 
				// number of words found in the record.
				self.penalt_osmt := smtSearchCount - COUNT(result(match)) ;				
		    self := left));

		  // ***** DID & SSN pulling and suppression ****
			Suppress.MAC_Suppress(recs_plus_pen,dids_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
			// pull, prune & suppress ssns twice, once for ssn_appended & once for ssn
			Suppress.MAC_Suppress(dids_pulled,ssns_pulled1,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,ssn_appended);
			Suppress.MAC_Suppress(ssns_pulled1,ssns_pulled2,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,ssn);
	    doxie.MAC_PruneOldSSNs(ssns_pulled2, ssns_pruned1, ssn_appended, did, isFCRA);
			doxie.MAC_PruneOldSSNs(ssns_pruned1, ssns_pruned2, ssn, did, isFCRA);

		  // set the ssn_mask_value that is used in Suppress.MAC_Mask
		  string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_val.val(project(in_mod, AutoStandardI.InterfaceTranslator.ssn_mask_val.params)); 

		  suppress.MAC_Mask(ssns_pruned2, ssns_suppressed1, ssn_appended, blank, true, false);
		  suppress.MAC_Mask(ssns_suppressed1, ssns_suppressed2, ssn, blank, true, false);
      return ssns_suppressed2;
		end;

	end; //end of search_view

  // ==========================================================================
  // Returns records of Sex offender data in Report view
  // ==========================================================================	
  export REPORT_VIEW := module
    shared raw_rec := SexOffender_Services.Layouts.raw_rec;

    shared format_rpt (dataset(raw_rec) recs, 
											 SexOffender_Services.IParam.report in_mod,
											 boolean isFCRA = false,
											 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
											 dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
											 integer8 inFFDOptionsMask = 0) := function

	    // Used to replace spaces in date strings with zeroes so cast to integer works Ok,
	    // since some dates only contain a yyyy or a yyyymm.
      fixed_date(string8 dtin) := StringLib.StringFindReplace(dtin, ' ', '0');
			// Restrict explicit offense descriptions
			od(string primKey, string od1, string od2) := function
				isRestricted := (primKey[3..4] in SexOffender.Constants.explicitOffenseStates);
				return od1 + if(in_mod.AllowGraphicDescription or not isRestricted, ' ' + od2, '');
			end;
			
		  //******** Offenses key file transform for Conviction data
		
			iesp.sexualoffender_fcra.t_FcraSexOffReportConviction offenses_file_xform(SexOffender_Services.Layouts.rec_offense_raw l) := transform
			  self.ConvictionJurisdiction := l.conviction_jurisdiction,
				self.ConvictionDate         := iesp.ECL2ESP.toDate ((integer4) l.conviction_date),
				self.CourtName              := l.court,
				self.CourtCaseNumber        := l.court_case_number,
				self.OffenseDate            := iesp.ECL2ESP.toDate ((integer4) l.offense_date),
				self.OffenseCodeOrStatute   := l.offense_code_or_statute,
				self.OffenseDescription     := od(l.seisint_primary_key, l.offense_description, l.offense_description_2),
				self.OffenseCategory				:= (string)l.offense_category;
				self.VictimIsMinor          := if (l.victim_minor='Y',true, false),
				self.VictimIsMinor2         := l.victim_minor,
				self.VictimAge              := (integer) l.victim_age,
				self.VictimGender           := l.victim_gender,
				self.VictimRelationship     := l.victim_relationship,
				self.SentenceDescription    := l.sentence_description + ' ' + l.sentence_description_2,
				self.StatementIDs           := l.StatementIDs,
				self.IsDisputed             := l.isDisputed,
			end;

			//******** Offender key file transform for AKA data
			iesp.share.t_Name SetAKANames (raw_rec l) := transform
				self := iesp.ECL2ESP.setName (l.fname, l.mname, l.lname,l.name_suffix, '',l.name_orig);
			end;


			// **************** MAIN TRANSFORM ****************
			//******** Offender file transform
			iesp.sexualoffender_fcra.t_FcraSexOffReportRecord spk_file_xform(recs l) := transform
				self.PrimaryKey := l.seisint_primary_key,
				self.RecordType := l.record_type,
				self.Name       := iesp.ECL2ESP.setName(l.fname, l.mname, l.lname, l.name_suffix, '',l.name_orig);
																																	
				self.Address    := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, 
				                                           l.predir, l.postdir, 
																									 l.addr_suffix, l.unit_desig, 
																									 l.sec_range, l.v_city_name, 
																							     l.st, l.zip5, l.zip4, ''),																		
				self.SSN              := l.ssn_appended,
				self.OrigSSN          := l.ssn,
				self.UniqueId         := if(l.did=0,'',intformat(l.did,12,1)),
				self.DOB              := iesp.ECL2ESP.toDate ((integer4) fixed_date(l.dob)),
				calculatedAge 				:= IF( trim(l.dob) = '', '', (string) ut.Age((UNSIGNED)l.dob));//Calculate Age
				self.Age			  			:= calculatedAge;
				self.DOB2             := iesp.ECL2ESP.toDate ((integer4) fixed_date(l.dob_aka)),
				self.DateFirstSeen    := iesp.ECL2ESP.toDate ((integer4) l.dt_first_reported),
				self.DateLastSeen     := iesp.ECL2ESP.toDate ((integer4) l.dt_last_reported),
			  self.DateOffenderLastUpdated := iesp.ECL2ESP.toDateYM ((integer4) l.addr_dt_last_seen),
				self.StateOfOrigin    := l.orig_state,
				self.OriginStateCode  := l.orig_state_code,
				self.OffenderStatus   := l.offender_status,
				self.OffenderCategory := l.offender_category,
				self.RiskLevelCode    := l.risk_level_code,
				self.RiskDescription  := l.risk_description,
						 
				// t_SexOffReportPoliceAgency record info 
				self.PoliceAgency.Name                        := l.police_agency,
				self.PoliceAgency.ContactName                 := l.police_agency_contact_name,
        iesp.share.t_Address SetAddress () := transform
					self.StreetAddress1      := l.police_agency_address_1;
					self.StreetAddress2      := l.police_agency_address_2;
					Self := [];
				end;
				self.PoliceAgency.Address := Row (SetAddress ());
				self.PoliceAgency.Phone	                     := l.police_agency_phone,
					
        //t_SexOffReportSchool record info
				self.School.Name     := l.school,
				self.School.Address1 := l.school_address_1,
				self.School.Address2 := l.school_address_2,
				self.School.Address3 := l.school_address_3,
				self.School.Address4 := l.school_address_4,
				self.School.Address5 := l.school_address_5,
				self.School.County   := l.school_county,

				//t_SexOffReportEmployer record info
				self.Employer.Name     := l.employer,
				self.Employer.Address1 := l.employer_address_1,
				self.Employer.Address2 := l.employer_address_2,
				self.Employer.Address3 := l.employer_address_3,
				self.Employer.Address4 := l.employer_address_4,
				self.Employer.Address5 := l.employer_address_5,
				self.Employer.County   := l.employer_county,

				//t_SexOffReportRegistration record info
				self.Registration._Type     := l.registration_type,
				self.Registration.Date1     := iesp.ECL2ESP.toDate ((integer4) l.reg_date_1),
				self.Registration.Date1Type := l.reg_date_1_type,
				self.Registration.Date2     := iesp.ECL2ESP.toDate ((integer4) l.reg_date_2),
				self.Registration.Date2Type := l.reg_date_2_type,
				self.Registration.Date3     := iesp.ECL2ESP.toDate ((integer4) l.reg_date_3),
				self.Registration.Date3Type := l.reg_date_3_type,
				self.Registration.Address1  := l.registration_address_1,
				self.Registration.Address2  := l.registration_address_2,
				self.Registration.Address3  := l.registration_address_3,
				self.Registration.Address4  := l.registration_address_4,
				self.Registration.Address5  := l.registration_address_5,
				self.Registration.County    := l.registration_county,

				//t_SexOffReportVehicle Vehicle1 record info
				self.Vehicle1.Year      := (integer) l.orig_veh_year_1,
				self.Vehicle1.Color     := l.orig_veh_color_1,
				self.Vehicle1.MakeModel := l.orig_veh_make_model_1,
				self.Vehicle1.Plate     := l.orig_veh_plate_1,
				self.Vehicle1.State     := l.orig_veh_state_1,

				//t_SexOffReportVehicle Vehicle2 record info
				self.Vehicle2.Year      := (integer) l.orig_veh_year_2,
				self.Vehicle2.Color     := l.orig_veh_color_2,
				self.Vehicle2.MakeModel := l.orig_veh_make_model_2,
				self.Vehicle2.Plate     := l.orig_veh_plate_2,
				self.Vehicle2.State     := l.orig_veh_state_2,
						 
				//t_SexOffRecordPhysicalCharacteristics record info
				self.PhysicalCharacteristics.Age                 := calculatedAge,
				self.PhysicalCharacteristics.Race                := l.race,
				self.PhysicalCharacteristics.Ethnicity           := l.ethnicity,
				self.PhysicalCharacteristics.Sex                 := l.sex,
				self.PhysicalCharacteristics.HairColor           := l.hair_color,
				self.PhysicalCharacteristics.EyeColor            := l.eye_color,
				self.PhysicalCharacteristics.Height              := l.height,
				self.PhysicalCharacteristics.Weight              := l.weight,
				self.PhysicalCharacteristics.SkinTone            := l.skin_tone,
				self.PhysicalCharacteristics.BuildType           := l.build_type,
				self.PhysicalCharacteristics.ScarsMarksTattoos   := l.scars_marks_tattoos,
				self.PhysicalCharacteristics.ShoeSize            := l.shoe_size,
				self.PhysicalCharacteristics.CorrectiveLenseFlag := l.corrective_lense_flag='Y', 

				//t_SexOffRecordIdNumbers record info
				self.IDNumbers.OffenderId    := l.offender_id,
				self.IDNumbers.DocNumber     := l.doc_number,
				self.IDNumbers.SORNumber     := l.sor_number,
				self.IDNumbers.StateIdNumber := l.st_id_number,
				self.IDNumbers.FBINumber     := l.fbi_number,
				self.IDNumbers.NCICNumber    := l.ncic_number,
				self.DriverLicenseNumber 		 := l.orig_dl_number,
				self.DriverLicenseState  		 := l.orig_dl_state,
				self.AdditionalComment1 		 := l.addl_comments_1,
				self.AdditionalComment2 		 := l.addl_comments_2,
				self.ImageLink          		 := l.image_link,

				// Sort Convictions by Conviction-Date reverse chron (descending)
				ds_spk := dataset([{l.seisint_primary_key, l.isDeepDive}], SexOffender_Services.Layouts.search);
				self.Convictions := sort(project(GetRawOffenses(ds_spk, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask),
			 				                           offenses_file_xform(left)),
																 -ConvictionDate),
				// (name_type=0 is the main name, not an AKA).
				self.AKAs := dedup(sort(project(recs (seisint_primary_key = l.seisint_primary_key, name_type <>'0'), SetAKANames(left)),
												        Last,First,Middle,Suffix),
													 Last,First,Middle,Suffix),													 
				self.BestAddress := [],
				self.StatementIDs 		 := l.StatementIDs,
			  self.isDisputed        := l.isDisputed
			end; /* end of spk_file_xform transform */

			// For offender data, use a project to do a keyed look up against the Key SPK (Offender)
			// file using the seisint primary key and also matching on the name_type = '0'
			// which is the main (not an AKA ) name.

			recs_pre_best  := project(recs(name_type ='0'), spk_file_xform(left));			
			
			// adding best information if requested.
			recs_best 		 := GetBestAddressRec(recs, in_mod.DPPAPurpose, in_mod.GLBPurpose);				
			recs_with_best := join(recs_pre_best, recs_best,
														 (unsigned6) left.UniqueId = right.did,
														 transform(iesp.sexualoffender_fcra.t_FcraSexOffReportRecord,
																				self.BestAddress := right.BestAddress,
																				self := left),
														 left outer, keep(1), limit(0));
			
			recs_out := if(in_mod.include_bestaddress and ~isFCRA, recs_with_best, recs_pre_best);
															 			
		  // ***** DID & SSN pulling and suppression ****
			Suppress.MAC_Suppress(recs_out,dids_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,UniqueId);

			// pull, prune & suppress ssns twice, once for ssn_appended & once for ssn
			Suppress.MAC_Suppress(dids_pulled,ssns_pulled1,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,ssn);
			Suppress.MAC_Suppress(ssns_pulled1,ssns_pulled2,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,OrigSSN);
	    doxie.MAC_PruneOldSSNs(ssns_pulled2, ssns_pruned1, SSN, UniqueId, isFCRA);
			doxie.MAC_PruneOldSSNs(ssns_pruned1, ssns_pruned2, OrigSSN, UniqueId, isFCRA);

		  // set the ssn_mask_value that is used in Suppress.MAC_Mask
		  string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(in_mod,
                                AutoStandardI.InterfaceTranslator.ssn_mask_value.params)); 

		  suppress.MAC_Mask(ssns_pruned2, ssns_suppressed1, SSN, blank, true, false);
		  suppress.MAC_Mask(ssns_suppressed1, ssns_suppressed2, OrigSSN, blank, true, false);

      return ssns_suppressed2;		
		end;
			
		export by_did (dataset(doxie.layout_references) in_dids, 
									 SexOffender_Services.IParam.report in_mod,
									 boolean isFCRA = false,
									 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
									 dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
									 integer8 inFFDOptionsMask = 0) := function

			fmt_dids := project(in_dids,SexOffender_Services.layouts.search_did);
			rec_ids  := byDIDs(fmt_dids, isFCRA);
			rawrecs  := GetRawOffenders(rec_ids, in_mod.ApplicationType, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
			rpt_recs := format_rpt(rawrecs, in_mod, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
			
		  return rpt_recs;
		end;
	
		export by_primary_key (dataset(SexOffender_Services.layouts.search)in_spks, 
													 SexOffender_Services.IParam.report in_mod,
													 boolean isFCRA = false,
													 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile) := function	
			
			rec_dids:= getDIDsbySPK(in_spks, isFCRA);
			rec_ids  := byDIDs(rec_dids, isFCRA)+in_spks;
			dedup_rec_ids  := dedup(sort(rec_ids,seisint_primary_key),seisint_primary_key);
			rawrecs  := GetRawOffenders(dedup_rec_ids, in_mod.ApplicationType, isFCRA, flagfile);
			rpt_recs := format_rpt(rawrecs, in_mod, isFCRA, flagfile);
			
			return rpt_recs;
		end;
			
	end; //end of report_view
	
	export batch_view := module
		export getOffendersRecs(dataset(SexOffender_Services.layouts.lookup_id_rec) in_spks, 
														boolean isFCRA = false,
														dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
														dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
														integer8 inFFDOptionsMask = 0) := function
														
			search_spks := dedup(sort(project(in_spks, SexOffender_Services.Layouts.search), seisint_primary_key), seisint_primary_key);
			ds_offenders_raw := GetRawOffenders(search_spks, , isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
      // transform to layout with FFD fields
			ds_offenders_final := JOIN(in_spks, ds_offenders_raw,
																	LEFT.seisint_primary_key = RIGHT.sspk,
																	transform(SexOffender_Services.Layouts.rec_offender_plus_acctno,
																	          self.acctno := left.acctno,
																						self.isDeepDive := left.isDeepDive,
																						self := right),
																	LIMIT(BatchServices.Constants.SEXPREDCPS_SERVICE_JOIN_LIMIT));

			return ds_offenders_final;
		end;
		export GetOffensesRecs(dataset(SexOffender_Services.Layouts.lookup_id_rec) in_spks, 
													 boolean isFCRA = false,
													 dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
													 dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
													integer8 inFFDOptionsMask = 0) := function 
													
			 search_spks := dedup(sort(project(in_spks, SexOffender_Services.Layouts.search), seisint_primary_key), seisint_primary_key);
			 raw_recs := GetRawOffenses(search_spks, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
			 // transform to layout with FFD fields
			 final_recs := join(in_spks, raw_recs,
													left.seisint_primary_key = right.seisint_primary_key,
													transform(SexOffender_Services.Layouts.rec_offense_raw,
													          self.acctno := left.acctno,
																		self := right));
		 return final_recs;
		end;
	end; //end of batch_view

end;
