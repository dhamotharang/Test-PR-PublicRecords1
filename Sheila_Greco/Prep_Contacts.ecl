
export Prep_Contacts(dataset(layouts.Input.Sprayed) pInputFile, string pversion)
		:= 	function
		
	preprocessCont := Parse_Input.PreProcess.Contacts	(pInputFile);
	parseCont  		 := Parse_Input.Contacts						(preprocessCont);
  Contacts_Updt	 := Standardize_Contacts.fStandardizeContNameDates(parseCont, pversion) : persist(Persistnames.PreppedContacts);

	return 	Contacts_Updt;
	
	end;