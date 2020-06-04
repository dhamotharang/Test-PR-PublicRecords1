import POE,mdr;

export As_POE(

	dataset(layouts.Base) pPOEsFromEamilsBase	= Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(layouts.Base l) :=
	transform
		
		self.source								 			:= l.Email_src														;
		self.did												:= 0																			;
		self.did_score									:= 0																			;
		self.bdid									 			:= 0																			;
		self.bdid_score						 			:= 0																			;
		self.dt_first_seen							:= l.date_first_seen											;
		self.dt_last_seen					 			:= l.date_last_seen												;

		self.vendor_id									:= (string40)hash(l.best_ssn, 
																											l.Pname.lname, 
																											l.Pname.fname, 
																											l.Pname.mname,
																											l.best_dob
																										 )	;
		self.subject_name					 			:= l.Pname																;
		self.subject_address						:= l.Person_addr													;
		self.subject_address.city_name	:= l.Person_addr.v_city_name							;
		self.subject_phone							:= 0																			;
		self.subject_ssn								:= (unsigned4)l.best_ssn									;
		self.subject_dob								:= (unsigned4)l.best_dob									;
		self.subject_job_title					:= ''																			;
		self.subject_rawaid 						:= l.append_rawaid												;
		//self.subject_aceaid 						:= l.ace_aid															;
		self.company_name					 			:= l.bh_company_name											;
		self.company_address						:= l.bh_Company_addr											;
		self.company_rawaid 						:= l.bh_rawaid														;
		self.company_phone							:= (unsigned5)l.bh_phone									;
		self.company_fein					 			:= 0																			;
		self.global_sid									:= l.global_sid														;
		self														:= []																			;
	
	end;

	dMappedToPOE := project(pPOEsFromEamilsBase	,tMapToPOE(left));
	
	return dMappedToPOE;

end;