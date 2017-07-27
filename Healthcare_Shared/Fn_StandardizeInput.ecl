Import Healthcare_Cleaners, STD;
EXPORT Fn_StandardizeInput := Module
//Set UPIN
		export healthcare_shared.layouts_commonized.layout_all_upin set_UPIN(string upin_in) := function
				healthcare_shared.layouts_commonized.layout_all_upin create_row := transform
					upin := Healthcare_Shared.Functions.cleanAlphaNumeric(upin_in);	
					isCorrectLength := length(upin) = 6;
					firstChar := Healthcare_Shared.Functions.cleanAlpha(upin);
					isFirstAlpha := length(firstChar) = 1;
					isNumeric := length(Healthcare_Shared.Functions.cleanOnlyNumbers(upin[2..])) = 5;
					UpinType := Healthcare_Shared.Functions.upinPractitionerType(firstChar);
					Missing_st := IF(upin_in <>'',0,Healthcare_Shared.Constants.stat_Missing);
					badFormat_st := if(upin_in = '' OR (isCorrectLength and isFirstAlpha and isNumeric),0,Healthcare_Shared.Constants.stat_BadFormat); 
					self.upin 	 := IF(badFormat_st > 0, '', upin);
					self.upin_st := Missing_st+badFormat_st;
				end;
			return row(create_row);
		end;
//Set DEA  
		// export healthcare_shared.layouts_commonized.layout_all_dea set_Dea(string dea_in, string dea_num_exp_in, string dea_num_sch_in, string dea_num_bus_act_ind_in, string dea_num_deact_date_in ) := function
		export healthcare_shared.layouts_commonized.layout_all_dea set_Dea(string dea_in, string name_last) := function
				healthcare_shared.layouts_commonized.layout_all_dea create_row := transform
					//DEA Validation first two positions must be chars , 1st position must be A-U, 2nd =  First Letter of last name
					//length of DEA must be 9 and the Last digit must match the checkDigit formula.
					//CheckDigit (9th position) must match the second digit in result from  (sum of digits(1,3,5) + (2*(sum of digits(2,4,6)))
					isMissing := dea_in = '';
					cln_dea := STD.Str.ToUpperCase(Healthcare_Shared.Functions.cleanAlphaNumeric(dea_in));
          dea_135_sum := (INTEGER) cln_dea[3] + (INTEGER) cln_dea[5] + (INTEGER) cln_dea[7];
          dea_246_sum := (INTEGER) cln_dea[4] + (INTEGER) cln_dea[6] + (INTEGER) cln_dea[8];
          double_246 := 2 * dea_246_sum;
          checkDigit0 := dea_135_sum + double_246;
          checkDigit := IF (checkDigit0 > 9, (INTEGER) checkDigit0[2],(INTEGER) checkDigit0[1]);
          alphaPrefix1 := IF(REGEXFIND('[^A,B,C,D,E,F,G,H,J,K,L,M,N,P,R,S,T,U,W,X,Y,Z]',cln_dea[1]),FALSE,TRUE);
					alphaPrefix2 := IF(REGEXFIND('[^A-Z,9]',cln_dea[2]),FALSE,TRUE);
					alphaPrefix  := alphaPrefix1 and alphaPrefix2;
          numericSuffix := IF(REGEXFIND('[^0-9]',cln_dea[3..9]),FALSE,TRUE);
          checkDigitPass := IF((INTEGER) cln_dea[9] = checkDigit, TRUE, FALSE);
          isValidDEA := IF(LENGTH(cln_dea) = 9 AND alphaPrefix AND numericSuffix, TRUE, FALSE);
					// New check for Non Medical deanum - matches Enclarity except 9 is allowed in 2nd char
					// adding G since Enclarity already has 441 occurences of Dea starting with G.
					isNotMedicalcodechar := IF (REGEXFIND('[^A,B,F,G,M]',cln_dea[1]),TRUE,FALSE);
					isNoTallowed2ndchar  := IF (REGEXFIND('[^A-Z,9]',cln_dea[2]),TRUE,FALSE);
					non_Medical_st := if(isNotMedicalcodechar OR isNoTallowed2ndchar,Healthcare_Shared.Constants.nonMedical,0);
					isValidforName := cln_dea[2] = name_last[1];
					invalidForName_st := if(isValidforName or cln_dea[2] = '9',0,Healthcare_Shared.Constants.invalidForName);
					self.dea_num := trim(Healthcare_Shared.Functions.cleanAlphaNumeric(dea_in),left,right);
					std_dea_num_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																 NOT isValidDEA => Healthcare_Shared.Constants.stat_BadFormat,0);
					checksum_st 	:= if(checkDigitPass,0,Healthcare_Shared.Constants.badCheckSum);											 
					self.dea_num_st := std_dea_num_st + non_Medical_st + checksum_st + invalidForName_st;
				end;
				// output(row(create_row),Named('set_Dea_create_row'),overwrite);
			return row(create_row);
		end;
		//Set NCPDP
		export healthcare_shared.layouts_commonized.layout_all_ncpdp set_NCPDP(string ncpdp_id_in) := function
				healthcare_shared.layouts_commonized.layout_all_ncpdp create_row := transform
					clnncpdp := trim(Healthcare_Shared.Functions.cleanAlphaNumeric(ncpdp_id_in),all);
					isCorrectLength := IF(length(clnncpdp) = 7, true, false);
					isMissing := ncpdp_id_in = '';
					isGoodFormat := isCorrectLength;
					isBadFormat  := NOT isMissing and NOT isGoodFormat;
					self.ncpdp_id := clnncpdp;
					self.ncpdp_id_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
				// output(row(create_row),Named('set_Ncpdp_create_row'),overwrite);
			return row(create_row);
		end;
		//Set Gender
		export healthcare_shared.layouts_commonized.layout_std_male_female set_Gender(string gender_in) := function
				healthcare_shared.layouts_commonized.layout_std_male_female create_row := transform
					clngender := STD.Str.ToUpperCase(trim(gender_in,all));
					isMissing := clngender = '';
					isBadFormat := if (clngender in ['M','F'], false, true);
					self.male_female := if (clngender in ['M','F'], clngender, '');
					self.male_female_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																		isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,
																		0);
				end;
			return row(create_row);
		end;
