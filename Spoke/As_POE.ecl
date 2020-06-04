import POE,mdr;

export As_POE(

	dataset(layouts.Base) pBase	= Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(layouts.Base l) :=
	transform
		
		self.source								 			:= mdr.sourceTools.src_Spoke							;
		self.did												:= l.did																	;
		self.did_score									:= l.did_score														;
		self.bdid									 			:= l.bdid																	;
		self.bdid_score						 			:= l.bdid_score														;
		self.dt_first_seen							:= l.dt_first_seen												;
		self.dt_last_seen					 			:= l.dt_last_seen													;
		self.vendor_id									:= (string)hash64(l.rawfields.Company_Name + l.rawfields.Company_Street_Address + l.rawfields.First_Name + l.rawfields.Last_Name);
		self.subject_name					 			:= l.clean_contact_name										;
		self.subject_address						:= l.clean_company_address								;
		self.subject_address.city_name	:= l.clean_company_address.v_city_name		;
		self.subject_phone							:= (unsigned5)l.clean_phones.Company_Phone_Number				;
		self.subject_ssn								:= 0																			;
		self.subject_dob								:= 0																			;
		self.subject_job_title					:= l.rawfields.Job_Title									;
		self.subject_rawaid 						:= l.raw_aid															;
		self.subject_aceaid 						:= l.ace_aid															;
		self.company_name					 			:= l.rawfields.COMPANY_NAME								;
		self.company_address						:= l.clean_company_address								;
		self.company_address.city_name	:= l.clean_company_address.v_city_name		;
		self.company_phone							:= (unsigned5)l.clean_phones.Company_Phone_Number;
		self.company_fein					 			:= 0																			;
		self.company_rawaid				 			:= l.raw_aid															;
		self.company_aceaid				 			:= l.ace_aid															;
		self.global_sid									:= l.global_sid														;
	
	end;

	dMappedToPOE := project(_Filters.fAs_POE(pBase)	,tMapToPOE(left));
	
	return dMappedToPOE;

end;