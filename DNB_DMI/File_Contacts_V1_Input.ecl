import tools,dnb;

export File_Contacts_V1_Input(

	 dataset(layouts.input.oldcontacts	)	pInputContactsFile	= Files().input.oldcontacts.using							
	,string																pversion
	,string																pPersistname				= persistnames().FileContactsV1Input

) :=
function


	dnormcontacts  := pInputContactsFile(exec_last_name != '',delete_record_indicator = '');

	dsetDates	:= project(dnormcontacts,transform(Layouts.Base.contacts,

		self.date_first_seen															:= (unsigned4)left.date_first_seen									;
		self.date_last_seen																:= (unsigned4)left.date_last_seen										;
		self.date_vendor_first_reported										:= if(regexfind('[[:digit:]]{8}',left.__filename),(unsigned4)regexfind('[[:digit:]]{8}',left.__filename,0), (unsigned4)pversion			);
		self.date_vendor_last_reported										:= self.date_vendor_first_reported;
		self.rawfields																		:= left											;
		self.company_name																	:= left.company_name				;
		self																							:= left											;
		self																							:= []												;
	
	
	)) : persist(pPersistname);
	
	return dsetDates;

end;