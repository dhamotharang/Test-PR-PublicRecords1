import address,Corp2,Corp2_mapping,Corp2_raw_al,Corp2_raw_ar,Corp2_raw_az,Corp2_raw_co,Corp2_raw_ct,Corp2_raw_dc, Corp2_raw_fl, Corp2_raw_ga,Corp2_raw_hi,Corp2_raw_ia,Corp2_raw_il,Corp2_raw_ks,
			 Corp2_raw_la,Corp2_raw_id,Corp2_raw_in,Corp2_raw_ky,Corp2_raw_ma,Corp2_raw_md,Corp2_raw_me,Corp2_raw_mi,Corp2_raw_mn,Corp2_raw_mo,Corp2_raw_ms,Corp2_raw_mt,Corp2_raw_nd,Corp2_raw_nc,
			 Corp2_raw_ne,Corp2_raw_nh,Corp2_raw_nm,Corp2_raw_nv,Corp2_raw_oh,Corp2_raw_ok,Corp2_raw_or,corp2_raw_pa,Corp2_raw_ri,Corp2_raw_sc,Corp2_raw_sd,Corp2_raw_tn,Corp2_raw_tx,Corp2_raw_ut,
			 Corp2_raw_va,Corp2_raw_vt,Corp2_raw_wa,Corp2_raw_wi,Corp2_raw_wv,Corp2_raw_wy,ut;
			 
