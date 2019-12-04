IMPORT corp2,ut;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_ln_name_type_cd: 	returns true or false based upon the incoming
		//													code.
		//****************************************************************************
		EXPORT invalid_name_type_code(STRING s, STRING recordorigin) := FUNCTION

			uc_s 		  := corp2.t2u(s);
			uc_ro 		:= corp2.t2u(recordorigin);
			 
			isValidCD := if(uc_ro = 'C',
											map(uc_s in ['01','03','04','05','07','09','F','P'] => true, 
													false
												 ),
												true //For contact records, corp_ln_name_type_cd doesn't have to exist
											 );

			 RETURN if(isValidCD,1,0);

		END;

		/*
		The purpose of this routine is to validate the corp_key for OH.
		if vendor corp_key (charter_num) length is only one character and 
		it is from this list['.,\&* ` !] or could be a space 
		then below function will return false 
		Scrubs_Corp2_Mapping_OH_Main.spc will catch a bad corp key record
		with breaking a four character length corp key rule. 
		*/


		EXPORT fGetValidKey(string30  Corpkey) := function

			InvalidChars					:= '(\\x27)*|(\\.)*|(\\,)*|(\\x5c)*|(\\*)*|(\\x60)*|(\\&)*|(\\\\)*|(\\x21)*(\\x20)';
			valid_key							:= regexreplace(InvalidChars,ut.fn_RemoveSpecialChars(Corpkey),'');
			
			return if(trim(valid_key,left,right) ='',0,1);

		End;
				
	  //Below table needs to be updated when we see new Org_Struc codes in Raw updates!
		EXPORT set_org_structure_cd := [ '00','01','02','03','04','05','06','07','08','09','10','11','12','13','14',
																		 '15','16','17','18','19','20','21','22','23','24','BT','CF','CH','CN','CP',
																		 'CV','FP','GL','LF','LL','LP','PR','RC','RT','UN',''];
																		

																		
END;