import doxie, RiskWiseFCRA, Watercraft, FCRA, LiensV2, riskwise, ut, Risk_Indicators, BankruptcyV2, BankruptcyV3,
				american_student_list, AlloyMedia_student_list, Prof_LicenseV2, paw, impulse_email, ln_propertyv2, 
				header, Inquiry_AccLogs, Gong, advo, Codes, iesp, address, corrections, Consumerstatement,
				Address, RiskView, suppress, LN_PropertyV2_Services, iesp, SexOffender, FAA, doxie;

EXPORT Search_RptData := MODULE

	SHARED MAX_OVERRIDE_LIMIT := FCRA.compliance.MAX_OVERRIDE_LIMIT;
	SHARED todaysdate := ut.GetDate;
	SHARED isFCRA := true;

	export historydate(d) := if( d >= 999999, ut.getDate, (string)(d) + '01');
	
// ------------- Utility functions esdlName esdlAddress provide consistent handling for these ESDL structures -------------
	export iesp.share.t_name esdlName(string62 Fullname, string20 fname, string20 mname, string20 lname, string5 suffix, string3 prefix) := FUNCTION

		parts := lname <> '';
		useFull := Fullname <> '' and not parts;
		
		allname := if( parts, TRIM(fname) + ' ' + TRIM(mname) + ' ' + TRIM(lname) + ' ' + TRIM(Suffix), Fullname);
		parseAll := if( useFull, Address.CleanPersonFML73(allname), '');
		
		p_fname := if( useFull, TRIM(parseAll[6..25]), fname);
		p_mname := if( useFull, TRIM(parseAll[26..45]), mname);
		p_lname := if( useFull, TRIM(parseAll[46..65]), lname);
		p_sname := if( useFull, TRIM(parseAll[66..70]), suffix);
		p_pname := if( useFull, TRIM(parseAll[1..5]), prefix);
		
		res := ROW({allname, p_fname, p_mname, p_lname, p_sname, p_pname}, iesp.share.t_name);	
		return res;
	END;

	export iesp.share.t_address esdlAddress(string10 prim_range, string2 predir, string28 prim_name, string4 addr_suffix, 
																					string2 postdir, string10 unit_desig, string8 sec_range, string60 street1, 
																					string60 street2, string25 city_name, string2 st, string5 zip5, string4 zip4, 
																					string18 county, string9 postalcode, string50 statecityzip) := FUNCTION
		parts := prim_name <> '';
		useFull := street1 <> '' and not parts;
		
		makeFull := TRIM(prim_range) + ' ' + TRIM(predir) + ' ' + TRIM(prim_name) + ' ' + TRIM(addr_suffix) + ' ' + TRIM(postdir) + ' ' + TRIM(unit_desig) + ' ' + TRIM(sec_range);
		
		p_street1 := if( street1='', makeFull, street1);
		p_street2 := if( street1='', '', street2);
		
		resNoClean := ROW( {prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range, p_street1, p_street2, city_name, st, zip5, zip4, county, postalcode, statecityzip}, iesp.share.t_address);
		clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(street1, city_name, st, zip5, street2);
		resCleaned := ROW( {clean_a2[1..10], clean_a2[11..12], clean_a2[13..40], clean_a2[41..44], clean_a2[45..46], clean_a2[47..56], clean_a2[57..64], street1, street2, clean_a2[90..114], clean_a2[115..116], clean_a2[117..121], clean_a2[122..125], '','',''}, iesp.share.t_address);

		res := if( useFull, resCleaned, resNoClean);

		return res;
	END;
	
