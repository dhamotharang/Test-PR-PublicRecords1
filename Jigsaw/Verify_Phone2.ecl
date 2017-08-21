IMPORT address,Gong_v2;

EXPORT Verify_Phone2(

	 DATASET(Layouts.Temporary.Jigsaw_AddTwoPhones			) pInput					
	,DATASET(Gong_v2.layout_gongMasterAid	) pGongMasterBase	= Gong_v2.Files().base.gongmaster.root
	,STRING1																pPurpose				= 'B'	//'B' = business, 'P' = person, '' = either
) := FUNCTION
	
	lay_gong_slim := RECORD
		UNSIGNED4  									dt_first_seen			;
		UNSIGNED6  									id								;
		UNSIGNED5  									phone							;
	END;

	dgongfiltered := MAP(pPurpose = 'B'	=> pGongMasterBase(listing_type_bus = 'B',current_record_flag = 'Y', bdid != 0)
											,pPurpose = 'P'	=> pGongMasterBase(listing_type_res = 'R',current_record_flag = 'Y',  did != 0)
											,									 pGongMasterBase(current_record_flag = 'Y'	,(did  != 0 or bdid != 0)) 
									);
	
	// phones in gong master file are not unique
	dGongMasterBase_filt := PROJECT(dgongfiltered,
		TRANSFORM(lay_gong_slim,
			SELF.dt_first_seen				:= IF((UNSIGNED4)LEFT.dt_last_seen > 0	,(UNSIGNED4)LEFT.dt_last_seen	,(UNSIGNED4)LEFT.dt_first_seen);
			SELF.id										:= IF(pPurpose = 'B' ,LEFT.bdid,LEFT.did	);
			SELF.phone	 							:= (UNSIGNED5)LEFT.phone10;
			
		));
		
	dGongMasterBase_dedup := DEDUP(SORT(DISTRIBUTE(dGongMasterBase_filt	,HASH64(id,phone)),id,phone,-dt_first_seen,LOCAL),id,phone, LOCAL);
	       
	
	pInput_withphone_bdid 		:= pInput(		bdid != 0 AND (UNSIGNED)rawfields.Phone != 0);
	 
	pInput_withoutphone_bdid 	:= pInput(NOT(bdid != 0 AND (UNSIGNED)rawfields.Phone != 0));
	
	pInput_withphone_did 			:= pInput(		did != 0 AND (UNSIGNED)rawfields.Phone != 0);
	   
	pInput_withoutphone_did 	:= pInput(NOT(did != 0 AND (UNSIGNED)rawfields.Phone != 0));

	//join poe to gong master on company phone, taking latest record
	djoin2gong_onBdid := JOIN(
		 DISTRIBUTE(pInput_withphone_bdid				,HASH64(bdid,(UNSIGNED5)rawfields.Phone))
		,dGongMasterBase_dedup
		,									LEFT.bdid							= RIGHT.id
			AND (UNSIGNED5)	LEFT.rawfields.Phone	= RIGHT.phone
		,TRANSFORM(
			Layouts.Temporary.Jigsaw_AddTwoPhones,
				SELF.bdid					 								:= LEFT.bdid															;
				SELF.rawfields.Phone 							:= (STRING)RIGHT.phone						;
				SELF								 							:= LEFT																		;
		)
		,LOCAL
		,LEFT OUTER
	);

	djoin2gong_onDid := JOIN(
		 DISTRIBUTE(pInput_withphone_did				,HASH64(did,(UNSIGNED5)rawfields.Phone))
		,dGongMasterBase_dedup
		,									LEFT.did							= RIGHT.id
			AND (UNSIGNED5)	LEFT.rawfields.Phone	= RIGHT.phone
		,TRANSFORM(
			Layouts.Temporary.Jigsaw_AddTwoPhones,
				SELF.did					 								:= LEFT.did																;
				SELF.rawfields.Phone 							:= (STRING)RIGHT.phone						;
				SELF								 							:= LEFT																		;
		)
		,LOCAL
		,LEFT OUTER
	);

	dconcat_bdid 	:= djoin2gong_onBdid 	+ pInput_withoutphone_bdid	;
	dconcat_did 	:= djoin2gong_onDid 	+ pInput_withoutphone_Did 	;

	RETURN IF(pPurpose = 'B' ,dconcat_bdid	,dconcat_did);

END;