//Set Phone		
		export healthcare_shared.layouts_commonized.layout_all_phone set_phone(string phone_in) := function
				healthcare_shared.layouts_commonized.layout_all_phone create_row := transform
					self.phone 				:= Healthcare_Shared.functions.cleanAlphaNumeric(phone_in);
					missing_st			  := IF(phone_in = '', Healthcare_Shared.Constants.stat_Missing,0);
					areacode_st       := Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured;  // this will always be set
					self.phone_st			:= missing_st+areacode_st;
				end;
			return row(create_row);
		end;
//Set Fax		
		export healthcare_shared.layouts_commonized.layout_all_fax set_fax(string fax_in) := function
				healthcare_shared.layouts_commonized.layout_all_fax create_row := transform
					self.fax 				:= Healthcare_Shared.functions.cleanAlphaNumeric(fax_in);
					missing_st			:= IF(fax_in = '', Healthcare_Shared.Constants.stat_Missing,0);
					areacode_st     := Healthcare_Shared.Constants.stat_Phone_AreaCodeNotConfigured;  // this will always be set
					self.fax_st			:= missing_st+areacode_st;
				end;
			return row(create_row);
		end;
//Set Email		
		export healthcare_shared.layouts_commonized.layout_all_email set_email(string email_in) := function
				healthcare_shared.layouts_commonized.layout_all_email create_row := transform
					self.email_addr := email_in;
					self.email_addr_st := IF(email_in = '', Healthcare_Shared.Constants.stat_Missing,0);
				end;
			return row(create_row);
		end;
//Set web_site		
		export healthcare_shared.layouts_commonized.layout_all_website set_website(string web_site_in) := function
				healthcare_shared.layouts_commonized.layout_all_website create_row := transform
					self.web_site := web_site_in;
					self.web_site_st := IF(web_site_in = '', Healthcare_Shared.Constants.stat_Missing,0);
				end;
			return row(create_row);
		end;		
//Set TIN		
		export healthcare_shared.layouts_commonized.layout_all_tin set_tin(string tin_in) := function
				TrimmedTin := trim(tin_in,right);
				isMissing := TrimmedTin = '';
				WrongLength := length(TrimmedTin) != 9;
				ValidPrefix := Healthcare_Shared.Functions.isValidTINPrefix(TrimmedTin);
				IsInvalid := TrimmedTin[1] = TrimmedTin[2] and TrimmedTin[1] = TrimmedTin[3] and  TrimmedTin[1] = TrimmedTin[4] and  TrimmedTin[1] = TrimmedTin[5] and  TrimmedTin[1] = TrimmedTin[6]
										 and  TrimmedTin[1] = TrimmedTin[7] and  TrimmedTin[1] = TrimmedTin[8] and  TrimmedTin[1] = TrimmedTin[9];
				isBadFormat := WrongLength or isInvalid or not ValidPrefix and not isMissing;
				healthcare_shared.layouts_commonized.layout_all_tin create_row := transform
					self.tin := Healthcare_Shared.Functions.cleanOnlyNumbers(tin_in);
					self.tin_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;