// ------------- SexOffender -------------
	export sexOffenderRecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
			res := RiskWiseFCRA._SO_data (dids, flag_file);
			so_main_recs := res.so_main;
			spk_Key := SexOffender.key_SexOffender_SPK(true);
			
			so_layout2 := record
				recordof(spk_Key);
				dataset(iesp.share.t_Name) Aliases1;
				iesp.share.t_Name Names1;
			end;

			//get the primary name information for later
			so_primaries := project(so_main_recs(name_type = '0'), transform(so_layout2, 
				self.Names1 := esdlName('', left.fname, left.mname, left.lname, left.name_suffix, '');
				self := left,
				self := []));	
			//get the alias information ready for rollup		
			so_aliases := project(so_main_recs(name_type = '2'), transform(so_layout2, 
				self.Aliases1 := esdlName('', left.fname,left.mname,left.lname, left.name_suffix, '');
				self := left,
				self := []));	
				
			lay_so_aliases := record
				dataset(iesp.share.t_Name) Aliases1;
				spk_Key.sspk;
			end;
			
			//get the alias and put together in a dataset	
			lay_so_aliases dorolls(lay_so_aliases l, lay_so_aliases r)	:= transform
				self.aliases1 := l.aliases1 + r.aliases1;
				self.sspk := r.sspk;	
				self := r;			
			end;

			aliases := project(so_aliases, transform(lay_so_aliases,
				self.aliases1 := left.aliases1;
				self.sspk := left.sspk));

			aliases_sorted := sort(aliases, sspk);

			aliases_roll := rollup(aliases_sorted, dorolls(LEFT, RIGHT), sspk);
			//add the aliases back to the offender information and primary information
			so_final := join(so_primaries, aliases_roll,
				left.sspk = right.sspk,
					transform(so_layout2, self.aliases1 := right.aliases1,
						self := left,
						self := []),
				left outer);
				
			return so_final;
	END;

	// -------------  CRIMINAL RECS  -------------
	export criminalrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
			
			result_layout := record
				Corrections.layout_offender offender;
				Corrections.Layout_Offense_Common offense;
			end;

			res := RiskWiseFCRA._crim_data(dids, flag_file);
			
			offr := project(res.offenders, TRANSFORM( result_layout, self.offender := left, self := []));
			
			result_layout2 := record
					Corrections.layout_offender offender;
					Corrections.Layout_Offense_Common offense;
					dataset(iesp.share.t_Name) Aliases1;
					iesp.share.t_Name Names1;
			end;
			//get the primary name information for later
			crim_primaries := project(offr(offender.pty_typ = '0'), transform(result_layout2, 
				self.Names1 := esdlName(left.offender.pty_nm, 
										 left.offender.fname, left.offender.mname, left.offender.lname, '', '');
				self := left,
				self := []));	
			//get the alias information ready for rollup		
			crim_aliases := project(offr(offender.pty_typ = '2'), transform(result_layout2, 
				self.Aliases1 := esdlName(left.offender.pty_nm, 
										 left.offender.fname, left.offender.mname, left.offender.lname, '', '');
				self := left,
				self := []));	
				
			lay_crim_aliases := record
				dataset(iesp.share.t_Name) Aliases1;
				Corrections.layout_offender.offender_key;
				Corrections.layout_offender.id_num;
				Corrections.layout_offender.case_num;
			end;
			//get the alias and put together in a dataset	
			lay_crim_aliases dorolls(lay_crim_aliases l, lay_crim_aliases r)	:= transform
				self.aliases1 := l.aliases1 + r.aliases1;
				self.offender_key := r.offender_key;
				self.id_num := r.id_num;
				self.case_num := r.case_num;				
				self := r;			
			end;

			aliases := project(crim_aliases, transform(lay_crim_aliases,
				self.aliases1 := left.aliases1;
				self.offender_key := left.offender.offender_key;
				self.id_num := left.offender.id_num;
				self.case_num := left.offender.case_num));

			aliases_sorted := sort(aliases, offender_key,
									id_num, case_num);

			aliases_roll := rollup(aliases_sorted, dorolls(LEFT, RIGHT), offender_key,
									id_num, case_num);
			//add the aliases back to the offender information and primary information
			crim_offenders := join(crim_primaries, aliases_roll,
				left.offender.offender_key = right.offender_key and
				left.offender.id_num = right.id_num and
				left.offender.case_num= right.case_num,
					transform(result_layout2, self.aliases1 := right.aliases1,
						self := left,
						self := []),
				left outer);
			
		 both := join(crim_offenders, res.offenses, 
						left.offender.offender_key = right.offender_key, 
					 TRANSFORM( result_layout2, self.offender := left.offender, self.offense := right, self := left),
					LEFT OUTER, KEEP(1)); // disclosures only show one of the offenses per offender record.
	return  both;		
	END;

	// ------------- Student Records -------------
	export americanstudentrecs(dataset (doxie.layout_references) dids, 
			dataset (fcra.Layout_override_flag) flag_file) := FUNCTION

			student_ffids := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT), flag_file_id );
			student_keys  := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT), record_id );
			student_corr  := CHOOSEN(FCRA.key_override_student_new_ffid( keyed( flag_file_id in student_ffids ) ), MAX_OVERRIDE_LIMIT );

			layouts.Layout_AmStudent amstudent_tx(dids l, american_student_list.key_DID_FCRA r) := TRANSFORM															
				self.type_exploded := map( r.college_type = 'R' => Constants.Private_schl,
																	 r.college_type = 'P' => Constants.Private_schl,
																	 Constants.Public_schl);
				//college_code_exploded is two year college, four year college, graduate school
				self.code_exploded := r.college_code_exploded;
				self := r;
			END;
			keyDID_fcra := american_student_list.key_DID_FCRA;
		  student_main := join(dids, keyDID_fcra,
				left.did<>0 and keyed(left.did=right.l_did) and (string)right.key not in student_keys,
				amstudent_tx(left, right),
				KEEP(100), atmost(riskwise.max_atmost) 
			);
			student_deduped := dedup(sort(student_main,record),record);

			all_student_recs  := student_deduped + PROJECT( student_corr,
					transform( layouts.Layout_AmStudent,
						self.l_did := left.did,
						self := LEFT,
						self := []
					) );

			// this transform taken from risk_indicators.boca_shell_student_fcra. rollup all ASL records to the same record we would use in production
			all_student_recs asl_roll( all_student_recs le, all_student_recs ri ) := TRANSFORM
					self := map(
						// Use any other record over File Type 'M'
						le.file_type='M' and ri.file_type<>'M' => ri,
						ri.file_type='M' and le.file_type<>'M'=> le,						
					
						// current ASL over historical -- SRC BECOMES HISTORICAL_FLAG
						le.historical_flag='C' and ri.historical_flag='H' => le,
						le.historical_flag='H' and ri.historical_flag='C' => ri,

						// take the newer record when the DLS are unequal
						le.date_last_seen > ri.date_last_seen => le,
						le.date_last_seen < ri.date_last_seen => ri,

						// take american student over alloy -- NOT APPLICABLE HERE SINCE IT'S ALL ASL
						le.historical_flag in ['C','H'] and ri.historical_flag = 'A' => le,
						ri.historical_flag in ['C','H'] and le.historical_flag = 'A' => ri,

						//take the newer record when the DFS are unequal
						le.date_first_seen > ri.date_first_seen => le,
						le.date_first_seen < ri.date_first_seen => ri,

						le
					);
				END;
			student_recs1 := rollup( all_student_recs, true, asl_roll(left,right) );
			student_recs2 := join(student_recs1, Codes.Key_Codes_V3,  
															left.college_major<>'' and 
															keyed(right.file_name='AMERICAN_STUDENT_LIST') and 
															keyed(right.field_name='COLLEGE_MAJOR') and
															keyed(right.field_name2='') and
															keyed(left.college_major = right.code),
															transform(layouts.Layout_AmStudent, 
																				self.college_major_exploded := right.long_desc,
																				self := left),
															left outer, keep(1));   
			student_recs_filtered := student_recs2(file_type in ['A','H','C'] OR //Rqmt: 1.10.2.c
														(file_type='M' and (college_code <>'' or //Rqmt: 1.10.2.a
														tier2 <>'' or college_major<>'')) OR
														(file_type ='' and (college_code <>'' or //Rqmt: 1.10.2.b
														tier2 <>'' or college_major<>'' or
														class <>'' or income_level_code<>'')));
			student_recs := sort(student_recs_filtered, -date_last_Seen, -date_first_Seen);			
			return student_recs;
	END;
					
	export alloystudentrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION

			alloy_ffids := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT_ALLOY), flag_file_id );
			alloy_keys  := SET(flag_file(file_id = FCRA.FILE_ID.STUDENT_ALLOY), record_id );
			alloy_corr  := CHOOSEN(FCRA.key_override_alloy_ffid( keyed( flag_file_id in alloy_ffids ) ), MAX_OVERRIDE_LIMIT );


			// from david lenz:
			// The records are normalized since a raw record can contain multiple addresses.  So, a unique identifier would
			// be sequence_number + key_code + rawaid. You will notice that if you look at all of the fields in that record
			// that they are actually the same except for the standardized/clean fields.

			// string7   sequence_number;
			// string15  key_code;
			// unsigned8 rawaid; // string20?

			alloy_main := join(dids, AlloyMedia_student_list.Key_DID_FCRA,
				left.did<>0
					and keyed(left.did=right.did)
					and ( TRIM(right.sequence_number) + TRIM(right.key_code) + (string)right.rawaid ) not in alloy_keys
					,
				transform(Layouts.Layout_Alloy, self := right ),
				KEEP(100), atmost(riskwise.max_atmost) 
			);
			alloy_deduped := dedup(sort(alloy_main,record),all);

			alloy_recs1  := alloy_deduped + PROJECT( alloy_corr, transform(Layouts.Layout_alloy, self := left, self := []) );
			
			alloy_recs2 := join(alloy_recs1, Codes.Key_Codes_V3,  
															left.major_code<>'' and 
															keyed(right.file_name='ALLOY_STUDENT_LIST') and 
															keyed(right.field_name='MAJOR_CODE') and
															keyed(right.field_name2='') and
															keyed(left.major_code = right.code),
															transform(Layouts.Layout_Alloy, 
																				self.college_major_exploded := right.long_desc,
																				self := left),
															left outer, keep(1));   
			Layouts.Layout_Alloy Code_Type(Layouts.Layout_Alloy l) := TRANSFORM
				self.type_exploded := map( l.public_private_code = '1' => Constants.Public_schl,
																	 l.public_private_code = '2' => Constants.Private_schl,
																	''); 
				self.code_exploded := map( l.public_private_code = '1' => Constants.FourYr_schl,
																	 l.public_private_code = '2' => Constants.FourYr_schl,
																	 l.public_private_code = '3' => Constants.TwoYr_schl,
																	 '');
				self := l;
			END;
			alloy_recs3 := project(alloy_recs2, Code_Type(left));
			alloy_recs_filtered := alloy_recs3(file_type in ['A','H','C'] OR //Rqmt: 1.10.2.c
														file_type='M' and (public_private_code <>'' or //Rqmt: 1.10.2.a
														tier2 <>'' or major_code <>'') OR
														file_type='' and (public_private_code <>'' or //Rqmt: 1.10.2.b
														tier2 <>'' or major_code <>'' or
														class_rank <>''));
			alloy_recs := sort(alloy_recs_filtered, -date_last_seen, -date_first_seen);		
		return alloy_recs;
	END;

