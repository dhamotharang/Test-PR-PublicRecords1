import POE,OPM;

export As_POE(

	dataset(OPM.layouts.Base) pBase	= OPM.Files().base.qa

) :=
function

	POE.Layouts.Base	tMapToPOE(OPM.layouts.Base l) :=
	transform
		
			self.source								 				:= l.source;
			self.did													:= l.did;
			self.did_score									  := l.did_score;
			self.dt_first_seen							  := l.dt_first_seen;
			self.dt_last_seen					 			  := l.dt_last_seen;
			self.vendor_id									  := (string)l.record_sid;		
			self.subject_job_title					  := l.Occu_Series_Desc;
			self.subject_rawaid 						  := l.raw_aid;
			self.subject_aceaid 						  := l.ace_aid;
			self.subject_name.title						:= l.title;
			self.subject_name.fname						:= l.fname;
			self.subject_name.mname					  := l.mname;
			self.subject_name.lname						:= l.lname;
			self.subject_name.name_suffix			:= l.name_suffix;
			self.subject_name.name_score			:= l.name_score;
			self.subject_address.prim_range		:= l.prim_range;
			self.subject_address.predir				:= l.predir;
			self.subject_address.prim_name		:= l.prim_name;
			self.subject_address.addr_suffix	:= l.addr_suffix;
			self.subject_address.postdir			:= l.postdir;
			self.subject_address.unit_desig		:= l.unit_desig;
			self.subject_address.sec_range		:= l.sec_range;
			self.subject_address.city_name		:= l.v_city_name;
			self.subject_address.st						:= l.st;
			self.subject_address.zip					:= l.zip;
			self.subject_ssn					        := (integer)l.ssn;
			self.company_name					 				:= l.Agency;
			self.company_address.prim_range		:= l.prim_range;
			self.company_address.predir				:= l.predir;
			self.company_address.prim_name		:= l.prim_name;
			self.company_address.addr_suffix	:= l.addr_suffix;
			self.company_address.postdir			:= l.postdir;
			self.company_address.unit_desig		:= l.unit_desig;
			self.company_address.sec_range		:= l.sec_range;
			self.company_address.city_name		:= l.v_city_name;
			self.company_address.st						:= l.st;
			self.company_address.zip					:= l.zip;
			self.company_rawaid				 				:= l.raw_aid  ;
			self.company_aceaid				 				:= l.ace_aid  ;
			self.record_sid										:= l.record_sid  ;
			self.global_sid										:= l.global_sid    ;										
			self															:= [ ];

	end;

	dMappedToPOE := project(pBase	,tMapToPOE(left));
	
	return dMappedToPOE;

end;