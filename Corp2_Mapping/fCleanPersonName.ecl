import corp2,corp2_mapping,corp2_raw_al,Corp2_Raw_ar,corp2_raw_co,corp2_raw_ga,corp2_raw_hi,corp2_raw_ia,corp2_raw_il,corp2_raw_ks,corp2_raw_ky,corp2_raw_la,corp2_raw_ma,
			 corp2_raw_me,corp2_raw_mi,corp2_raw_mn,corp2_raw_mo,corp2_raw_mt,corp2_raw_nd,corp2_raw_nh,corp2_raw_nm,corp2_raw_nv,corp2_raw_or,corp2_raw_sc,corp2_raw_tn,
			 corp2_raw_tx,corp2_raw_va,corp2_raw_vt,corp2_raw_wa,corp2_raw_wy,ut;
			 
export fCleanPersonName(string pStateOrigin,string pStateOriginDesc,string pfName='',string pmName='',string plName='') := module
	//********************************************************************
	//fCleanPersonName: takes a first, middle and last name and tries to
	//								 clean the name looking for invalid words or 
	//								 characters.
	//Blank out the name if:
	//1) Only special characters exists in the field
	//2) If digits exists within the field
	//Remove from the name:
	//1) The same special character that doesn't begin and end the name(e.g. ")
	//2) Parens that begin and end the name
	//3) Names that end with a special character
	//4) Any words as indicated in "PatternInvalidName"
	//5) Any words like "SAME AS ABOVE" where "SAME" exists in first name
	//	 and "AS" exists in the middle name and "ABOVE" exists is the last name
	//   or all these words exists in one of the parameter fields.
	//********************************************************************                       
		shared UC_StateOrigin			:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOrigin));
		shared UC_StateOriginDesc	:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOriginDesc));		
		shared UC_FName 					:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pfName));
		shared UC_MName						:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pmName));
		shared UC_LName		 				:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(plName));

		export CleanCharsFName  	:= Map(pStateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),																		 
																		 pStateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),																		 
																		 pStateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 pStateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.FirstName.InvalidChars,UC_FName,''),
																		 UC_FName
																		);
		export CleanWordsFName  	:= Map(pStateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 pStateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.FirstName.InvalidWords,CleanCharsFName,''),
																		 UC_FName
																		);																	
		export CleanCharsMName  	:= Map(pStateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.MiddleName.InvalidWords,UC_MName,''),
																		 pStateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),																		 
																		 pStateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),																		 
																		 pStateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 pStateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.MiddleName.InvalidChars,UC_MName,''),
																		 UC_MName
																		);
		export CleanWordsMName  	:= Map(pStateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'ME' => regexreplace(corp2_raw_mo.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
 																		 pStateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 pStateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.MiddleName.InvalidWords,CleanCharsMName,''),
																		 UC_MName
																		);
																		
		export CleanCharsLName  	:= Map(pStateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 pStateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.LastName.InvalidChars,UC_LName,''),
																		 UC_LName
																		);
																		
		export CleanWordsLName  	:= Map(pStateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''), 
																		 pStateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),																		 
																		 pStateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 pStateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.LastName.InvalidWords,CleanCharsLName,''),
																		 UC_LName
																		);
		shared PatternInvalidEnd						:= ['\\x5c','\\x27','-','=','|','/',';','`','*','&','_',',','+'];
		shared PatternBegEndParens					:= '[(]*[)]*';
		
		//create a full name
		export temp_full_name 							:= corp2.t2u(CleanWordsFName + ' ' + CleanWordsMName + ' ' + CleanWordsLName);
		//check for invalid names and remove unprintable characters
		export invalid_words1								:= ['ABOVE','ABOVE AND','ABOVE PLUS','SAME AS ABOVE','AS ABOVE'];
		export invalid_words2								:= ['SEE FILE','SEE FICHE','SEE AR FICHE','SEE A/R','SEE ANNUAL REPORT','SEE ATTACHED'];
		export invalid_words3								:= ['AS PRES','AS SECR','AS VP','AS SEC','AS SECRETARY'];
		export invalid_words4								:= ['LIST ON FILE WITH SECRETARY OF STATE'];
		export temp_fname										:= if (temp_full_name in [invalid_words1,invalid_words2,invalid_words3,invalid_words4],'',corp2.t2u(CleanWordsFName));
		export temp_mname										:= if (temp_full_name in [invalid_words1,invalid_words2,invalid_words3,invalid_words4],'',corp2.t2u(CleanWordsMName));
		export temp_lname										:= if (temp_full_name in [invalid_words1,invalid_words2,invalid_words3,invalid_words4],'',corp2.t2u(CleanWordsLName));
		//***************************UC_fName*********************************
		//Begin validating FIRST
		//********************************************************************	
		//Get the length of the first name
		export len_fName									 	:= length(temp_fname);
		//Get the length of the first name after all digits are removed
		export len_fName_wo_digits				 	:= length(stringlib.stringfilterout(temp_fname,'0123456789'));
		//Check if the first name begins with a special character as indicated in "PatternNameUnknown"
		//export isfNameAllSpecialCharacters 	:= if(regexreplace(PatternNameUnknown,temp_fname,'') = '',true,false);
		//Check the first character in first name and check to see if the last character matches
		export isfNameBegEndNotSameSpecChar	:= if(temp_fname[1] in PatternInvalidEnd and temp_fname[len_fName] <> temp_fname[1],true,false);
		//Check if the first character in first name begins and ends with a paren
		export isfNameBegEndWithParens		 	:= if(temp_fname[1] = '(' and temp_fname[len_fName]=')',true,false);
		//******************************************************************** 
		//Begin validating MIDDLE NAME
		//********************************************************************
		//Get the length of the middle name
		export len_mName									 	:= length(temp_mname);
		//Get the length of the middle name after all digits are removed
		export len_mName_wo_digits				 	:= length(stringlib.stringfilterout(temp_mname,'0123456789'));
		//Check if the middle name begins with a special character as indicated in "PatternNameUnknown"
		//export ismNameAllSpecialCharacters 	:= if(regexreplace(PatternNameUnknown,temp_mname,'') = '',true,false);
		//Check the first character in middle name and check to see if the last character matches
		export ismNameBegEndNotSameSpecChar	:= if(temp_mname[1] in PatternInvalidEnd and temp_mname[len_mName] <> temp_mname[1],true,false);
		//Check if the first character in middle name begins and ends with a paren	
		export ismNameBegEndWithParens		 	:= if(temp_mname[1] = '(' and temp_mname[len_mName]=')',true,false);
		//******************************************************************** 
		//Begin validating LAST NAME
		//********************************************************************
		//Get the length of the last name
		export len_lName 										:= length(temp_lname);
		//Get the length of the last name after all digits are removed
		export len_lName_wo_digits				 	:= length(stringlib.stringfilterout(temp_lname,'0123456789'));
		//Check if the last name begins with a special character as indicated in "PatternNameUnknown"
		//export islNameAllSpecialCharacters 	:= if(regexreplace(PatternNameUnknown,temp_lname,'') = '',true,false);
		//Check the first character in last name and check to see if the last character matches
		export islNameBegEndNotSameSpecChar	:= if(temp_lname[1] in PatternInvalidEnd and temp_lname[len_lName] <> temp_lname[1],true,false);
		//Check if the first character in middle name begins and ends with a paren	
		export islNameBegEndWithParens		 	:= if(temp_lname[1] = '(' and temp_lname[len_lName]=')',true,false);
		//******************************************************************** 
		//Begin cleaning LAST NAME
		//********************************************************************	
		export MapLastName									:= map(//islNameAllSpecialCharacters		  					 =>'',
																							 //length(temp_lname)=2 											 =>regexreplace(PatternNameUnknown,temp_lname,''),
																							 //islNameBegEndNotSameSpecChar				 	 			 =>regexreplace(PatternNameUnknown,temp_lname,''),
																							 temp_lname[1] in PatternInvalidEnd			   	 =>temp_lname[2..],
																							 temp_lname[len_lName] in PatternInvalidEnd  =>temp_lname[1..len_lName-1],
																							 islNameBegEndWithParens							 			 =>regexreplace(PatternBegEndParens,temp_lname,''),
																							 len_lName_wo_digits <> len_lName 		 			 =>'',																								 
																							 temp_lname
																							);
		export LastName											:= if(corp2.t2u(UC_FName+UC_MName+UC_LName)<>'',corp2.t2u(MapLastName),'');
		//******************************************************************** 
		//Begin cleaning MIDDLE NAME
		//********************************************************************				
		export MapMiddleName								:= map(//ismNameAllSpecialCharacters		  			 		 =>'',
																							 //length(temp_mname)=2 											 =>regexreplace(PatternNameUnknown,temp_mname,''), 
																							 //ismNameBegEndNotSameSpecChar					 			 =>regexreplace(PatternNameUnknown,temp_mname,''),
																							 temp_mname[1] in PatternInvalidEnd				 	 =>temp_mname[2..],
																							 temp_mname[len_mName] in PatternInvalidEnd  =>temp_mname[1..len_mName-1],																					 
																							 ismNameBegEndWithParens							 			 =>regexreplace(PatternBegEndParens,temp_mname,''),
																							 len_mName_wo_digits <> len_mName 		 			 =>'',
																							 temp_mname
																							);
		export MiddleName										:= if(corp2.t2u(UC_FName+UC_MName+UC_LName)<>'',corp2.t2u(MapMiddleName),'');																							
		//******************************************************************** 
		//Begin cleaning FIRST NAME
		//********************************************************************																											
		export MapFirstName									:= map(//isfNameAllSpecialCharacters		  		 			 =>'',
																							 //length(temp_fname)=2 											 =>regexreplace(PatternNameUnknown,temp_fname,''),
																							 //isfNameBegEndNotSameSpecChar					 			 =>regexreplace(PatternNameUnknown,temp_fname,''),																					 
																							 temp_fname[1] in PatternInvalidEnd				 	 =>temp_fname[2..],
																							 temp_fname[len_fName] in PatternInvalidEnd  =>temp_fname[1..len_fName-1],																					 
																							 isfNameBegEndWithParens							 			 =>regexreplace(PatternBegEndParens,temp_fname,''),
																							 len_fName_wo_digits <> len_fName 		 			 =>'',
																							 temp_fname
																							);
		export FirstName										:= if(corp2.t2u(UC_FName+UC_MName+UC_LName)<>'',corp2.t2u(MapFirstName),'');																							
end;