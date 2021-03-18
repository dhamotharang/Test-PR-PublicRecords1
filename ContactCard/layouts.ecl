import bankruptcyv2_services, doxie, doxie_raw, EmailV2_Services, header,
      PersonReports, PhonesFeedback_Services;

export layouts := module

  shared con := contactcard.constants;

  shared head := doxie_raw.Layout_HeaderRawOutput;


  export contact_rec := record
    head.did;
    head.fname;
    head.mname;
    head.lname;
    string120 company_name := '';
  end;

  export phone_ln_rec := record
    string10 phone;
    string4 timezone;
    string100 listing_name;
    string1 publish_code;
  end;

  export phone_ln_rec_feedback := record
    phone_ln_rec;
    DATASET(PhonesFeedback_Services.Layouts.feedback_report) Feedback {MAXCOUNT(1)};
  end;

  export phone_rec := record
    phone_ln_rec_feedback;
    boolean ApartmentOffice;
    string20 PhoneType := '';
  end;

  export phone_rec_ext := record
    phone_rec;
    unsigned3 dt_last_seen;
  end;

  export comp_addr_rec := record(doxie.Layout_Comp_Addresses - [feedback])
    boolean verified;
    string4 timezone;
    string4 listed_timezone;
    // string2 src;
    dataset(phone_ln_rec)	phones		{maxcount(con.max_PhonesPerAddr)};
  end;

  export addr_rec := record
    unsigned3 subject_dt_last_seen := 0;
    comp_addr_rec - [did,fname,mname,lname,hri_address,phones];
  end;

  export phone_addr_rec := record
    phone_rec phone;
    addr_rec  addr;
  end;

  export contact_phone_addr_rec := record
    contact_rec contact;
    phone_addr_rec;
  end;

  export contact_phone_addr_rec_ext := record
    contact_rec contact;
    phone_rec_ext phone;
    addr_rec  addr;
  end;

  export addr_phones_rec := record
    dataset(phone_rec) phones {maxcount(con.max_TotalPhonesPerAddr)}; // increased to accomodate PhonesPlus for finders
    addr_rec  addr;
  end;

  export contact_relat_rec := record
    integer1 depth;
    string40 relationship;
    string15 relationship_type;
    string10 relationship_confidence;
    unsigned3 relationship_last_seen := 0;
    contact_rec contact;
    unsigned3 dt_last_seen;
  end;

  export pridid_rec := record
    unsigned1 priority;
    head.did;
    unsigned1 depth;
    integer2  rel_prim_range;
    unsigned1 TitleNo := 0;
    string15 type;
    string10 confidence;
    integer3 recent_cohabit;
    boolean isRelative;
    contact_relat_rec.relationship;
  end;

  export addr_phones_contacts_rec := record
    dataset(contact_relat_rec) WhoToAskFor {maxcount(con.max_WhoToAskFor)};
    addr_phones_rec addr_phones;
  end;

  export finder_rec := record
    pridid_rec.priority;
    string20 ReachMe;
    dataset(addr_phones_contacts_rec) try {maxcount(con.max_Try)};
  end;

  export indicator_rec := record
    unsigned2 bk_count;
    unsigned2 corp_affil_count;
    unsigned2 comp_prop_count;
  end;

  export imposter_rec := personreports.layouts.indiv_imposter;

  export bankruptcy_rec := bankruptcyv2_services.layouts.layout_rollup;

  export phoneSection_rec := doxie.layout_AppendGongByAddr_input;

  shared name_rec := record
    Header.Layout_Header.title;
    personreports.layouts.name.fml;
  END;

  export aka_rec := record
    name_rec name;
    PersonReports.layouts.identity - [drivers_licenses,name];
    string1 deceased;
  end;

  export subject_rec := record
    name_rec name;
    personreports.layouts.identity - [name] ;
    string1 deceased;
  end;

  export result_ext_rec := record
    dataset(finder_rec) 		finders 						{maxcount(con.max_finders)};
    dataset(aka_rec) 				akas 								{maxcount(con.max_akas)};
    dataset(indicator_rec) 	indicators 					{maxcount(con.max_indicators)};
    dataset(bankruptcy_rec) bankruptcies				{maxcount(con.max_bankruptcies)};
    dataset(subject_rec) 		subject_information	{maxcount(con.max_subject_info_names)};
    dataset(imposter_rec) 	imposters						{maxcount(con.max_imposters)};
    dataset(comp_addr_rec) 	addresses 					{maxcount(con.max_addresses)};
    EmailV2_Services.Layouts.crs_email_combined_rec;
  end;

  export result_rec := record
    result_ext_rec - [EmailV2Royalties];
  end;

  export rollup_rec2 := record
    finder_rec;
    contact_relat_rec;
    phone_rec_ext phone;
    addr_rec  addr;
  end;

 // these layouts are added so phone records can be sorted by dates before final output
  export addr_phones_rec_ext := record
    dataset(phone_rec_ext) phones {maxcount(con.max_TotalPhonesPerAddr)};
    addr_rec  addr;
  end;

  export addr_phones_contacts_rec_ext := record
    dataset(contact_relat_rec) WhoToAskFor {maxcount(con.max_WhoToAskFor)};
    addr_phones_rec_ext addr_phones;
  end;

  export finder_rec_ext := record
    pridid_rec.priority;
    string20 ReachMe;
    dataset(addr_phones_contacts_rec_ext) try {maxcount(con.max_Try)};
  end;

  export rollup_rec_ext := record
    finder_rec_ext;
    contact_relat_rec;
    phone_rec_ext phone;
    addr_rec  addr;
  end;


END;
