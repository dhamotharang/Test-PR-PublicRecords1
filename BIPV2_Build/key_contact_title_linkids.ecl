Import BIPV2, tools, AutoStandardI, InsuranceHeader_PostProcess, STD,doxie;
import BIPV2_Contacts;

EXPORT key_contact_title_linkids(string pVersion=(string) STD.Date.Today()) := module

  //Using the index instead of base file (BIPV2_Build.files().contact_linkids.built) because of Roxie compile problems 
  contactKey := project(pull(BIPV2_Contacts.key_contact_linkids.keyvs(,false).built), BIPV2_Contacts.layouts.contact_linkids.layoutOrigFile);
	 
  build_date := (unsigned) STD.Str.Filter(pversion,'0123456789');
  shared contactTitles := BestContactTitle(contactKey, build_date).contact_title;

  shared contact_title_bipd_pst          :=   contactTitles : persist('~persist::BIPV2_Build::key_contact_title_linkids.ds_prep');
  export contact_title_bipd_dst          :=   dataset('~persist::BIPV2_Build::key_contact_title_linkids.ds_prep',{contactTitles},flat);
  
  export dkeybuild      := contact_title_bipd_pst;
	
  // DEFINE THE INDEX
  export Key := BIPV2_Contacts.KeyRead_Contact_Title(pversion).IndexDef(ds := dkeybuild);
 
	export contact_title_layout := BIPV2_Contacts.Layouts.contactTitle.contact_title_layout
		: deprecated('use BIPV2_Contacts.Layouts.contactTitle.contact_title_layout');

	export finalLayout := BIPV2_Contacts.Layouts.contactTitle.linkids
		: deprecated('use BIPV2_Contacts.Layouts.contactTitle.linkids');

  // -- ensure easy access to different logical and super versions of the key
  export keyvs := BIPV2_Contacts.KeyRead_Contact_Title(pversion).keyvs
		: deprecated('use BIPV2_Contacts.KeyRead_Contact_Title().keyvs');
  export keybuilt := BIPV2_Contacts.KeyRead_Contact_Title(pversion).keybuilt
		: deprecated('use BIPV2_Contacts.KeyRead_Contact_Title().keybuilt');
  export keyQA := BIPV2_Contacts.KeyRead_Contact_Title(pversion).keyQA
		: deprecated('use BIPV2_Contacts.KeyRead_Contact_Title().keyQA');
  export keyfather := BIPV2_Contacts.KeyRead_Contact_Title(pversion).keyfather
		: deprecated('use BIPV2_Contacts.KeyRead_Contact_Title().keyfather');
  export keygrandfather := BIPV2_Contacts.KeyRead_Contact_Title(pversion).keygrandfather
		: deprecated('use BIPV2_Contacts.KeyRead_Contact_Title().keygrandfather');
 
	export kFetch2 := BIPV2_Contacts.KeyRead_Contact_Title(pversion).kFetch2
		: deprecated('use BIPV2_Contacts.KeyRead_Contact_Title().keygrandfather');
  
END;
