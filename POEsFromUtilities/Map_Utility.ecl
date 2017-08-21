import POE,mdr,utilfile,ut;

export Map_Utility(

	 dataset(utilfile.layout_util.base	) pUtilityBase	= utilfile.Files().fullbase.root

) :=
function

	Layouts.Base	tMapToPOE(utilfile.layout_util.base l) :=
	transform
		
		self.source								 				:= mdr.sourceTools.src_Utilities	;
		self.did													:= 0															;
		self.did_score										:= 0															;
		self.bdid									 				:= 0															;
		self.bdid_score						 				:= 0															;
		self.dt_first_seen								:= (UNSIGNED4)l.date_first_seen		;
		self.dt_last_seen					 				:= (UNSIGNED4)l.date_first_seen		;
		self.vendor_id										:= l.id														;
		self.subject_name.title						:= l.title												;
		self.subject_name.fname						:= l.fname												;
		self.subject_name.mname						:= l.mname												;
		self.subject_name.lname						:= l.lname												;
		self.subject_name.name_suffix			:= l.name_suffix									;
		self.subject_name.name_score			:= l.name_score										;
		self.subject_address.prim_range		:= l.prim_range										;
		self.subject_address.predir				:= l.predir												;
		self.subject_address.prim_name		:= l.prim_name										;
		self.subject_address.addr_suffix	:= l.addr_suffix									;
		self.subject_address.postdir			:= l.postdir											;
		self.subject_address.unit_desig		:= l.unit_desig										;
		self.subject_address.sec_range		:= l.sec_range										;
		self.subject_address.city_name		:= l.v_city_name									;
		self.subject_address.st						:= l.st														;
		self.subject_address.zip					:= l.zip													;
		self.subject_address.zip4					:= l.zip4													;
		self.subject_phone								:= (unsigned5)l.Phone							;
		self.subject_ssn									:= (unsigned4)l.ssn								;
		self.subject_dob									:= (unsigned4)l.dob								;
		self.subject_job_title						:= ''															;
		self.subject_rawaid 							:= l.Append_RawAID								;
		self.subject_aceaid 							:= 0															;
		self.company_name					 				:= ''															;
		self.company_address							:= []															;
		self.company_phone								:= (unsigned5)l.work_phone				;	// pull company info from EDA using work phone
		self.company_fein					 				:= 0															;
		self.company_rawaid				 				:= 0															;
		self.company_aceaid				 				:= 0															;
		self.rawfields										:= l															;
	
	end;

	one_year_ago := (unsigned4)((string)((unsigned)ut.GetDate[1..4] - 1) + ut.GetDate[5..]);

	dMappedToPOE	:= project(pUtilityBase(lname != '',(unsigned)work_phone != 0,(unsigned4)record_date > one_year_ago)	,tMapToPOE(left));
	
	return dMappedToPOE;

end;