export fCleanAddress(string pStateOrigin,string pStateOriginDesc,string pAddr1 = '',string pAddr2 = '',string pCity  = '',string pState = '',string pZip = '',string pCountry = '') := module
		//********************************************************************
		//fCleanAddress: Cleans address elements and forms a standard format:
		//							 AddressLine1(Addr1 + Addr2) and 
		//							 AddressLine2(City + State + Zip) that can be passed
		//							 into the address cleaner.
		//********************************************************************
		shared UC_StateOrigin			:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pStateOrigin));
		shared UC_StateOriginDesc	:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pStateOriginDesc));
		shared UC_Addr1 					:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pAddr1));
		shared UC_Addr2						:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pAddr2));
		shared UC_City		 				:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pCity));
		shared UC_State						:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pState));
		shared UC_Zip							:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pZip));
		shared UC_Country 				:= corp2_mapping.fn_RemoveSpecialChars(Corp2.t2u(pCountry));

		shared alpha							:= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		shared alpha_numeric			:= '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		shared numeric						:= '0123456789';
		shared special_characters	:= '`~!@#$%^*()_-+=|%}]{[":;?/>.<- ';

		export CleanCharsAddr1  	:= Map(pStateOrigin = 'AL' => regexreplace(Corp2_raw_al.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'AR' => regexreplace(Corp2_raw_ar.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'AZ' => regexreplace(Corp2_raw_az.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'CO' => regexreplace(Corp2_raw_co.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'CT' => regexreplace(Corp2_raw_ct.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'DC' => regexreplace(Corp2_raw_dc.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'FL' => regexreplace(Corp2_raw_fl.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'GA' => regexreplace(Corp2_raw_ga.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'HI' => regexreplace(Corp2_raw_hi.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),																	 
																		 pStateOrigin = 'IA' => regexreplace(Corp2_raw_ia.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'ID' => regexreplace(Corp2_raw_id.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'IL' => regexreplace(Corp2_raw_il.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'IN' => regexreplace(Corp2_raw_in.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'KS' => regexreplace(Corp2_raw_ks.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'KY' => regexreplace(Corp2_raw_ky.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),																	 
																		 pStateOrigin = 'LA' => regexreplace(Corp2_raw_la.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'MA' => regexreplace(Corp2_raw_ma.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'MD' => regexreplace(Corp2_raw_md.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'ME' => regexreplace(Corp2_raw_me.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'MI' => regexreplace(Corp2_raw_mi.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'MN' => regexreplace(Corp2_raw_mn.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'MO' => regexreplace(Corp2_raw_mo.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'MS' => regexreplace(Corp2_raw_ms.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'MT' => regexreplace(Corp2_raw_mt.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'NC' => regexreplace(Corp2_raw_nc.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),																	 
																		 pStateOrigin = 'ND' => regexreplace(Corp2_raw_nd.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'NE' => regexreplace(Corp2_raw_ne.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'NH' => regexreplace(Corp2_raw_nh.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'NM' => regexreplace(Corp2_raw_nm.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'NV' => regexreplace(Corp2_raw_nv.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'OH' => regexreplace(Corp2_raw_oh.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'OK' => regexreplace(Corp2_raw_ok.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),		
																		 pStateOrigin = 'OR' => regexreplace(Corp2_raw_or.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'PA' => regexreplace(Corp2_raw_pa.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'RI' => regexreplace(Corp2_raw_ri.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'SC' => regexreplace(Corp2_raw_sc.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'SD' => regexreplace(Corp2_raw_sd.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'TN' => regexreplace(Corp2_raw_tn.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'TX' => regexreplace(Corp2_raw_tx.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'UT' => regexreplace(Corp2_raw_ut.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'VA' => regexreplace(Corp2_raw_va.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'VT' => regexreplace(Corp2_raw_vt.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'WA' => regexreplace(Corp2_raw_wa.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'WI' => regexreplace(Corp2_raw_wi.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'WV' => regexreplace(Corp2_raw_wv.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pStateOrigin = 'WY' => regexreplace(Corp2_raw_wy.fGetRegExPattern.Address.InvalidChars,UC_Addr1,''),
																		 pAddr1
																  );
		export CleanCharsAddr2  	:= Map(pStateOrigin = 'AL' => regexreplace(Corp2_raw_al.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'AR' => regexreplace(Corp2_raw_ar.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'AZ' => regexreplace(Corp2_raw_az.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'CO' => regexreplace(Corp2_raw_co.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'CT' => regexreplace(Corp2_raw_ct.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'DC' => regexreplace(Corp2_raw_dc.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'FL' => regexreplace(Corp2_raw_fl.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'GA' => regexreplace(Corp2_raw_ga.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'HI' => regexreplace(Corp2_raw_hi.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),																	 
																		 pStateOrigin = 'IA' => regexreplace(Corp2_raw_ia.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'ID' => regexreplace(Corp2_raw_id.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'IL' => regexreplace(Corp2_raw_il.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),	
																		 pStateOrigin = 'IN' => regexreplace(Corp2_raw_in.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),																	 
																		 pStateOrigin = 'KS' => regexreplace(Corp2_raw_ks.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'KY' => regexreplace(Corp2_raw_ky.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'LA' => regexreplace(Corp2_raw_la.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'MA' => regexreplace(Corp2_raw_ma.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'MD' => regexreplace(Corp2_raw_md.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'ME' => regexreplace(Corp2_raw_me.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'MI' => regexreplace(Corp2_raw_mi.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'MN' => regexreplace(Corp2_raw_mn.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'MO' => regexreplace(Corp2_raw_mo.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),	
																		 pStateOrigin = 'MS' => regexreplace(Corp2_raw_ms.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'MT' => regexreplace(Corp2_raw_mt.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),	
																		 pStateOrigin = 'NC' => regexreplace(Corp2_raw_nc.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),																	 
																		 pStateOrigin = 'ND' => regexreplace(Corp2_raw_nd.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),	
																		 pStateOrigin = 'NE' => regexreplace(Corp2_raw_ne.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'NH' => regexreplace(Corp2_raw_nh.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'NM' => regexreplace(Corp2_raw_nm.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'NV' => regexreplace(Corp2_raw_nv.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'OH' => regexreplace(Corp2_raw_oh.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'OK' => regexreplace(Corp2_raw_ok.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),																	 
																		 pStateOrigin = 'OR' => regexreplace(Corp2_raw_or.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),		
																		 pStateOrigin = 'OR' => regexreplace(Corp2_raw_or.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'PA' => regexreplace(Corp2_raw_pa.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'SC' => regexreplace(Corp2_raw_sc.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'SD' => regexreplace(Corp2_raw_sd.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'TN' => regexreplace(Corp2_raw_tn.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),																	 
																		 pStateOrigin = 'TX' => regexreplace(Corp2_raw_tx.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'UT' => regexreplace(Corp2_raw_ut.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'VA' => regexreplace(Corp2_raw_va.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'VT' => regexreplace(Corp2_raw_vt.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'WA' => regexreplace(Corp2_raw_wa.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'WI' => regexreplace(Corp2_raw_wi.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'WV' => regexreplace(Corp2_raw_wv.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pStateOrigin = 'WY' => regexreplace(Corp2_raw_wy.fGetRegExPattern.Address.InvalidChars,UC_Addr2,''),
																		 pAddr2
																  );
		export CleanWordsAddr1  	:= Map(pStateOrigin = 'AL' => regexreplace(Corp2_raw_al.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'AR' => regexreplace(Corp2_raw_ar.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'AZ' => regexreplace(Corp2_raw_az.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'CO' => regexreplace(Corp2_raw_co.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'CT' => regexreplace(Corp2_raw_ct.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'DC' => regexreplace(Corp2_raw_dc.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'FL' => regexreplace(Corp2_raw_fl.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'GA' => regexreplace(Corp2_raw_fl.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'HI' => regexreplace(Corp2_raw_hi.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'IA' => regexreplace(Corp2_raw_ia.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'ID' => regexreplace(Corp2_raw_id.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'IL' => regexreplace(Corp2_raw_il.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),																	 
																		 pStateOrigin = 'IN' => regexreplace(Corp2_raw_in.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),																	 
																		 pStateOrigin = 'KS' => regexreplace(Corp2_raw_ks.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'KY' => regexreplace(Corp2_raw_ky.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'LA' => regexreplace(Corp2_raw_la.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'MA' => regexreplace(Corp2_raw_ma.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'MD' => regexreplace(Corp2_raw_md.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'ME' => regexreplace(Corp2_raw_me.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'MI' => regexreplace(Corp2_raw_mi.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'MN' => regexreplace(Corp2_raw_mn.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'MO' => regexreplace(Corp2_raw_mo.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'MS' => regexreplace(Corp2_raw_ms.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'MT' => regexreplace(Corp2_raw_mt.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'NC' => regexreplace(Corp2_raw_nc.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),																	 
																		 pStateOrigin = 'ND' => regexreplace(Corp2_raw_nd.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'NE' => regexreplace(Corp2_raw_ne.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'NH' => regexreplace(Corp2_raw_nh.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'NM' => regexreplace(Corp2_raw_nm.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'NV' => regexreplace(Corp2_raw_nv.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'OH' => regexreplace(Corp2_raw_oh.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'OK' => regexreplace(Corp2_raw_ok.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),	
																		 pStateOrigin = 'OR' => regexreplace(Corp2_raw_or.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),		
																		 pStateOrigin = 'OR' => regexreplace(Corp2_raw_or.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'PA' => regexreplace(Corp2_raw_pa.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'SC' => regexreplace(Corp2_raw_sc.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'SD' => regexreplace(Corp2_raw_sd.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'TN' => regexreplace(Corp2_raw_tn.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'TX' => regexreplace(Corp2_raw_tx.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'UT' => regexreplace(Corp2_raw_ut.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'VA' => regexreplace(Corp2_raw_va.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'VT' => regexreplace(Corp2_raw_vt.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'WA' => regexreplace(Corp2_raw_wa.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'WI' => regexreplace(Corp2_raw_wi.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'WV' => regexreplace(Corp2_raw_wv.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pStateOrigin = 'WY' => regexreplace(Corp2_raw_wy.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr1,''),
																		 pAddr1
																  );
		export CleanWordsAddr2  	:= Map(pStateOrigin = 'AL' => regexreplace(Corp2_raw_al.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'AR' => regexreplace(Corp2_raw_ar.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'AZ' => regexreplace(Corp2_raw_az.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'CO' => regexreplace(Corp2_raw_co.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'CT' => regexreplace(Corp2_raw_ct.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'DC' => regexreplace(Corp2_raw_dc.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'FL' => regexreplace(Corp2_raw_fl.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'GA' => regexreplace(Corp2_raw_ga.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'HI' => regexreplace(Corp2_raw_hi.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),																	 
																		 pStateOrigin = 'IA' => regexreplace(Corp2_raw_ia.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'ID' => regexreplace(Corp2_raw_id.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'IN' => regexreplace(Corp2_raw_in.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'IL' => regexreplace(Corp2_raw_il.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),																	 																	 
																		 pStateOrigin = 'KS' => regexreplace(Corp2_raw_ks.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'KY' => regexreplace(Corp2_raw_ky.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'LA' => regexreplace(Corp2_raw_la.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'MA' => regexreplace(Corp2_raw_ma.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'MD' => regexreplace(Corp2_raw_md.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),	
																		 pStateOrigin = 'ME' => regexreplace(Corp2_raw_me.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'MI' => regexreplace(Corp2_raw_mi.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'MN' => regexreplace(Corp2_raw_mn.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'MO' => regexreplace(Corp2_raw_mo.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'MS' => regexreplace(Corp2_raw_ms.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'MT' => regexreplace(Corp2_raw_mt.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'NC' => regexreplace(Corp2_raw_nc.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'NE' => regexreplace(Corp2_raw_ne.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'NH' => regexreplace(Corp2_raw_nh.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),																	 
																		 pStateOrigin = 'NM' => regexreplace(Corp2_raw_nm.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'NV' => regexreplace(Corp2_raw_nv.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'OH' => regexreplace(Corp2_raw_oh.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'OK' => regexreplace(Corp2_raw_ok.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),																   
																		 pStateOrigin = 'OR' => regexreplace(Corp2_raw_or.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),		
																		 pStateOrigin = 'OR' => regexreplace(Corp2_raw_or.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'PA' => regexreplace(Corp2_raw_pa.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'SC' => regexreplace(Corp2_raw_sc.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'SD' => regexreplace(Corp2_raw_sd.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'TN' => regexreplace(Corp2_raw_tn.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'TX' => regexreplace(Corp2_raw_tx.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'UT' => regexreplace(Corp2_raw_ut.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'VA' => regexreplace(Corp2_raw_va.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'VT' => regexreplace(Corp2_raw_vt.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'WA' => regexreplace(Corp2_raw_wa.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),				
																		 pStateOrigin = 'WI' => regexreplace(Corp2_raw_wi.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'WV' => regexreplace(Corp2_raw_wv.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pStateOrigin = 'WY' => regexreplace(Corp2_raw_wy.fGetRegExPattern.Address.InvalidWords,CleanCharsAddr2,''),
																		 pAddr2
																  );
		//If Addr1 is only special characters or blanks, then blank out Addr1
		export CleanAddr1  			:= if(Corp2.t2u(stringlib.stringfilterout(CleanWordsAddr1,special_characters))<>'',CleanWordsAddr1,'');
		//If Addr2 is only special characters or blanks, then blank out Addr2
		export CleanAddr2  			:= if(Corp2.t2u(stringlib.stringfilterout(CleanWordsAddr2,special_characters))<>'',CleanWordsAddr2,'');
		
		//If Addr1 has an "R" (for route) followed by alphanumeric then keep
		//If Addr1 has an "I" (for interstate) that is preceeded by alphanumeric and followed by numeric then keep
		//else if only one character exists in Addr1, then blank out Addr1
		export CleanAddr1Size		:= map(CleanAddr1 = ''																								 => '',
																	 regexfind('(^R[ ]*[.]*[  ]*[#]*[A-Z0-9]+$)',CleanAddr1,0)<>''			 => CleanAddr1,	//e.g. R #123 or R. 1 or RT. 1, etc.
																	 regexfind('(^[A-Z0-9]+[ ]*[I]+[ ]*[0-9]+$)',CleanAddr1,0)<>''	 => CleanAddr1, //e.g. 18945 I35	
																	 length(stringlib.stringfilter(CleanAddr1,alpha)) = 1						 => '',
																	 CleanAddr1
																	);

		//If Addr2 is only one character, then blank out Addr2
		export CleanAddr2Size		:= map(CleanAddr2 = ''																								=> '',
																	 length(stringlib.stringfilter(CleanAddr2,alpha))>1 						=> CleanAddr2,
																	 ''
																	);
		//If Addr1 ends with a special character, then remove the last special character (e.g. 374 MAIN STREET- becomes 374 MAIN STREET)
		export Addr1	  				:= map(CleanAddr1Size = ''																													 			=> '',
																	 stringlib.stringfilter(CleanAddr1Size[length(CleanAddr1Size)],alpha_numeric) = '' => CleanAddr1Size[1..length(CleanAddr1Size)-1],
																	 CleanAddr1Size
																	);
		//If Addr2 ends with a special character, then remove the last special character (e.g. 374 MAIN STREET- becomes 374 MAIN STREET)
		export Addr2	  				:= map(CleanAddr2Size = ''																													 			=> '',
																	 stringlib.stringfilter(CleanAddr2Size[length(CleanAddr2Size)],alpha_numeric) = '' => CleanAddr2Size[1..length(CleanAddr2Size)-1],
																	 CleanAddr2Size
																	);
		export TempAddr				  := Corp2.t2u(Addr1 + ' ' + Addr2);
		export TempZip			 	  := if(Corp2.t2u(Addr1+Addr2+UC_City+UC_State+UC_Zip+UC_Country)<>'',
																	Corp2_Mapping.fCleanZip(UC_StateOrigin,UC_StateOriginDesc,Addr1,Addr2,UC_City,UC_State,UC_Zip,UC_Country).Zip,
																	''
																 );
		export TempCity				  := if(Corp2.t2u(Addr1+Addr2+UC_City+UC_State+UC_Zip+UC_Country)<>'',
																	Corp2_Mapping.fCleanCity(UC_StateOrigin,UC_StateOriginDesc,UC_State,TempAddr,UC_City,TempZip[1..5]).City,
																	''
																 );	
		export TempState		 	  := map(Corp2.t2u(Addr1+Addr2+UC_City+UC_State+UC_Zip+UC_Country) = ''																					=> '',
																	 Corp2_Mapping.fCleanState(UC_StateOrigin,UC_StateOriginDesc,UC_State,TempAddr).State <> '' 						=> Corp2_Mapping.fCleanState(UC_StateOrigin,UC_StateOriginDesc,UC_State,TempAddr).State,
																	 Corp2_Mapping.fCleanState(UC_StateOrigin,UC_StateOriginDesc,UC_State,TempCity+' '+TempZip).State <> '' => Corp2_Mapping.fCleanState(UC_StateOrigin,UC_StateOriginDesc,UC_State,TempCity+' '+TempZip).State,
																	 ''
																	);
		export TempAddrLine1 	  := map(TempAddr = ''																						=> '',
																	 Corp2.t2u(stringlib.stringfilterout(TempAddr,'#-\\'))='' => '', //blank out if only special chars exist
																	 Corp2.t2u(stringlib.stringfilterout(TempAddr,'X'))		='' => '', //blank out if only X's exist
																	 TempAddr
																	);
		export TempAddrLine2 	  := if(Corp2.t2u(TempCity+TempState+TempZip)<>'',Corp2.t2u(TempCity)+if(Corp2.t2u(TempCity) <> '' and Corp2.t2u(TempState)<>'',', ',' ')+Corp2.t2u(TempState)+' '+if(stringlib.stringfilterout(TempZip,'0- ')<>'',TempZip,''),'');
		export AddressLine1  	  := if(stringlib.stringfilterout(TempAddrLine1,numeric)<>'',Corp2.t2u(TempAddrLine1),'');
		export AddressLine2  	  := if(AddressLine1='' and Corp2.t2u(TempAddrLine2) = UC_StateOrigin,'',Corp2.t2u(TempAddrLine2));
		export Country 				  := if(AddressLine2='','',Corp2_Mapping.fCleanCountry(UC_StateOrigin,UC_StateOriginDesc,TempState,UC_Country).Country);
		export AddressLine3 		:= Country;
		export TempAddress		 	:= if(Corp2.t2u(AddressLine1+AddressLine2)<>'',Address.CleanAddress182(AddressLine1,AddressLine2),'');	
		export City							:= map(TempAddress = '' 			 	=> '',
																	 Corp2.t2u(Country)='US' 	=> Corp2.t2u(TempAddress[65..89]),
																	 TempCity
																	);
		export State						:= map(TempAddress = '' 			  => '',
																	 Corp2.t2u(Country)='US' 	=> Corp2.t2u(TempAddress[115..116]),
																	 TempState
																	);		
		export Zip							:= map(TempAddress = '' 			  => '',
																	 Corp2.t2u(Country)='US' 	=> Corp2.t2u(TempAddress[117..121]+if(TempAddress[122..125] not in['0000','9999'],TempAddress[122..125],'')),
																	 TempZip
																	);
		export PrepAddrLastLine := map(Corp2.t2u(City+State+Zip) = '' => '',
																	 Corp2.t2u(Country)='US'				=> Corp2.t2u(City+if(City <> '' and State<>'',', ',' ')+State+' '+if((string)(integer)Zip <> '0',Zip[1..5],'')),
																	 ''
																	);																
		export PrepAddrLine1 		:= if(Corp2.t2u(Country)='US' and PrepAddrLastLine<>'',Corp2.t2u(AddressLine1),'');
end;