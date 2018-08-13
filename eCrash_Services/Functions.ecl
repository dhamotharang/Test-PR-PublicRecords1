import iesp, lib_stringlib, ut, FLAccidents_Ecrash, AutoStandardI, doxie, Std, eCrash_Services;

export Functions := MODULE

	/*
		Break Str1 and Str2 into sets of tokens, takes the set with lesser amount of tokens (let's say it would be Str1), 
		intersects with the second set (Str2) and determines if all of the tokens from the first set (in our example Str1) are present in the second set (Str2).
	*/
	EXPORT BOOLEAN StringTokenMatch(STRING Str1, STRING Str2, STRING SeparatorStr = ' ') := FUNCTION
		Str1Trimmed := TRIM(Str1, LEFT, RIGHT);
		Str2Trimmed := TRIM(Str2, LEFT, RIGHT);
		Str1Prepared := Std.Str.FindReplace(Str1Trimmed, '-', SeparatorStr);
		Str2Prepared := Std.Str.FindReplace(Str2Trimmed, '-', SeparatorStr);
		Str1Set := Std.Str.SplitWords(Std.Str.ToUpperCase(Str1Prepared), SeparatorStr);
		Str2Set := Std.Str.SplitWords(Std.Str.ToUpperCase(Str2Prepared), SeparatorStr);
		
		StrCondition := COUNT(Str2Set) <= COUNT(Str1Set);
		TokensMustMatchSet := IF(StrCondition, Str2Set, Str1Set);
		TokensMustMatchWithSet := IF(StrCondition, Str1Set, Str2Set);
		
		TokenLayout := RECORD
			STRING piece;
		END;
		TokensMustMatchDs := DATASET(TokensMustMatchSet, TokenLayout);
		TokensMustMatchWithDs := DATASET(TokensMustMatchWithSet, TokenLayout);
		
		TokensNotMatched := JOIN(
			TokensMustMatchDs,
			TokensMustMatchWithDs,
			LEFT.piece = RIGHT.piece,
			LEFT ONLY
		);	
		
		RETURN Str1Trimmed <> '' AND Str2Trimmed <> '' AND ~EXISTS(TokensNotMatched);
	END;

	EXPORT eCrash_Services.Layouts.recs_with_penalty FilterOutDeletedReports(DATASET(eCrash_Services.Layouts.recs_with_penalty) Recs) := FUNCTION
			//eliminating supplements and leaving only unique reports with is_deleted = 1
			RecsDeletedDeduped := DEDUP(
				SORT(
					Recs(is_deleted = 1),
					-(UNSIGNED8)report_id, //getting the latest deleted report
					report_code,
					report_type_id,
					orig_accnbr,
					addl_report_number,
					accident_date,
					jurisdiction_state,
					jurisdiction
				),
				report_code,
				report_type_id,
				orig_accnbr,
				addl_report_number,
				accident_date,
				jurisdiction_state,
				jurisdiction
			);	
			
			//all the matches between LEFT and RIGHT records correspond to deleted reports, therefore returning LEFT ONLY gives us only not deleted reports
			Result := JOIN(
				Recs(is_deleted = 0), 
				RecsDeletedDeduped,
				(LEFT.report_code = RIGHT.report_code 
					OR (LEFT.report_code IN ['TM', 'TF'] AND RIGHT.report_code IN ['TM', 'TF'])
				)
				//A are DE are mutually removable
				AND (LEFT.report_type_id = RIGHT.report_type_id
					OR (LEFT.report_type_id IN ['A', 'DE'] AND RIGHT.report_type_id IN ['A', 'DE'])
				)
				AND LEFT.orig_accnbr = RIGHT.orig_accnbr 
				AND LEFT.addl_report_number = RIGHT.addl_report_number
				AND LEFT.accident_date = RIGHT.accident_date
				AND LEFT.jurisdiction_state = RIGHT.jurisdiction_state
				AND LEFT.jurisdiction = LEFT.jurisdiction
				AND LEFT.report_id <= RIGHT.report_id //if report A came after the latest deleted report B (which means LEFT.report_id will be > then RIGHT.report_id) 
																							 //then we don't want to delete report A
				AND LEFT.date_added <= RIGHT.date_added //if report was undeleted (in that case report_id will be the same but date_added of undeleted report will be greater) we don't want to mark it as deleted																			 
				AND LEFT.vehicle_incident_id <= RIGHT.vehicle_incident_id, //if report when through the additional keying process or through the edit keyed reports we will have report_id the same and date_added the same
																																//so we have to consider incident_id as well
				LEFT ONLY
			);

			RETURN Result;
		END;

	EXPORT create_date_dataset(string startdate, integer offset, boolean forwardOnly=false):=function

		tmp_rec := record
			string8 daterange;
		end;
		ds_tmp:=dataset([{startdate}],tmp_rec);

		tmp_rec create_back_dates(ds_tmp l, integer c):=transform
			self.daterange := ut.date_math(l.daterange,-c)	;
		end;

		tmp_rec create_forward_dates(ds_tmp l, integer c):=transform
			self.daterange := ut.date_math(l.daterange,c)	;
		end;
			

		ds_back:=normalize(ds_tmp,offset,create_back_dates(left,counter));
		ds_forward:=normalize(ds_tmp,offset,create_forward_dates(left,counter));
		
		result := MAP (
			forwardOnly => ds_forward + ds_tmp,
			ds_back + ds_tmp
		);
		
		return result;

	end;
	
	
	EXPORT location_filter (dataset(recordof(eCrash_Services.Layouts.recs_with_penalty)) recs, eCrash_Services.IParam.searchrecords in_mod):=function
				string CrossStreet := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationCrossStreet);
				string loc_street := lib_stringlib.StringLib.StringToUpperCase(in_mod.AccidentLocationStreet);
				recs_exact:= recs((CrossStreet='' or (eCrash_Services.Constants.contains_match(accident_cross_street,CrossStreet) or 
																						 eCrash_Services.Constants.contains_match(accident_street,CrossStreet) or
																						 eCrash_Services.Constants.contains_match(next_street,CrossStreet)))
																						 and 
													
												(loc_street='' or (eCrash_Services.Constants.contains_match(accident_cross_street,loc_street) or
																						 eCrash_Services.Constants.contains_match(next_street,loc_street) or 
																						 eCrash_Services.Constants.contains_match(accident_street,loc_street))));
												
				return recs_exact;
	end;
	
	EXPORT OwnerDriverDedup(DATASET(eCrash_Services.Layouts.eCrashRecordStructure) Parties) := FUNCTION
		Result := DEDUP(
			SORT(
				Parties,
				(UNSIGNED8)report_id, 
				vehicle_Unit_Number,
				lname,
				fname,
				dob,
				address,
				v_city_name,
				person_addr_st, 
				zipFull,
				MAP(
					REGEXFIND('DRIVER|VEHICLE DRIVER|VEHICLEDRIVER', record_type) => 1, /*record_type is person type*/
					REGEXFIND('OWNER|VEHICLE OWNER|VEHICLEOWNER', record_type) => 2,
					3
				),
				-person_creation_date,
				/*in case of VRK, InvalidVINQueue or additional keying we will have the same report_id but different vehicle_incident_id.
				Non-deleted report in that case will have higher incident id and we want to keep it.
				*/
				-(UNSIGNED8)vehicle_incident_id
			),
			report_id, 
			vehicle_Unit_Number,
			lname,
			fname,
			dob,
			address,
			v_city_name,
			person_addr_st, 
			zipFull
		);			
		
		RETURN Result;
	END;
	
	EXPORT SupplementRollupTransform (DATASET(eCrash_Services.Layouts.eCrashRecordStructure) recs) := FUNCTION
		
		eCrash_Services.Layouts.eCrashRecordCompare rollupTransform(eCrash_Services.Layouts.eCrashRecordCompare L, eCrash_Services.Layouts.eCrashRecordCompare R) := TRANSFORM
				SELF.accident_street := L.accident_street + R.accident_street;
				SELF.accident_cross_street := L.accident_cross_street + R.accident_cross_street;
				SELF.fname := L.fname + R.fname;
				SELF.mname := L.mname + R.mname;
				SELF.lname := L.lname + R.lname;
				SELF.driver_license_nbr := L.driver_license_nbr + R.driver_license_nbr;
				SELF.tag_nbr := L.tag_nbr + R.tag_nbr;
				//prim_range,
				//prim_name,
				//sec_range,
				SELF.v_city_name := L.v_city_name + R.v_city_name;
				SELF.st := L.st + R.st;
				SELF.zip := L.zip + R.zip;
				SELF.vin := L.vin + R.vin;
				SELF.vehicle_year := L.vehicle_year + R.vehicle_year;
				SELF.make_description := L.make_description + R.make_description;
				SELF.model_description := L.model_description + R.model_description;
				/*we can have original instance of report in the payload or in the deltabase and deleted instance in the deltabase - in that case
					report_id and vehicle_incident_id for those reports will be the same and in that case we have to treat report as deleted.
					Another case is VKR, Invalid Vin Queue or Additional keying where new version of the same report gets extracted to deltabase and old
					version of that report gets marked as deleted - in that case report_id will be the same but vehicle_incident_id will be different
					(new updated report will have higher vehicle_incident_id and we want to preserve its is_deleted = 0 flag)
				*/
				SELF.is_deleted := IF(
					L.vehicle_incident_id = R.vehicle_incident_id
					AND (L.is_deleted = 1 OR R.is_deleted = 1), 
					1, 
					L.is_deleted
				);
				SELF.date_added := IF(
					L.date_added != '', 
					L.date_added, 
					IF (R.date_added != '', R.date_added, '')
				);//deltabase date_added
				SELF := L;		
		END;

		ReportsAllSorted := SORT(
													recs, 
													-(UNSIGNED8)report_id,
													/*in case of VRK, InvalidVINQueue or additional keying we will have the same report_id but different vehicle_incident_id.
													Non-deleted report in that case will have higher incident id.
													*/
													-(UNSIGNED8)vehicle_incident_id, 
													accident_street,
													accident_cross_street,
													fname,
													mname,
													lname,
													driver_license_nbr,
													tag_nbr,
													//prim_range,
													//prim_name,
													//sec_range,
													v_city_name,
													st,
													zip,
													vin,
													vehicle_year,
													make_description,
													model_description
												);

		ReportsAllCompare := PROJECT(
			ReportsAllSorted, 
			eCrash_Services.Layouts.eCrashRecordCompare
		);
		
		ReportsAllRolledUp := ROLLUP(ReportsAllCompare,LEFT.report_id = RIGHT.report_id,rollupTransform(LEFT, RIGHT));
		
	ReportsAllRolledUpSorted := SORT(
															ReportsAllRolledUp,
															-(UNSIGNED8)report_id,
															-(UNSIGNED1)is_deleted,
															accident_street,
															accident_cross_street,
															fname,
															mname,
															lname,
															driver_license_nbr,
															tag_nbr,
															//prim_range,
															//prim_name,
															//sec_range,
															v_city_name,
															st,
															zip,
															vin,
															vehicle_year,
															make_description,
															model_description
														);

	ReportsAllDeduped := DEDUP(
											ReportsAllRolledUpSorted,
											accident_street,
											accident_cross_street,
											fname,
											mname,
											lname,
											driver_license_nbr,
											tag_nbr,
											//prim_range,
											//prim_name,
											//sec_range,
											v_city_name,
											st,
											zip,
											vin,
											vehicle_year,
											make_description,
											model_description
										);

		return ReportsAllDeduped;
	END;

		
	EXPORT GetSuperReportIdFromDeltabase(STRING SqlQuery, eCrash_Services.IParam.searchrecords InMod) := FUNCTION
		Parties := RecordsDeltaBase(InMod).DeltaService.LookupIncidentPersons(SqlQuery);
		
		RETURN MIN(Parties, report_id);
	END;
	
	EXPORT GetSuperReportId(eCrash_Services.Layouts.recs_with_penalty ReportRecord, eCrash_Services.IParam.searchrecords InMod) := FUNCTION
			Payload := FLAccidents_Ecrash.key_EcrashV2_accnbrv1(
				KEYED(
					l_accnbr = ReportRecord.l_accnbr AND
					jurisdiction_state = ReportRecord.jurisdiction_state AND
					jurisdiction = ReportRecord.jurisdiction 
				) AND
				WILD(report_code) AND
				accident_date = ReportRecord.accident_date AND
				orig_accnbr = ReportRecord.orig_accnbr AND
				report_type_id = ReportRecord.report_type_id
			);
			
			ReportRecordForSql := PROJECT(
				ReportRecord, 
				TRANSFORM(
					eCrash_Services.Layouts.eCrashRecordStructure,
					SELF := LEFT;
				)
			);

			DeltaBaseSqlString := RecordsDeltaBase(InMod).deltaSQL.getImageRetrievalSql(ReportRecordForSql);
			SuperReportId := IF(
				EXISTS(Payload), 
				Payload[1].super_report_id, 
				GetSuperReportIdFromDeltabase(DeltaBaseSqlString, InMod)
			);		
				
			RETURN SuperReportId;
	END;

	EXPORT GetReportPricingData(eCrash_Services.Layouts.recs_with_penalty ReportRecord, eCrash_Services.IParam.searchrecords InMod) := FUNCTION
			Payload := LIMIT(
				FLAccidents_Ecrash.key_EcrashV2_accnbrv1(
					KEYED(
						l_accnbr = ReportRecord.l_accnbr AND
						jurisdiction_state = ReportRecord.jurisdiction_state AND
						jurisdiction = ReportRecord.jurisdiction 
					) AND
					WILD(report_code) AND
					accident_date = ReportRecord.accident_date AND
					orig_accnbr = ReportRecord.orig_accnbr AND
					report_type_id = ReportRecord.report_type_id
				),
				eCrash_Services.constants.MAX_REPORT_NUMBER,
				FAIL(203, doxie.ErrorCodes(203))
			);	
			
			ReportRecordForSql := PROJECT(
				ReportRecord, 
				TRANSFORM(
					eCrash_Services.Layouts.eCrashRecordStructure,
					SELF := LEFT;
				)
			);
			
			DeltaBaseSqlString := RecordsDeltaBase(InMod).deltaSQL.getImageRetrievalSql(ReportRecordForSql);
			Parties := RecordsDeltaBase(InMod).DeltaService.LookupIncidentPersons(DeltaBaseSqlString);
			ReportOwnerDriverDeduped := OwnerDriverDedup(Parties);
			PayloadRecs := project(Payload,TRANSFORM(eCrash_Services.Layouts.eCrashRecordStructure, SELF:=LEFT, SELF := []));
			
			ReportsPageCountRaw := ReportOwnerDriverDeduped + PayloadRecs;
			ReportsPageCountWithDeleted := PROJECT(ReportsPageCountRaw, TRANSFORM(eCrash_Services.Layouts.recs_with_penalty, SELF := LEFT, SELF := []));
			ReportsPageCountWithoutDeleted := FilterOutDeletedReports(ReportsPageCountWithDeleted);
			ReportsPageCount := PROJECT(ReportsPageCountWithoutDeleted,TRANSFORM(eCrash_Services.Layouts.eCrashRecordStructure, SELF := LEFT, SELF := []));	
			
			// Get the min report_id for page_count, we have to pick the page_count for the lastest non dupe report (If supplemental we want the older report page_count, since supplements are free)
			SupplementTransformedRecs := SupplementRollupTransform(ReportsPageCount);
			
			PageCountReportId :=TOPN(SupplementTransformedRecs, 1, report_id);//MIN(SupplementTransformedRecs,report_id);
			
			PageCountRecs:= join (PageCountReportId, ReportsPageCount,
														left.report_id = right.report_id,
														transform(right),keep(1));
														
			deltabaseRecs := project(Parties,TRANSFORM(eCrash_Services.Layouts.eCrashRecordStructure, SELF.super_report_id := left.report_id, SELF:=LEFT));
			
			superReportRecsRaw :=PayloadRecs + deltabaseRecs; 
			superReportRecsWithDeleted := PROJECT(
				superReportRecsRaw,
				TRANSFORM(
					eCrash_Services.Layouts.recs_with_penalty, 
					SELF := LEFT; 
					SELF := [];
				)	
			);
			
			superReportRecs := FilterOutDeletedReports(superReportRecsWithDeleted);
	
			superReportRecsFiltered := TOPN(superReportRecs, 1, report_id);
			
			supplementalRecsPageCount := TOPN(
				CHOOSEN(
					FLAccidents_Ecrash.Key_eCrashv2_Supplemental(super_report_id=superReportRecsFiltered[1].super_report_id),
					eCrash_Services.constants.MAX_REPORT_NUMBER
				),	
				1,
				report_id
			);
			//@TODO: figure out what does compiler complain about limits here....we are using topn
			
			page_count := if(exists(supplementalRecsPageCount),supplementalRecsPageCount[1].page_count, PageCountRecs[1].page_count);
			
			reportPricingRec := ROW(TRANSFORM(eCrash_Services.Layouts.ReportPricing, SELF.superreportid := superReportRecsFiltered[1].super_report_id; SELF.pagecount := page_count));
			
			RETURN reportPricingRec;
	END;

   EXPORT AssociatedReportsTransform (dataset(iesp.ecrash.t_ECrashSearchRecord) in_recs, eCrash_Services.IParam.searchrecords in_mod) := FUNCTION
	 
		RawDocIn := RawDocument(in_mod);
		iesp.ecrash.t_ECrashSearchRecordData xformSearchRecordData(iesp.ecrash.t_ECrashSearchRecord l) := TRANSFORM
	
		  iesp.ecrash.t_ECrashDocument xform_Documents(eCrash_Services.Layouts.DocumentData l) := TRANSFORM
				self.DocType := l.reportTypeId;
				self.id := l.documentId;
				self.extension := l.extension;
				self.pages := (integer)l.pageCount;
			END;
			
			self.Documents := project(RawDocIn.GetReportDocuments(l.superreportid),xform_Documents(left));
			self := l;
			self := [];
		END;
	
		iesp.ecrash.t_ECrashSearchRecord groupable_xform(iesp.ecrash.t_ECrashSearchRecord l, dataset(iesp.ecrash.t_ECrashSearchRecord) r):= TRANSFORM
			SELF.Reports := project(r,xformSearchRecordData(left));
			SELF.DateOfLoss.Year := l.DateOfLoss.Year;
			SELF.DateOfLoss.Month := l.DateOfLoss.Month;
			SELF.DateOfLoss.Day := l.DateOfLoss.Day;
			SELF := l;
			SELF := [];
		END;
		
		iesp.ecrash.t_ECrashSearchRecord nongroupable_xform(iesp.ecrash.t_ECrashSearchRecord l):= TRANSFORM
			SELF.Reports := project(dataset(l),xformSearchRecordData(left));
			SELF.DateOfLoss.Year := l.DateOfLoss.Year;
			SELF.DateOfLoss.Month := l.DateOfLoss.Month;
			SELF.DateOfLoss.Day := l.DateOfLoss.Day;
			SELF := l;
			SELF := [];
		END;
		
		// groupable := in_recs.ReportType in constants.groupable_report_codes and in_recs.ReportCode in (constants.Iyetek_src);
		// groupable_recs := in_recs(in_recs.ReportType in constants.groupable_report_codes and in_recs.ReportCode in (constants.Iyetek_src));
    // non_groupable_recs := in_recs(~(in_recs.ReportType in constants.groupable_report_codes and in_recs.ReportCode in (constants.Iyetek_src)));
		groupable_recs := in_recs(ReportType in eCrash_Services.constants.groupable_report_codes and ReportCode in eCrash_Services.constants.Iyetek_src);
    non_groupable_recs := in_recs(ReportType not in eCrash_Services.constants.groupable_report_codes or ReportCode not in eCrash_Services.constants.Iyetek_src);
		
		rpt_grp := GROUP(
				SORT(groupable_recs,
				Jurisdiction,
				ReportNumber,
				DateOfLoss
				
				), 
				Jurisdiction,
				ReportNumber,
				DateOfLoss
			);
			
			non_groupable_xform_recs := project(non_groupable_recs,nongroupable_xform(left));
			groupable_xform_recs := rollup (rpt_grp, group, groupable_xform (left, rows (left)));	
			
			RETURN non_groupable_xform_recs + groupable_xform_recs;
	END;
	
	
	
	EXPORT InvolvedPartyTransform (dataset(eCrash_Services.Layouts.recs_with_penalty) in_recs, eCrash_Services.IParam.searchrecords in_mod, boolean is_direct_match):=FUNCTION
		
		primary_agency := in_mod.agencies(PrimaryAgency)[1];
		boolean no_state_search := eCrash_Services.constants.no_state_search(in_mod);
		boolean no_jurisdiction_search := eCrash_Services.constants.no_jurisdiction_search(in_mod);
		boolean use_rpt_num:= eCrash_Services.Constants.use_rpt_num (in_mod);
		boolean direct_match_confirm:= is_direct_match and not no_state_search and not no_jurisdiction_search;
		boolean has_name:=in_mod.firstname<>'' and in_mod.lastname<>'';

		iesp.ecrash.t_ECrashSearchRecord final_xform(eCrash_Services.Layouts.recs_with_penalty l, dataset(eCrash_Services.Layouts.recs_with_penalty) r):=TRANSFORM	
		
			iesp.ecrash.t_ECrashInvolvedParty xform_InvolvedParty(eCrash_Services.Layouts.recs_with_penalty l):=TRANSFORM
							self.DriverLicenseNumber := l.driver_license_nbr,
							self.Vehicle.Licenseplate := l.tag_nbr,
							self.Vehicle.Vin := l.vin,
							self.Vehicle.VehicleUnitNumber := l.vehicle_Unit_Number,
							self.Vehicle.PlateState := l.tagnbr_st,
							self.DOB := iesp.ECL2ESP.toDatestring8(l.dob),
							self.Name:= iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, l.name_suffix,''),
							self.address :=   iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
																															l.addr_suffix, l.unit_desig, l.sec_range,
																															l.v_city_name, l.st, l.zip, l.zip4,''),					
					END;
					
					// boolean no_state_search :=constants.no_state_search(in_mod);
					// boolean no_jurisdiction_search :=constants.no_jurisdiction_search(in_mod);
					// boolean use_rpt_num:= Constants.use_rpt_num (in_mod);
					// boolean use_dol_internal:= Constants.use_dol_internal(in_mod);

					/* match_type --> D for direct and P for possible  => is_direct_match corresponds to previous match_type = 'D'*/

					// boolean direct_match_confirm:= is_direct_match and not no_state_search and not no_jurisdiction_search;
									
					// boolean dol_valid:=in_mod.dateofloss<>'';
					// boolean has_name:=in_mod.firstname<>'' and in_mod.lastname<>'';
					
				  deltaReportPricingRec := GetReportPricingData(l, in_mod);
				
					self.SuperReportID := IF(NOT l.isDelta, l.super_report_id, deltaReportPricingRec.SuperReportID);
					self.pages := (integer)deltaReportPricingRec.pagecount;
					//self.pages := IF(NOT l.isDelta, (integer)l.page_count, (integer)deltaReportPricingRec.pagecount);
								
					boolean agency_match   := (l.jurisdiction_state = primary_agency.JurisdictionState and
																		 l.Jurisdiction = primary_agency.Jurisdiction);
				
																						 
				  self.ResultType := MAP(	eCrash_Services.constants.b_internal_pduser(in_mod.UserType) and direct_match_confirm and (use_rpt_num or has_name) and agency_match =>eCrash_Services.constants.DIRECT_hit,
																	eCrash_Services.constants.b_internal_pduser(in_mod.UserType) => eCrash_Services.constants.POSSIBLE_hit,
																  direct_match_confirm and agency_match => eCrash_Services.constants.DIRECT_hit,
																	eCrash_Services.constants.POSSIBLE_hit),
					self.ReportHashKey := l.image_hash;
					self.AgencyORI := l.agency_ori;
					self.agencyid:=l.jurisdiction_nbr;
					self.JurisdictionState := l.jurisdiction_state,
					self.Jurisdiction :=l.jurisdiction,
					self.IsReadyForPublic :=trim(l.is_available_for_public) = '1' or l.report_code in eCrash_Services.constants.Inhouse_src;
					//getting involved parties from the latest report
					InvolvedParties := r(report_id = l.report_id);
					
					self.InvolvedParties:=choosen(project(sort(InvolvedParties,penalt,lname,fname,record),xform_InvolvedParty(left)),iesp.Constants.eCrashMod.Max_Involved_Parties),
					self.DateOfLoss:=iesp.ECL2ESP.toDatestring8(l.accident_date);
					self.ReportNumber:= (string)l.orig_accnbr;//l.l_accnbr,
					self.StateReportNumber:= (string)l.addl_report_number;
					self.AccidentLocation.Street := l.accident_street ;
					self.AccidentLocation.CrossStreet := l.accident_cross_street ;
					self.HasCoverSheet := trim(l.report_has_coversheet)='1';
					self.ReportType := l.report_type_id;
					self.ReportLinkID := l.reportlinkid;
					self.VendorCode := l.vendor_code;
					self.ReportCode := l.report_code;
					self.ContribSource := l.contrib_source;
					keys_report_date := eCrash_Services.Constants.Format_Report_Creation_Date(l.creation_date);
					self.DateReportCreated := IF(l.isDelta, l.date_added[1..10], keys_report_date);
					self.OfficerBadgeNumber := l.officer_id;
					self.VendorReportID := l.vendor_report_id;
					self.DateReportSubmitted.Year := (integer)l.Date_Report_submitted[1..4];
					self.DateReportSubmitted.Month := (integer)l.Date_Report_submitted[6..7];
					self.DateReportSubmitted.Day := (integer)l.Date_Report_submitted[9..10];
					self:=[]
					END;
					
			rpt_grp := GROUP(
				SORT(in_recs, 
					//all the TM and TF reports have orig_accnbr and addl_report_number switched
					IF(report_code = 'EA', orig_accnbr, addl_report_number), 
					IF(report_code = 'EA', addl_report_number, orig_accnbr),
					jurisdiction_state,
					jurisdiction,
					accident_date,
					IF(report_code = 'TM', 1, 0),// //TM has the least priority
					report_type_id,
					-(UNSIGNED8)report_id
				), 
				IF(report_code = 'EA', orig_accnbr, addl_report_number), 
				IF(report_code = 'EA', addl_report_number, orig_accnbr),
				jurisdiction_state,
				jurisdiction,
				accident_date,
				report_type_id
			);
			
			
			recs_result := rollup (rpt_grp, group, final_xform (left, rows (left)));	
		
			RETURN recs_result;
		END;
		
		EXPORT GetImageDataFromDeltabase(SET OF STRING ReportIds, eCrash_Services.IParam.searchrecords InModuleDeltabase) := FUNCTION
			DeltabaseService := DeltaBaseSoapCall(InModuleDeltabase);
			DeltabaseSql := RawDeltaBaseSQL(InModuleDeltabase);
			DeltabaseResponse := DeltabaseService.GetImageData(DeltabaseSql.GetTmImageSql(ReportIds));
			
			iesp.accident_image.t_AccidentImageResponseEx AccidentImageResponse := TRANSFORM
				SELF.response.ImageData := DeltabaseResponse[1].Blob; //response contains only one latest image
				SELF := [];
			END;
			
			RETURN DATASET([AccidentImageResponse]);
		END;
		
	 EXPORT SubscriptionNonAssociatedGroupedReports(dataset(iesp.ecrash.t_ECrashSearchRecord) in_recs) := FUNCTION
	
		iesp.ecrash.t_ECrashSearchRecord final_xform(iesp.ecrash.t_ECrashSearchRecord l):= TRANSFORM
			SELF.Reports := project(dataset(l),TRANSFORM(iesp.ecrash.t_ECrashSearchRecordData, SELF:=LEFT,SELF:=[]));
			SELF.DateOfLoss.Year := l.DateOfLoss.Year;
			SELF.DateOfLoss.Month := l.DateOfLoss.Month;
			SELF.DateOfLoss.Day := l.DateOfLoss.Day;
			SELF := [];
		END;
		
		return project(in_recs,final_xform(left));
	END;
	
	EXPORT PreferDriverRecords(DATASET(eCrash_Services.Layouts.recs_with_penalty) InRecords) := FUNCTION
		
			RecordsSorted := SORT(InRecords, 
					fname,
					lname,
					accident_date,
					jurisdiction_state,
					jurisdiction,
					//all the TM and TF reports have orig_accnbr and addl_report_number switched
					// DE's should be deduped by case_identifier
					IF(report_code = 'EA', orig_accnbr, addl_report_number),
					MAP (report_type_id = 'DE' => '',
					     report_code = 'EA' => addl_report_number,
							 orig_accnbr),//IF(report_code = 'EA', addl_report_number, orig_accnbr), 
					report_type_id,
					if (report_code = 'TM', 1, 0), //TM has the least priority
					-(UNSIGNED8)report_id,
					-isDelta,
					-date_added,
					 //DRIVER records have more information
					if(record_type = 'DRIVER', 0, 1),
					//preferring record with person that is assigned to a vehicle because sometimes we might not have vehicle.unit_number keyed in and in that case
					//we will be assigning vehicle without unit_number to every single person in the report (even to a person that is properly assigned to a vehicle) 
					//and we might end up with several records with the same person where one of them has vehicle's unit_number populated and another one don't. In that
					//case we need to prefer person with assigned vehicle number.
					IF(vehicle_unit_number <> '' AND vehicle_unit_number = unit_number, 0, 1) 
				);
				
			RETURN DEDUP(
				RecordsSorted,
				fname,
				lname,
				accident_date,
				jurisdiction_state,
				jurisdiction,
				IF(report_code = 'EA', orig_accnbr, addl_report_number),
				MAP (report_type_id = 'DE' => '',
						 report_code = 'EA' => addl_report_number,
						 orig_accnbr),//
				report_type_id
			); 
			
		END;	
		
		EXPORT dedupReportRecordsFromParties(DATASET(eCrash_Services.Layouts.recs_with_penalty) recs) := FUNCTION
			result := DEDUP(
									SORT(
										recs,
	                  -(UNSIGNED8)report_id,
										accident_date,
										report_code,
										jurisdiction,
										jurisdiction_state,
										IF(report_code = 'EA', orig_accnbr, addl_report_number),
										MAP (report_type_id = 'DE' => '',
												 report_code = 'EA' => addl_report_number,
												 orig_accnbr
										),
										report_type_id,
										if (report_code = 'TM', 1, 0) //TM has the least priority
									),
									report_id, 
									accident_date,
									report_code,
									jurisdiction,
									jurisdiction_state,
									IF(report_code = 'EA', orig_accnbr, addl_report_number),
									MAP (report_type_id = 'DE' => '',
											 report_code = 'EA' => addl_report_number,
											 orig_accnbr
									),
									report_type_id
								);	
			return result;
		END;
		
		EXPORT BOOLEAN isTokenInString(STRING TokenStr, STRING ValueStr, STRING SeparatorStr = ' ') := FUNCTION
		  ValueStrLower := Std.Str.ToUpperCase(ValueStr);
			Tokens := Std.Str.SplitWords(Std.Str.ToUpperCase(TokenStr), SeparatorStr);
			
			RETURN ValueStrLower IN Tokens;
		END;
				
  	EXPORT eCrash_Services.Layouts.GetSupplementalsResult getSupplementalsDeltabase(
			STRING RequestReportId,
			DATASET(RECORDOF(FLAccidents_Ecrash.Key_eCrashv2_Supplemental)) ReportHashKeysFromKey,
			eCrash_Services.IParam.searchrecords InModuleDeltaBase
		) := FUNCTION
				
		//Filtering out TMs from the mix because we were having problems where TM were sent to HPCC before TF/EA but it would have greater report_id (caused by migration of TMs to incident table). 
		//We don't care about TMs if we have other sources in the mix.	
		NotTMrecs := ReportHashKeysFromKey(report_code != 'TM');
		ReportHashKeysFromKeyTMFiltered := IF(EXISTS(NotTMrecs), NotTMrecs, ReportHashKeysFromKey);				
				
		/*
		In the ReportHashKeysFromKey all the records have the same 
		accident_nbr, jurisdiction_state, jurisdiction, accident_date and orig_accnbr fields
		because those are the fields that identify supplimentals (except for TM reports: they have accident_nbr and orig_accnbr switched).
		We need to get the last one here because it will lead us to the latest report in the payload 
		(if payload for example have TF and EA then we need to get the latest one because we will be comparing it to the reports from the deltabase).
		*/
		LastReportHashKeysFromKey := TOPN(ReportHashKeysFromKeyTMFiltered, 1, -(UNSIGNED)report_id);
	
		ReportPayloadRow := JOIN(
			LastReportHashKeysFromKey,
			FLAccidents_Ecrash.key_EcrashV2_accnbrv1,
			KEYED(
				LEFT.accident_nbr = RIGHT.l_accnbr AND
				LEFT.report_code = RIGHT.report_code AND 
				LEFT.jurisdiction_state = RIGHT.jurisdiction_state AND
				LEFT.jurisdiction = RIGHT.jurisdiction 
			) AND 
			LEFT.accident_date = RIGHT.accident_date AND 
			LEFT.orig_accnbr = RIGHT.orig_accnbr AND
			LEFT.report_type_id = RIGHT.report_type_id,	
			TRANSFORM(
				eCrash_Services.Layouts.eCrashRecordStructure,
				SELF := RIGHT;
			),
			LIMIT(eCrash_Services.constants.MAX_REPORT_NUMBER, FAIL(203, doxie.ErrorCodes(203)))
		);	

		DeltaBaseService := DeltaBaseSoapCall(InModuleDeltaBase);
		DeltaBaseSql := RawDeltaBaseSQL(InModuleDeltaBase);				
		
		DeltaBaseDateAddedRaw := FLAccidents_Ecrash.Key_eCrashV2_DeltaDate(delta_text = 'DELTADATE');
		DeltaBaseDateAdded := ut.date_math(DeltaBaseDateAddedRaw[1].date_added[1..8], -1);
		DeltaBaseDateAddedSql := DeltaBaseSql.dateFormatted(DeltaBaseDateAdded);
		DeltabaseReportSelectSql := DeltaBaseSql.GetImageRetrievalSqlByReportId(TRIM(RequestReportId), DeltaBaseDateAddedSql);

		EmptyReportDeltabaseRow := DATASET([],eCrash_Services.Layouts.eCrashRecordStructure);
		ReportDeltabaseRow := IF(
			EXISTS(ReportHashKeysFromKey), 
			EmptyReportDeltabaseRow, 
			OwnerDriverDedup(DeltaBaseService.GetReportData(DeltabaseReportSelectSql))
		);
			
		SuperReportRow := IF(EXISTS(ReportHashKeysFromKey), ReportPayloadRow, ReportDeltabaseRow);
		//if we don't have request report id in the key, but do have it in the deltabase then
		// we need to search keys for supplimentals for the report in deltabase
		
		//don't use JOIN here because it will return multiplication of rows and we don't need that. PayloadRowByDeltabase has to contain as many rows as many parties report has.
		//all the records in the ReportDeltabaseRow have the same fields l_accnbr, report_code, etc (fiels we filter by) and that's why we use the first row from it.
		PayloadRowByDeltabaseRaw := LIMIT(
			FLAccidents_Ecrash.key_EcrashV2_accnbrv1(
				KEYED(
					l_accnbr = ReportDeltabaseRow[1].l_accnbr AND
					//report_code IN ReportCodeDeltabase AND    //WE NEED to comment this out because if for example we found
						// TF in the deltabase then we don't want to miss EA in the payload because we will be looking for supplements in the deltabase by this payload record
					jurisdiction_state = ReportDeltabaseRow[1].jurisdiction_state AND
					jurisdiction = ReportDeltabaseRow[1].jurisdiction
				) AND 
				WILD(report_code) AND
				accident_date = ReportDeltabaseRow[1].accident_date AND 
				orig_accnbr = ReportDeltabaseRow[1].orig_accnbr	AND
				report_type_id = ReportDeltabaseRow[1].report_type_id
			),
			eCrash_Services.constants.MAX_REPORT_NUMBER,
			FAIL(203, doxie.ErrorCodes(203))
		);	
		PayloadRowByDeltabase := PROJECT(PayloadRowByDeltabaseRaw, eCrash_Services.Layouts.eCrashRecordStructure);

		ReportHashKeysFromKeyFinal := IF(
			EXISTS(ReportHashKeysFromKey),
			ReportHashKeysFromKey,
			IF(
				LENGTH(TRIM(PayloadRowByDeltabase[1].super_report_id)) > 0,
				LIMIT(
					FLAccidents_Ecrash.Key_eCrashv2_Supplemental(
						super_report_id = PayloadRowByDeltabase[1].super_report_id
					),
					eCrash_Services.constants.MAX_REPORT_NUMBER,
					FAIL(203, doxie.ErrorCodes(203))
				)	
			)	
		);

		//searching the Deltabase with parameters (data fields) that we get from the payload
		//We can search deltabase by using case_identifier or state_report_number against case_identifier field,
		//because for every report with case_identifer != '' we have duplicate report where state_report_number gets copied over case_identifier
		//and even if case_identifer == '' then state_report_number also gets copied over case_identifier
		DeltaBaseSqlString := DeltaBaseSql.GetImageRetrievalSql(SuperReportRow[1], '', DeltaBaseDateAddedSql);
		ReportDeltabase := IF(DeltaBaseSqlString != ''
			AND	SuperReportRow[1].jurisdiction_nbr != ''
			AND	SuperReportRow[1].jurisdiction_state != ''
			AND SuperReportRow[1].accident_date != '', 
			DeltaBaseService.LookupIncidentPersons(DeltaBaseSqlString),
			DATASET([], eCrash_Services.Layouts.eCrashRecordStructure)
		);

		ReportDeltabaseDriverOwnerDeduped := OwnerDriverDedup(ReportDeltabase);
		ReportsAllRaw := PayloadRowByDeltabase + SuperReportRow + ReportDeltabaseDriverOwnerDeduped;
				
		IsEATFExist := EXISTS(ReportsAllRaw(report_code IN ['EA', 'TF'] AND is_deleted = 0));
		//Removing TMs from the mix if we have not deleted reports of other types present
		ReportsAll := IF(IsEATFExist, ReportsAllRaw(report_code != 'TM'), ReportsAllRaw);
		
		LastReport := TOPN(ReportsAll, 1, -(UNSIGNED)report_id);
		ReportsAllRefined := CASE(
			LastReport[1].report_code,
				'TF' => LastReport,
				'EA' => ReportsAll(report_code = 'EA'),
				ReportsAll
		);
		ReportsAllDeduped := SupplementRollupTransform(ReportsAllRefined);

		//If LastReport is TF or TM then we have to make ReportHashKeyesFromKeyForDedup empty because we only have to consider the latest reports,
		//which is payload or deltabase reports (ReportsAllDedupedSlim),
		//If LastReport is EA then we have to leave only EA in ReportHashKeyesFromKeyForDedup;
		ReportHashKeyesFromKeyForDedup := IF(
			LastReport[1].report_code = 'EA',
			ReportHashKeysFromKeyFinal(report_code = 'EA' and report_id != ReportPayloadRow[1].report_id) //we need to remove payload report 
		//from ReportHashKeysFromKeyFinal because it exists in ReportsAllDedupedSlim and if it was deduped
		//from ReportsAllDeduped (superseded by report from deltabase) then it has to be gone from the result
		);
		
		//Start: filtering out records with is_deleted = 1 
		ReportsAllDedupedWithDeleted := PROJECT(
			ReportsAllDeduped, 
			TRANSFORM(
				eCrash_Services.Layouts.recs_with_penalty, 
				SELF := LEFT; 
				SELF := [];
			)
		);
	
		ReportHashKeyesFromKeyForDedupWithDeleted := PROJECT(
			ReportHashKeyesFromKeyForDedup, 
			TRANSFORM(
				eCrash_Services.Layouts.recs_with_penalty, 
				SELF.image_hash := LEFT.hash_key;
				SELF := LEFT; 
				SELF := [];
			)	
		);
		
		ReportsAllWithDeleted := ReportsAllDedupedWithDeleted + ReportHashKeyesFromKeyForDedupWithDeleted;
		ReportsAllWithoutDeleted := FilterOutDeletedReports(ReportsAllWithDeleted);
		
		ReportsAllSlim := PROJECT(
			ReportsAllWithoutDeleted, 
			TRANSFORM(
				RECORDOF(ReportHashKeysFromKey),
				SELF.hash_key := LEFT.image_hash;
				SELF := LEFT; 
				SELF := [];
			)
		);
		//End: filtering out records with is_deleted = 1 
		
		RETURN ROW({
			ReportHashKeysFromKeyFinal, 
			IF (
				COUNT(ReportsAllWithoutDeleted) > 0, 
				SuperReportRow
			), 
			ReportsAll,
			ReportsAllSlim
		}, eCrash_Services.Layouts.GetSupplementalsResult);
		
	END;
			
	//Returns the same result type as getSupplementalsDeltabase() except return datasets don't contain reports from deltabase.
  EXPORT eCrash_Services.Layouts.GetSupplementalsResult getSupplementalsBypassDeltabase(
			DATASET(RECORDOF(FLAccidents_Ecrash.Key_eCrashv2_Supplemental)) ReportHashKeysFromKey
		) := FUNCTION			

		LastReport := TOPN(ReportHashKeysFromKey, 1, -(UNSIGNED)report_id);

		ReportHashKeyesFromKeyForDedup := CASE(
			LastReport[1].report_code,
				'TF' => LastReport,
				'EA' => ReportHashKeysFromKey(report_code = 'EA'),
				ReportHashKeysFromKey
		);		

		ReportsAll := PROJECT(
			ReportHashKeysFromKey, 
			TRANSFORM(
				eCrash_Services.Layouts.eCrashRecordStructure,
				SELF := LEFT; 
				SELF := [];
			)
		);

		RETURN ROW({
			ReportHashKeysFromKey, 
			ReportsAll,//this is used as SuperReportRow and ReportsAll in the underlying code
			DATASET([], eCrash_Services.Layouts.eCrashRecordStructure),
			ReportHashKeyesFromKeyForDedup
		}, eCrash_Services.Layouts.GetSupplementalsResult);
		END;	
		
		EXPORT SortFinalResults (dataset(iesp.ecrash.t_ECrashSearchRecord) in_recs, eCrash_Services.IParam.searchrecords in_mod):=FUNCTION
		
			search_record_with_primaryAgency := RECORD
					iesp.ecrash.t_ECrashSearchRecord;
					integer SortOrder;
			END;
						
			result_recs_joined := JOIN(in_recs, in_mod.agencies, (left.JurisdictionState = right.JurisdictionState or right.JurisdictionState = '')and
																													 (left.Jurisdiction = right.Jurisdiction or right.Jurisdiction = '') and
																													 (left.AgencyId = right.AgencyId or right.AgencyId ='') and
																													 (left.AgencyORI = right.AgencyORI or right.AgencyORI = ''),
																														TRANSFORM(search_record_with_primaryAgency, 
																																// self.PrimaryAgency := right.PrimaryAgency;
																																self.SortOrder := IF(right.PrimaryAgency <> TRUE, 1, 0);
																																// self.ResultType		 := IF(left.ResultType = constants.DIRECT_hit AND right.PrimaryAgency,
																																													// left.ResultType, constants.POSSIBLE_hit);
																																self := left;), LEFT OUTER, ALL);
																								
      result_recs_sorted := SORT(result_recs_joined, SortOrder, -DateOfLoss);
			results_filtered   := CHOOSEN(result_recs_sorted,iesp.constants.eCrashMod.MaxRecords);
			result_recs 			 := PROJECT(results_filtered, TRANSFORM(iesp.ecrash.t_ECrashSearchRecord,
																															self:=left;), ORDERED(TRUE));
																															
			
			RETURN result_recs;
		END;
		
		EXPORT GetAgencySearchDs (IParam.searchrecords in_mod):=FUNCTION
		
			searchDs    := PROJECT(in_mod.agencies, transform(eCrash_Services.Layouts.SearchParameters, 
																														self.vin := in_mod.VehicleVin;
																														self.DriversLicenseNum := in_mod.driversLicenseNumber;
																														self.OfficerBadge := in_mod.OfficerBadgeNumber;
																														self.LicensePlate := in_mod.LicensePlate;
																														self.CrossStreet := in_mod.AccidentLocationCrossStreet;
																														self.LocStreet := in_mod.AccidentLocationStreet;
																														self.start_date := in_mod.DolStartdate;
																														self.end_date := in_mod.DolEnddate;
																														self := left;));
																															
			
			RETURN searchDs;
		END;

END;