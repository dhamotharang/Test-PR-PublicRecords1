import POE,mdr;

export As_POE(

	dataset(layouts.Base) pBase	= Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(layouts.Base l) :=
	transform
		
		self.source								 			:= mdr.sourceTools.src_One_Click_Data			;
		self.did												:= l.did																	;
		self.did_score									:= l.did_score														;
		self.bdid									 			:= l.bdid																	;
		self.bdid_score						 			:= l.bdid_score														;
		self.dt_first_seen							:= l.dt_first_seen												;
		self.dt_last_seen					 			:= l.dt_last_seen													;
		self.vendor_id									:= (string)hash64(trim(l.rawfields.SSN,left,right) + trim(l.rawfields.DOB,left,right) + trim(l.rawfields.WorkName,left,right) + trim(l.rawfields.FirstName,left,right) + trim(l.rawfields.LastName,left,right));
		self.subject_name					 			:= l.clean_name														;
		self.subject_address						:= l.clean_home_address										;
		self.subject_address.city_name	:= l.clean_home_address.v_city_name				;
		self.subject_phone							:= (unsigned5)l.clean_phones.HomePhone		;
		self.subject_ssn								:= (unsigned4)l.rawfields.ssn							;
		self.subject_dob								:= (unsigned4)l.rawfields.dob							;
		self.subject_job_title					:= ''																			;
		self.subject_rawaid 						:= l.raw_home_aid													;
		self.subject_aceaid 						:= l.ace_home_aid													;
		self.company_name					 			:= l.rawfields.WorkName										;
		self.company_address						:= l.clean_work_address										;
		self.company_address.city_name	:= l.clean_work_address.v_city_name				;
		self.company_phone							:= (unsigned5)l.clean_phones.WorkPhone		;
		self.company_fein					 			:= 0																			;
		self.company_rawaid				 			:= l.raw_work_aid													;
		self.company_aceaid				 			:= l.ace_work_aid													;
		self.global_sid									:= l.global_sid														;
		
	end;

	dMappedToPOE := project(pBase	,tMapToPOE(left));
	
	return dMappedToPOE;

end;