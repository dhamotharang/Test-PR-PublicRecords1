import address,corp2,corp2_mapping,corp2_raw_al,corp2_raw_ar,corp2_raw_az,corp2_raw_co,corp2_raw_ct,corp2_raw_dc,corp2_raw_fl,corp2_raw_ga,corp2_raw_hi,corp2_raw_ia,corp2_raw_il,corp2_raw_ks,
			 corp2_raw_la,corp2_raw_id,corp2_raw_in,corp2_raw_ky,corp2_raw_ma,corp2_raw_md,corp2_raw_me,corp2_raw_mi,corp2_raw_mn,corp2_raw_mo,corp2_raw_ms,corp2_raw_mt,corp2_raw_nd,corp2_raw_nc,
			 corp2_raw_ne,corp2_raw_nh,corp2_raw_nm,corp2_raw_oh,corp2_raw_ok,corp2_raw_or,corp2_raw_pa,corp2_raw_ri,corp2_raw_nv,corp2_raw_sc,corp2_raw_sd,corp2_raw_tn,corp2_raw_tx,corp2_raw_ut,
			 corp2_raw_va,corp2_raw_vt,corp2_raw_wa,corp2_raw_wi,corp2_raw_wv,corp2_raw_wy,ut;
			 
export fCleanCity(string pStateOrigin,string pStateOriginDesc,string pState='',string pAddress='',string pCity='',string pZip='') := module
		//********************************************************************
		//CleanCity: This routine cleans the input "pCity" if it exists.  If
		//					 a city doesn't exist, then the pAddress parameter is used
		//					 by the Address.CleanAddress182 routine to try and derive
		//					 it. 
		//********************************************************************
		export UC_StateOrigin	:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOrigin));
		export UC_Address	 		:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pAddress));
		export UC_City		 		:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pCity));
		export UC_State		 		:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pState));
		export UC_Zip			 		:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pZip));
		
		export CleanChars  		:= Map(UC_StateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'AZ' => regexreplace(corp2_raw_az.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'CT' => regexreplace(corp2_raw_ct.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'DC' => regexreplace(corp2_raw_dc.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'FL' => regexreplace(corp2_raw_fl.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'ID' => regexreplace(corp2_raw_id.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'IN' => regexreplace(corp2_raw_in.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'MD' => regexreplace(corp2_raw_md.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'MI' => regexreplace(corp2_raw_ma.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'MN' => regexreplace(corp2_raw_mi.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'MS' => regexreplace(corp2_raw_ms.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'NC' => regexreplace(corp2_raw_nc.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'NE' => regexreplace(corp2_raw_ne.fGetRegExPattern.City.InvalidChars,UC_City,''),					
																 UC_StateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.City.InvalidChars,UC_City,''),																 
																 UC_StateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'OH' => regexreplace(corp2_raw_oh.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'OK' => regexreplace(corp2_raw_ok.fGetRegExPattern.City.InvalidChars,UC_City,''),		
																 UC_StateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'PA' => regexreplace(corp2_raw_pa.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'RI' => regexreplace(corp2_raw_ri.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'SD' => regexreplace(corp2_raw_sd.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'UT' => regexreplace(corp2_raw_ut.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'WI' => regexreplace(corp2_raw_wi.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'WV' => regexreplace(corp2_raw_wv.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_StateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.City.InvalidChars,UC_City,''),
																 UC_City
															  );
		export CleanWords  		:= Map(UC_StateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'AZ' => regexreplace(corp2_raw_az.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'CT' => regexreplace(corp2_raw_ct.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'DC' => regexreplace(corp2_raw_dc.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'FL' => regexreplace(corp2_raw_fl.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.City.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ID' => regexreplace(corp2_raw_id.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'IN' => regexreplace(corp2_raw_in.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MD' => regexreplace(corp2_raw_md.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.City.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MS' => regexreplace(corp2_raw_ms.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NC' => regexreplace(corp2_raw_nc.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NE' => regexreplace(corp2_raw_ne.fGetRegExPattern.City.InvalidWords,CleanChars,''),					
																 UC_StateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'OH' => regexreplace(corp2_raw_oh.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'OK' => regexreplace(corp2_raw_ok.fGetRegExPattern.City.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'PA' => regexreplace(corp2_raw_pa.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'RI' => regexreplace(corp2_raw_ri.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'SD' => regexreplace(corp2_raw_sd.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'UT' => regexreplace(corp2_raw_ut.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'VA' => regexreplace(corp2_raw_va.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WI' => regexreplace(corp2_raw_wi.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WV' => regexreplace(corp2_raw_wv.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.City.InvalidWords,CleanChars,''),
																 CleanChars
														    );
																
		//If City is only special characters, then blank out city
		export CleanCitySC  				:= if(corp2.t2u(stringlib.stringfilterout(CleanWords,'-&<>,.():;#/* '))<>'',CleanWords,'');
		
		//If City is only one character, then blank out city
		export CleanCitySize				:= if(length(stringlib.stringfilter(CleanCitySC,'ABCDEFGHIJKLMNOPQRSTUVWXYZ')) > 1,CleanCitySC,'');

		//If City ends with a special character, then remove the last special character (e.g. DAYTON- becomes DAYTON)
		export CleanCity	  				:= if(stringlib.stringfilter(CleanCitySize[length(CleanCitySize)],'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = '',CleanCitySize[1..length(CleanCitySize)-1],CleanCitySize);

		//If numeric data exists in the City, then the City is not a valid City or
		//If the City is only made up of X, then the City is not a valid City
		export IsCityInvalid			  := if(regexfind('([0-9]+)',CleanCity) or regexfind('^([X]+)$',CleanCity),true,false);

		//If Zip exists and is numeric, then considered valid
		export IsZipInvalid			  	:= if(length(stringlib.stringfilter(pZip,'0123456789')) = 5,false,true);

		//Try and derive city from pAddress if pCity is blank and pZip is blank or invalid; Checking for a zip in pAddress
		export TempZip		  			  := if(corp2.t2u(CleanCity) = '' and IsZipInvalid = true,regexfind('[0-9]{5}\\-*[0-9]{0,4}$',corp2.t2u(UC_Address),0),stringlib.stringfilter(UC_Zip,'0123456789'));

		//Try and derive city using CleanAddress182 if pCity is blank or invalid
		export TempAddress				 	:= if(corp2.t2u(CleanCity) = '' or IsCityInvalid = true
																		  ,Address.CleanAddress182(corp2.t2u(UC_Address),TempZip[1..5])
																		  ,''
																		 );			

		//Use address from Address Cleaner if CleanCity is blank or invalid
		export TempCity	 	  		 		:= if(CleanCity = '' or IsCityInvalid = true,TempAddress[65..89],CleanCity);
		export City									:= corp2.t2u(TempCity);
		
end;