//Set NPI		
		export healthcare_shared.layouts_commonized.layout_all_npi set_npi(string npi_in,string taxonomy) := function
				healthcare_shared.layouts_commonized.layout_all_npi create_row := transform
					isMissing := if(trim(npi_in,left,right) = '',true,false);
					clnNpi := trim(Healthcare_Shared.Functions.cleanAlphaNumeric(npi_in),left,right);
					NPILength := length(clnNPI);
					isNumeric := NOT isMissing and length(Healthcare_Shared.Functions.cleanOnlyNumbers(clnNpi)) in [10,15];
					isCorrectLength := NPILength in [0,10,15];
					isValidFirstDigit := ((NPILength = 15 and (integer)clnNPI[6] in [1,2]) or (NPILength = 10 and (integer)clnNPI[1] in [1,2]));
					isGoodPrefix:= ((NPILength = 15 and clnNPI[1..5] = '80840') or NPILength = 10);
					isGoodFormat:= isCorrectLength and isNumeric and isGoodPrefix and isValidFirstDigit;
					isBadFormat:= (NOT isMissing ) and (NOT isGoodFormat);
					isValidNPI := HealthCare_Shared.Functions.fn_NPICheckSum(clnNPI); // Separate Invalid ustat based on CheckSum or CheckDigit
					self.npi_num := clnNpi;
					self.npi_drc := '';				
					self.taxonomy_mprd := taxonomy;
					self.last_update_date := '';
					self.npi_deact_date := '';
					self.npi_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,
																	 NOT isValidNPI => Healthcare_Shared.Constants.stat_Invalid,0);
			end;
			// output(row(create_row),Named('set_Npi_create_row'),overwrite);
			return row(create_row);
		end;	
//set Taxonomy
		export healthcare_shared.layouts_commonized.layout_all_taxonomy set_taxonomy(string taxonomy_in) := function
				healthcare_shared.layouts_commonized.layout_all_taxonomy create_row() := transform
					cln_taxonomy_in:=trim(taxonomy_in,left,right);
					self.taxonomy := Healthcare_Shared.Functions.cleanAlphaNumeric(trim(taxonomy_in,left,right));
					ui_isCorrectLength := length(cln_taxonomy_in) in[10,0];
					ui_islastAlpha := cln_taxonomy_in[10] in['X','x',''];
					ui_isInvalid := if(NOT ui_islastAlpha or NOT ui_isCorrectLength ,1,0);
					ui_taxMissing := IF(taxonomy_in <>'',0,Healthcare_Shared.Constants.stat_Missing);
					ui_taxbadFormat := if(taxonomy_in='' or(ui_isCorrectLength and ui_islastAlpha) ,0,Healthcare_Shared.Constants.stat_BadFormat); 
					self.taxonomy_st := ui_taxMissing+ui_taxbadFormat+ui_isInvalid;
				end;
			return row(create_row());
		end;	
//Set License		
		export healthcare_shared.layouts_commonized.layout_all_license set_license(string lic_num_in, string lic_state_in, string lic_type_in, string prac_state, boolean subPracStateForEmptyLicState) := function
				healthcare_shared.layouts_commonized.layout_all_license create_row := transform
					license_parsed := healthcare_shared.Functions_License.fn_parseLicense(lic_num_in, lic_state_in, lic_type_in, prac_state,subPracStateForEmptyLicState);
					self.lic_num := license_parsed[1].parsed_input_license_num;
					self.lic_state := license_parsed[1].parsed_input_license_state;
					self.lic_type := license_parsed[1].parsed_input_license_type;
					self.lic_st := if(lic_num_in = '',Healthcare_Shared.Constants.stat_Missing, 0);
				end;
			return row(create_row);
		end;
//Set CLIA		
		export healthcare_shared.layouts_commonized.layout_all_clia set_clia(string clia_num_in) := function
				healthcare_shared.layouts_commonized.layout_all_clia create_row := transform
					isMissing := clia_num_in = '';
					isCorrectLength := length(trim(clia_num_in,all)) = 10; //Length of Code is always 10 characters. Can be numbers or letters 
					hasChar := clia_num_in[3] in ['C','D','X']; //Third letter of CLIA code is always a C, D or X. 
					isGoodFormat := isCorrectLength and hasChar;
					isBadFormat := not isMissing and not isGoodFormat;
					self.clia_num := STD.Str.toUpperCase(clia_num_in);
					self.clia_data_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
					self:=[];
				end;
			return row(create_row);
		end;
