import iesp, AutoStandardI, ut, doxie, suppress;

export Functions := MODULE

  /* missing delim *? and word OUT */
  EXPORT searchableGangName(STRING aName) := FUNCTION
		nameRec := RECORD
			String gang;
		END;
		
		oneName := DATASET([{StringLib.StringToUpperCase(aName)}], nameRec);
		
		String delims := ' .#-\'(),;/[]&=:';
		trimmedname := TRIM (oneName.gang, LEFT, RIGHT);
		len_trim := LENGTH (trimmedname);
		Boolean ContainsDelims := 
			len_trim > LENGTH (StringLib.StringFilterOut (trimmedname, delims));

		 data_delimeted := oneName (ContainsDelims);
		 //output(data_delimeted);

		//output(data_delimeted);

		//==============================================================
		//=======  Parsing name into individual parts  ===========
		//==============================================================
		 PATTERN pt_word   := PATTERN ('[A-Za-z0-9]')+;
		 PATTERN pt_delim   := (ANY NOT IN pt_word)+;
		 TOKEN word1 := pt_word;
		 TOKEN word2 := pt_word;
		 TOKEN word3 := pt_word;
		 TOKEN word4 := pt_word;
		 RULE name_parts := OPT (pt_delim) word1 OPT (pt_delim word2 OPT (pt_delim word3 OPT (pt_delim word4)));

		// Parse name into parts (first 4 parts considered only)
		 layout_nameParts := RECORD
			 data_delimeted;
			 first_part  := MATCHTEXT (word1);
			 second_part := MATCHTEXT (word2);
			 third_part  := MATCHTEXT (word3);
			 fourth_part := MATCHTEXT (word4);
		 END; 
		 data_parsed := PARSE (data_delimeted, gang, name_parts, layout_nameParts, MAX);
		 //output(data_parsed);

		// Preliminary filtering by invalid name's part (purely empirical).
		// Any record, containing those, is considered invalid
		 SET OF String NotAName := ['EX','ON','THE','AND','EL','DEL','ST','TH','ND','RD',
															 'NA','NO','NONE','OF', 'INC', 'ASS', 'AVE',
															 'EST', 'SPA', 'AUTO', 'EXPO', 'PROPERTIES','NON',
															 'INT']; //'CONSTRUCTION, etc.

		 SET OF String CommonName3 := ['AKA', 'DEL', 'VAN', 'ABU', 'BEN', 'ALI', 'WON', 'VON',
																	'DER', 'DES', 'DON'];

		/** write macro for valid length */
		setValidName(field) := MACRO
			#uniquename(tempField);
			%tempField% := if(length(trim(left.field)) > 1, 
				if (left.field not in NotAName and 
									left.field not in CommonName3 , left.field, ''), '');
			#uniquename(cleanfield);						
			%cleanfield% := stringlib.stringfilterout(%tempField%,' .#-\'(),;/[]&=:');
			self.field := REGEXREPLACE('([0-9])(TH |ST |RD |ND )', %cleanfield%, '$1 ');									
		ENDMACRO;
															
		datafinal := project(data_parsed, TRANSFORM(layout_nameParts, 
				setValidName(first_part);
				setValidName(second_part);
				setValidName(third_part);
				setValidName(fourth_part); 
			self := left));

		layout_did_partname := RECORD
			datafinal;
			qstring20 partName;
		END;

		datapart := project(datafinal, transform(layout_did_partname,
			self.partname := trim(left.first_part) + trim(left.second_part) + trim(left.third_part) + trim(left.fourth_part);
			self := left));
		
		RETURN if (COUNT(oneName (ContainsDelims)) > 0, datapart[1].partname, oneName[1].gang);
	END;
	
	EXPORT apply_penalty(dataset(Layouts.mainBooking) logRecord, 
												IParam.searchParams aInputData) := FUNCTION												
		UNSIGNED2 penalty_threshold := aInputData.penalty_threshold;    
		
		Layouts.mainBooking setPenalty(Layouts.mainBooking logs) := TRANSFORM		
			tempIndvMod := MODULE(PROJECT(aInputData, AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
				export allow_wildcard := false;
				export city_field := logs.p_city_name;
				export did_field := (String)logs.did;
				export fname_field := logs.fname;
				export lname_field := logs.lname;
				export mname_field := logs.mname;
				export pname_field := logs.prim_name;
				export postdir_field := logs.postdir;
				export prange_field := logs.prim_range;
				export predir_field := logs.predir;
				export ssn_field := logs.ssn;  
				export state_field := logs.state;
				export suffix_field := logs.addr_suffix;
				export sec_range_field := logs.sec_range;
				export zip_field := logs.zip5;
				// Empty non input.
				export city2_field := '';
				export county_field := '';
				export dob_field := logs.date_of_birth;
				export dod_field := '';
				export phone_field := logs.home_phone;
			END;
						
				extraPenalty(inField, outField, penaltyNumber, pWeight = 5) := MACRO					
					penaltyNumber := IF(aInputData.inField = '' or 
						stringlib.stringtouppercase(aInputData.inField) = stringlib.stringtouppercase(logs.outField), 0, pWeight);									
				ENDMACRO;
				
				// Calculate extra penalty
				rangePenalty(inField1, inField2, outField, penaltyNumber, pWeight = 5) := MACRO
					#uniquename(intValue);
						%intValue% := (unsigned)logs.outField;
						penaltyNumber := IF((aInputData.inField1 = 0 and aInputData.inField2 = 0) 
						or (%intValue% between aInputData.inField1 and aInputData.inField2), 0, pWeight);
				ENDMACRO;
				
				subStringPenalty(inField1, inField2, penaltyNumber, pWeight = 5) := MACRO					
					penaltyNumber := IF(aInputData.inField1 = '' or 
						StringLib.StringFind(logs.inField2, aInputData.inField1,1) > 0 , 0, pWeight);									
				ENDMACRO;
							  
				extraPenalty(hair, key_hair, hairP, 5) ;			
				extraPenalty(eye, key_eye, eyeP, 3);
				rangePenalty(yearLow, yearHigh, date_of_birth[1..4], ageP, 5);
				rangePenalty(weightLow, weightHigh, key_wgt, weightP, 3);
				rangePenalty(heightLow, heightHigh, key_hgt, heightP, 5);
				extraPenalty(gangName, gang, gangP, 5);
				
				// web should never send a combination in these values,
				// if one has a value usually all others will be empty.
				subStringPenalty(smt, marks_scars_tatoos, smtP);
				subStringPenalty(scar, scar, scarP);
				subStringPenalty(mark, mark, markP);
				subStringPenalty(tattoo, tattoo, tattooP);
				
				SELF.record_penalty := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempIndvMod)
				 + weightP + heightP + hairP + eyeP + smtP + gangP + ageP + scarP + markP + tattooP;
								
				SELF := logs;
			END;
	
			penaltyRecs := project(logRecord, setPenalty(LEFT));					
		RETURN penaltyRecs(record_penalty <= penalty_threshold or isDeepDive );
	END;
	
	EXPORT apply_restrictions(DATASET(Layouts.mainBooking) aBookings, 													
													IParam.reportParams aInputData) := FUNCTION
		// DPPA CHECKING.		
		dppa_purpose := aInputData.dppaPurpose;
		
 		Layouts.mainBooking clearRestrictDL(aBookings L) := TRANSFORM
		   clearDLInfo := ~ut.PermissionTools.dppa.state_ok(L.dlstate,dppa_purpose);
			 self.dlstate := if (clearDLInfo, '', l.dlstate);
			 self.dlNumber := if (clearDLInfo, '', l.dlNumber);
			 self := l;
		END;
		
    Bookings01 := project(aBookings, clearRestrictDl(LEFT));		
				
		Suppress.MAC_Suppress(bookings01,pull_ssns,aInputData.applicationType,Suppress.Constants.LinkTypes.SSN,ssn);
		Suppress.MAC_Suppress(pull_ssns,bookings02,aInputData.applicationType,Suppress.Constants.LinkTypes.DID,did);
 
		ssn_mask_value := aInputData.ssnMask;
    dl_mask_value := aInputData.dl_Mask;
      
    suppress.mac_mask(bookings02, bookings03, ssn, dlNumber, true, true);  
    
		RETURN bookings03;
	END;
	
	SHARED setIESPCommonValues() := MACRO	
		SELF.Name := iesp.ECL2ESP.SetName(l.fname, l.mname, l.lname, l.name_suffix, l.title) ;
						 
		SELF.Address := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
	                       l.addr_suffix, l.unit_desig, l.sec_range, l.p_city_name,
												 l.state, l.zip5, l.zip4,	'') ;
		SELF.SSN := l.ssn;
		SELF.DOB := iesp.ECL2ESP.toDatestring8(l.date_of_birth);			
		SELF.Phone10 := l.home_phone;
		SELF.StateOfBirth := l.pob;		
		SELF.UniqueId := (String)l.did ;		
		SELF.CaseNumber := l.booking_sid;		
		SELF.GangNameMoniker := l.gang;
		SELF.height := l.key_hgt;
		SELF.weight := l.key_wgt;
		SELF.raceCode := l.key_race;
		SELF.race := CodeTranslations.raceDescription(l.key_race);
		SELF.EyeColorCode:= l.key_eye;
		SELF.gender := CodeTranslations.genderDescription(l.key_gender);
		SELF.Eyes := CodeTranslations.eyeColorDescription(l.key_eye);
		SELF.HairColorCode := l.key_hair;		
		SELF.Hair := CodeTranslations.hairColorDescription(l.key_hair);
		SELF.Jurisdiction := l.state_cd;
		SELF.ScarsMarksTattoos := l.marks_scars_tatoos;
		SELF.CaseFilingDate := iesp.ECL2ESP.toDatestring8(l.booking_date); 			
		self.ArrestDate := iesp.ECL2ESP.toDatestring8(l.arrest_date);     
		self.ReleaseDate := iesp.ECL2ESP.toDatestring8(l.release_date);              
		self.ReleaseReason := l.rreason ;
		self.AgencyCode := l.agency;    
		SELF.FBINumber := l.fbi_nbr;		
		SELF.DlNumber := l.dlnumber;
		SELF.DlState := l.dlstate;
		SELF.StateId := l.state_id;	
		SELF.BookingNumber := l.booking_nbr;
		SELF.Agency := l.agency_description;
		SELF.scars := l.scar;
		SELF.marks := l.mark;
		SELF.tattoos := l.tattoo;
    Self.InmateNumber := l.inmate_nbr; 
	ENDMACRO;
	
	EXPORT xform_BookingsIESP_Report(dataset (Layouts.mainBooking) inFile) := FUNCTION
			iesp.jailBooking.t_JailBookingCharge toCharges(Layouts.bookingCharges l) := TRANSFORM				 
				 SELF.ChargeSequence := l.charge_seq;  
  			 SELF.ChargeCount := l.charge_cnt;
  			 SELF.Charge := l.charge;
  			 SELF.ChargeDescription := l.description;
  			 SELF.ChargeDate := iesp.ECL2ESP.toDatestring8(l.charge_dt);
  			 SELF.CourtDate := iesp.ECL2ESP.toDatestring8(l.court_dt);
  			 SELF.Severity := l.key_severity;
  			 SELF.BondAmount := l.bond_amt;
				 SELF.BondType := l.bond_type_txt;
  			 SELF.DispositionDate := iesp.ECL2ESP.toDatestring8(l.disposition_dt);
  			 SELF.DispositionDescription := l.disposition_text;
				 SELF.NcicOffense := l.ncic_offense_cd;				 
  			 SELF.NcicOffenseDescription := l.ncic_offense_class_txt;
		 END;
		
		iesp.jailbooking.t_JailBookingReportRecord toOutReport(Layouts.mainBooking l) := TRANSFORM		
			setIESPCommonValues();				
			SELF.WorkPhone := l.work_phone;			
			SELF.MaritalStatus := l.mstatus;
			SELF.Employer := l.employer;
			SELF.Occupation := l.occupation;
			SELF.Nationality := l.nationality;
			SELF.USCitizen := l.citizen_ind;
			SELF.ForeignBorn := l.foreign_born_ind;
			SELF.Ethnicity := l.key_ethnicity_cd;
			SELF.HandPreference := l.handed;
			SELF.Skin := l.key_complex;
			SELF.WarningsCautions := l.warnings_cautions;
			SELF.Military := l.military;
			SELF.CorrectiveLenses := l.correct_lenses_ind;
			SELF.OtherPhysicalFeatures := l.other_phy_features;
			SELF.Language := l.language_spoken;
			SELF.LanguagesWritten := l.language_written;
			SELF.LanguagesRead := l.language_read;											
			SELF.OffenseDate := iesp.ECL2ESP.toDatestring8(l.offense_date);
			SELF.SexOffender := l.sex_offender_ind;
			SELF.MentalIllness := l.mental_illness_ind;
			SELF.Violent := l.violent_behavior_ind;
			SELF.EscapeRisk := l.escape_risk_ind;
			SELF.SuicideRisk := l.suicide_risk_ind;
			SELF.Weekender := l.weekender_ind;
			SELF.MedicalAlert := l.medical_alert;			
			SELF.Education := l.education_yrs;
			SELF.Charges := CHOOSEN(project(l.charges, toCharges(LEFT)), iesp.Constants.JB.MAX_CHARGES_RECORDS);			
		END;
		
		RETURN project (inFile, toOutReport(left));
	END;
		
	EXPORT xform_BookingsIESP (dataset (Layouts.mainBooking) inFile) := function		
		iesp.jailbooking.t_JailBookingSearchRecord toOutFile (Layouts.mainBooking l)  := TRANSFORM
			setIESPCommonValues();			
			SELF._Penalty := l.record_penalty;
			SELF.AlsoFound := l.isDeepDive;	
		END;
		RETURN project (inFile, toOutFile(left));
	END;
	
		EXPORT xform_BaseBookingsIESP (dataset (Layouts.mainBooking) inFile) := function		
		iesp.jailbooking.t_BaseJailBookingRecord toOutFile (Layouts.mainBooking l)  := TRANSFORM
			setIESPCommonValues();									
		END;
		RETURN project (inFile, toOutFile(left));
	END;
END;