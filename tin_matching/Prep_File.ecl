import ut,address,idl_header;
export Prep_File(
	 string														pversion
	,dataset(Layouts.Input.Sprayed	)	pSprayedFile
	,string														pPersistname	= persistnames().PrepFile
) :=
function

	dPrep_File := project(pSprayedFile	,transform(
		layouts.base,
			self.rawfields.jobid						:= '';
			self.rawfields.acctno						:= '';
			self.rawfields.account_number		:= '';
			self.rawfields.gcid							:= '';
			self.date_first_seen						:= (unsigned4)regexreplace('/',left.date_created[1..10],'');
			self.date_last_seen							:= (unsigned4)regexreplace('/',left.last_updated[1..10],'');
			self.date_vendor_first_reported	:= (unsigned4)pversion;
			self.date_vendor_last_reported	:= (unsigned4)pversion;
			self.rawfields									:= left;
			self 														:= [];
	
	));

	dPrep_File_persist := dPrep_File : persist(pPersistname);
	
	return dPrep_File_persist;
end;