// ------------- Inquiries -------------
	// need to filter inqiries return with data restriction mask field 16... AutoStandardI.DataRestrictionI
	// we will do this in the calling routine, so as not to disturb the current inquiry code...
	// this returns them all, they should be filtered more by the caller.
	export inquiryrecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
		inquiry_recs := RiskWiseFCRA._inquiries_data(project(dids, TRANSFORM(doxie.layout_references, self:=left)), flag_file);
		return inquiry_recs;
	END;


	// ------------- impulse -------------
	export impulserecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file,
				boolean isDirectToConsumerPurpose = false) := FUNCTION

		impulse_ffids := SET(flag_file(file_id = FCRA.FILE_ID.IMPULSE), flag_file_id );
		impulse_keys  := SET(flag_file(file_id = FCRA.FILE_ID.IMPULSE), trim(record_id) );
		impulse_corr  := CHOOSEN(FCRA.key_override_impulse_ffid( keyed( flag_file_id in impulse_ffids ) ), MAX_OVERRIDE_LIMIT );
		impulse_main := join(dids,Impulse_Email.Key_Impulse_DID_FCRA,
														left.did<>0 and keyed(left.did=right.did) and 
														trim((string)right.did)+trim(right.created) not in impulse_keys and // created and last modified should be 8 byte (20100215)										
								isDirectToConsumerPurpose = false, //can't return data if this is enabled
														transform( Layouts.layout_impulse, self := right ),
														KEEP(100), atmost(riskwise.max_atmost) 
													);
		impulse_deduped := dedup(sort(impulse_main,record),all);
		impulse_recs1 := impulse_deduped + 
												PROJECT( impulse_corr(isDirectToConsumerPurpose = false),
														transform( Layouts.Layout_Impulse,
															self := LEFT,
															self := []
														) );
		impulse_recs := sort(impulse_recs1, -DateVendorLastReported, -DateVendorFirstReported);	
				
		return impulse_recs;
	END;

	// ------------- thrive -------------
	// after 9/24 _thrive_date only returns 'T$' records, no need to filter later
	export thriverecs(dataset (doxie.layout_references) dids, dataset (fcra.Layout_override_flag) flag_file) := FUNCTION
		thrive_recs := RiskWiseFCRA._thrive_data(dids, flag_file);
		return thrive_recs;
	END;

  // ------------- property ------------
	export propertyrecs(dataset (risk_indicators.Layout_Boca_Shell) bs,
			string50 DataRestrictionMask
			) := FUNCTION

	//start property prep
	in_mod_property := MODULE(LN_PropertyV2_Services.interfaces.Iinput_report)		
			SHARED LN_PropertyV2_Services.interfaces.layout_entity buildEntity1() :=
				TRANSFORM
					SELF.firstname        := bs[1].shell_Input.fname;
					SELF.middlename       := bs[1].shell_Input.mname;
					SELF.lastname         := bs[1].shell_Input.lname;
					SELF.unparsedfullname := '';
					SELF.allownicknames   := FALSE;
					SELF.phoneticmatch    := FALSE;
					SELF.companyname      := '';
					SELF.addr             := bs[1].shell_Input.in_streetAddress;
					SELF.sec_range        := bs[1].shell_Input.sec_range;
					SELF.city             := bs[1].shell_Input.p_city_name;
					SELF.state            := bs[1].shell_Input.st;
					SELF.zip              := bs[1].shell_Input.z5;
					SELF.zipradius        := 0;
					SELF.county           := '';
					SELF.phone            := bs[1].shell_Input.p_city_name;
					SELF.fein             := '';
					SELF.bdid             := '';
					SELF.did              := (string) bs[1].shell_Input.did;
					SELF.ssn              := bs[1].shell_Input.ssn;
				END;		
		
		//property settings
		// Option fields: set each to its default value unless present here in getAllBocaShellData.
		EXPORT faresID                 := '';
		// Data restrictions
		EXPORT data_restriction_mask   := DataRestrictionMask;
		EXPORT srcRestrict             := []; // We'll do restrictions in Boca_Shell_Property_Common
		EXPORT currentVend             := FALSE;
		EXPORT currentOnly             := FALSE;
		EXPORT robustnessScoreSorting  := FALSE;
		EXPORT ssn_mask_value          := 'NONE';
		EXPORT application_type_value  := '';
		EXPORT set_AddressFilters      := ALL;
		EXPORT paSearch                := FALSE;
		// Tuning
		EXPORT DisplayMatchedParty_val := FALSE; 
		EXPORT pThresh                 := 10;
		EXPORT lookupVal               := '';
		EXPORT partyType               := '';
		EXPORT incDetails              := FALSE;
		EXPORT TwoPartySearch          := FALSE;
		EXPORT xadl2_weight_threshold_value	:= 0;
		// For penalization
		EXPORT entity1 := ROW(buildEntity1());
		EXPORT entity2 := ROW([],LN_PropertyV2_Services.interfaces.layout_entity);
	END;
