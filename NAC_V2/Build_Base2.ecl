import _validate, ut, std, address;

EXPORT Build_Base2(dataset(layout_Base2) basein, string Version = ut.Now(), seed = 1) := FUNCTION


	 Layout_Base2 xPrep(basein l) := TRANSFORM
				self.ProcessDate := (unsigned)Version;
				
				SELF.clean_dob                := if(l.dob_Type_Indicator = Mod_sets.Actual_Type
																			,(unsigned)_validate.date.fCorrectedDateString(l.DOB,false)
																			,0);

				integer YYYYMMDDToDays(string pInput) := 
				 (((integer)(pInput[1..4])*365) + ((integer)(pInput[5..6])*30)+ ((integer)(pInput[7..8])));
				today := YYYYMMDDToDays(ut.GetDate);

				SELF.age:=if(SELF.clean_dob>0,(integer)((today - YYYYMMDDToDays((string)SELF.clean_dob)) / 365),-999);

				Client_SSN		                := if(l.ssn_Type_Indicator = NAC_V2.Mod_Sets.Actual_Type
																					and length(regexreplace('[^0-9]',l.SSN,''))=9
																					,l.SSN
																					,'');
				SELF.clean_ssn                := if((unsigned)Client_SSN > 0,if(Client_SSN in ut.Set_BadSSN ,'',Client_SSN), '');
		
				self := l;

	END;
	
	//seed := max(NAC.Files().Base2,PrepRecSeq)+1);

	MAC_Sequence_Records(basein,PrepRecSeq,step0,seed);	
	
	step1 := PROJECT(step0, xPrep(LEFT));	
	
	step2 := NAC_V2.proc_cleanNames(step1);
	
	step3 := proc_CleanAddresses(step2);
	
	step4 := proc_link(step3);
	
	step5 := DEDUP(
						SORT(DISTRIBUTE(step4, HASH64(ProgramState, ProgramCode, CaseID, ClientId)),
									ProgramState, ProgramCode, CaseID, ClientId, prim_name, st, zip, prim_range, sec_range, -StartDate, LOCAL),
									ProgramState, ProgramCode, CaseID, ClientId, prim_name, st, zip, prim_range, sec_range, StartDate, LOCAL);


	return step5;

END;