import POE,mdr;

export As_POE(

	dataset(layouts.Base) pZoomBase	= Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(layouts.keybuild l) :=
	transform
		
		self.source								 			:= mdr.sourceTools.src_ZOOM								;
		self.did												:= 0																			;
		self.did_score									:= 0																			;
		self.bdid									 			:= 0																			;
		self.bdid_score						 			:= 0																			;
		self.dt_first_seen							:= l.dt_first_seen												;
		self.dt_last_seen					 			:= l.dt_last_seen													;

		self.vendor_id									:= if(l.rawfields.zoom_company_id <> ''
																					,trim(l.rawfields.zoomid,left,right) + '-' + trim(l.rawfields.zoom_company_id,left,right)
																					,trim(l.rawfields.zoomid,left,right)
																		);
		self.subject_name					 			:= l.clean_contact_name										;
		self.subject_address						:= l.clean_company_address								;
		self.subject_address.city_name	:= l.clean_company_address.v_city_name		;
		self.subject_phone							:= (unsigned5)l.clean_phones.phone				;
		self.subject_ssn								:= 0																			;
		self.subject_dob								:= 0																			;
		self.subject_job_title					:= l.rawfields.Job_Title									;
		self.subject_rawaid 						:= l.raw_aid															;
		self.subject_aceaid 						:= l.ace_aid															;
		self.company_name					 			:= l.rawfields.COMPANY_NAME								;
		self.company_address						:= l.clean_company_address								;
		self.company_address.city_name	:= l.clean_company_address.v_city_name		;
		self.company_phone							:= (unsigned5)l.clean_phones.company_phone;
		self.company_fein					 			:= 0																			;
		self.company_rawaid				 			:= l.raw_aid															;
		self.company_aceaid				 			:= l.ace_aid															;
		self.global_sid									:= l.global_sid														;
	
	end;

	dMappedToPOE := project(_Filters.Keybuild(_Filters.fAs_POE(pZoomBase))	,tMapToPOE(left));	//apply same filter to as poe as it does to keys
	
	return dMappedToPOE;

end;