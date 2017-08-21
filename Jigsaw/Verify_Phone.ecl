import address,Gong_v2;

export Verify_Phone(

	 dataset(layouts.Temporary.Jigsaw_UniqueId			) pInput					
	,dataset(Gong_v2.layout_gongMasterAid	) pGongMasterBase	= Gong_v2.Files().base.gongmaster.root
	,string1																pPurpose				= 'B'	//'B' = business, 'P' = person, '' = either
//	,string																	pPersistname		= persistnames().VerifyPhone

) :=
function
	
	lay_gong_slim := record
		unsigned4  									dt_first_seen			;
		unsigned6  									id								;
		unsigned5  									phone							;
	end;

	dgongfiltered := map(pPurpose = 'B'	=> pGongMasterBase(listing_type_bus = 'B',current_record_flag = 'Y', bdid != 0)
											,pPurpose = 'P'	=> pGongMasterBase(listing_type_res = 'R',current_record_flag = 'Y',  did != 0)
											,									 pGongMasterBase(current_record_flag = 'Y'	,(did  != 0 or bdid != 0)) 
									);
	
	// phones in gong master file are not unique
	dGongMasterBase_filt := project(dgongfiltered,
		transform(lay_gong_slim,
			self.dt_first_seen				:= if((unsigned4)left.dt_last_seen > 0	,(unsigned4)left.dt_last_seen	,(unsigned4)left.dt_first_seen);
			self.id										:= if(pPurpose = 'B' ,left.bdid,left.did	);
			self.phone	 							:= (unsigned5)left.phone10;
			
		));
		
	dGongMasterBase_dedup := dedup(sort(distribute(dGongMasterBase_filt	,hash64(id,phone)),id,phone,-dt_first_seen,local),id,phone, local);
	
	pInput_withphone_bdid 		:= pInput(		bdid != 0 and (unsigned)rawfields.Phone != 0);
	pInput_withoutphone_bdid 	:= pInput(not(bdid != 0 and (unsigned)rawfields.Phone != 0));
	
	pInput_withphone_did 			:= pInput(		did != 0 and (unsigned)rawfields.Phone != 0);
	pInput_withoutphone_did 	:= pInput(not(did != 0 and (unsigned)rawfields.Phone != 0));

	//join poe to gong master on company phone, taking latest record
	djoin2gong_onBdid := join(
		 distribute(pInput_withphone_bdid				,hash64(bdid,(unsigned5)rawfields.Phone))
		,dGongMasterBase_dedup
		,									left.bdid							= right.id
			and (unsigned5)	left.rawfields.Phone	= right.phone
		,transform(
			layouts.Temporary.Jigsaw_UniqueId,
				self.bdid					 								:= left.bdid															;
				self.rawfields.Phone 							:= (string)right.phone						;
				self								 							:= left																		;
		)
		,local
		,left outer
	);

	djoin2gong_onDid := join(
		 distribute(pInput_withphone_did				,hash64(did,(unsigned5)rawfields.Phone))
		,dGongMasterBase_dedup
		,									left.did							= right.id
			and (unsigned5)	left.rawfields.Phone	= right.phone
		,transform(
			layouts.Temporary.Jigsaw_UniqueId,
				self.did					 								:= left.did																;
				self.rawfields.Phone 							:= (string)right.phone						;
				self								 							:= left																		;
		)
		,local
		,left outer
	);

	dconcat_bdid 	:= djoin2gong_onBdid 	+ pInput_withoutphone_bdid	;
	dconcat_did 	:= djoin2gong_onDid 	+ pInput_withoutphone_Did 	;

	return if(pPurpose = 'B' ,dconcat_bdid	,dconcat_did);

end;