//end property prep	
	//put in Risk_Indicators.layout_PropertyRecord
		bs_ungrouped := PROJECT(bs, 
			TRANSFORM(Risk_Indicators.layout_PropertyRecord, 
				SELF.seq := LEFT.seq,
				SELF.did := LEFT.did,
				SELF.HistoryDate := LEFT.historyDate, //reliant on these fields for property so defining rather than assuming
				SELF.fname := LEFT.shell_Input.fname,
				SELF.lname := LEFT.shell_Input.lname,			
				self.prim_range := left.shell_input.prim_range,
				self.predir := left.shell_input.predir,
				self.prim_name := left.shell_input.prim_name,
				self.addr_suffix := left.shell_input.addr_suffix,
				self.unit_desig := left.shell_input.unit_desig,
				self.sec_range := left.shell_input.sec_range,
				self.city_name := left.shell_input.p_city_name,
				self.st := left.shell_input.st,
				self.zip5 := left.shell_input.z5,		
				self := LEFT, SELF := []));
		//put in Layout_Boca_Shell_ids 
		grpd_address := GROUP(SORT(bs_ungrouped, seq), seq);
		ids := PROJECT(bs_ungrouped, TRANSFORM(Risk_Indicators.Layout_Boca_Shell_ids, SELF := LEFT, SELF := []));
		grpd_ids :=  GROUP(SORT( ids, SEQ), SEQ);
		props := Risk_Indicators.Boca_Shell_Property_Common(grpd_address, grpd_ids, 
							FALSE,//includeRelatives
							TRUE, //filter_out_fares
							TRUE, //is_FCRA
							in_mod_property,
							FALSE //ViewDebugs
							); 	
		propsBydid := props(did=bs[1].did);
		props4did := propsBydid(property_status_applicant in ['S', 'O']);
		//output(props, named('props'));
	return props4did;
	end;
	
	// ------------- consumer statement -------------
	export consumerstmt(dataset (risk_indicators.Layout_Boca_Shell) dids) := FUNCTION
		
		layout_res := RECORD
				Unsigned8 LexID;
				String9  SSN;
				String20 fname;
				String20 lname;
				String2000 cs_text;
		END;
		
		bydid := join( dids, Consumerstatement.key.fcra.lexid, 
										left.did<>0 and
										KEYED(left.did = right.LexID), 
										TRANSFORM(layout_res, self:=right), 
										atmost(riskwise.max_atmost));
		byssn := join( dids, Consumerstatement.key.fcra.ssn, 
										left.shell_Input.ssn<>'' and
										KEYED(left.shell_Input.ssn = right.ssn) and
										datalib.NameMatch (Left.shell_Input.fname,  '',  Left.shell_Input.lname, 
                                        Right.fname, '', Right.lname) < 3, 
										TRANSFORM(layout_res, self:=right), 
										atmost(riskwise.max_atmost));											

    stmt := if(exists(bydid), bydid, byssn);
		return stmt;
	END;				
		
	export getAddrCharacteristics(dataset(Layouts.addrhist_layout) in_addr) := FUNCTION

		layout_working := RECORD
			Layouts.addrhist_layout;
			Risk_Indicators.Layouts.Layout_Addr_Flags Addr_Flags;
			string1 college_indicator;
		END;
			
		// search citystatezip for each address to get the corp/mil flag
		layout_working getZipFlag(Layouts.addrhist_layout le, riskwise.Key_CityStZip ri) := transform
			self.addr_flags.corpMil := if(ri.zipclass in ['U','M'], '1', '0');
			self := le;
			self := [];	// blank out the rest of the addr flags initially
		end;
		wZipClass := join(in_addr, riskwise.Key_CityStZip,	
																	keyed(right.zip5=left.zip) and left.zip!='',
																	getZipFlag(left, right), left outer, 
																	ATMOST(keyed(right.zip5=left.zip),RiskWise.max_atmost));
	
		layout_working zipRoll(layout_working le, layout_working ri) := transform
			self.addr_flags.corpMil := if(le.addr_flags.corpMil='1', '1', ri.addr_flags.corpMil);	
			self := le;
		end;
		wZipClassRoll := ROLLUP(SORT(wZipClass, groupId),left.groupId=right.groupId, zipRoll(left,right));

		// search HRI for each record to get prisonAddr and highRisk addr flags
		layout_working getHRIflags(layout_working le, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra ri) := transform
			self.addr_flags.prisonAddr := if(ri.sic_code='2225', '1', '0');
			self.addr_flags.highRisk := if(ri.sic_code<>'', '1', '0');
			self := le;
		end;
		wHRI := join(wZipClassRoll, risk_indicators.key_HRI_Address_To_SIC_filtered_fcra,  
												left.zip!='' and left.prim_name != '' and
												keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and 
												keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and 
												keyed(left.sec_range=right.sec_range), 
												// check date
												// and right.dt_first_seen < history_Date, // no history date filtering in this function currently, it's used in RiskWiseFCRA.FCRAData_Service only which doesn't support retro testing
												getHRIflags(left,right), left outer,
												ATMOST(keyed(left.zip=right.z5) and keyed(left.prim_name=right.prim_name) and keyed(left.suffix=right.suffix) and
														keyed(left.predir=right.predir) and keyed(left.postdir=right.postdir) and keyed(left.prim_range=right.prim_range) and
														keyed(left.sec_range=right.sec_range), RiskWise.max_atmost), keep(100));	
						
		layout_working hriRoll(layout_working le, layout_working ri) := transform
			self.addr_flags.prisonAddr := if(le.addr_flags.prisonAddr='1', '1', ri.addr_flags.prisonAddr);	
			self.addr_flags.highRisk := if(le.addr_flags.highRisk='1', '1', ri.addr_flags.highRisk); // == 1 transient or institutioinal
			self := le;
		end;
		wHRIRoll := ROLLUP(SORT(wHRI, groupId),left.groupId=right.groupId,hriRoll(left,right));

		// search advo for each record to get the advo flags
		layout_working getAdvoFlags(wHRIRoll le, Advo.Key_Addr1_FCRA ri) := transform
			self.addr_flags.doNotDeliver := ri.dnd_indicator;
			self.addr_flags.deliveryStatus := Map(ri.throw_back_indicator='Y' => 'T',	
																						ri.seasonal_delivery_indicator='E' => 'E', //seasonal
																						ri.seasonal_delivery_indicator='Y' => 'S', // seasonal
																						ri.address_vacancy_indicator='Y' => 'V',
																						'');
			self.addr_flags.addressType := Map(	ri.residential_or_business_ind = 'A' => 'A',
																					ri.residential_or_business_ind = 'B' => 'B',
																					ri.residential_or_business_ind = 'C' => 'C',
																					ri.residential_or_business_ind = 'D' => 'D',
																					'');
			self.addr_flags.dropIndicator := Map(	ri.drop_indicator = 'C' => 'C',	
																						ri.drop_indicator = 'Y' => 'Y',
																						ri.drop_indicator = 'N' => 'N',
																						ri.drop_indicator = '' => 'S',
																						'');
      self.college_indicator := ri.college_indicator;																						
			self := le;
		end;
		wAdvo  := join(wHRIRoll, Advo.Key_Addr1_FCRA,
				left.zip != '' and left.prim_range != '' and
				keyed(left.zip = right.zip) and
				keyed(left.prim_range = right.prim_range) and
				keyed(left.prim_name = right.prim_name) and
				keyed(left.suffix = right.addr_suffix) and
				keyed(left.predir = right.predir) and
				keyed(left.postdir = right.postdir) and
				keyed(left.sec_range = right.sec_range),
				getAdvoFlags(left, right), LEFT OUTER,
				KEEP(1), atmost(riskwise.max_atmost));


		Layouts.addrhist_layout add_characteristic(layout_working l) := TRANSFORM
			self.AddrCharacteristics := map( 
																			 l.zip4 = '' => Constants.InvalidAddr_char,
																			 l.addr_flags.prisonAddr = '1' => Constants.CorrInst_char,
																			 l.addr_flags.highRisk = '1' => Constants.TransInst_char,
																			 l.addr_flags.deliveryStatus ='C' => Constants.Seasonal_char,
																			 l.addr_flags.deliveryStatus ='S' => Constants.Seasonal_char,
																			 l.college_indicator = 'Y' => Constants.EdInst_char,
																			 l.addr_flags.deliveryStatus ='E' => Constants.EdInst_char,//this the same as ii.	ADVO season_delivery_indicator = 'E'
																			 l.standardized_land_use_code in ['1111','9103', '9204', '0118', 
																						'0656', '0680',  '0119', '9203'] => Constants.EdInst_char,
																			 ''); 
      self := l;
		END;
		return project(wAdvo, add_characteristic(left));
	END;
	
