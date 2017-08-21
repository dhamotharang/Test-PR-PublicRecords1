import tools,dnb;

export File_Contacts_V1_Base(

	dataset(dnb.Layout_DNB_Contacts_Base	)	pBaseContactsFile		= Files(,_Constants().IsDataland,'DNB').V1.Contacts.root								

) :=
function

	tools.mac_RedefineFormat(pBaseContactsFile,layouts.base.contacts_prev,dRedefineFormat);

	dBaseContactsFile := project(dRedefineFormat,transform(layouts.base.Contacts, 

			self.date_first_seen	:= (unsigned4)left.date_first_seen	;
			self.date_last_seen		:= (unsigned4)left.date_last_seen		;
			self.record_type			:= utilities.CurrentHistoricalFlag2RT(left.record_type);
			self									:= left;
			self									:= [];
	
	));

	return dBaseContactsFile;

end;