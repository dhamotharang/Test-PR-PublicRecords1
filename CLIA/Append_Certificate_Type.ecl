EXPORT Append_Certificate_Type(DATASET(Layouts.Base) pDataset) := FUNCTION

/*
	Layouts.Base add_certificate(DATASET(Layouts.Base) input_ds, STRING in_certificate_type) := FUNCTION
	
	  // Deterimine which input dataset we are going to use for the join
		cert_ds :=
		  MAP(in_certificate_type = 'CERTIFICATE OF ACCREDITATION' => Files().Input.Accreditation.Sprayed,
		      in_certificate_type = 'CERTIFICATE OF COMPLIANCE' => Files().Input.Compliance.Sprayed,
					in_certificate_type = 'CERTIFICATE FOR PROVIDER PERFORMED MICROSCOPY' => Files().Input.Microscopy.Sprayed,
					in_certificate_type = 'CERTIFICATE OF WAIVER' => Files().Input.Waiver.Sprayed);
		cert_ds_dist := DISTRIBUTE(cert_ds, HASH(CLIA_number));
	  cert_ds_sort := SORT(cert_ds_dist, CLIA_number, LOCAL);
	  cert_ds_dedup := DEDUP(cert_ds_sort, CLIA_number, LOCAL);
		
		Layouts.Base xform_add_certificate(Layouts.Base L, Layouts.Input R) := TRANSFORM
		  SELF.certificate_type := IF(L.clia_number = R.clia_number, in_certificate_type, L.certificate_type);

      SELF := L;
		END;
		
		RETURN JOIN(input_ds, cert_ds_dedup,
		            LEFT.CLIA_number = RIGHT.CLIA_number,
								xform_add_certificate(LEFT, RIGHT),
								LEFT OUTER,
								LOCAL);

	END;
*/

  // The physical media now has a code for the lab type vs. the description... needs to be translated.
	lab_code_rec := RECORD
	  STRING2  lab_type_code;
		STRING50 lab_type_description;
	END;
	
	lab_code_lookup := DATASET([
	                            {'01', 'AMBULANCE'},
	                            {'02', 'AMBULATORY SURGERY CENTER'},
	                            {'03', 'ANCILLARY TEST SITE IN HEALTH CARE FACILITY'},
	                            {'04', 'ASSISTED LIVING FACILITY'},
	                            {'05', 'BLOOD BANKS'},
	                            {'06', 'COMMUNITY CLINIC'},
	                            {'07', 'COMPREHENSIVE OUTPATIENT REHAB'},
	                            {'08', 'END STAGE RENAL DISEASE DIALYSIS'},
	                            {'09', 'FEDERALLY QUALIFIED HEALTH CENTER'},
	                            {'10', 'HEALTH FAIR'},
	                            {'11', 'HEALTH MAINTENANCE ORGANIZATION'},
	                            {'12', 'HOME HEALTH AGENCY'},
	                            {'13', 'HOSPICE'},
	                            {'14', 'HOSPITAL'},
	                            {'15', 'INDEPENDENT'},
	                            {'16', 'INDUSTRIAL'},
	                            {'17', 'INSURANCE'},
	                            {'18', 'INTERMEDIATE CARE FACILITY-MENTALLY RETARDED'},
	                            {'19', 'MOBILE LAB'},
	                            {'20', 'PHARMACY'},
	                            {'21', 'PHYSICIAN OFFICE'},
	                            {'22', 'OTHER PRACTITIONER (OTHER SPECIFY)'},
	                            {'23', 'PRISON'},
	                            {'24', 'PUBLIC HEALTH LABORATORY'},
	                            {'25', 'RURAL HEALTH CLINIC'},
	                            {'26', 'SCHOOL/STUDENT HEALTH SERVICE'},
	                            {'27', 'SKILLED NURSING/NURSING FACILITY'},
	                            {'28', 'TISSUE BANK/REPOSITORIES'},
	                            {'29', 'OTHER (SPECIFY)'}
														 ], lab_code_rec);

  // Since the CD contains the lab type code, we'll go ahead and do the translation here, at the same
	// time we're doing the certificate type code translation.
  Layouts.Base add_certificate_etc(DATASET(Layouts.Base) input_ds) := FUNCTION
	
	  // We now have the certificate type code in the main base file, just need to translate it		
		Layouts.Base xform_add_certificate(Layouts.Base L) := TRANSFORM
		  SELF.certificate_type := MAP(L.certificate_type_code = '1' => 'CERTIFICATE OF COMPLIANCE',
																	 L.certificate_type_code = '2' => 'CERTIFICATE OF WAIVER',
																	 L.certificate_type_code = '3' => 'CERTIFICATE OF ACCREDITATION',
																	 L.certificate_type_code = '4' => 'CERTIFICATE FOR PROVIDER PERFORMED MICROSCOPY',
																	 '');

      SELF := L;
		END;
		
		base_with_certificates := PROJECT(input_ds, xform_add_certificate(LEFT));
		
		Layouts.Base add_lab_type(Layouts.Base L, lab_code_rec R) := TRANSFORM
		  SELF.lab_type := R.lab_type_description;

      SELF := L;
    END;

    RETURN JOIN(base_with_certificates, lab_code_lookup,
		            LEFT.lab_type_code = RIGHT.lab_type_code,
								add_lab_type(LEFT, RIGHT), skew(1),
								LEFT OUTER, LOOKUP);

	END;
	
	// NOTE: pDataset has already been distributed before being passed in, no need to do it again.	
	// accreditation_ds := add_certificate(pDataset, 'CERTIFICATE OF ACCREDITATION');
	// compliance_ds := add_certificate(accreditation_ds, 'CERTIFICATE OF COMPLIANCE');
	// microscopy_ds := add_certificate(compliance_ds, 'CERTIFICATE FOR PROVIDER PERFORMED MICROSCOPY');
	// waiver_ds := add_certificate(microscopy_ds, 'CERTIFICATE OF WAIVER');

	RETURN add_certificate_etc(pDataset);

END;