//Set Medicare		
		export healthcare_shared.layouts_commonized.layout_all_medicare set_medicare(string medicare_in) := function
				healthcare_shared.layouts_commonized.layout_all_medicare create_row := transform
					isMissing := medicare_in = '';
					isCorrectLength := length(trim(medicare_in,all)) = 6 or length(trim(medicare_in,all)) = 10;
					isBadFormat := not isCorrectLength;
					self.medicare_fac_num := Healthcare_Shared.Functions.cleanAlphaNumeric(medicare_in);
					self.medicare_fac_num_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																					isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
//Set Medicaid		
		export healthcare_shared.layouts_commonized.layout_all_medicaid set_medicaid(string medicaid_in) := function
				healthcare_shared.layouts_commonized.layout_all_medicaid create_row := transform
					isMissing := medicaid_in = '';
					isCorrectLength := length(medicaid_in) = 6 or length(medicaid_in) = 10;
					isBadFormat := not isCorrectLength;
					self.medicaid_fac_num := Healthcare_Shared.Functions.cleanAlphaNumeric(medicaid_in);
					self.medicaid_fac_num_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																					isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
//Set birthdate		
		export healthcare_shared.layouts_commonized.layout_all_birthdate set_birthdate(string birthdate_in) := function
				healthcare_shared.layouts_commonized.layout_all_birthdate create_row := transform
					isMissing := birthdate_in = '' or birthdate_in= '0';
					// isCorrectLength := length(birthdate_in) = 8;
					// isBadFormat := not isMissing and not isCorrectLength;
					dob := Healthcare_Shared.Functions.cleanOnlyNumbers(birthdate_in);
					dob_st := Healthcare_Shared.Functions.getDateStat(dob);
					self.birthdate := dob;
					self.birthdate_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing,
																	 dob_st);
				end;
			// output(row(create_row),Named('set_birthdate_create_row'),overwrite);
			return row(create_row);
		end;		
//Set ssn		
		export healthcare_shared.layouts_commonized.layout_all_ssn set_ssn(string ssn_in) := function
				healthcare_shared.layouts_commonized.layout_all_ssn create_row := transform
					ssnNumber := trim(Healthcare_Shared.Functions.cleanOnlyNumbers(ssn_in));
					isMissing := ssnNumber = '';
					ds_ssnbadlist8 := ['00000000','11111111','22222222','33333333','44444444','55555555',
														 '66666666','77777777','88888888','99999999','23456789','87654321',
														 '12345678','76543210','21212121','23121234','04040404','40404040'];
					ds_ssnbadlist9 := ['000000000','111111111','222222222','333333333','444444444','555555555',
														 '666666666','777777777','888888888','999999999','121212121','123121234',
														 '123456789','012345678','987654321','876543210','404040404','040404040'];			
			
					ssn_in_length := length(ssnNumber);
					cooked_ssn := map( ssn_in_length = 7 => trim('00')+ssnNumber,
														 ssn_in_length = 8 => trim('0')+ssnNumber,
														 ssn_in_length = 9 => ssnNumber,
														 '');
					cooked_ssn_length := 	length(cooked_ssn);								 
					isCorrect_ssn_in_Length := ssn_in_length = 9;
					isCorrect_cooked_ssn_Length := cooked_ssn_length =9;
					// No zeroes in Area , Group or Serial allowed
					isInvalidArea   := cooked_ssn[1..3] = '000' OR cooked_ssn[1] = '9';
					isInvalidGroup  := cooked_ssn[4..5]  = '00';
					isInvalidSerial := cooked_ssn[6..9]  = '0000';
					isFoundinBadList := map ( ssn_in_length = 8 and ssnNumber in ds_ssnbadlist8 => true,
																		ssn_in_length = 9 and ssnNumber in ds_ssnbadlist9 => true,
																		false);
					isGoodDefinition := NOT isInvalidArea and NOT isInvalidGroup and NOT isInvalidSerial and NOT isFoundinBadList; 
					isGoodLength		 := isCorrect_ssn_in_Length OR isCorrect_cooked_ssn_Length;
					isBadFormat := (not isGoodDefinition OR not isGoodLength) and not isMissing;
					stat_Missing 				:= IF(IsMissing,Healthcare_Shared.Constants.stat_Missing,0);
					stat_InvalidArea 		:= IF(isInvalidArea,Healthcare_Shared.Constants.invalidArea,0);
					stat_InvalidGroup 	:= IF(isInvalidGroup,Healthcare_Shared.Constants.invalidGroup,0);
					stat_InvalidSerial  := IF(isInvalidSerial,Healthcare_Shared.Constants.invalidSerial,0);
					stat_BadFormat 			:= IF(IsBadFormat,Healthcare_Shared.Constants.stat_BadFormat,0);
					self.ssn_st 				:= stat_Missing + stat_InvalidArea +  stat_InvalidGroup + stat_InvalidSerial + stat_Badformat;
					self.ssn := cooked_ssn;   // pass on via candidates the orig or cooked (pre-fixed with 0 or 00) ssn
					end;
			return row(create_row);
		end;		
