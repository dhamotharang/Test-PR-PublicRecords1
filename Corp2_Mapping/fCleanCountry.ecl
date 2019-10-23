import corp2,corp2_raw_co,corp2_raw_dc,corp2_raw_al,corp2_raw_az,corp2_raw_ct,corp2_raw_fl,corp2_raw_hi,corp2_raw_ia,corp2_raw_ks,corp2_raw_ky,corp2_raw_il,corp2_raw_la,corp2_raw_ma,
			 corp2_raw_me,corp2_raw_mi,corp2_raw_mn,corp2_raw_mo,corp2_raw_ms,corp2_raw_mt,corp2_raw_nc,corp2_raw_nd,corp2_raw_nh,corp2_raw_nm,corp2_raw_nv,corp2_raw_ok,corp2_raw_or,corp2_raw_sc,
			 corp2_raw_sd,corp2_raw_tn,corp2_raw_tx,corp2_raw_va,corp2_raw_vt,corp2_raw_wa,corp2_raw_wv,corp2_raw_wy,ut;
			 
export fCleanCountry(string pStateOrigin,string pStateOriginDesc,string pState='',string pCountry='') := module
		//********************************************************************
		//fCleanCountry: This routine removes any non-alpha character and  
		//							 invalid word from the input parameter "pCountry" to
		//							 determine if the country is "US".  The goal is to 
		//							 standardize the country field to "US" based upon the
		//         			 input.
		//							 If the country cannot be determined, then a "cleaned"
		//							 country is returned.
		//********************************************************************
		export UC_StateOrigin			:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOrigin));
		export UC_StateOriginDesc	:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOriginDesc));		
		export UC_Country 				:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pCountry));
		export UC_State						:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pState));
		
		export CleanChars  		:= stringlib.stringfilter(UC_Country,' ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		export CleanWords  		:= Map(UC_StateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'AZ' => regexreplace(corp2_raw_az.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'CT' => regexreplace(corp2_raw_ct.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'DC' => regexreplace(corp2_raw_dc.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'FL' => regexreplace(corp2_raw_fl.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.Country.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.Country.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MS' => regexreplace(corp2_raw_ms.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NC' => regexreplace(corp2_raw_nc.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'OK' => regexreplace(corp2_raw_ok.fGetRegExPattern.Country.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'SD' => regexreplace(corp2_raw_sd.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.Country.InvalidWords,CleanChars,''),	
																 UC_StateOrigin = 'WV' => regexreplace(corp2_raw_wv.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.Country.InvalidWords,CleanChars,''),
																 CleanChars
																);
		export CleanCountry    	:= CleanWords;
		export CountryWOSpaces 	:= stringlib.stringfilterout(CleanCountry,' ');
		export Country 				 	:= map(regexfind('UNITEDSTATESOFAMERICA',CountryWOSpaces) 					 						 => 'US',
																	 regexfind('UNITEDSTATES',CountryWOSpaces) 										 						 => 'US',
																	 regexfind('USA',CountryWOSpaces) 																			   => 'US',
																	 regexfind('^US$',CountryWOSpaces) 															 					 => 'US',
																	 //note: uc_country = '' and uc_state = '' returns 'US'
																	 uc_country = '' and corp2_mapping.functions.valid_us_state_cd(uc_state) 	 => 'US',
																	 corp2_mapping.functions.valid_us_state_cd(uc_country) 				 						 => 'US',
																	 uc_country = '' and corp2_mapping.functions.valid_us_state_desc(uc_state) => 'US',
																	 corp2_mapping.functions.valid_us_state_desc(uc_country)  		 						 => 'US',
																	 uc_stateorigin = uc_country																	 						 => 'US',
																	 CountryWOSpaces in ['XXX','XX','X']													 						 => '',
																	 CleanCountry
																	);
end;
