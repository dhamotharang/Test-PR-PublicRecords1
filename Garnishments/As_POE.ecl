import POE,mdr;

export As_POE(

	dataset(layouts.Base) pBase	= Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(layouts.Base l) :=
	transform
		
		self.source								 			:= mdr.sourceTools.src_Garnishments				;
		self.did												:= l.did																	;
		self.did_score									:= l.did_score														;
		self.bdid									 			:= l.bdid																	;
		self.bdid_score						 			:= l.bdid_score														;
		self.dt_first_seen							:= l.dt_first_seen												;
		self.dt_last_seen					 			:= l.dt_last_seen													;
		self.vendor_id									:= 				trim(l.rawfields.Courtid		,left,right)
																			+ '-' + trim(l.rawfields.Filetypeid	,left,right)
																			+ '-' + trim(l.rawfields.CaseNumber	,left,right)
																			+ '-' + trim(l.rawfields.FilingDate	,left,right)
																			;
		self.subject_name					 			:= l.clean_defendant_name									;
		self.subject_address						:= l.Clean_Defendant_address							;
		self.subject_address.city_name	:= l.Clean_Defendant_address.v_city_name	;
		self.subject_phone							:= (unsigned5)l.clean_phones.AttorneyPhone;//attorney phone is actually defendant phone
		self.subject_ssn								:= (unsigned4)l.rawfields.ssn							;
		self.subject_dob								:= 0																			;
		self.subject_job_title					:= ''																			;
		self.subject_rawaid 						:= l.Defendant_raw_aid										;
		self.subject_aceaid 						:= l.Defendant_ace_aid										;
		self.company_name					 			:= l.rawfields.AttorneyName								;
		self.company_address						:= l.Clean_attorney_address								;
		self.company_address.city_name	:= l.Clean_attorney_address.v_city_name		;
		self.company_phone							:= 0																			;
		self.company_fein					 			:= 0																			;
		self.company_rawaid				 			:= l.attorney_raw_aid											;
		self.company_aceaid				 			:= l.attorney_ace_aid											;
	
	end;

	dMappedToPOE := project(pBase	,tMapToPOE(left));
	
	return dMappedToPOE;

end;