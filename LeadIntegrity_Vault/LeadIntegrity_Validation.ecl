IMPORT LeadIntegrity_Vault_Layout, _control, LeadIntegrity_Vault;

Layout_LeadIntegrity_Attr_Output := RECORD
	unsigned4 seq;
	unsigned6 lexid;
	LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Layout_Slimmed;
END;

EXPORT LeadIntegrity_Validation(STRING8 date_in, STRING part_in) := MODULE

		EXPORT dset_Input_Validation() := FUNCTION

				dset_Input := DATASET(LeadIntegrity_Vault.Constants.MMPrefix + date_in+ '_' + TRIM(part_in)+'_of_15', LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Inlayout, THOR);
	
				dset_Input_lexid := DISTRIBUTE(dset_Input,HASH64(lexid));	

				dset_Input_seq := DISTRIBUTE(dset_Input,HASH64(seq));	

				lay_tab1 := RECORD
					dset_Input_lexid.lexid;
					cnt := COUNT(GROUP);
				END;

				tab1 := TABLE(dset_Input_lexid,lay_tab1,lexid,LOCAL)(cnt > 1);

				lay_tab2 := RECORD
					dset_Input_seq.seq;
					cnt := COUNT(GROUP);
				END;

				tab2 := TABLE(dset_Input_seq,lay_tab2,seq,LOCAL)(cnt > 1);

				fn_IndvFilecount(STRING2 part) := FUNCTION
					IndvFilecount := DATASET(LeadIntegrity_Vault.Constants.MMPrefix + date_in+ '_' + TRIM(part_in)+'_of_15', 
																	 LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Inlayout,
																	 CSV(HEADING(SINGLE),SEPARATOR('|')),OPT);
					RETURN IndvFilecount;
				END;

				splitfilecount := COUNT(fn_IndvFilecount('1')+fn_IndvFilecount('2')+fn_IndvFilecount('3')+fn_IndvFilecount('4')+fn_IndvFilecount('5')+
																fn_IndvFilecount('6')+fn_IndvFilecount('7')+fn_IndvFilecount('8')+fn_IndvFilecount('9')+fn_IndvFilecount('10')+
																fn_IndvFilecount('11')+fn_IndvFilecount('12')+fn_IndvFilecount('13')+fn_IndvFilecount('14')+fn_IndvFilecount('15'));

  			Input_duplicate_lexid_Check                := IF(COUNT(tab1) > 0,'FAIL','PASS');
				Input_duplicate_seq_Check                  := IF(COUNT(tab2) > 0,'FAIL','PASS');
				Input_zero_lexid_Check                     := IF(COUNT(dset_Input(lexid = 0)) > 0,'FAIL','PASS');
				Input_zero_seq_Check                       := IF(COUNT(dset_Input(seq = 0)) > 0,'FAIL','PASS');
				Input_insuranceonly_lexid_Check            := IF(COUNT(dset_Input(LENGTH(TRIM((STRING20)lexid)) > 12)) > 0,'FAIL','PASS');
				InputFile_SplitFile_Reccount_Check         := IF(SUM(splitfilecount) != COUNT(dset_Input),'FAIL','PASS');


				Lay_input_validation := RECORD
					STRING8 Build_period;
					STRING  TestCase_Name;
					STRING4 Status;
				END;

				res_in  := DATASET([{TRIM(date_in),'Input_duplicate_lexid_Check',Input_duplicate_lexid_Check},
														{TRIM(date_in),'Input_duplicate_seq_Check',Input_duplicate_seq_Check},
														{TRIM(date_in),'Input_zero_lexid_Check',Input_zero_lexid_Check},
														{TRIM(date_in),'Input_zero_seq_Check',Input_zero_seq_Check},
														{TRIM(date_in),'Input_insuranceonly_lexid_Check',Input_insuranceonly_lexid_Check},
														{TRIM(date_in),'InputFile_SplitFile_Reccount_Check',InputFile_SplitFile_Reccount_Check}],
													//	{TRIM(date_in),'ThorSplitFile_RmtDirFile_Filecount_Check',ThorSplitFile_RmtDirFile_Filecount_Check},
													//	{TRIM(date_in),'IH_Core_Check',IH_Core_Check}], 
													  Lay_input_validation);
				
				RETURN res_in; 		 
		END;

		EXPORT dset_Output_Validation(STRING8 date_in, STRING2 part_in) := FUNCTION

				lead_integrity_input_suffix := date_in+ '_' + TRIM(part_in)+'_of_15';
																					
				lead_integrity_output_suffix := date_in + '::lead_integrity_attrib::p' + TRIM(part_in);  

				dset_Input := DISTRIBUTE(DATASET(LeadIntegrity_Vault.Constants.MMPrefix + lead_integrity_input_suffix,
																			   LeadIntegrity_Vault_Layout.Layout_LeadIntegrity_Inlayout,
																				 CSV(HEADING(0),SEPARATOR('|')))(acctno<>'acctno'),HASH64(lexid));

				dset_output := DISTRIBUTE(DATASET(LeadIntegrity_Vault.Constants.ARPrefix + lead_integrity_output_suffix,
																					Layout_LeadIntegrity_Attr_Output,
																				  CSV(HEADING(0),SEPARATOR('|'),quote('"'))),HASH64(lexid));

				dset_validate_input_output := JOIN(dset_Input, dset_output,
																					 LEFT.lexid = RIGHT.lexid// and
																					 // LEFT.seq = RIGHT.seq
																					 , LOCAL);	
				
				dset_CurrAddrDwellType := dset_output(CurrAddrDwellType NOT IN ['-1','F','G','H','M','P','R','S','U','']);
				dset_Curraddrapplicantowned := dset_output(Curraddrapplicantowned NOT IN ['0','1','-1','']);
				dset_EducationAttendedCollege := dset_output(EducationAttendedCollege NOT IN ['0','1','']);
				dset_PropertyOwner := dset_output(PropertyOwner NOT IN ['0','1','']);
				dset_BankruptcyType := dset_output(BankruptcyType NOT IN ['-1','I','B','']);
				dset_scorename1 := dset_output(scorename1 NOT IN ['MSN1106_0']);
				dset_scorevalue := dset_output(score1 = '' OR
																			 (INTEGER)score1 NOT BETWEEN 0 AND 999);
				dset_mismatch := dset_output(lexid != (INTEGER)did AND (INTEGER)did != 0);
				dset_did_zero_percentage := COUNT(dset_output((INTEGER)did = 0))/COUNT(dset_output);
				
				output_total_Reccount_Chk := IF(COUNT(dset_Input) != COUNT(dset_output),'FAIL','PASS');
				input_output_col_Chk := IF(COUNT(dset_validate_input_output) != COUNT(dset_Input),'FAIL','PASS');
				CurrAddrDwellType_Invalid := IF(COUNT(dset_CurrAddrDwellType) > 0,'FAIL','PASS');
				Curraddrapplicantowned_Invalid := IF(COUNT(dset_Curraddrapplicantowned) > 0,'FAIL','PASS');
				EducationAttendedCollege_Invalid := IF(COUNT(dset_EducationAttendedCollege) > 0,'FAIL','PASS');
				PropertyOwner_Invalid := IF(COUNT(dset_PropertyOwner) > 0,'FAIL','PASS');
				BankruptcyType_Invalid := IF(COUNT(dset_BankruptcyType) > 0,'FAIL','PASS');
				scorename1_Invalid := IF(COUNT(dset_scorename1) > 0,'FAIL','PASS');
				scorevalue_Invalid := IF(COUNT(dset_scorevalue) > 0,'FAIL','PASS');
				did_lexid_chk := IF(COUNT(dset_mismatch) > 0,'FAIL','PASS');
				did_zero_percentage_chk := IF(dset_did_zero_percentage > 0.05,'FAIL','PASS');
												
				Lay_output_validation := RECORD
					STRING8 Build_period;
					STRING2 File_Part;
					STRING  TestCase_Name;
					STRING4 Status;
				END;

				res_out  := DATASET([{TRIM(date_in),TRIM(part_in),'Output_total_Reccount_Check',output_total_Reccount_Chk},
														 {TRIM(date_in),TRIM(part_in),'Input_output_columnmatch_Check',input_output_col_Chk},
														 {TRIM(date_in),TRIM(part_in),'CurrAddrDwellType_Invalid',CurrAddrDwellType_Invalid},
														 {TRIM(date_in),TRIM(part_in),'Curraddrapplicantowned_Invalid',Curraddrapplicantowned_Invalid},
														 {TRIM(date_in),TRIM(part_in),'EducationAttendedCollege_Invalid',EducationAttendedCollege_Invalid},
														 {TRIM(date_in),TRIM(part_in),'PropertyOwner_Invalid',PropertyOwner_Invalid},
														 {TRIM(date_in),TRIM(part_in),'BankruptcyType_Invalid',BankruptcyType_Invalid},
														 {TRIM(date_in),TRIM(part_in),'scorename1_Invalid',scorename1_Invalid},
														 {TRIM(date_in),TRIM(part_in),'scorevalue_Invalid',scorevalue_Invalid},
														 {TRIM(date_in),TRIM(part_in),'did_lexid_chk',did_lexid_chk},
														 {TRIM(date_in),TRIM(part_in),'did_zero_percentage_chk',did_zero_percentage_chk}],
														Lay_output_validation);
				RETURN res_out;
		END;

END;