// ------------- address history2 -------------
	export addrHistory2(dataset (risk_indicators.Layout_Boca_Shell) dids, 
		dataset (fcra.Layout_override_flag) flagrecs, 
		integer bsVersion_in, string50 datarestriction, 
		dataset(Risk_Indicators.Layouts.Layout_Relat_Prop_Plus_BusInd) props) := FUNCTION
			unsigned2 MAX_PROP_KEEP  := 100;
			unsigned4 MAX_PROP_MATCH := 5000;		
			
			risk_indicators.Layout_Output toLO(risk_indicators.Layout_Boca_Shell l) := TRANSFORM
				
				SELF.header_correct_record_id       := SET(flagrecs(file_id = FCRA.FILE_ID.hdr),record_id);

				self := l;
				self := l.Shell_Input;
				self := [];
			END;
			
			prepped := group(sort(project( dids, toLO(left)), seq, did), seq, did);
	//for 5.0 changes					
			hdr1 := risk_indicators.iid_getHeader(prepped, 1, 1, true, false,bsVersion:=bsVersion_in);
			hdr_appd_addr_history := Risk_Indicators.iid_append_address_hierarchy(hdr1, true, bsVersion_in);//output in Risk_indicators.iid_constants.layout_outx
			hdr_with_addr_history := risk_indicators.Boca_Shell_Address_History(hdr_appd_addr_history, true, datarestriction);//input in Risk_indicators.iid_constants.layout_outx
	//end for 5.0 changes
	
		ug := ungroup(hdr_with_addr_history);
		Layouts.addrhist_layout ReformatAddr(risk_indicators.iid_constants.layout_outx l, integer c):= TRANSFORM
														self.seq := l.seq;
														self.historydate := l.historydate;													
														self.dob := (integer) l.h.dob,
														self.groupid := c;
														self := l.h;
														self := [];
		END;		
		addrHistRfmted := project(ug, ReformatAddr(LEFT, COUNTER));
	
	//bug fix: 142995	- changed sort to match the rollup criteria									
		address_hierarchy_sorted := sort(addrHistRfmted, -zip, -prim_name, -prim_range, -predir, -suffix, -postdir,
						-city_name, -st, -dt_last_seen, -dt_first_seen);
		Layouts.addrhist_layout unique_header(Layouts.addrhist_layout l, Layouts.addrhist_layout r) := TRANSFORM			
			self.dt_first_seen := map( 
				l.src = 'LA' => r.dt_first_seen, //show LA records but don't show dates from it
				r.src = 'LA' => l.dt_first_seen,				
				l.dt_first_seen = 0 => r.dt_first_seen,
				r.dt_first_seen = 0 => l.dt_first_seen,
				l.dt_first_seen < r.dt_first_seen => l.dt_first_seen,
				r.dt_first_seen < l.dt_first_seen => r.dt_first_seen,
				l.dt_first_seen);
	
			self.dt_last_seen := map(
					l.dt_last_seen > r.dt_last_seen => l.dt_last_seen,
					r.dt_last_seen);	
				self.ssn := if( l.ssn='', r.ssn, l.ssn);
				self.dob := if( l.dob=0, r.dob, l.dob);
				self := l;
			END;

		address_hierarchy_dedupe := rollup(address_hierarchy_sorted, 
																		left.zip=right.zip AND left.prim_name=right.prim_name AND
																		left.prim_range= right.prim_range AND left.predir=right.predir
																		AND left.suffix=right.suffix AND
																		left.postdir=right.postdir 
																		AND left.city_name=right.city_name AND left.st=right.st,
																		unique_header(left, right));	
																	
	address_hierarchy := address_hierarchy_dedupe;

	PropAddrHist := join(address_hierarchy, props,
		Left.prim_name<>'' AND
		Left.prim_name=Right.prim_name AND
		Left.prim_range=Right.prim_range AND
		Left.zip=Right.zip5 AND
		Left.predir=Right.predir AND
		Left.postdir=Right.postdir AND
		Left.suffix=Right.addr_suffix AND
		Left.sec_range=Right.sec_range,
		TRANSFORM(Layouts.addrhist_layout, 
				self.assessmentprice := (string11) right.assessed_total_value;
				self.assessmentdate :=  (string32) right.assessed_value_year;
				self.standardized_land_use_code := right.standardized_land_use_code;
				self := left));
      final_PropAddrHist := join(PropAddrHist, Codes.Key_Codes_V3,  
															trim(left.standardized_land_use_code)<>'' and 
															keyed(right.file_name='FARES_2580') and 
															keyed(right.field_name='STANDARDIZED_LAND_USE_CODE') and
															(left.standardized_land_use_code = right.code),
															transform(Layouts.addrhist_layout, 
																				self.land_use := right.long_desc, // this desc is of format xxx|desc...just return this per dave.
																				self := left),
															left outer, keep(1));			
	// 		Get Fares ids for all addresses...needed to get the tax asses and to flag valid eq records.																		
			assessment_fares := SET (flagrecs (file_id = FCRA.FILE_ID.ASSESSMENT),record_id);
			assessment_ffid  := SET (flagrecs (file_id = FCRA.FILE_ID.ASSESSMENT), flag_file_id);

			deed_fares := SET (flagrecs (file_id = FCRA.FILE_ID.DEED),record_id);
			deed_ffid  := SET (flagrecs (file_id = FCRA.FILE_ID.DEED), flag_file_id);

			search_puids := SET (flagrecs (file_id = FCRA.FILE_ID.SEARCH),record_id);
			search_ffid  := SET (flagrecs (file_id = FCRA.FILE_ID.SEARCH), flag_file_id);

			// we need a combined list of fares from D & A:
			layout_fares_search := ln_propertyv2.layout_search_building;
			layout_assessments := ln_propertyv2.layout_property_common_model_base;
			layout_deeds := ln_propertyv2.layout_deed_mortgage_common_model_base;
			search_fares := assessment_fares + deed_fares;

			key_prop_addr_fid := ln_propertyv2.key_addr_fid (IsFCRA);
			//for consistency, we will use the property info for the properties we own
			//then use the raw data to back fill the property info we do not own
			address_hierarchy_nonOwned := join(address_hierarchy, props,
													Left.prim_name<>'' AND
													Left.prim_name=Right.prim_name AND
													Left.prim_range=Right.prim_range AND
													Left.zip=Right.zip5 AND
													Left.predir=Right.predir AND
													Left.postdir=Right.postdir AND
													Left.suffix=Right.addr_suffix AND
													Left.sec_range=Right.sec_range,
								transform(LEFT), LEFT ONLY);
			header_withfares := JOIN (address_hierarchy_nonOwned, key_prop_addr_fid,          
													Left.prim_name<>'' AND
													keyed (Left.prim_name=Right.prim_name) AND
													keyed (Left.prim_range=Right.prim_range) AND
													keyed (Left.zip=Right.zip) AND
													keyed (Left.predir=Right.predir) AND
													keyed (Left.postdir=Right.postdir) AND
													keyed (Left.suffix=Right.suffix) AND
													keyed (Left.sec_range=Right.sec_range) and
													keyed (right.source_code_2 = 'P') AND
													(right.source_code_1 <> 'C') and // filter out "Care-Of" records
													(Right.ln_fares_id NOT IN search_fares), // weed out corrected prop. records
													TRANSFORM(Layouts.addrhist_layout, self.ln_fares_id := right.ln_fares_id, 
														self.dob := (integer) left.dob,
														self := left, self := []),
													LEFT OUTER, atmost(riskwise.max_atmost), KEEP(MAX_PROP_KEEP));

			property_fid_dedup := DEDUP (SORT (header_withfares, RECORD), ALL); // remove dup fids...

			// collect assessment information....needed for all history records.
			pre_assessments := JOIN (property_fid_dedup, ln_propertyv2.key_assessor_fid (true),
													 left.ln_fares_id<>'' AND
													 keyed (Left.ln_fares_id = Right.ln_fares_id),
													 TRANSFORM (layout_assessments, SELF := Right),
													 atmost(riskwise.max_atmost), KEEP (MAX_PROP_KEEP))
													 + PROJECT (CHOOSEN (FCRA.key_override_property.assessment (keyed (flag_file_id IN assessment_ffid)), MAX_OVERRIDE_LIMIT),
														TRANSFORM(layout_assessments, self:=left));
					 
			deduped_assessments := DEDUP (SORT (pre_assessments, RECORD), ALL);
			assessments := sort(deduped_assessments, -assessed_value_year, ln_fares_id);
			
			// trac
			Layouts.addrhist_layout assessedinfo_tx(Layouts.addrhist_layout l, layout_assessments r) := TRANSFORM
				boolean market := if(r.market_total_value<>'', true, false);
				self.assessmentprice := r.assessed_total_value;
				self.assessmentdate := r.assessed_value_year; 
				self.standardized_land_use_code := r.standardized_land_use_code;
				self.vendor_source_flag := map(r.vendor_source_flag='F' => 'FAR_F',
																				r.vendor_source_flag='S' => 'FAR_S',
																				r.vendor_source_flag='O' => 'OKCTY',
																				r.vendor_source_flag='D' => 'DAYTN',
										'');
				self := l;
			END;
			header_with_assessment := join(property_fid_dedup, assessments, Left.ln_fares_id = Right.ln_fares_id, 
																assessedinfo_tx(left, right), LEFT OUTER);

			Layouts.addrhist_layout bestassessed(Layouts.addrhist_layout l, Layouts.addrhist_layout r) := TRANSFORM
				isleft := l.assessmentdate > r.assessmentdate;
				self.assessmentdate := if(isleft, l.assessmentdate, r.assessmentdate);
				self.assessmentprice := if( isleft, l.assessmentprice, r.assessmentprice);
				BOOLEAN useL := l.standardized_land_use_code <> '';
				self.standardized_land_use_code := if( useL, l.standardized_land_use_code, r.standardized_land_use_code);
				self.vendor_source_flag := if( useL, l.vendor_source_flag, r.vendor_source_flag);
				self := l;
			END;
			
			finalhistory := rollup(sort(header_with_assessment, groupid), left.groupid=right.groupid, bestassessed(left,right));
			
			//get the land use description
      finalhistory1 := join(finalhistory, Codes.Key_Codes_V3,  
															trim(left.standardized_land_use_code)<>'' and 
															keyed(right.file_name='FARES_2580') and 
															keyed(right.field_name='STANDARDIZED_LAND_USE_CODE') and
															keyed(right.field_name2=left.vendor_source_flag) and
															keyed(left.standardized_land_use_code = right.code),
															transform(Layouts.addrhist_layout, 
																				self.land_use := right.long_desc, // this desc is of format xxx|desc...just return this per dave.
																				self := left),
															left outer, keep(1));   
			//last step, addin address Characteristics
			finalhistory2 := finalhistory1 + final_PropAddrHist;

      addrchar := getAddrCharacteristics(finalhistory2);
		return sort(addrchar, -dt_last_seen);
	END;
	
