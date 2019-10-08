import BIPV2_Build;

export BestContactTitles := function
  contact_title_layout := RECORD
    unsigned8 contact_title_rank;
    string contact_job_title_derived;
    unsigned6 contact_did;
  END;

  flatContactTitleRec := RECORD
    unsigned6 ultid;
    unsigned6 orgid;
    unsigned6 seleid;
    unsigned6 proxid;
    contact_title_layout;
  END;

  contactTitles     := pull(BIPV2_Build.key_contact_title_linkids().keyvs(,false).qa);
  flatContactTitles := normalize(contactTitles, left.contact_title,transform(flatContactTitleRec,self := left, self := right));

  return flatContactTitles(proxid=0);
end;