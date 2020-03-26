import address,corp2,corp2_mapping,corp2_raw_al,corp2_raw_ar,corp2_raw_az,corp2_raw_co,corp2_raw_ct,corp2_raw_dc,corp2_raw_fl,corp2_raw_ga,corp2_raw_hi,corp2_raw_ia,corp2_raw_ks,corp2_raw_ky,
			 corp2_raw_il,corp2_raw_la,corp2_raw_id,corp2_raw_in, corp2_raw_ma,corp2_raw_md,corp2_raw_me,corp2_raw_mi,corp2_raw_mn,corp2_raw_mo,corp2_raw_ms,corp2_raw_mt,corp2_raw_nd,corp2_raw_ne,corp2_raw_nc,corp2_raw_nh,corp2_raw_nm,
			 corp2_raw_nv,corp2_raw_oh,corp2_raw_ok,corp2_raw_or,corp2_raw_pa,corp2_raw_ri,corp2_raw_sc,corp2_raw_sd,corp2_raw_tn,corp2_raw_tx,corp2_raw_ut,corp2_raw_vt,corp2_raw_wa,corp2_raw_wi,corp2_raw_wv,
			 corp2_raw_wy;
			 
export fCleanState(string pStateOrigin,string pStateOriginDesc,string pState='',string pAddress='',string pCountry='') := module
		//********************************************************************
		//CleanState: The input parameters are as follows:
		//						pState: 						the state being validated
		//						pAddress: 					used if pState is blank to derive State
		//						pStateOrigin: 			used for deriving/validating state
		//						pStateOriginDesc: 	used for deriving/validating state
		//*******************************************************************
		shared UC_StateOrigin			:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOrigin));
		shared UC_StateOriginDesc	:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pStateOriginDesc));
		shared UC_Address	 				:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pAddress));
		shared UC_State		 				:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pState));
		shared UC_Country	 				:= corp2_mapping.fn_RemoveSpecialChars(corp2.t2u(pCountry));
		shared StandardCountry		:= corp2_Mapping.fCleanCountry(UC_StateOrigin,UC_StateOriginDesc,UC_State,UC_COUNTRY).Country;		
		
		export CleanChars  		:= Map(UC_StateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'AZ' => regexreplace(corp2_raw_az.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'CT' => regexreplace(corp2_raw_ct.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'DC' => regexreplace(corp2_raw_dc.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'FL' => regexreplace(corp2_raw_fl.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'ID' => regexreplace(corp2_raw_id.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'IN' => regexreplace(corp2_raw_in.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'MD' => regexreplace(corp2_raw_md.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'MS' => regexreplace(corp2_raw_ms.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'NC' => regexreplace(corp2_raw_nc.fGetRegExPattern.State.InvalidChars,UC_State,''),	
																 UC_StateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.State.InvalidChars,UC_State,''),	
																 UC_StateOrigin = 'NE' => regexreplace(corp2_raw_ne.fGetRegExPattern.State.InvalidChars,UC_State,''),																
																 UC_StateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.State.InvalidChars,UC_State,''),																 
																 UC_StateOrigin = 'OH' => regexreplace(corp2_raw_oh.fGetRegExPattern.State.InvalidChars,UC_State,''),																 
																 UC_StateOrigin = 'OK' => regexreplace(corp2_raw_ok.fGetRegExPattern.State.InvalidChars,UC_State,''),																 
																 UC_StateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'PA' => regexreplace(corp2_raw_pa.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'RI' => regexreplace(corp2_raw_ri.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'SD' => regexreplace(corp2_raw_sd.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'UT' => regexreplace(corp2_raw_ut.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_StateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.State.InvalidChars,UC_State,''),																 
																 UC_StateOrigin = 'WI' => regexreplace(corp2_raw_wv.fGetRegExPattern.State.InvalidChars,UC_State,''),	
																 UC_StateOrigin = 'WV' => regexreplace(corp2_raw_wi.fGetRegExPattern.State.InvalidChars,UC_State,''),																 
																 UC_StateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.State.InvalidChars,UC_State,''),
																 UC_State
															  );
		export CleanWords  		:= Map(UC_StateOrigin = 'AL' => regexreplace(corp2_raw_al.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'AR' => regexreplace(corp2_raw_ar.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'AZ' => regexreplace(corp2_raw_az.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'CO' => regexreplace(corp2_raw_co.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'CT' => regexreplace(corp2_raw_ct.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'DC' => regexreplace(corp2_raw_dc.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'FL' => regexreplace(corp2_raw_fl.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'GA' => regexreplace(corp2_raw_ga.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'HI' => regexreplace(corp2_raw_hi.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'IA' => regexreplace(corp2_raw_ia.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ID' => regexreplace(corp2_raw_ia.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'IL' => regexreplace(corp2_raw_il.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'IN' => regexreplace(corp2_raw_in.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'KS' => regexreplace(corp2_raw_ks.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'KY' => regexreplace(corp2_raw_ky.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'LA' => regexreplace(corp2_raw_la.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MA' => regexreplace(corp2_raw_ma.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MD' => regexreplace(corp2_raw_md.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ME' => regexreplace(corp2_raw_me.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MI' => regexreplace(corp2_raw_mi.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MN' => regexreplace(corp2_raw_mn.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MO' => regexreplace(corp2_raw_mo.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MS' => regexreplace(corp2_raw_ms.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'MT' => regexreplace(corp2_raw_mt.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NC' => regexreplace(corp2_raw_nc.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'ND' => regexreplace(corp2_raw_nd.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NE' => regexreplace(corp2_raw_ne.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NH' => regexreplace(corp2_raw_nh.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NM' => regexreplace(corp2_raw_nm.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'NV' => regexreplace(corp2_raw_nv.fGetRegExPattern.State.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'OH' => regexreplace(corp2_raw_oh.fGetRegExPattern.State.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'OK' => regexreplace(corp2_raw_ok.fGetRegExPattern.State.InvalidWords,CleanChars,''),																 
																 UC_StateOrigin = 'OR' => regexreplace(corp2_raw_or.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'PA' => regexreplace(corp2_raw_pa.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'RI' => regexreplace(corp2_raw_ri.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'SC' => regexreplace(corp2_raw_sc.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'SD' => regexreplace(corp2_raw_sd.fGetRegExPattern.State.InvalidWords,CleanChars,''),	
																 UC_StateOrigin = 'TN' => regexreplace(corp2_raw_tn.fGetRegExPattern.State.InvalidWords,CleanChars,''),	
																 UC_StateOrigin = 'TX' => regexreplace(corp2_raw_tx.fGetRegExPattern.State.InvalidWords,CleanChars,''),	
																 UC_StateOrigin = 'UT' => regexreplace(corp2_raw_ut.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'VT' => regexreplace(corp2_raw_vt.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WA' => regexreplace(corp2_raw_wa.fGetRegExPattern.State.InvalidWords,CleanChars,''),	
																 UC_StateOrigin = 'WI' => regexreplace(corp2_raw_wi.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WV' => regexreplace(corp2_raw_wv.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 UC_StateOrigin = 'WY' => regexreplace(corp2_raw_wy.fGetRegExPattern.State.InvalidWords,CleanChars,''),
																 CleanChars
														    );
		export CleanState	  	:= CleanWords;		

		//Try and derive state from pAddress if pState is blank; Checking for a zip in pAddress		
		export TempZip		  	:= if(CleanState= '',regexfind('[0-9]{5}\\-*[0-9]{0,4}$',corp2.t2u(UC_Address),0),'');
		//Try and derive state using CleanAddress182 if pState is blank
		export TempAddress		:= if(CleanState = '' and standardCountry = 'US',Address.CleanAddress182(UC_Address,TempZip),'');
		//Remove invalid characters from state
		export TempState	 	  := if(CleanState = '',TempAddress[115..116],CleanState);												
		//Get the first word in TempState
		export TempSt1stWord	:= stringlib.stringgetnthword(TempState,1);
		//Try and derive State
		export DeriveState	 	:= map(tempstate = uc_stateorigin																											=> uc_stateorigin,
																 corp2_mapping.functions.valid_us_state_cd(tempstate) and length(tempstate) = 2	=> tempstate,
																 stringlib.stringfind(tempstate,uc_stateorigin,1)			<> 0  										=> uc_stateorigin,
																 stringlib.stringfind(tempstate,uc_stateorigindesc,1)	<> 0  										=> uc_stateorigin,
																 corp2_mapping.functions.valid_us_state_desc(tempstate)													=> corp2_mapping.functions.USStateDesc2Code(tempstate),
																 corp2_mapping.functions.valid_us_state_desc(tempst1stword) 										=> corp2_mapping.functions.USStateDesc2Code(tempst1stword),							 
																 UC_State
																);
		//Do final UC and trim
		export State					:= corp2.t2u(DeriveState);														
	end;
		