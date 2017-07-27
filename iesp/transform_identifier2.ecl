IMPORT identifier2,risk_indicators, iesp, address, models;

EXPORT transform_identifier2 (dataset(identifier2.layout_Identifier2) identifier2Recs) := FUNCTION

	iesp.mod_identifier2.t_Identifier2Result toOut(identifier2.layout_Identifier2 L) := transform
		self.InputEcho.Name.Full   := '';
		self.InputEcho.Name.First  := L.fname;
		self.InputEcho.Name.Middle := L.mname;
		self.InputEcho.Name.Last   := L.lname;
		self.InputEcho.Name.Suffix := L.suffix;
		self.InputEcho.Name.Prefix := L.title;
		
		self.InputEcho.Address.StreetNumber           := L.prim_range;
		self.InputEcho.Address.StreetPreDirection     := L.predir;
		self.InputEcho.Address.StreetName             := L.prim_name;
		self.InputEcho.Address.StreetSuffix           := L.addr_suffix;
		self.InputEcho.Address.StreetPostDirection    := L.postdir;
		self.InputEcho.Address.UnitDesignation        := L.unit_desig;
		self.InputEcho.Address.UnitNumber             := L.sec_range;
		self.InputEcho.Address.StreetAddress1         := l.in_streetaddress;
		self.InputEcho.Address.StreetAddress2         := '';
		self.InputEcho.Address.City                   := L.p_city_name;
		self.InputEcho.Address.State                  := L.st; 
		self.InputEcho.Address.Zip5                   := L.z5;
		self.InputEcho.Address.Zip4                   := L.zip4;
		self.InputEcho.Address.County                 := L.county;
		self.InputEcho.Address.PostalCode             := '';
		self.InputEcho.Address.StateCityZip           := '';

		self.InputEcho.DOB                  := iesp.ECL2ESP.toDate((integer4)L.DOB);
		self.InputEcho.Age                  := (unsigned)L.Age;
		self.InputEcho.SSN                  := L.SSN;
		self.InputEcho.SSNLast4             := l.ssn[6..9];
		self.InputEcho.DriverLicenseNumber  := l.dl_number;
		self.InputEcho.DriverLicenseState   := l.dl_state;
		self.InputEcho.IPAddress            := l.ip_address;
		self.InputEcho.HomePhone            := l.phone10 ;
		self.InputEcho.WorkPhone            := l.wphone10;
		self.InputEcho.UseDOBFilter         := false;
		self.InputEcho.DOBRadius            := 0;
		self.InputEcho.UniqueId             := l.InputEcho.UniqueId;
		self.UniqueId                       := (string)l.did;

		self.VerifiedInput.Name.Full   := '';
		self.VerifiedInput.Name.First  := L.verfirst;
		self.VerifiedInput.Name.Middle := '';
		self.VerifiedInput.Name.Last   := L.verlast;
		self.VerifiedInput.Name.Suffix := '';
		self.VerifiedInput.Name.Prefix := '';
				
		Map_Addr( in_addr, in_city, in_state, in_zip, out_destination ) := MACRO
			#uniquename(clean)
			%clean% := risk_indicators.MOD_AddressClean.clean_addr( in_addr, in_city, in_state, in_zip ) ;
			#uniquename(cf)
			%cf% := Address.CleanFields(%clean%);

			out_destination.StreetNumber         := %cf%.prim_range;
			out_destination.StreetPreDirection   := %cf%.predir;
			out_destination.StreetName           := %cf%.prim_name;
			out_destination.StreetSuffix         := %cf%.addr_suffix;
			out_destination.StreetPostDirection  := %cf%.postdir;
			out_destination.UnitDesignation      := %cf%.unit_desig;
			out_destination.UnitNumber           := %cf%.sec_range;
			out_destination.StreetAddress1       := in_addr;
			out_destination.StreetAddress2       := '';
			out_destination.City                 := %cf%.p_city_name;
			out_destination.State                := %cf%.st;
			out_destination.Zip5                 := %cf%.zip;
			out_destination.Zip4                 := %cf%.zip4;
			out_destination.County               := %cf%.county[3..5];
			out_destination.PostalCode           := '';
			out_destination.StateCityZip         := '';
		ENDMACRO;

		Map_Addr( L.veraddr, l.vercity, l.verstate, l.verzip, self.VerifiedInput.Address );

		self.VerifiedInput.SSN              := l.verssn;
		self.VerifiedInput.HomePhone        := l.verhphone;
		self.VerifiedInput.DOB.Year         := (integer)l.verDOB[1..4];
		self.VerifiedInput.DOB.Month        := (integer)l.verDOB[5..6];
		self.VerifiedInput.DOB.Day          := (integer)l.verDOB[7..8];
		self.VerifiedInput.MaskedDOB.Year   := l.verDOB[1..4];
		self.VerifiedInput.MaskedDOB.Month  := l.verDOB[5..6];
		self.VerifiedInput.MaskedDOB.Day    := l.verDOB[7..8];
		self.DOBVerified                    := l.verify_dob='Y';  
		self.NameAddressSSNSummary          := l.NAS_Summary;
		self.NameAddressPhone.Summary       := (string)l.NAP_Summary;  
		self.NameAddressPhone._Type         := l.NAP_Type;
		self.NameAddressPhone.Status        := l.NAP_Status;
		self.ComprehensiveVerificationIndex := (integer)l.CVI;
		
		self.InputCorrected.Name.Full   := '';
		self.InputCorrected.Name.First  := '';
		self.InputCorrected.Name.Middle := '';
		self.InputCorrected.Name.Last   := L.corrected_lname;
		self.InputCorrected.Name.Suffix := '';
		self.InputCorrected.Name.Prefix := '';

		Map_Addr( L.corrected_address, l.p_city_name, l.st, l.z5, self.InputCorrected.Address );
		Map_Addr( l.phone_address, l.phone_city, l.phone_st, l.phone_zip, self.ReversePhone.Address );
																		
		self.InputCorrected.SSN        := l.corrected_ssn;
		self.InputCorrected.HomePhone  := L.corrected_phone;
		self.InputCorrected.DOB.Year   := (integer)L.Corrected_DOB[1..4];
		self.InputCorrected.DOB.Month  := (integer)L.Corrected_DOB[5..6];
		self.InputCorrected.DOB.Day    := (integer)L.Corrected_DOB[7..8];
		self.NewAreaCode.AreaCode      := l.area_code_split;
		self.NewAreaCode.EffectiveDate := iesp.ECL2ESP.toDate ((integer4) L.area_code_split_date);
		
		self.ReversePhone.Name.Full   := '';
		self.ReversePhone.Name.First  := L.phone_fname;
		self.ReversePhone.Name.Middle := '';
		self.ReversePhone.Name.Last   := L.phone_lname;
		self.ReversePhone.Name.Suffix := '';
		self.ReversePhone.Name.Prefix := '';
		
		self.PhoneOfNameAddress := l.name_addr_phone;
		
		ifirstDate := (integer)L.ssa_date_first;
		ifirstLen := length(trim(L.ssa_date_first));
		issuedStart := map(
			ifirstLen = 8 => iesp.ECL2ESP.toDate(ifirstDate),
			ifirstLen = 6 => iesp.ECL2ESP.toDateYM(ifirstDate),
			ifirstLen = 4 => row ({ifirstDate , 0, 0}, iesp.share.t_Date),
			row ({0,0,0}, iesp.share.t_Date)
		);
								 
		ilastDate := (integer)L.ssa_date_last;
		ilastLen := length(trim(L.ssa_date_last));
		issuedEnd := map(
			ilastLen = 8 => iesp.ECL2ESP.toDate(ilastDate),
			ilastLen = 6 => iesp.ECL2ESP.toDateYM(ilastDate),
			ilastLen = 4 => row ({ilastDate , 0, 0}, iesp.share.t_Date),
			row ({0,0,0}, iesp.share.t_Date)
		);
		// SSNissueState := l.ssa_state;
		self.SSNInfo.SSN                   := L.verssn;
		self.SSNInfo.Valid                 := l.valid_ssn;
		self.SSNInfo.IssuedLocation        := l.ssa_State_name;
		self.SSNInfo.IssuedStartDate.Year  := IssuedStart.year;
		self.SSNInfo.IssuedStartDate.Month := IssuedStart.month;
		self.SSNInfo.IssuedStartDate.Day   := IssuedStart.day;
		self.SSNInfo.IssuedEndDate.Year    := IssuedEnd.year;
		self.SSNInfo.IssuedEndDate.Month   := IssuedEnd.month;
		self.SSNInfo.IssuedEndDate.Day     := IssuedEnd.day;


		self.WatchList.Table := l.watchlist_table;
		self.WatchList.RecordNumber := l.Watchlist_Record_Number;
		self.WatchList.Name.Full   := '';
		self.WatchList.Name.First  := L.Watchlist_fname;
		self.WatchList.Name.Middle := '';
		self.WatchList.Name.Last   := L.Watchlist_lname;
		self.WatchList.Name.Suffix := '';
		self.WatchList.Name.Prefix := '';
		
		// after running stats on the patriot file, 97.8% of the records on the patriot file don't have a cleanable address anyway, just return the address without cleaning it
		self.WatchList.Address.StreetNumber         := '';
		self.WatchList.Address.StreetPreDirection   := '';
		self.WatchList.Address.StreetName           := '';
		self.WatchList.Address.StreetSuffix         := '';
		self.WatchList.Address.StreetPostDirection  := '';
		self.WatchList.Address.UnitDesignation      := '';
		self.WatchList.Address.UnitNumber           := '';
		self.WatchList.Address.StreetAddress1       := l.Watchlist_address;
		self.WatchList.Address.StreetAddress2       := '';
		self.WatchList.Address.City                 := l.Watchlist_city;
		self.WatchList.Address.State                := l.Watchlist_state;
		self.WatchList.Address.Zip5                 := l.Watchlist_zip;
		self.WatchList.Address.Zip4                 := '';
		self.WatchList.Address.County               := '';
		self.WatchList.Address.PostalCode           := '';
		self.WatchList.Address.StateCityZip         := '';
			
		// I'll leave this code in here in case someone really wants the cleaned address from the watchlist file
		// only run the address through the cleaner if it's a US Address
		// watchlist_address := if(l.watchlist_contry='UNITED STATES' and l.watchlist_address<>'', ... );
		// Map_Addr( l.watchlist_address, l.watchlist_city, l.watchlist_state, l.watchlist_zip, self.Watchlist.Address );


		self.WatchList.Country := l.Watchlist_contry;
		self.WatchList.EntityName := l.Watchlist_Entity_Name;
		self.AdditionalScore1 := (string)l.additional_score1;  
		self.AdditionalScore2 := (string)l.additional_score2; 
		self.CurrentName.Full   := '';
		self.CurrentName.First  := L.current_fname;
		self.CurrentName.Middle := '';
		self.CurrentName.Last   := L.current_lname;
		self.CurrentName.Suffix := '';
		self.CurrentName.Prefix := '';
		
		SELF.InputAddressRisk.AddressDoNotDeliver := IF(L.ADVODoNotDeliver, TRUE, FALSE);
		SELF.InputAddressRisk.AddressIsNotHighRisk := IF(L.ADVODoNotDeliver OR L.USPISHotList OR L.ADVOAddressVacancyIndicator OR TRIM(L.ADVODropIndicator) IN ['C', 'Y'], FALSE, TRUE);
		SELF.InputAddressRisk.AddressIsNotABusiness := IF(TRIM(L.ADVOResidentialOrBusinessInd) IN ['B', 'C', 'D'] OR TRIM(L.Sic_Code) <> '', FALSE, TRUE);
		
		iesp.share.t_riskIndicator xform_redflag( risk_indicators.layouts.layout_desc_plus_seq le ) := TRANSFORM
			self.riskcode := le.hri;
			self.description := le.desc;
		END;
		rf1  := project(l.red_flags.ADDRESS_DISCREPANCY_CODES,  xform_redflag(LEFT));
		rf2  := project(l.red_flags.SUSPICIOUS_DOCUMENTS_CODES, xform_redflag(LEFT));
		rf3  := project(l.red_flags.SUSPICIOUS_ADDRESS_CODES,   xform_redflag(LEFT));
		rf4  := project(l.red_flags.SUSPICIOUS_SSN_CODES,       xform_redflag(LEFT));
		rf5  := project(l.red_flags.SUSPICIOUS_DOB_CODES,       xform_redflag(LEFT));
		rf6  := project(l.red_flags.HIGH_RISK_ADDRESS_CODES,    xform_redflag(LEFT));
		rf7  := project(l.red_flags.SUSPICIOUS_PHONE_CODES,     xform_redflag(LEFT));
		rf8  := project(l.red_flags.SSN_MULTIPLE_LAST_CODES,    xform_redflag(LEFT));
		rf9  := project(l.red_flags.MISSING_INPUT_CODES,        xform_redflag(LEFT));
		rf10 := project(l.red_flags.FRAUD_ALERT_CODES,          xform_redflag(LEFT));
		rf11 := project(l.red_flags.CREDIT_FREEZE_CODES,        xform_redflag(LEFT));
		rf12 := project(l.red_flags.IDENTITY_THEFT_CODES,       xform_redflag(LEFT));
		
		// new structure introduced with 2/8/2011 update to iesp.instantid
		iesp.share.t_SequencedRiskIndicator xform_redflagSeq( risk_indicators.layouts.layout_desc_plus_seq le, integer i ) := TRANSFORM
			self.sequence := i;
			self.riskcode := le.hri;
			self.description := le.desc;
		END;
		rfs1  := project(l.red_flags.ADDRESS_DISCREPANCY_CODES,  xform_redflagSeq(LEFT,COUNTER));
		rfs2  := project(l.red_flags.SUSPICIOUS_DOCUMENTS_CODES, xform_redflagSeq(LEFT,COUNTER));
		rfs3  := project(l.red_flags.SUSPICIOUS_ADDRESS_CODES,   xform_redflagSeq(LEFT,COUNTER));
		rfs4  := project(l.red_flags.SUSPICIOUS_SSN_CODES,       xform_redflagSeq(LEFT,COUNTER));
		rfs5  := project(l.red_flags.SUSPICIOUS_DOB_CODES,       xform_redflagSeq(LEFT,COUNTER));
		rfs6  := project(l.red_flags.HIGH_RISK_ADDRESS_CODES,    xform_redflagSeq(LEFT,COUNTER));
		rfs7  := project(l.red_flags.SUSPICIOUS_PHONE_CODES,     xform_redflagSeq(LEFT,COUNTER));
		rfs8  := project(l.red_flags.SSN_MULTIPLE_LAST_CODES,    xform_redflagSeq(LEFT,COUNTER));
		rfs9  := project(l.red_flags.MISSING_INPUT_CODES,        xform_redflagSeq(LEFT,COUNTER));
		rfs10 := project(l.red_flags.FRAUD_ALERT_CODES,          xform_redflagSeq(LEFT,COUNTER));
		rfs11 := project(l.red_flags.CREDIT_FREEZE_CODES,        xform_redflagSeq(LEFT,COUNTER));
		rfs12 := project(l.red_flags.IDENTITY_THEFT_CODES,       xform_redflagSeq(LEFT,COUNTER));
		
		
		
		redflags :=
			if(count(rf1)>0, dataset([{'AddressDiscrepancyCodes', rf1, rfs1}], iesp.instantid.t_redFlag)) + 
			if(count(rf2)>0, dataset([{'SuspiciousDocumentsCodes', rf2, rfs2}], iesp.instantid.t_redFlag)) + 
			if(count(rf3)>0, dataset([{'SuspiciousAddressCodes', rf3, rfs3}], iesp.instantid.t_redFlag)) + 
			if(count(rf4)>0, dataset([{'SuspiciousSSNCodes', rf4, rfs4}], iesp.instantid.t_redFlag)) + 
			if(count(rf5)>0, dataset([{'SuspiciousDOBCodes', rf5, rfs5}], iesp.instantid.t_redFlag)) + 
			if(count(rf6)>0, dataset([{'HighRiskAddressCodes', rf6, rfs6}], iesp.instantid.t_redFlag)) + 
			if(count(rf7)>0, dataset([{'SuspiciousPhoneCodes', rf7, rfs7}], iesp.instantid.t_redFlag)) + 
			if(count(rf8)>0, dataset([{'SSNMultipleLastCodes', rf8, rfs8}], iesp.instantid.t_redFlag)) + 
			if(count(rf9)>0, dataset([{'MissingInputCodes', rf9, rfs9}], iesp.instantid.t_redFlag)) + 
			if(count(rf10)>0, dataset([{'FraudAlertCodes', rf10, rfs10}], iesp.instantid.t_redFlag)) + 
			if(count(rf11)>0, dataset([{'CreditFreezeCodes', rf11, rfs11}], iesp.instantid.t_redFlag)) + 
			if(count(rf12)>0, dataset([{'IdentityTheftCodes', rf12, rfs12}], iesp.instantid.t_redFlag))
		; 
		
		// self.RedFlagsReport.Version  := if(exists(redflags), 1, 0 ); // This only sets the version number if flags are found... Should be the version passed in - moved to Identifier2_Service.
		self.RedFlagsReport.RedFlags := CHOOSEN(redflags, iesp.Constants.Identifier2c.MaxOther); //Prevent too many rows returned error
		
		self.RiskIndicators := project(l.ri, xform_redflag(left));
		self.PotentialFollowupActions := project(l.fua,TRANSFORM(iesp.share.t_RiskIndicator,
													  self.riskcode :=  left.hri, 
													  self.Description := left.desc));

		iesp.instantID.t_ChronologyHistory xform_chronohist( Risk_Indicators.Layout_AddressHistory le ) := TRANSFORM
			Map_Addr( le.address, le.city, le.st, le.zip, self.address );
			self.Phone := le.Phone;
			self.DateFirstSeen := iesp.ECL2ESP.toDateYM((integer4)Le.dt_first_seen);
			self.DateLastSeen  := iesp.ECL2ESP.toDateYM((integer4)Le.dt_last_seen);
			self.isBestAddress := le.isBestMatch;
		END;
		self.ChronologyHistories := project(l.Chronology, xform_chronohist(LEFT));
		
											
		
		self.AKAs := [];  // not used
		//additional lastname contains firstname too...but its missing from iesp.instantid.t_additionalLastName
		self.AdditionalLastNames := project(l.Additional_Lname,transform(iesp.instantid.t_additionalLastName,
																		 self.DateLastSeen  := iesp.ECL2ESP.toDateYM ((integer4)Left.date_last),
																		 self.lastname  := left.lname1));

		iesp.share.t_RiskIndicator xform_reasons( risk_indicators.layouts.layout_reason_codes_plus_seq le ) := TRANSFORM
			self.riskcode    := le.Reason_Code, 
			self.Description := le.Reason_Description;
		end;
		iesp.instantid.t_score xform_scores( Models.layouts.Layout_Score_IID_wFP le ) := TRANSFORM
			self._type := le.description;  // ie.. '10-90', '10-50', or '0-999'
			self.value := (integer)le.i;   // the actual score result cast to an integer value
			self.RiskIndicators := project( le.reason_codes, xform_reasons(left) );
		END;
		iesp.instantid.t_model xform_models( Models.layouts.Layout_Model_IID le ) := TRANSFORM
			self.name := le.description;  // ie, 'Fraud Defender', 'Fraud Point', or 'Student Defender'
			self.scores := project( le.scores, xform_scores(left) );
		END;
		self.Models := project(l.models, xform_models(left));


		self := L;
		self := [];
	end;

	RETURN project (identifier2Recs, toOut (Left));

END;