//Set specialty		
		export healthcare_shared.layouts_commonized.layout_all_specialty set_specialty(string specialty_in, string subspecialty) := function
				healthcare_shared.layouts_commonized.layout_all_specialty create_row := transform
					isMissing := specialty_in = '';
					isBadFormat := false;//reserved for validation function for valid specialties
					cleanSpecialty := Healthcare_Shared.Functions.convertSpecialty2Int(specialty_in,subspecialty);
					self.specialty := cleanSpecialty;
					self.specialty_st := map(isMissing => Healthcare_Shared.Constants.stat_Missing + Healthcare_Shared.Constants.stat_Invalid,
																	 isBadFormat => Healthcare_Shared.Constants.stat_BadFormat,0);
				end;
			return row(create_row);
		end;		
	export STRING fn_make_address_key(Healthcare_Cleaners.Layouts.cleanAddressOutput stdAddr) := FUNCTION
		// If the rec_type is 'R' (rural route), isolate the RR number, then the box
		rr_num := 		if (stdAddr.rec_type = 'R',
									stringlib.StringFilter(stdAddr.prim_name, '0123456789'),	// isolate the digits
									'');
		rr_box_num := if (stdAddr.rec_type = 'R',
									stringlib.StringFilter(stdAddr.sec_range, '0123456789'),	// isolate the digits
									'');
		// If the rec_type is 'P' (PO BOX), isolate the box #
		pob_num := 		if (stdAddr.rec_type = 'P' and STD.Str.ToUpperCase(stdAddr.prim_name)[1..6] = 'PO BOX',
									stringlib.StringFilter(stdAddr.prim_name, '0123456789'),	// isolate the digits
									'');
		Street_address_string := TRIM( stdAddr.zip +'_'
												+ 'S' +'_'
												+ stdAddr.prim_name + '_'
												+ stdAddr.prim_range + '_'
												+ stdAddr.predir + '_'
												+ stdAddr.postdir + '_'
												+ '_'+ '_'	// used in tight addr key construction only (not used by LN).
												+ stdAddr.addr_suffix + '_'
												,ALL);
		RR_address_string := TRIM( stdAddr.zip + '_'
												+ 'R' + '_'
												+ rr_num + '_'
												+ rr_box_num + '_'
												,ALL);
		PO_address_string := TRIM( stdAddr.zip +'_'
												+ 'P' + '_'
												+ pob_num + '_'
												,ALL);
		isGoodPO := stdAddr.rec_type = 'P' and pob_num != '';
		isGoodRR := stdAddr.rec_type = 'R' and (rr_num != '' or rr_box_num != '');
		isGoodStreet := stdAddr.prim_name != '';
		string_to_use := map(isGoodPO => PO_address_string, 
												 isGoodRR => RR_address_string, 
												 isGoodStreet => Street_address_string, '');
		addrstring := STD.Str.ToUpperCase(string_to_use);
		// If we have a good string to build the hash from, use it. Otherwise return blank.
		addr_key := if(addrstring != '', INTFORMAT(Healthcare_Shared.Fn_CheckSum.create_crc32_key(addrstring,LENGTH(addrstring)),10,1)+INTFORMAT(Healthcare_Shared.Fn_CheckSum.mod11(addrstring,LENGTH(addrstring)),10,1), '');
		return (STRING)addr_key;
	END;
	Export string make_primary_address_string(Healthcare_Cleaners.Layouts.cleanAddressOutput stdAddr) := function
			cat_clean(string s) := if (s != '', (trim(s, left, right) + ' '), '');
			return 			cat_clean(stdAddr.prim_range) + 
									cat_clean(stdAddr.predir) + 
									cat_clean(stdAddr.prim_name) + 
									cat_clean(stdAddr.addr_suffix) + 
									cat_clean(stdAddr.postdir) +
									cat_clean(stdAddr.unit_desig) + 
									cat_clean(stdAddr.sec_range) +
//									cat_clean(stdAddr.po_box_nbr) +
									cat_clean(stdAddr.rural_box_nbr) + 
									cat_clean(stdAddr.non_postal_unit_nbr);
									
	end;
End;