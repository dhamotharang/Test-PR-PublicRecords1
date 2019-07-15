import POE,mdr;

export As_POE(

	 boolean 										pUsingInPOE				= true
	,boolean 										pUseOtherEnviron	= _Constants().IsDataland
	,dataset(layouts.Base_new			)	pDataset					= if(pUsingInPOE
																												,files('Using_In_POE',pUseOtherEnviron).base.logical
																												,files(,pUseOtherEnviron).base.qa
																									)
	,string1										pTodo							= 'R'	//'R' = recalculate persist,'P' = pull from persist(don't recalculate),'N' = Don't persist code
	,string											pPersistname			= persistnames(									).AsPOE
	,dataset(POE.Layouts.Base	) pPersist 					= persists		(pUseOtherEnviron	).AsPOE

) :=
function

	POE.Layouts.Base	tMapToPOE(layouts.Base_new l) :=
	transform
		
		self.source								 				:= mdr.sourceTools.src_SalesChannel				;
		self.did													:= 0															;
		self.did_score										:= 0															;
		self.bdid									 				:= 0															;
		self.bdid_score						 				:= 0															;
		self.dt_first_seen								:= (UNSIGNED4)l.date_first_seen		;
		self.dt_last_seen					 				:= (UNSIGNED4)l.date_first_seen		;
		self.vendor_id										:= trim(l.rawfields.Row_ID) + '-' + (string)hash64(trim(l.rawfields.Company_Name,left,right))	;
		self.subject_name.title						:= l.clean_name.title									;
		self.subject_name.fname						:= l.clean_name.fname									;
		self.subject_name.mname						:= l.clean_name.mname									;
		self.subject_name.lname						:= l.clean_name.lname									;
		self.subject_name.name_suffix			:= l.clean_name.name_suffix						;
		self.subject_name.name_score			:= l.clean_name.name_score							;
		self.subject_address.prim_range		:= l.clean_address.prim_range							;
		self.subject_address.predir				:= l.clean_address.predir									;
		self.subject_address.prim_name		:= l.clean_address.prim_name							;
		self.subject_address.addr_suffix	:= l.clean_address.addr_suffix						;
		self.subject_address.postdir			:= l.clean_address.postdir								;
		self.subject_address.unit_desig		:= l.clean_address.unit_desig							;
		self.subject_address.sec_range		:= l.clean_address.sec_range							;
		self.subject_address.city_name		:= l.clean_address.v_city_name						;
		self.subject_address.st						:= l.clean_address.st											;
		self.subject_address.zip					:= l.clean_address.zip										;
		self.subject_address.zip4					:= l.clean_address.zip4										;
		self.subject_phone								:= (unsigned5)regexreplace('[-]',l.rawfields.Phone_Number,'');
		self.subject_ssn									:= (unsigned4)0								;
		self.subject_dob									:= (unsigned4)0								;
		self.subject_job_title						:= l.rawfields.Title															;
		self.subject_rawaid 							:= l.RawAID								;
		self.subject_aceaid 							:= l.ACEAID														;
		self.company_name					 				:= l.rawfields.Company_Name														;
		self.company_address.prim_range		:= l.clean_address.prim_range							;
		self.company_address.predir				:= l.clean_address.predir									;
		self.company_address.prim_name		:= l.clean_address.prim_name							;
		self.company_address.addr_suffix	:= l.clean_address.addr_suffix						;
		self.company_address.postdir			:= l.clean_address.postdir								;
		self.company_address.unit_desig		:= l.clean_address.unit_desig							;
		self.company_address.sec_range		:= l.clean_address.sec_range							;
		self.company_address.city_name		:= l.clean_address.v_city_name						;
		self.company_address.st						:= l.clean_address.st											;
		self.company_address.zip					:= l.clean_address.zip										;
		self.company_address.zip4					:= l.clean_address.zip4										;
		self.company_phone								:= (unsigned5)regexreplace('[-]',l.rawfields.Phone_Number,'');				;	// pull company info from EDA using work phone
		self.company_fein					 				:= 0															;
		self.company_rawaid				 				:= l.RawAID															;
		self.company_aceaid				 				:= l.ACEAID															;
	
	end;

	dMappedToPOE := project(pDataset	,tMapToPOE(left));

	dMappedToPOE_persisted 	:= dMappedToPOE : persist(pPersistname);
	dMappedToPOE_persist		:= pPersist;
	
	decision := map(
		 pTodo = 'R' => dMappedToPOE_persisted
		,pTodo = 'P' => dMappedToPOE_persist
		,pTodo = 'N' => dMappedToPOE
		,								dMappedToPOE_persisted
	);

	return decision;

end;