// ------------- best address from addr hist + best phone and best dob -------------
export summary(dataset(Layouts.addrhist_layout) addrhist, 
				risk_indicators.Layout_Boca_Shell bs, 
				boolean inqRestrict,
				dataset(Risk_Indicators.Layout_Input) raw_input,
				boolean LexIDOnlyOnInput,
				string6 SSNMask,
				unsigned1 dob_mask_value) := FUNCTION

			// first address in list that is equifax valid (no eq only)
			// OR that matches the input
			bestValid := choosen(sort(addrhist, (integer) -dt_last_seen), 1);


			phonejoin_layout := record
				integer groupid;
				boolean didmatch;
				integer namematch;
				string8 dt_last_seen;
				string10 phone;
				//Gong_v2.Layout_GongHistory gong; // only needed for testing...
			END;

			bestValid_plusphone := join(bestValid, Gong.Key_FCRA_History_Address,
												trim(left.prim_name)!='' and trim(left.zip)!='' and
												keyed(right.prim_name=left.prim_name) and keyed(right.st=left.st) and 
												keyed(right.z5=left.zip) and
												keyed(right.prim_range=left.prim_range) and left.sec_range=right.sec_range and
												right.current_flag,
												TRANSFORM( phonejoin_layout,
																		self.groupid := left.groupid;
																		self.didmatch := left.did = right.did;
																		self.namematch := 1;
																		self.dt_last_seen := right.dt_last_seen;
																		// self.gong := right; // only copy out if we need to look at it.
																		self.phone := right.phone10),
												atmost(RiskWise.max_atmost),										
												keep(100), left outer);
												
			phonejoin_layout rollupphones(phonejoin_layout l, phonejoin_layout r) := TRANSFORM
				useleft := l.didmatch or (not r.didmatch); // these are all in descending date order so just take the first didmatch encountered
				self := if( useleft, l, r);
			END;
			
			bestValid_plusphone_rolled := rollup(sort( bestValid_plusphone, groupid, -dt_last_seen), left.groupid = right.groupid, 
																						rollupphones(left, right));
			bestValid_finalphone := join(bestValid, bestValid_plusphone_rolled, left.groupid = right.groupid, 
																			TRANSFORM(Layouts.addrhist_layout, self.phone := right.phone, self := left),
																			left outer); // right is unique on groupid, so left out is good / will not add records
			MisMatch_layout := record
				Layouts.addrhist_layout;
				string1 SSNMismatch;
				string1 DOBMismatch;
				string1 AddressMismatch;
				string1 PhoneMismatch;
				string1 uniqueidmismatch;//LexIDMismatch;
			END;		


			MisMatch_layout addMismatchFlags(Layouts.addrhist_layout li, Risk_Indicators.Layout_Input ri) := TRANSFORM
				self.SSNMismatch := MAP(ri.ssn = ''=> '',
							ri.ssn = li.ssn => Constants.No_flag,
								Constants.Yes_flag); 
				self.DOBMismatch := MAP(ri.dob = '' or (integer) ri.dob = 0 => '',
								ri.dob = (string) bs.reported_dob => Constants.No_flag,
								Constants.Yes_flag);   
				BestAddr := Address.Addr1FromComponents(li.prim_range, li.predir, li.prim_name, li.suffix, li.postdir, li.unit_desig, li.sec_range);
				InputAddr := Address.Addr1FromComponents(ri.prim_range, ri.predir, ri.prim_name, ri.addr_suffix, ri.postdir, ri.unit_desig, ri.sec_range);
				self.AddressMismatch := MAP(InputAddr = '' => '',//in_streetAddress
								InputAddr = BestAddr => Constants.No_flag,
								Constants.Yes_flag); 
				self.PhoneMismatch := MAP(ri.phone10 = '' => '',
								ri.phone10 = li.phone => Constants.No_flag,
								Constants.Yes_flag);   
				self.uniqueidmismatch := MAP(ri.did = 0 => '',//no input DID so don't display mismatch - 1.3.d
								LexIDOnlyOnInput => '', //only Lexid on input so don't display mismatch - 1.3.c
								(string)ri.did = (string)li.did => Constants.No_flag,
								Constants.Yes_flag); 
				self := li;
			end;
		
			bestValid_finalphoneFlags :=	join(bestValid_finalphone, raw_input, 
				left.seq = right.seq,
				addMismatchFlags(LEFT, RIGHT), left outer);
		
			iesp.riskview2.t_Rv2ReportSummaryRecord formatsummaryrec(MisMatch_layout l, risk_indicators.Layout_Boca_Shell bs):= TRANSFORM
				self.Name := esdlName('', l.fname, l.mname, l.lname, l.name_suffix, l.title);
				self.Address := esdlAddress(l.prim_range, l.predir, l.prim_name, l.suffix, l.postdir, l.unit_desig, l.sec_range, '','', l.city_name, l.st, l.zip, l.zip4, '','','');  
				self.SSN := l.ssn;
				self.Phone := l.phone;
				dob_string := iesp.ECL2ESP.toMaskableDatestring8((string) bs.reported_dob);
				masked_dob := iesp.ECL2ESP.ApplyDateStringMask(dob_string, dob_mask_value);
				self.DOB := masked_dob;	
				self.AddressStability := (string) bs.other_Address_Info.addrs_last_5years;//code from RiskView.get_attributes_v5

				self.InquiriesRestricted := (string) inqRestrict;
				self.UniqueId := (string)l.did;
				self.SSNMismatch := l.SSNMismatch;
				self.DOBMismatch := l.DOBMismatch;
				self.AddressMismatch := l.AddressMismatch;
				self.PhoneMismatch := l.PhoneMismatch;
				self.uniqueidmismatch := l.uniqueidmismatch; 
			end;
				
			res := project(bestValid_finalphoneFlags, formatsummaryrec(left, bs));
			Suppress.MAC_Mask(res, res_output, SSN, '', true, false, false, false, '', SSNMask);
			return res_output[1];
	END;

END;