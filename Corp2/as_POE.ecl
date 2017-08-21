import POE,mdr;

export As_POE(

	 dataset(Layout_Corporate_Direct_Cont_AID) pContBase	= Files().AID.cont.qa
	,dataset(Layout_Corporate_Direct_Corp_AID) pCorpBase	= Files().AID.corp.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(Layout_Corporate_Direct_Cont_AID l) :=
	transform
		
		self.source								 				:= MDR.sourceTools.fCorpV2(l.corp_key, l.corp_state_origin)	;
		self.did													:= l.did																										;
		self.did_score										:= 0																												;
		self.bdid									 				:= l.bdid																										;
		self.bdid_score						 				:= 0																												;
		self.dt_first_seen								:= l.dt_first_seen																					;
		self.dt_last_seen					 				:= l.dt_last_seen																						;
		self.vendor_id										:= l.corp_key																								;
		self.subject_name.title						:= l.cont_title																							;
		self.subject_name.fname						:= l.cont_fname																							;
		self.subject_name.mname						:= l.cont_mname																							;
		self.subject_name.lname						:= l.cont_lname																							;
		self.subject_name.name_suffix			:= l.cont_name_suffix;																			;
		self.subject_name.name_score			:= l.cont_score																							;
		self.subject_address.prim_range		:= l.cont_prim_range																				;
		self.subject_address.predir				:= l.cont_predir																						;
		self.subject_address.prim_name		:= l.cont_prim_name																					;
		self.subject_address.addr_suffix	:= l.cont_addr_suffix																				;
		self.subject_address.postdir			:= l.cont_postdir																						;
		self.subject_address.unit_desig		:= l.cont_unit_desig																				;
		self.subject_address.sec_range		:= l.cont_sec_range																					;
		self.subject_address.city_name		:= l.cont_v_city_name																				;
		self.subject_address.st						:= l.cont_state																							;
		self.subject_address.zip					:= l.cont_zip5																							;
		self.subject_address.zip4					:= l.cont_zip4																							;
		self.subject_phone								:= (unsigned5)l.cont_phone10																;
		self.subject_ssn									:= (unsigned4)l.cont_ssn																		;
		self.subject_dob									:= (unsigned4)l.cont_dob																		;
		self.subject_job_title						:= Stringlib.StringToUpperCase(l.cont_title_desc)						;
		self.subject_rawaid 							:= l.Append_Cont_Addr_RawAID																;
		self.subject_aceaid 							:= l.Append_Cont_Addr_ACEAID																;
		self.company_name					 				:= Stringlib.StringToUpperCase(l.corp_legal_name)						;
		self.company_address.prim_range		:= l.corp_addr1_prim_range																	;
		self.company_address.predir				:= l.corp_addr1_predir																			;
		self.company_address.prim_name		:= l.corp_addr1_prim_name																		;
		self.company_address.addr_suffix	:= l.corp_addr1_addr_suffix																	;
		self.company_address.postdir			:= l.corp_addr1_postdir																			;
		self.company_address.unit_desig		:= l.corp_addr1_unit_desig																	;
		self.company_address.sec_range		:= l.corp_addr1_sec_range																		;
		self.company_address.city_name		:= l.corp_addr1_v_city_name																	;
		self.company_address.st						:= l.corp_addr1_state																				;
		self.company_address.zip					:= l.corp_addr1_zip5																				;
		self.company_address.zip4					:= l.corp_addr1_zip4																				;
		self.company_phone								:= (unsigned5)l.corp_phone10																;
		self.company_fein					 				:= 0																												;//not sure if I can use cont_fein
		self.company_rawaid				 				:= l.Append_Corp_Addr_RawAID																;
		self.company_aceaid				 				:= l.Append_Corp_Addr_ACEAID																;
	
	end;

	dFiltered := Filters.fAs_POE(pContBase,pCorpBase);

	dMappedToPOE := project(dFiltered	,tMapToPOE(left));
	
	// dAppendaids := Append_AID_For_POE.fall(dMappedToPOE);
	
	return dMappedToPOE;

end;