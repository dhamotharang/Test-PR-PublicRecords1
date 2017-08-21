import POE,mdr;

export As_POE(

	dataset(layouts.Base) pTeletrackBase	= Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(layouts.Base l) :=
	transform
		
		self.source								 			:= mdr.sourceTools.src_Teletrack					;
		self.did												:= 0																			;
		self.did_score									:= 0																			;
		self.bdid									 			:= 0																			;
		self.bdid_score						 			:= 0																			;
		self.dt_first_seen							:= l.dt_first_seen												;
		self.dt_last_seen					 			:= l.dt_last_seen													;

		self.vendor_id									:= (string40)hash(l.rawfields.ssn, 
																											l.clean_name.lname, 
																											l.clean_name.fname, 
																											l.clean_name.mname, 
																											l.rawfields.time_stamp)	;
		self.subject_name					 			:= l.Clean_name														;
		self.subject_address						:= l.Clean_address												;
		self.subject_address.city_name	:= l.Clean_address.v_city_name						;
		self.subject_phone							:= (unsigned5)l.clean_hphone							;
		self.subject_ssn								:= (unsigned4)l.rawfields.ssn							;
		self.subject_dob								:= 0																			;
		self.subject_job_title					:= ''																			;
		self.subject_rawaid 						:= l.raw_aid															;
		self.subject_aceaid 						:= l.ace_aid															;
		self.company_name					 			:= l.rawfields.work_place									;
		self.company_address.city_name	:= l.rawfields.work_city									;
		self.company_address.st					:= l.rawfields.work_state									;
		self.company_phone							:= (unsigned5)l.clean_wphone							;
		self.company_fein					 			:= 0																			;
		self														:= []																			;
	
	end;

	dMappedToPOE := project(pTeletrackBase	,tMapToPOE(left));
	
	return dMappedToPOE;

end;