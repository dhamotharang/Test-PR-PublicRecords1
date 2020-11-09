IMPORT _Validate, ALC, MDR, STD, ut;

EXPORT Standardize_Input(STRING pversion, BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT Apply_Common_Xform(pInputFile, pLayout, pIsPilotLawyerInsurance = FALSE, pIsInsurance = FALSE) := FUNCTIONMACRO
		ALC.Layouts.Base xform(pLayout L):= TRANSFORM
		  #IF(NOT(pIsPilotLawyerInsurance))
		    the_degree          := ut.CleanSpacesAndUpper(L.degree);
				the_specialty       := ut.CleanSpacesAndUpper(L.specialty);
				the_email           := ut.CleanSpacesAndUpper(L.email);
				the_license_no      := ut.CleanSpacesAndUpper(L.license_no);
				bad_email           := ['NULL', 'NO EMAIL ADDRESS', 'N/A', 'NA', 'NO EMAIL PROVIDED',
				                        'NO EMAIL GIVEN', 'NONE', 'NONE PROVIDED', 'NO E-MAIL ADDRESS GIVEN'];
				bad_license_no      := ['NONE'];
				bad_specialty       := ['0000'];

				SELF.degree         := IF(REGEXFIND('(NOT APPLICABL|NO DEGREE|UNKN)', the_degree),
				                          '',
																	the_degree);
        SELF.email          := IF(the_email IN bad_email, '', the_email);
        SELF.license_no     := IF(the_license_no IN bad_license_no, '', the_license_no);
        SELF.specialty      := IF(the_specialty IN bad_specialty, '', the_specialty);
				SELF.specialty_desc := IF(the_specialty IN bad_specialty, '', the_specialty);
				SELF.clean_dob      := IF(_Validate.Date.fIsValid(L.dob) AND
																		 _Validate.Date.fIsValid(L.dob, _Validate.Date.Rules.DateInPast),
																	L.dob,
																	'');
		  #END

			the_company           := ut.CleanSpacesAndUpper(L.company);
			the_gender            := ut.CleanSpacesAndUpper(L.gender);

      SELF.fname            := ut.CleanSpacesAndUpper(L.fname);
      SELF.lname            := ut.CleanSpacesAndUpper(L.lname);
      SELF.title            := ut.CleanSpacesAndUpper(L.title);
      SELF.company          := IF(StringLib.StringFind(the_company, 'NOT REPORTED', 1) > 0,
			                            '',
															    the_company);
      SELF.address1         := ut.CleanSpacesAndUpper(L.address1);
      SELF.address2         := ut.CleanSpacesAndUpper(L.address2);
      SELF.city             := ut.CleanSpacesAndUpper(L.city);
      SELF.state            := ut.CleanSpacesAndUpper(L.state);
      SELF.gender           := the_gender;
      SELF.addr_type        := ut.CleanSpacesAndUpper(L.addr_type);
			SELF.clean_gender     := IF(the_gender IN ['M', 'F'], the_gender, '');
			#IF(NOT(pIsInsurance))
			  SELF.clean_phone    := ut.CleanPhone(L.phone);
			#END
			SELF.keycode          := ut.CleanSpacesAndUpper(L.keycode);
			SELF.src              := MDR.sourceTools.src_ALC;
			SELF.dt_first_seen    := (UNSIGNED)pversion;
			SELF.dt_last_seen     := (UNSIGNED)pversion;
			SELF.dt_vendor_first_reported := (UNSIGNED)pversion;
			SELF.dt_vendor_last_reported  := (UNSIGNED)pversion;

			SELF := L;
			SELF := [];
		END;

		RETURN PROJECT(pInputFile, xform(LEFT));
	ENDMACRO;

  // Dates from this vendor are either in the 8-digit format, the 6-digit format, or have various
	//   combinations of numbers with 2 slashes (almost always a 2-digit year, but 1 or 2 digits with
	//   the month and day).  We take care of a couple odd cases and everything else is considered
	//   invalid.
  EXPORT Convert_Date(STRING pDate) := FUNCTION
	  fix_letter_o   := TRIM(StringLib.StringFindReplace(pDate, 'O', '0'));
		// Remove space and digit at the end of date string.  It allows me to capture a few extra dates.
	  the_date       := REGEXREPLACE(' [0-9]$', fix_letter_o, '');

	  do_not_convert := REGEXFIND('[0-9]{8}', the_date) OR 
		                     (LENGTH(the_date) = 6 AND REGEXFIND('[0-9]{6}', the_date));
		is_convertable := REGEXFIND('^[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}([0-9]{2})?$', the_date);
		first_slash    := IF(is_convertable, StringLib.StringFind(the_date, '/', 1), 0);
		second_slash   := IF(is_convertable, StringLib.StringFind(the_date, '/', 2), 0);
		month          := IF(is_convertable, the_date[1..first_slash - 1], '');
		day            := IF(is_convertable, the_date[first_slash + 1..second_slash - 1], '');
		year           := IF(is_convertable, the_date[second_slash + 1..], '');
		final_month    := IF(LENGTH(month) = 1, '0' + month, month);
		final_day      := IF(LENGTH(day) = 1, '0' + day, day);
		final_year     := IF(LENGTH(year) = 4,
		                     year,
												 IF((UNSIGNED)year > 50, '19' + year, '20' + year));
		final_date     := MAP(NOT(is_convertable) => '',
		                      (UNSIGNED)month > 12 => '',
											    final_year + final_month + final_day);

    RETURN MAP(do_not_convert => the_date,
							 final_date);
  END;

  // There are some fields that contain multiple codes, separated by 1 or many #(s).  This function
	//   takes the string of code(s) and returns a string with their description text.  For example:
	//   '1#2#3#' becomes 'desctiption1#description2#description3#'.  Extra #(s) are unwanted in the
	//   final output.
	// ASSUMPTION: no NULLS are coming through... check for NULL before calling function.
	EXPORT Get_Description(pInput, code_type) := FUNCTIONMACRO
		input_delimiter_clean := REGEXREPLACE('#{2,}', TRIM(pInput), '#');
		// Remove those that are only a single # and remove the #, if it's the first character.
		input_cleaned         := IF(input_delimiter_clean = '#',
		                            '',
																IF(input_delimiter_clean[1] = '#',
																   input_delimiter_clean[2..],
																	 input_delimiter_clean));

		input_rec := RECORD
			STRING        input_string;
			SET OF STRING parsed_input;
			STRING        code;
			STRING        final_string;
		END;

		ds_input := DATASET([{input_cleaned, {''}, '', ''}], input_rec);

		input_rec split_input(input_rec L) := TRANSFORM
			SELF.parsed_input := STD.Str.SplitWords(L.input_string, '#');

			SELF := L;
		END;

		ds_input_split := PROJECT(ds_input, split_input(LEFT));

		input_rec add_code(input_rec L, INTEGER C) := TRANSFORM
			SELF.code := L.parsed_input[C];

			SELF := L;
		END;

		ds_input_norm := NORMALIZE(ds_input_split, COUNT(LEFT.parsed_input), add_code(LEFT, COUNTER));

		input_rec concat_description(input_rec L, input_rec R) := TRANSFORM
		  description := TRIM(ALC.Lookups(TRIM(R.code)).code_type);

      // If there is no code or description, we want nothing.
			SELF.final_string := L.final_string + IF(R.code != '',
			                                         IF(description != '',
			                                            description + '#',
																									''),
																							 '');
			SELF := R;
		END;

		ds_input_iterate := ITERATE(ds_input_norm, concat_description(LEFT, RIGHT));

		RETURN ds_input_iterate[COUNT(ds_input_iterate)].final_string;
	ENDMACRO;

  // Accountants have no license type or anything else that needs normalization.
	EXPORT Accountants := FUNCTION
    input               := ALC.Files(pversion, pUseProd).Input.Accountants;
		input_initial_clean := Apply_Common_Xform(input, ALC.Layouts.Input.Accountants);

		ALC.Layouts.Base clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_orig_date := Convert_Date(L.orig_date);
		  the_exp_date  := Convert_Date(L.exp_date);

      SELF.alc_prof_type   := 'ACCOUNTANT';
      SELF.clean_orig_date := IF(_Validate.Date.fIsValid(the_orig_date) AND
		                                _Validate.Date.fIsValid(the_orig_date, _Validate.Date.Rules.DateInPast),
									               the_orig_date,
									               '');
      SELF.clean_exp_date  := IF(_Validate.Date.fIsValid(the_exp_date),
									               the_exp_date,
									               '');
      SELF.company_type    := ut.CleanSpacesAndUpper(L.company_type);
			SELF.job_code_desc   := MAP(L.job_code = '1#' => 'CPA',
			                            L.job_code = '4#' => 'ENROLLED AGENT',
																  '');

		  SELF := L;
			SELF := [];
		END;

		RETURN PROJECT(input_initial_clean, clean_input(LEFT));
  END;

  // Dental professionals need normalization on license_type and specialty_code (they are connected
	//   to each other).
	EXPORT Dental_Professionals := FUNCTION
    input               := ALC.Files(, pUseProd).Input.Dental_Professionals;
		input_initial_clean := Apply_Common_Xform(input, ALC.Layouts.Input.Dental_Professionals);

		ALC.Layouts.Base_Plus clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_orig_date    := Convert_Date(L.orig_date);
		  the_exp_date     := Convert_Date(L.exp_date); // This one is only 6-digits long
			the_license_type := ut.CleanSpacesAndUpper(L.license_type);

      SELF.alc_prof_type        := 'DENTAL PROFESSIONAL';
      SELF.clean_orig_date      := IF(_Validate.Date.fIsValid(the_orig_date) AND
		                                     _Validate.Date.fIsValid(the_orig_date, _Validate.Date.Rules.DateInPast),
									                    the_orig_date,
									                    '');
      SELF.clean_exp_date       := IF(_Validate.Date.fIsValid(the_exp_date, _Validate.Date.Rules.MonthValid),
									                    the_exp_date,
									                    '');
      SELF.license_state        := ut.CleanSpacesAndUpper(L.license_state);
      SELF.license_type         := the_license_type;
			SELF.license_type_desc    := IF(the_license_type != '',
                                      Get_Description(the_license_type, Dental_License_Type_Codes),
																	    '');
			SELF.specialty_code_desc  := IF(L.specialty_code != '',
                                      Get_Description(L.specialty_code, Dental_Specialty_Codes),
																	    '');
			SELF.license_type_count   := StringLib.StringFindCount(SELF.license_type_desc, '#');
			SELF.specialty_code_count := StringLib.StringFindCount(SELF.specialty_code_desc, '#');

		  SELF := L;
			SELF := [];
		END;

		input_cleaned := PROJECT(input_initial_clean, clean_input(LEFT));

    // Figure out the number of times to normalize.
    max_num_license_type   := MAX(input_cleaned, license_type_count);
    max_num_specialty_code := MAX(input_cleaned, specialty_code_count);
    max_number             := MAX(max_num_license_type, max_num_specialty_code);

    // The skip makes sure we don't create extra records with nothing in both of the fields that
		//   contain the single text for license type description and for specialty code description.
		ALC.Layouts.Base xform(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP((C > L.license_type_count AND C > L.specialty_code_count) OR
			         (L.specialty_code_count > L.license_type_count AND L.license_type_count NOT IN [0, 1] AND
							  C > L.license_type_count))
			license_type_pound_clean    := REGEXREPLACE('#{2,}', TRIM(L.license_type), '#');
			license_type_cleaned        := IF(license_type_pound_clean = '#',
		                                    '',
																        IF(license_type_pound_clean[1] = '#',
																           license_type_pound_clean[2..],
																	         license_type_pound_clean));
			specialty_code_pound_clean  := REGEXREPLACE('#{2,}', TRIM(L.specialty_code), '#');
			specialty_code_cleaned      := IF(specialty_code_pound_clean = '#',
		                                    '',
																        IF(specialty_code_pound_clean[1] = '#',
																           specialty_code_pound_clean[2..],
																	         specialty_code_pound_clean));
			start_lt_index              := IF(C = 1,
			                                  1,
													              StringLib.StringFind(L.license_type_desc, '#', C - 1) + 1);
			end_lt_index                := StringLib.StringFind(L.license_type_desc, '#', C) - 1;
			first_word_end_lt_index     := StringLib.StringFind(L.license_type_desc, '#', 1) - 1;
			start_lt_acr_index          := IF(C = 1,
			                                  1,
													              StringLib.StringFind(license_type_cleaned, '#', C - 1) + 1);
			end_lt_acr_index            := StringLib.StringFind(license_type_cleaned, '#', C) - 1;
			first_word_end_lt_acr_index := StringLib.StringFind(license_type_cleaned, '#', 1) - 1;
			start_sc_index              := IF(C = 1,
			                                  1,
													              StringLib.StringFind(L.specialty_code_desc, '#', C - 1) + 1);
			end_sc_index                := StringLib.StringFind(L.specialty_code_desc, '#', C) - 1;
			first_word_end_sc_index     := StringLib.StringFind(L.specialty_code_desc, '#', 1) - 1;
			start_sc_acr_index          := IF(C = 1,
			                                  1,
													              StringLib.StringFind(specialty_code_cleaned, '#', C - 1) + 1);
			end_sc_acr_index            := StringLib.StringFind(specialty_code_cleaned, '#', C) - 1;
			first_word_end_sc_acr_index := StringLib.StringFind(specialty_code_cleaned, '#', 1) - 1;

      // We want every license_type, regardless of the count in specialty_code.
			SELF.license_type_singular_desc :=
			  MAP(L.license_type_count = 0  => '',
				    L.license_type_count = 1  => L.license_type_desc[1..first_word_end_lt_index],
						C <= L.license_type_count => L.license_type_desc[start_lt_index..end_lt_index],
						'');
			SELF.license_type_singular :=
			  MAP(L.license_type_count = 0  => '',
				    L.license_type_count = 1  => license_type_cleaned[1..first_word_end_lt_acr_index],
						C <= L.license_type_count => license_type_cleaned[start_lt_acr_index..end_lt_acr_index],
						'');

      // We only want the specialty_code if there is only 1, the count equals the license_type count,
			//   or if there's more than license_type, only when there is either 0 or 1 licence_type.
			SELF.specialty_code_singular_desc :=
			  MAP(L.specialty_code_count = 0 => '',
				    L.specialty_code_count = 1 => L.specialty_code_desc[1..first_word_end_sc_index],
						L.license_type_count > 1 AND L.license_type_count != L.specialty_code_count => '',
						L.specialty_code_desc[start_sc_index..end_sc_index]);
			SELF.specialty_code_singular :=
			  MAP(L.specialty_code_count = 0 => '',
				    L.specialty_code_count = 1 => specialty_code_cleaned[1..first_word_end_sc_acr_index],
						L.license_type_count > 1 AND L.license_type_count != L.specialty_code_count => '',
						specialty_code_cleaned[start_sc_acr_index..end_sc_acr_index]);

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for either field.  The transform will handle when the two fields are uneven... we want the
		//   license_type broken out regardless and will break out specialty_code if license_type is
		//   empty or has one value.
		input_blanks := input_cleaned(license_type_count = 0 AND specialty_code_count = 0);

		input_to_normalize := input_cleaned(license_type_count != 0 OR specialty_code_count != 0);
		input_cleaned_norm := NORMALIZE(input_to_normalize, max_number, xform(LEFT, COUNTER));

    RETURN PROJECT(input_blanks, ALC.Layouts.Base) + input_cleaned_norm;
  END;

  // Insurance Agents need normalization on insurance_type.
	EXPORT Insurance_Agents := FUNCTION
    input               := ALC.Files(, pUseProd).Input.Insurance_Agents;
		input_initial_clean := Apply_Common_Xform(input, ALC.Layouts.Input.Insurance_Agents, TRUE, TRUE);

		ALC.Layouts.Base_Plus clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_license_type                := IF((UNSIGNED)L.license_type = 1,
			                                      'INSURANCE AGENTS',
																			      '');

      SELF.alc_prof_type              := 'INSURANCE AGENT';
			SELF.insurance_type_desc        := IF(L.insurance_type != '',
                                            Get_Description(L.insurance_type, Insurance_Type_Codes),
																	          '');
			SELF.insurance_type_count       := StringLib.StringFindCount(SELF.insurance_type_desc, '#');
			// With Insurance Agents, the license type only has 1 value.
			SELF.license_type               := L.license_type;
			SELF.license_type_desc          := the_license_type;
			SELF.license_type_singular      := L.license_type;
			SELF.license_type_singular_desc := the_license_type;

		  SELF := L;
			SELF := [];
		END;

		input_cleaned := PROJECT(input_initial_clean, clean_input(LEFT));

    // Figure out the number of times to normalize.
    max_number := MAX(input_cleaned, insurance_type_count);

    // The skip makes sure we don't create extra records with nothing in the field that contains the
		//   single text for the insurance type description.
		ALC.Layouts.Base xform(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP(C > L.insurance_type_count)
			insurance_type_pound_clean        := REGEXREPLACE('#{2,}', TRIM(L.insurance_type), '#');
			insurance_type_cleaned            := IF(insurance_type_pound_clean = '#',
		                                          '',
																              IF(insurance_type_pound_clean[1] = '#',
																                 insurance_type_pound_clean[2..],
																	               insurance_type_pound_clean));
			start_it_index                    := IF(C = 1,
			                                        1,
													                    StringLib.StringFind(L.insurance_type_desc, '#', C - 1) + 1);
			end_it_index                      := StringLib.StringFind(L.insurance_type_desc, '#', C) - 1;
			start_it_acr_index                := IF(C = 1,
			                                        1,
													                    StringLib.StringFind(insurance_type_cleaned, '#', C - 1) + 1);
			end_it_acr_index                  := StringLib.StringFind(insurance_type_cleaned, '#', C) - 1;

			SELF.insurance_type_singular_desc := L.insurance_type_desc[start_it_index..end_it_index];
			SELF.insurance_type_singular      := insurance_type_cleaned[start_it_acr_index..end_it_acr_index];

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for the insurance type field.
		input_blanks := input_cleaned(insurance_type_count = 0);

		input_to_normalize := input_cleaned(insurance_type_count != 0);
		input_cleaned_norm := NORMALIZE(input_to_normalize, max_number, xform(LEFT, COUNTER));

    RETURN PROJECT(input_blanks, ALC.Layouts.Base) + input_cleaned_norm;
  END;

  // Lawyers need normalization on practice_area.
	EXPORT Lawyers := FUNCTION
    input               := ALC.Files(, pUseProd).Input.Lawyers;
		input_initial_clean := Apply_Common_Xform(input, ALC.Layouts.Input.Lawyers, TRUE);

		ALC.Layouts.Base_Plus clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_practice_area            := ut.CleanSpacesAndUpper(L.practice_area);
		  the_title_cd_desc            := IF(L.title_cd != '',
                                         Get_Description(L.title_cd, Lawyer_Title_Codes),
																	       '');
			// Remove the # at the end of the string.
			the_title_cd_desc_trim       := IF(the_title_cd_desc != '',
			                                   the_title_cd_desc[1..LENGTH(the_title_cd_desc) - 1],
																				 '');

      SELF.alc_prof_type           := 'LAWYER';
      SELF.number_of_lawyers_range := ut.CleanSpacesAndUpper(L.number_of_lawyers_range);
      SELF.practice_area           := the_practice_area;
			SELF.practice_area_desc      := IF(the_practice_area != '',
                                         Get_Description(the_practice_area, Lawyer_Practice_Area_Codes),
																	       '');
			SELF.title_cd_desc           := StringLib.StringFindReplace(the_title_cd_desc_trim, '#', '/');
			SELF.practice_area_count     := StringLib.StringFindCount(SELF.practice_area_desc, '#');

		  SELF := L;
			SELF := [];
		END;

		input_cleaned := PROJECT(input_initial_clean, clean_input(LEFT));

    // Figure out the number of times to normalize.
    max_number := MAX(input_cleaned, practice_area_count);

    // The skip makes sure we don't create extra records with nothing in the field that contains the
		//   single text for the practice area description.
		ALC.Layouts.Base xform(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP(C > L.practice_area_count)
			practice_area_pound_clean        := REGEXREPLACE('#{2,}', TRIM(L.practice_area), '#');
			practice_area_cleaned            := IF(practice_area_pound_clean = '#',
		                                         '',
																             IF(practice_area_pound_clean[1] = '#',
																                practice_area_pound_clean[2..],
																	              practice_area_pound_clean));
			start_pa_index                   := IF(C = 1,
			                                       1,
													                   StringLib.StringFind(L.practice_area_desc, '#', C - 1) + 1);
			end_pa_index                     := StringLib.StringFind(L.practice_area_desc, '#', C) - 1;
			start_pa_acr_index               := IF(C = 1,
			                                       1,
													                   StringLib.StringFind(practice_area_cleaned, '#', C - 1) + 1);
			end_pa_acr_index                 := StringLib.StringFind(practice_area_cleaned, '#', C) - 1;

			SELF.practice_area_singular_desc := L.practice_area_desc[start_pa_index..end_pa_index];
			SELF.practice_area_singular      := practice_area_cleaned[start_pa_acr_index..end_pa_acr_index];

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for the practice area field.
		input_blanks := input_cleaned(practice_area_count = 0);

		input_to_normalize := input_cleaned(practice_area_count != 0);
		input_cleaned_norm := NORMALIZE(input_to_normalize, max_number, xform(LEFT, COUNTER));

    RETURN PROJECT(input_blanks, ALC.Layouts.Base) + input_cleaned_norm;
  END;

  // Nurses need normalization on nurse_type (basically license type) and specialty (they are
	//   connected to each other).
	EXPORT Nurses := FUNCTION
		input01 := ALC.Files(, pUseProd).Input.Nurses1 +
								ALC.Files(, pUseProd).Input.Nurses2 +
								ALC.Files(, pUseProd).Input.Nurses3;
	  input:=  DEDUP(SORT(DISTRIBUTE(input01(TRIM(fname) <> '' AND TRIM(license_no) <> ''), HASH32(custno, license_no)), custno, license_no, LOCAL));

		nurses4_01 := ALC.Files(, pUseProd).Input.Nurses4; 
		nurses4:=  DEDUP(SORT(DISTRIBUTE(nurses4_01(TRIM(licstate) <> ''), HASH32(custno, licstate)), custno, licstate, LOCAL));
		nurses4_slim := PROJECT(nurses4, {LEFT.custno, LEFT.lic_no, LEFT.licstate});

		full_state_join := JOIN(input, nurses4_slim, LEFT.custno = RIGHT.custno AND LEFT.license_no = RIGHT.lic_no, FULL OUTER);  

		RECORDOF(full_state_join) xLicState(RECORDOF(full_state_join) l) := TRANSFORM
			SELF.reg_state := IF(l.licstate <> '', l.licstate, l.reg_state);
			SELF := l;
		END;

		correcting_input01 := PROJECT(full_state_join, xLicState(LEFT))(TRIM(fname) <> '' AND TRIM(license_no) <> '');
		correcting_input := DEDUP(SORT(DISTRIBUTE(correcting_input01, HASH32(custno, license_no)), custno, license_no, LOCAL));

		ambiguous_states :=  DEDUP(JOIN(correcting_input, correcting_input, 
					LEFT.custno = RIGHT.custno AND LEFT.license_no = RIGHT.license_no AND LEFT.reg_state <> RIGHT.reg_state, INNER, LOCAL));
		ambiguous_fixed_with_licstate := DEDUP(JOIN(correcting_input, correcting_input, 
					LEFT.custno = RIGHT.custno AND LEFT.license_no = RIGHT.license_no AND LEFT.reg_state <> RIGHT.reg_state, INNER, LOCAL)  (std.str.contains(reg_state, state, FALSE)));

		fix_ambig_step1 := correcting_input - ambiguous_states;
		fix_ambig_step2 := PROJECT((fix_ambig_step1(fname<>'') + ambiguous_fixed_with_licstate(fname<>'')), ALC.Layouts.Input.Nurses) ;  //  new filter

		input_initial_clean := Apply_Common_Xform(fix_ambig_step2, ALC.Layouts.Input.Nurses);

		ALC.Layouts.Base_Plus clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_orig_date := Convert_Date(L.orig_date);
		  the_exp_date  := Convert_Date(L.exp_date);

      SELF.alc_prof_type      := 'NURSE';
      SELF.clean_orig_date    := IF(_Validate.Date.fIsValid(the_orig_date) AND
		                                   _Validate.Date.fIsValid(the_orig_date, _Validate.Date.Rules.DateInPast),
									                  the_orig_date,
									                  '');
      SELF.clean_exp_date     := IF(_Validate.Date.fIsValid(the_exp_date),
									                  the_exp_date,
									                  '');
      SELF.reg_state          := ut.CleanSpacesAndUpper(L.reg_state);
			SELF.license_type_desc  := IF(L.nurse_type != '',
                                    Get_Description(L.nurse_type, Nurse_Type_Codes),
																	  '');
			// specialty for nurses holds 1->M specialties, unlike everyone else.
			SELF.specialty_desc     := IF(L.specialty != '',
                                    Get_Description(L.specialty, Nurse_Specialty_Codes),
																    '');
			SELF.license_type_count := StringLib.StringFindCount(SELF.license_type_desc, '#');
			SELF.specialty_count    := StringLib.StringFindCount(SELF.specialty_desc, '#');
			SELF.reg_state_count    := StringLib.StringFindCount(SELF.reg_state, '#');

		  SELF := L;
			SELF := [];
		END;

		input_cleaned := PROJECT(input_initial_clean, clean_input(LEFT));

    // Figure out the number of times to normalize.
    max_num_license_type := MAX(input_cleaned, license_type_count);
    max_num_specialty    := MAX(input_cleaned, specialty_count);
    max_number           := MAX(max_num_license_type, max_num_specialty);

    // The skip makes sure we don't create extra records with nothing in both of the fields that
		//   contain the single text for license type description and for specialty description.
		ALC.Layouts.Base_Plus xform(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP((C > L.license_type_count AND C > L.specialty_count) OR
			         (L.specialty_count > L.license_type_count AND L.license_type_count NOT IN [0, 1] AND
							  C > L.license_type_count))
			license_type_pound_clean    := REGEXREPLACE('#{2,}', TRIM(L.nurse_type), '#');
			license_type_cleaned        := IF(license_type_pound_clean = '#',
		                                    '',
																        IF(license_type_pound_clean[1] = '#',
																           license_type_pound_clean[2..],
																	         license_type_pound_clean));
			specialty_pound_clean       := REGEXREPLACE('#{2,}', TRIM(L.specialty), '#');
			specialty_cleaned           := IF(specialty_pound_clean = '#',
		                                    '',
																        IF(specialty_pound_clean[1] = '#',
																           specialty_pound_clean[2..],
																	         specialty_pound_clean));
			start_lt_index              := IF(C = 1,
			                                  1,
													              StringLib.StringFind(L.license_type_desc, '#', C - 1) + 1);
			end_lt_index                := StringLib.StringFind(L.license_type_desc, '#', C) - 1;
			first_word_end_lt_index     := StringLib.StringFind(L.license_type_desc, '#', 1) - 1;
			start_lt_acr_index          := IF(C = 1,
			                                  1,
													              StringLib.StringFind(license_type_cleaned, '#', C - 1) + 1);
			end_lt_acr_index            := StringLib.StringFind(license_type_cleaned, '#', C) - 1;
			first_word_end_lt_acr_index := StringLib.StringFind(license_type_cleaned, '#', 1) - 1;
			start_s_index               := IF(C = 1,
			                                  1,
													              StringLib.StringFind(L.specialty_desc, '#', C - 1) + 1);
			end_s_index                 := StringLib.StringFind(L.specialty_desc, '#', C) - 1;
			first_word_end_s_index      := StringLib.StringFind(L.specialty_desc, '#', 1) - 1;
			start_s_acr_index           := IF(C = 1,
			                                  1,
													              StringLib.StringFind(specialty_cleaned, '#', C - 1) + 1);
			end_s_acr_index             := StringLib.StringFind(specialty_cleaned, '#', C) - 1;
			first_word_end_s_acr_index  := StringLib.StringFind(specialty_cleaned, '#', 1) - 1;

      // We want every license_type, regardless of the count in specialty.
			SELF.license_type_singular_desc :=
			  MAP(L.license_type_count = 0  => '',
				    L.license_type_count = 1  => L.license_type_desc[1..first_word_end_lt_index],
						C <= L.license_type_count => L.license_type_desc[start_lt_index..end_lt_index],
						'');
			SELF.license_type_singular :=
			  MAP(L.license_type_count = 0  => '',
				    L.license_type_count = 1  => license_type_cleaned[1..first_word_end_lt_acr_index],
						C <= L.license_type_count => license_type_cleaned[start_lt_acr_index..end_lt_acr_index],
						'');

      // We only want the specialty if there is only 1, the count equals the license_type count,
			//   or if there's more than license_type, only when there is either 0 or 1 licence_type.
			SELF.specialty_singular_desc :=
			  MAP(L.specialty_count = 0 => '',
				    L.specialty_count = 1 => L.specialty_desc[1..first_word_end_s_index],
						L.license_type_count > 1 AND L.license_type_count != L.specialty_count => '',
						L.specialty_desc[start_s_index..end_s_index]);
			SELF.specialty_singular :=
			  MAP(L.specialty_count = 0 => '',
				    L.specialty_count = 1 => specialty_cleaned[1..first_word_end_s_acr_index],
						L.license_type_count > 1 AND L.license_type_count != L.specialty_count => '',
						specialty_cleaned[start_s_acr_index..end_s_acr_index]);

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for either field.  The transform will handle when the two fields are uneven... we want the
		//   license_type broken out regardless and will break out specialties if license_type is
		//   empty or has one value.
		input_blanks := input_cleaned(license_type_count = 0 AND specialty_count = 0);

		input_to_normalize := input_cleaned(license_type_count != 0 OR specialty_count != 0);
		input_cleaned_norm := NORMALIZE(input_to_normalize, max_number, xform(LEFT, COUNTER));
		input_pseudo_final := input_blanks + input_cleaned_norm;

    // Figure out the number of times to normalize.
    max_num_reg_state := MAX(input_cleaned, reg_state_count);

		ALC.Layouts.Base xform_reg_state(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP(C > L.reg_state_count)
			reg_state_pound_clean   := REGEXREPLACE('#{2,}', TRIM(L.reg_state), '#');
			reg_state_cleaned       := IF(reg_state_pound_clean = '#',
		                                '',
																    IF(reg_state_pound_clean[1] = '#',
																       reg_state_pound_clean[2..],
																	     reg_state_pound_clean));
			start_rs_index          := IF(C = 1,
			                              1,
													          StringLib.StringFind(L.reg_state, '#', C - 1) + 1);
			end_rs_index            := StringLib.StringFind(L.reg_state, '#', C) - 1;

			SELF.reg_state_singular := reg_state_cleaned[start_rs_index..end_rs_index];

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for the reg state field.
		input_blanks_reg_state := input_pseudo_final(reg_state_count = 0);

    input_to_normalize_reg_state := input_pseudo_final(reg_state_count != 0);
		input_reg_state_norm := NORMALIZE(input_to_normalize_reg_state, max_num_reg_state, xform_reg_state(LEFT, COUNTER));

    RETURN PROJECT(input_blanks_reg_state, ALC.Layouts.Base) + input_reg_state_norm;
  END;





  // Pharmacists need normalization on license_type.
	EXPORT Pharmacists := FUNCTION
    input               := ALC.Files(, pUseProd).Input.Pharmacists;
		input_initial_clean := Apply_Common_Xform(input, ALC.Layouts.Input.Pharmacists);

		ALC.Layouts.Base_Plus clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_orig_date    := Convert_Date(L.orig_date); // This one is only 6-digits long
		  the_exp_date     := Convert_Date(L.exp_date); // This one is only 6-digits long
			the_license_type := ut.CleanSpacesAndUpper(L.license_type);

      SELF.alc_prof_type      := 'PHARMACIST';
			SELF.clean_fax          := ut.CleanPhone(L.fax);
      SELF.clean_orig_date    := IF(_Validate.Date.fIsValid(the_orig_date, _Validate.Date.Rules.MonthValid) AND
		                                   _Validate.Date.fIsValid(the_orig_date, _Validate.Date.Rules.DateInPast),
									                  the_orig_date,
									                  '');
      SELF.clean_exp_date     := IF(_Validate.Date.fIsValid(the_exp_date, _Validate.Date.Rules.MonthValid),
									                  the_exp_date,
									                  '');
      SELF.license_state      := ut.CleanSpacesAndUpper(L.license_state);
      SELF.license_type       := the_license_type;
			SELF.license_type_desc  := IF(the_license_type != '',
                                    Get_Description(the_license_type, Pharmacist_License_Type_Codes),
																	  '');
			SELF.license_type_count := StringLib.StringFindCount(SELF.license_type_desc, '#');

		  SELF := L;
			SELF := [];
		END;

		input_cleaned := PROJECT(input_initial_clean, clean_input(LEFT));

    // Figure out the number of times to normalize.
    max_number := MAX(input_cleaned, license_type_count);

    // The skip makes sure we don't create extra records with nothing in the field that contains the
		//   single text for the license type description.
		ALC.Layouts.Base xform(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP(C > L.license_type_count)
			license_type_pound_clean        := REGEXREPLACE('#{2,}', TRIM(L.license_type), '#');
			license_type_cleaned            := IF(license_type_pound_clean = '#',
		                                        '',
																            IF(license_type_pound_clean[1] = '#',
																               license_type_pound_clean[2..],
																	             license_type_pound_clean));
			start_lt_index                  := IF(C = 1,
			                                      1,
													                  StringLib.StringFind(L.license_type_desc, '#', C - 1) + 1);
			end_lt_index                    := StringLib.StringFind(L.license_type_desc, '#', C) - 1;
			start_lt_acr_index              := IF(C = 1,
			                                      1,
													                  StringLib.StringFind(license_type_cleaned, '#', C - 1) + 1);
			end_lt_acr_index                := StringLib.StringFind(license_type_cleaned, '#', C) - 1;

			SELF.license_type_singular_desc := L.license_type_desc[start_lt_index..end_lt_index];
			SELF.license_type_singular      := license_type_cleaned[start_lt_acr_index..end_lt_acr_index];

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for the license type field.
		input_blanks := input_cleaned(license_type_count = 0);

		input_to_normalize := input_cleaned(license_type_count != 0);
		input_cleaned_norm := NORMALIZE(input_to_normalize, max_number, xform(LEFT, COUNTER));

    RETURN PROJECT(input_blanks, ALC.Layouts.Base) + input_cleaned_norm;
  END;

  // Pilots need normalization on cert_type and cert_lvl (they are connected to each other).  There
	//   also needs normalization on cert_type_secondary and rating (they are connected to each other).
	EXPORT Pilots := FUNCTION
    input               := ALC.Files(, pUseProd).Input.Pilots;
		input_initial_clean := Apply_Common_Xform(input, ALC.Layouts.Input.Pilots, TRUE);

		ALC.Layouts.Base_Plus clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_cert_lvl            := ut.CleanSpacesAndUpper(L.cert_lvl);
		  the_cert_type           := ut.CleanSpacesAndUpper(L.cert_type);
		  the_cert_type_secondary := ut.CleanSpacesAndUpper(L.cert_type_secondary);

      SELF.alc_prof_type             := 'PILOT';
      SELF.cert_lvl_desc             := IF(the_cert_lvl != '',
																					 Get_Description(the_cert_lvl, Pilot_Cert_Lvl_Codes),
																					 '');
      SELF.cert_type_desc            := IF(the_cert_type != '',
																					 Get_Description(the_cert_type, Pilot_Cert_Type_Codes),
																					 '');
      SELF.cert_type_secondary_desc  := IF(the_cert_type_secondary != '',
																					 Get_Description(the_cert_type_secondary, Pilot_Cert_Type_Secondary_Codes),
																					 '');
      SELF.rating_desc               := IF(L.rating != '',
																					 Get_Description(L.rating, Pilot_Rating_Codes),
																					 '');
			SELF.cert_lvl_count            := StringLib.StringFindCount(SELF.cert_lvl_desc, '#');
			SELF.cert_type_count           := StringLib.StringFindCount(SELF.cert_type_desc, '#');
			SELF.cert_type_secondary_count := StringLib.StringFindCount(SELF.cert_type_secondary_desc, '#');
			SELF.rating_count              := StringLib.StringFindCount(SELF.rating_desc, '#');

		  SELF := L;
			SELF := [];
		END;

		input_cleaned := PROJECT(input_initial_clean, clean_input(LEFT));

    // Figure out the number of times to normalize.
    max_num_cert_type := MAX(input_cleaned, cert_type_count);
    max_num_cert_lvl  := MAX(input_cleaned, cert_lvl_count);
    max_number_cert   := MAX(max_num_cert_type, max_num_cert_lvl);

    // The skip makes sure we don't create extra records with nothing in both of the fields that
		//   contain the single text for cert type description and for cert lvl description.
		ALC.Layouts.Base_Plus xform_cert(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP(C > L.cert_type_count AND C > L.cert_lvl_count)
			cert_type_pound_clean       := REGEXREPLACE('#{2,}', TRIM(L.cert_type), '#');
			cert_type_cleaned           := IF(cert_type_pound_clean = '#',
		                                    '',
																        IF(cert_type_pound_clean[1] = '#',
																           cert_type_pound_clean[2..],
																	         cert_type_pound_clean));
			cert_lvl_pound_clean        := REGEXREPLACE('#{2,}', TRIM(L.cert_lvl), '#');
			cert_lvl_cleaned            := IF(cert_lvl_pound_clean = '#',
		                                    '',
																        IF(cert_lvl_pound_clean[1] = '#',
																           cert_lvl_pound_clean[2..],
																	         cert_lvl_pound_clean));
			start_ct_index              := IF(C = 1,
			                                  1,
													              StringLib.StringFind(L.cert_type_desc, '#', C - 1) + 1);
			end_ct_index                := StringLib.StringFind(L.cert_type_desc, '#', C) - 1;
			first_word_end_ct_index     := StringLib.StringFind(L.cert_type_desc, '#', 1) - 1;
			start_ct_acr_index          := IF(C = 1,
			                                  1,
													              StringLib.StringFind(cert_type_cleaned, '#', C - 1) + 1);
			end_ct_acr_index            := StringLib.StringFind(cert_type_cleaned, '#', C) - 1;
			first_word_end_ct_acr_index := StringLib.StringFind(cert_type_cleaned, '#', 1) - 1;
			start_cl_index              := IF(C = 1,
			                                  1,
													              StringLib.StringFind(L.cert_lvl_desc, '#', C - 1) + 1);
			end_cl_index                := StringLib.StringFind(L.cert_lvl_desc, '#', C) - 1;
			first_word_end_cl_index     := StringLib.StringFind(L.cert_lvl_desc, '#', 1) - 1;
			start_cl_acr_index          := IF(C = 1,
			                                  1,
													              StringLib.StringFind(cert_lvl_cleaned, '#', C - 1) + 1);
			end_cl_acr_index            := StringLib.StringFind(cert_lvl_cleaned, '#', C) - 1;
			first_word_end_cl_acr_index := StringLib.StringFind(cert_lvl_cleaned, '#', 1) - 1;

			SELF.cert_type_singular_desc :=
			  MAP(L.cert_type_count = 0 => '',
				    L.cert_type_count = 1 => L.cert_type_desc[1..first_word_end_ct_index],
						L.cert_type_desc[start_ct_index..end_ct_index]);
			SELF.cert_type_singular :=
			  MAP(L.cert_type_count = 0 => '',
				    L.cert_type_count = 1 => cert_type_cleaned[1..first_word_end_ct_acr_index],
						cert_type_cleaned[start_ct_acr_index..end_ct_acr_index]);

			SELF.cert_lvl_singular_desc :=
			  MAP(L.cert_lvl_count = 0 => '',
				    L.cert_lvl_count = 1 => L.cert_lvl_desc[1..first_word_end_cl_index],
						L.cert_lvl_desc[start_cl_index..end_cl_index]);
			SELF.cert_lvl_singular :=
			  MAP(L.cert_lvl_count = 0 => '',
				    L.cert_lvl_count = 1 => cert_lvl_cleaned[1..first_word_end_cl_acr_index],
						cert_lvl_cleaned[start_cl_acr_index..end_cl_acr_index]);

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for either field and when the number of cert types doesn't equal the number of cert
		//   levels, except if one of them is empty or has a single value.
		input_blanks_cert := input_cleaned(cert_type_count = 0 AND cert_lvl_count = 0);
		input_not_equal_cert := input_cleaned(cert_type_count != cert_lvl_count AND
		                                         cert_type_count NOT IN [0, 1] AND cert_lvl_count NOT IN [0, 1]);

		input_to_normalize_cert := input_cleaned((cert_type_count != 0 AND cert_lvl_count != 0 AND cert_type_count = cert_lvl_count) OR
		                                            (cert_type_count != cert_lvl_count AND (cert_type_count IN [0, 1] OR cert_lvl_count IN [0, 1])));
		input_cleaned_norm_cert := NORMALIZE(input_to_normalize_cert, max_number_cert, xform_cert(LEFT, COUNTER));

		input_cleaned_cert := input_blanks_cert + input_not_equal_cert + input_cleaned_norm_cert;

    // Figure out the number of times to normalize.
    max_num_cert_type_secondary := MAX(input_cleaned_cert, cert_type_secondary_count);
    max_num_rating              := MAX(input_cleaned_cert, rating_count);
    max_number                  := MAX(max_num_cert_type_secondary, max_num_rating);

    // The skip makes sure we don't create extra records with nothing in both of the fields that
		//   contain the single text for cert type secondary description and for rating description.
		ALC.Layouts.Base xform(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP(C > L.cert_type_secondary_count AND C > L.rating_count)
			cert_type_sec_pound_clean    := REGEXREPLACE('#{2,}', TRIM(L.cert_type_secondary), '#');
			cert_type_sec_cleaned        := IF(cert_type_sec_pound_clean = '#',
		                                     '',
																         IF(cert_type_sec_pound_clean[1] = '#',
																            cert_type_sec_pound_clean[2..],
																	          cert_type_sec_pound_clean));
			rating_pound_clean           := REGEXREPLACE('#{2,}', TRIM(L.rating), '#');
			rating_cleaned               := IF(rating_pound_clean = '#',
		                                     '',
																         IF(rating_pound_clean[1] = '#',
																            rating_pound_clean[2..],
																	          rating_pound_clean));
			start_cts_index              := IF(C = 1,
			                                   1,
														             StringLib.StringFind(L.cert_type_secondary_desc, '#', C - 1) + 1);
			end_cts_index                := StringLib.StringFind(L.cert_type_secondary_desc, '#', C) - 1;
			first_word_end_cts_index     := StringLib.StringFind(L.cert_type_secondary_desc, '#', 1) - 1;
			start_cts_acr_index          := IF(C = 1,
			                                   1,
														             StringLib.StringFind(cert_type_sec_cleaned, '#', C - 1) + 1);
			end_cts_acr_index            := StringLib.StringFind(cert_type_sec_cleaned, '#', C) - 1;
			first_word_end_cts_acr_index := StringLib.StringFind(cert_type_sec_cleaned, '#', 1) - 1;
			start_r_index                := IF(C = 1,
			                                   1,
														             StringLib.StringFind(L.rating_desc, '#', C - 1) + 1);
			end_r_index                  := StringLib.StringFind(L.rating_desc, '#', C) - 1;
			first_word_end_r_index       := StringLib.StringFind(L.rating_desc, '#', 1) - 1;
			start_r_acr_index            := IF(C = 1,
			                                   1,
														             StringLib.StringFind(rating_cleaned, '#', C - 1) + 1);
			end_r_acr_index              := StringLib.StringFind(rating_cleaned, '#', C) - 1;
			first_word_end_r_acr_index   := StringLib.StringFind(rating_cleaned, '#', 1) - 1;

			SELF.cert_type_secondary_singular_desc :=
			  MAP(L.cert_type_secondary_count = 0 => '',
				    L.cert_type_secondary_count = 1 => L.cert_type_secondary_desc[1..first_word_end_cts_index],
						L.cert_type_secondary_desc[start_cts_index..end_cts_index]);
			SELF.cert_type_secondary_singular :=
			  MAP(L.cert_type_secondary_count = 0 => '',
				    L.cert_type_secondary_count = 1 => cert_type_sec_cleaned[1..first_word_end_cts_acr_index],
						cert_type_sec_cleaned[start_cts_acr_index..end_cts_acr_index]);

			SELF.rating_singular_desc :=
			  MAP(L.rating_count = 0 => '',
				    L.rating_count = 1 => L.rating_desc[1..first_word_end_r_index],
						L.rating_desc[start_r_index..end_r_index]);
			SELF.rating_singular :=
			  MAP(L.rating_count = 0 => '',
				    L.rating_count = 1 => rating_cleaned[1..first_word_end_r_acr_index],
						rating_cleaned[start_r_acr_index..end_r_acr_index]);

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for either field and when the number of cert type secondary doesn't equal the number of
		//   ratings, except if one of them is empty or has a single value.
		input_blanks := input_cleaned_cert(cert_type_secondary_count = 0 AND rating_count = 0);
		input_not_equal := input_cleaned_cert(cert_type_secondary_count != rating_count AND
		                                         cert_type_secondary_count NOT IN [0, 1] AND rating_count NOT IN [0, 1]);

		input_to_normalize := input_cleaned_cert((cert_type_secondary_count != 0 AND rating_count != 0 AND cert_type_secondary_count = rating_count) OR
		                                            (cert_type_secondary_count != rating_count AND (cert_type_secondary_count IN [0, 1] OR rating_count IN [0, 1])));
		input_cleaned_norm := NORMALIZE(input_to_normalize, max_number, xform(LEFT, COUNTER));

    RETURN PROJECT(input_blanks + input_not_equal, ALC.Layouts.Base) + input_cleaned_norm;
  END;

  // Professionals need normalization on license_type and license_class (they are connected to each
	//   other).
	EXPORT Professionals := FUNCTION
    input               := ALC.Files(, pUseProd).Input.Professionals1 +
		                          ALC.Files(, pUseProd).Input.Professionals2 +
								              ALC.Files(, pUseProd).Input.Professionals3;
		input_initial_clean := Apply_Common_Xform(input, ALC.Layouts.Input.Professionals);

		ALC.Layouts.Base_Plus clean_input(ALC.Layouts.Base L) := TRANSFORM
		  the_orig_date    := Convert_Date(L.orig_date);
		  the_exp_date     := Convert_Date(L.exp_date);
			the_license_type := ut.CleanSpacesAndUpper(L.license_type);

      SELF.alc_prof_type       := 'PROFESSIONAL';
      SELF.clean_orig_date     := IF(_Validate.Date.fIsValid(the_orig_date) AND
		                                    _Validate.Date.fIsValid(the_orig_date, _Validate.Date.Rules.DateInPast),
									                   the_orig_date,
									                   '');
      SELF.clean_exp_date      := IF(_Validate.Date.fIsValid(the_exp_date),
									                   the_exp_date,
									                   '');
      SELF.license_state       := ut.CleanSpacesAndUpper(L.license_state);
      SELF.license_type        := the_license_type;
			SELF.license_class_desc  := IF(L.license_class != '',
                                     Get_Description(L.license_class, Professional_License_Class_Codes),
																	   '');
			SELF.license_type_desc   := IF(the_license_type != '',
                                     Get_Description(the_license_type, Professional_License_Type_Codes),
																	   '');
			SELF.license_type_count  := StringLib.StringFindCount(SELF.license_type_desc, '#');
			SELF.license_class_count := StringLib.StringFindCount(SELF.license_class_desc, '#');

		  SELF := L;
			SELF := [];
		END;

		input_cleaned := PROJECT(input_initial_clean, clean_input(LEFT));

    // Figure out the number of times to normalize.
    max_num_license_type  := MAX(input_cleaned, license_type_count);
    max_num_license_class := MAX(input_cleaned, license_class_count);
    max_number            := MAX(max_num_license_type, max_num_license_class);

    // The skip makes sure we don't create extra records with nothing in both of the fields that
		//   contain the single text for license type description and for license class description.
		ALC.Layouts.Base xform(ALC.Layouts.Base_Plus L, INTEGER C) := TRANSFORM,
		   SKIP((C > L.license_type_count AND C > L.license_class_count) OR
			         (L.license_class_count > L.license_type_count AND L.license_type_count NOT IN [0, 1] AND
							  C > L.license_type_count))
			license_type_pound_clean    := REGEXREPLACE('#{2,}', TRIM(L.license_type), '#');
			license_type_cleaned        := IF(license_type_pound_clean = '#',
		                                    '',
																        IF(license_type_pound_clean[1] = '#',
																           license_type_pound_clean[2..],
																	         license_type_pound_clean));
			license_class_pound_clean   := REGEXREPLACE('#{2,}', TRIM(L.license_class), '#');
			license_class_cleaned       := IF(license_class_pound_clean = '#',
		                                    '',
																        IF(license_class_pound_clean[1] = '#',
																           license_class_pound_clean[2..],
																	         license_class_pound_clean));
			start_lt_index              := IF(C = 1,
			                                  1,
																	      StringLib.StringFind(L.license_type_desc, '#', C - 1) + 1);
			end_lt_index                := StringLib.StringFind(L.license_type_desc, '#', C) - 1;
			first_word_end_lt_index     := StringLib.StringFind(L.license_type_desc, '#', 1) - 1;
			start_lt_acr_index          := IF(C = 1,
			                                  1,
													              StringLib.StringFind(license_type_cleaned, '#', C - 1) + 1);
			end_lt_acr_index            := StringLib.StringFind(license_type_cleaned, '#', C) - 1;
			first_word_end_lt_acr_index := StringLib.StringFind(license_type_cleaned, '#', 1) - 1;
			start_lc_index              := IF(C = 1,
			                                  1,
																	      StringLib.StringFind(L.license_class_desc, '#', C - 1) + 1);
			end_lc_index                := StringLib.StringFind(L.license_class_desc, '#', C) - 1;
			first_word_end_lc_index     := StringLib.StringFind(L.license_class_desc, '#', 1) - 1;
			start_lc_acr_index          := IF(C = 1,
			                                  1,
																	      StringLib.StringFind(license_class_cleaned, '#', C - 1) + 1);
			end_lc_acr_index            := StringLib.StringFind(license_class_cleaned, '#', C) - 1;
			first_word_end_lc_acr_index := StringLib.StringFind(license_class_cleaned, '#', 1) - 1;

      // We want every license_type, regardless of the count in license_class.
			SELF.license_type_singular_desc :=
			  MAP(L.license_type_count = 0  => '',
				    L.license_type_count = 1  => L.license_type_desc[1..first_word_end_lt_index],
						C <= L.license_type_count => L.license_type_desc[start_lt_index..end_lt_index],
						'');
			SELF.license_type_singular :=
			  MAP(L.license_type_count = 0  => '',
				    L.license_type_count = 1  => license_type_cleaned[1..first_word_end_lt_acr_index],
						C <= L.license_type_count => license_type_cleaned[start_lt_acr_index..end_lt_acr_index],
						'');

      // We only want the license_class if there is only 1, the count equals the license_type count,
			//   or if there's more than license_type, only when there is either 0 or 1 licence_type.
			SELF.license_class_singular_desc :=
			  MAP(L.license_class_count = 0 => '',
				    L.license_class_count = 1 => L.license_class_desc[1..first_word_end_lc_index],
						L.license_type_count > 1 AND L.license_type_count != L.license_class_count => '',
						L.license_class_desc[start_lc_index..end_lc_index]);
			SELF.license_class_singular :=
			  MAP(L.license_class_count = 0 => '',
				    L.license_class_count = 1 => license_class_cleaned[1..first_word_end_lc_acr_index],
						L.license_type_count > 1 AND L.license_type_count != L.license_class_count => '',
						license_class_cleaned[start_lc_acr_index..end_lc_acr_index]);

			SELF := L;
		END;

    // Break out records that we don't want put through normalization: records that contain nothing
		//   for either field.  The transform will handle when the two fields are uneven... we want the
		//   license_type broken out regardless and will break out license_class if license_type is
		//   empty or has one value.
		input_blanks := input_cleaned(license_type_count = 0 AND license_class_count = 0);

		input_to_normalize := input_cleaned(license_type_count != 0 OR license_class_count != 0);
		input_cleaned_norm := NORMALIZE(input_to_normalize, max_number, xform(LEFT, COUNTER));

    RETURN PROJECT(input_blanks, ALC.Layouts.Base) + input_cleaned_norm;
  END;

END;
