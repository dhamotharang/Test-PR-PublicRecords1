 
import BIPV2_Contacts;
import BIPV2_Build;
import STD;

export BestContactTitles(string pVersion=(string) STD.Date.Today()) := function
  contact_title_layout := RECORD
    unsigned8 contact_title_rank;
    unsigned6 contact_did;
  END;

  flatContactTitleRec := RECORD
    unsigned6 ultid;
    unsigned6 orgid;
    unsigned6 seleid;
    unsigned6 proxid;
    contact_title_layout;
  END;

  contactKey := project(pull(BIPV2_Contacts.key_contact_linkids.keyvs(,false).built), BIPV2_Contacts.layouts.contact_linkids.layoutOrigFile);

   
  build_date        := (unsigned) STD.Str.Filter(pversion,'0123456789');	 
  contactTitles     := BIPV2_Build.BestContactTitle(contactKey, build_date).contact_title;
  
  flatContactTitles := normalize(contactTitles, left.contact_title,transform(flatContactTitleRec,self := left, self := right));

  return flatContactTitles(proxid=0);
end;