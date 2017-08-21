import tools,dnb;

export File_Contacts_Keybuild(

	 string														pVersion						= 'qa'
	,boolean													pIsTesting					= _Constants().IsDataland
	,dataset(Layouts.Base.Contacts	)	pBaseContactsFile		= Files(pVersion,pIsTesting).base.Contacts.new								

) :=
function

	dBaseContactsFile := project(pBaseContactsFile,transform(layouts.base.Contacts_prev, 

			self.date_first_seen	:= (string8)left.date_first_seen	;
			self.date_last_seen		:= (string8)left.date_last_seen		;
			self.record_type			:= utilities.RT2CurrentHistoricalFlag(left.company_record_type);
			self									:= left;
	
	));

	tools.mac_RedefineFormat(dBaseContactsFile,DNB.Layout_DNB_Contacts_Base,dreturndataset);

	return dreturndataset;

end;