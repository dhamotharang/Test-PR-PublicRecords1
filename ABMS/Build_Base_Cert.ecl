IMPORT tools, ut, _Validate;

EXPORT Build_Base_Cert(STRING 										 pversion,
											 DATASET(Layouts.Base.Cert)  inCertBase,
											 DATASET(Layouts.Input.Cert) inCertUpdate) := MODULE

	TrimUpper(STRING s) := FUNCTION
		RETURN TRIM(StringLib.StringToUppercase(s), LEFT, RIGHT);
	END;

  Layouts.Base.Cert standardize_input(Layouts.Input.Cert L) := TRANSFORM
    the_cert_date           := L.cert_year + L.cert_month + L.cert_day;
		the_expiration_date     := L.expiration_year + L.expiration_month + L.expiration_day;
		the_reverification_date := L.reverification_year + L.reverification_month + L.reverification_day;

	  SELF.cert_name                := TrimUpper(L.cert_name);
	  SELF.cert_type_ind            := TrimUpper(L.cert_type_ind);
	  SELF.recert_ind               := TrimUpper(L.recert_ind);
	  SELF.board_certified          := TrimUpper(L.board_certified);
	  SELF.duration_type            := TrimUpper(L.duration_type);
	  SELF.board_web_desc           := TrimUpper(L.board_web_desc);
	  SELF.mocpathway_name          := TrimUpper(L.mocpathway_name);
		SELF.dt_vendor_first_reported := (UNSIGNED4)pversion;
		SELF.dt_vendor_last_reported  := (UNSIGNED4)pversion;
		SELF.cert_date                := IF(_Validate.Date.fIsValid(the_cert_date), the_cert_date, '');
		SELF.expiration_date          := IF(_Validate.Date.fIsValid(the_expiration_date),
		                                    the_expiration_date,
																				'');
		SELF.reverification_date      := IF(_Validate.Date.fIsValid(the_reverification_date),
		                                    the_reverification_date,
																				'');
		SELF.record_type              := 'C';
		
		SELF := L;
		SELF := [];
	END;

	// Take the cert update file, standardize it, and PROJECT it into the base layout.
	workingCertUpdate := PROJECT(inCertUpdate, standardize_input(LEFT));

  // Distribute needed files for quicker processing.
	workingCertUpdate_dist := DISTRIBUTE(workingCertUpdate, HASH(biog_number));
	inCertBase_dist := DISTRIBUTE(inCertBase, HASH(biog_number));

	// Make the input unique for biog_number, to help determine what's historical and what's not.
	unique_update := DEDUP(SORT(workingCertUpdate_dist, biog_number, LOCAL), biog_number, LOCAL);

  // If the vendor isn't sending records for a given biog_number anymore, we want them, but
	// don't need to do anything to them.  They've already been marked up with C and H appropriately.
	// (no inline transform needed).
  workingCurrentCertBase := JOIN(inCertBase_dist, unique_update,
	                               LEFT.biog_number = RIGHT.biog_number,
																 LEFT ONLY,
																 LOCAL);

  // Determine the records that are historical... vendor is still sending updates for that biog_number.
	workingHistoricalCertBase := JOIN(inCertBase_dist, unique_update,
	                                    LEFT.biog_number = RIGHT.biog_number,
																			TRANSFORM(Layouts.Base.Cert,
																			          SELF.record_type := 'H';
																				        SELF.cert_type_ind_desc := '';
																				        SELF.recert_ind_desc := '';
																				        SELF.duration_type_desc := '';
																				        SELF := LEFT),
																	    LOCAL);

	// Join base and update cert to determine what's new.
	combinedCert := workingCertUpdate + workingCurrentCertBase + workingHistoricalCertBase;
	combinedCert_dist := DISTRIBUTE(combinedCert, HASH(biog_number));
	combinedCert_sort := SORT(combinedCert_dist,
														biog_number, (UNSIGNED)biog_cert_id, record_type,
														   -dt_vendor_last_reported, RECORD,
														LOCAL);
	
	Layouts.Base.Cert rollupCert(Layouts.Base.Cert L,
	                             Layouts.Base.Cert R) := TRANSFORM
    SELF.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported, R.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported := ut.LatestDate(L.dt_vendor_last_reported, R.dt_vendor_last_reported);
																								 
	  SELF := L;
	END;
	
	baseCert := ROLLUP(combinedCert_sort,
										 rollupCert(LEFT, RIGHT),
										 biog_number, RECORD,
										    EXCEPT record_type, dt_vendor_last_reported, dt_vendor_first_reported,
										 LOCAL);

  Layouts.Base.Cert add_description_text(Layouts.Base.Cert L) := TRANSFORM
    SELF.cert_type_ind_desc := MAP(L.cert_type_ind = 'G' => 'GENERAL CERTIFICATE',
		                               L.cert_type_ind = 'S' => 'SUBCERTIFICATE',
																   '');
    SELF.recert_ind_desc    := MAP(L.recert_ind = 'I' => 'INITIAL CERTIFICATION',
		                            L.recert_ind = 'R' => 'RECERTIFICATION',
																'');
    SELF.duration_type_desc := MAP(L.duration_type = 'L' => 'LIFETIME CERTIFICATE (NEVER EXPIRES)',
		                               L.duration_type = 'TL' => 'TIME LIMITED CERTIFICATE',
		                               L.duration_type = 'M' => 'MAINTENANCE OF CERTIFICATION',
																   '');
		SELF.record_type      	:= IF((UNSIGNED)L.expiration_date<(UNSIGNED)ut.GetDate and (UNSIGNED)L.expiration_date>0, 'H','C');														 

    SELF                    := L
	END;

	// Finally, get descriptions.
	baseCertPlusDescriptions := PROJECT(baseCert, add_description_text(LEFT));
	
	// Return
	tools.mac_WriteFile(Filenames(pversion).Base.Cert.New, baseCertPlusDescriptions, Build_Base_File);

	EXPORT full_build := SEQUENTIAL(Build_Base_File,
			                            Promote(pversion).buildfiles.New2Built);
		
	EXPORT All := IF(tools.fun_IsValidVersion(pversion),
		               full_build,
		               OUTPUT('No Valid version parameter passed, skipping ABMS.Build_Base_Cert atribute'));

END;