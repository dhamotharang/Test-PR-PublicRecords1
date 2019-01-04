import Entiera,doxie,address, AutoStandardI;

export Assorted_Layouts := MODULE

  export did_w_deepdive := record
    doxie.layout_references;
    boolean isdeepdive := FALSE;
  END;

inputmod := AutoStandardI.GlobalModule();

export layout_inputs := record
typeof(inputmod.addr)           addr  ;
typeof(inputmod.agehigh)           agehigh  ;
typeof(inputmod.agelow)           agelow  ;
typeof(inputmod.asisname)            asisname  ;
typeof(inputmod.city    )        city  ;
typeof(inputmod.county)            county  ;
typeof(inputmod.did)            input_did  ;
typeof(inputmod.dob)           dob  ;
typeof(inputmod.firstname)            firstname  ;
typeof(inputmod.fname3 )           fname3  ;
typeof(inputmod.isfcraval)            isfcraval  ;
typeof(inputmod.isprp)          isprp  ;
typeof(inputmod.lastname)            lastname  ;
typeof(inputmod.lfmname  )          lfmname  ;
typeof(inputmod.lname )           lname  ;
typeof(inputmod.lname4 )           lname4  ;
typeof(inputmod.lnbranded )          lnbranded  ;
typeof(inputmod.middlename )           middlename  ;
typeof(inputmod.nameasis)            nameasis  ;
typeof(inputmod.nonexclusion)           nonexclusion  ;
typeof(inputmod.phone)            phone  ;
typeof(inputmod.phoneticdistancematch)           phoneticdistancematch  ;
typeof(inputmod.phoneticmatch)            phoneticmatch  ;
typeof(inputmod.postdir)            postdir  ;
typeof(inputmod.predir)            predir  ;
typeof(inputmod.prim_name)            prim_name  ;
typeof(inputmod.prim_range )           prim_range  ;
typeof(inputmod.sec_range )           sec_range  ;
typeof(inputmod.primname )           primname  ;
typeof(inputmod.primrange )           primrange  ;
typeof(inputmod.secrange )           secrange  ;
typeof(inputmod.scorethreshold)           scorethreshold  ;
typeof(inputmod.ssn )           ssn  ;
typeof(inputmod.st)            st  ;
typeof(inputmod.st_orig)            st_orig  ;
typeof(inputmod.state )           state  ;
typeof(inputmod.statecityzip)            statecityzip  ;
typeof(inputmod.street_name)            street_name  ;
typeof(inputmod.suffix)            suffix  ;
typeof(inputmod.unparsedfullname)           unparsedfullname  ;
typeof(inputmod.z5 )           z5  ;
typeof(inputmod.zip )           zip  ;
typeof(inputmod.zipradius)           zipradius  ;
typeof(inputmod.ssnmask)  ssn_mask_value;
typeof(inputmod.useGlobalScope)  useGlobalScope;
end;



export did_w_input := record
unsigned3 seq;
did_w_deepdive;
layout_inputs;
unsigned2 penalt_threshold;
end;



export layout_emails := record
Entiera.All_Entiera_Layouts.Entiera_final_layout.orig_email;
string clean_email := '';
Entiera.All_Entiera_Layouts.Entiera_final_layout.orig_login_date;
Entiera.All_Entiera_Layouts.Entiera_final_layout.orig_site;
string8 date_first_seen;
string8 date_last_seen;
string8 date_vendor_first_reported;
string8 date_vendor_last_reported;
end;

export parsed_email := record
  string60 Email_addr1;
  string60 Email_addr2;
  boolean isdeepdive := FALSE;
  unsigned6 did;
end;

export layout_names := record (address.Layout_Clean_Name)
unsigned2 penalt_name;
end;

export layout_addresses :=record (address.Layout_Clean182)
unsigned2 penalt_addr;
end;

  export layout_report_rollup := record
    unsigned6 did;
    unsigned6 emailid;
    string2 src;
    Entiera.All_Entiera_Layouts.Entiera_final_layout.best_dob;
    Entiera.All_Entiera_Layouts.Entiera_final_layout.best_ssn;
    unsigned4 latest_orig_login_date;
    dataset(layout_names) names {maxcount(Constants.MAX_NAMES_PER_PERSON)};
    dataset(layout_addresses) addresses {maxcount(Constants.MAX_ADDRS_PER_PERSON)};
    dataset(layout_emails) emails {maxcount(Constants.MAX_EMAILS_PER_PERSON)};  
  END;

  export layout_entiera_rollup := record
    boolean isDeepDive;
    unsigned2 penalt_didssndob;
    layout_inputs.ssn_mask_value;
    unsigned2 penalt_threshold;    
    layout_report_rollup;
  END;  

  export layout_entiera_rollup_w_seq := record
    unsigned3 seq;
    unsigned2 penalt;    
    layout_entiera_rollup;
  END;

  export layout_relationship := record
    unsigned subject_lexId;
    unsigned identity_lexid;   // the identity which relationship to subject we try to identify
    string relationship := '';
  end;

  export layout_search_out := record (layout_entiera_rollup_w_seq)
    string relationship := '';
    unsigned subject_lexId := 0;
  end;

END;