import _control, VersionControl;
export _Flags :=
module
   export IsTesting                    := VersionControl._Flags.IsDataland;
   
   export UseStandardizePersists := not IsTesting; // for bug 26170 -- Missing dependency from persist to stored
   
   export ExistCurrentSprayed    := count(nothor(fileservices.superfilecontents(filenames().input.using  ))) > 0;
   
	 export ExistCompaniesBaseFile := count(nothor(fileservices.superfilecontents(filenames().base.Companies.qa ))) > 0;
   export ExistContactsBaseFile  := count(nothor(fileservices.superfilecontents(filenames().base.Contacts.qa  ))) > 0;
   
	 export UpdateCompanies        := ExistCurrentSprayed and ExistCompaniesBaseFile;
   export UpdateContacts         := ExistCurrentSprayed and ExistContactsBaseFile ;
end;                                                  
