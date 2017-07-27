import iesp;

// flatten layouts reprsenting IdentityReport output
export layout_identityreport := MODULE;
  shared rec_indicator := iesp.identityfraudreport.t_ColoredRiskIndicator;

  // need to flatten standard structures
  export rec_src := record
    iesp.identityfraudreport.t_IFRLinkIdSources src_1;
    iesp.identityfraudreport.t_IFRLinkIdSources src_2;
    iesp.identityfraudreport.t_IFRLinkIdSources src_3;
    iesp.identityfraudreport.t_IFRLinkIdSources src_4;
    iesp.identityfraudreport.t_IFRLinkIdSources src_5;
    iesp.identityfraudreport.t_IFRLinkIdSources src_6;
    iesp.identityfraudreport.t_IFRLinkIdSources src_7;
    iesp.identityfraudreport.t_IFRLinkIdSources src_8;
    iesp.identityfraudreport.t_IFRLinkIdSources src_9;
    iesp.identityfraudreport.t_IFRLinkIdSources src_10;
  end;

  export rec_info := record // t_IFRInfo
    iesp.share.t_Date DateFirstSeen;
    iesp.share.t_Date DateLastSeen;
    integer2 SourceCount;
    rec_indicator RI_1;
    rec_indicator RI_2;
    rec_indicator RI_3;
    rec_indicator RI_4;
    rec_src SRC;
  end;

  export rec_linkid := record (rec_info)
    string12 UniqueId;
    string _Type {maxlength(32)}; //use typof...
  end;

  export rec_name := record (rec_info)
    iesp.share.t_Name NAME;
  end;

  export rec_address := record (rec_info)
    iesp.share.t_Address ADDRESS;
    iesp.share.t_GeoLocation Location;
  end;

  export rec_phone := record (rec_info)
    string10 Phone10 {xpath('Phone10')};
    string ListedName {xpath('ListedName'), maxlength(120)};
    string4 TimeZone {xpath('TimeZone')};
    string12 PhoneType {xpath('PhoneType')};
    string30 CarrierName {xpath('CarrierName')};
    string25 CarrierCity {xpath('CarrierCity')};
    string2 CarrierState {xpath('CarrierState')};
    string1 ListingType; // we will use only one
  end;

  export rec_dob := record (rec_info)
    iesp.share.t_Date DOB;
  end;

  export rec_ssn := record (rec_info)
    iesp.share.t_SSNInfo SSNData;
  end;

  export rec_dl := record (rec_info)
    string24 Number {xpath('Number')};
    string2 IssueState {xpath('IssueState')};
    iesp.share.t_Date IssueDate {xpath('IssueDate')};
    iesp.share.t_Date ExpirationDate {xpath('ExpirationDate')};
    boolean IsGovernmentSource {xpath('IsGovernmentSource')};
  end;

  export rec_prim_identity := record
    rec_linkid LII;
    rec_name NI;
    rec_address AI;
    rec_phone PI_1;
    rec_phone PI_2;
    rec_dob DI;
    iesp.share.t_Date DOD;
    string7 Gender;
    rec_ssn SI;
    rec_dl DL;
    iesp.share.t_Name MothersMaidenName;
  end;

  export rec_assoc_identity := record
    rec_linkid LII;
    rec_name NI;
    rec_address AI;
    rec_phone PI;
    rec_dob DI;
    iesp.share.t_Date DOD;
    string7 Gender;
    rec_ssn SI;
    string24 InferredAssociation;
  end;

  export rec_in := record
    string32 TABLE_NAME;
    string30 ACCOUNT;
    string20 firstname;
    string20 lastname;
    string5 zip5; 
    string9 ssn; 
    string10 phone; 

    // header and summary; not used
    string2 H_STATUS;
    string2 H_MESSAGE;
    string2 QUERY_ID;
    string2 TRANSACTIONID;
    string2 EXC_SOURCE;
    string2 EXC_CODE;
    string2 EXC_LOCATION;
    string2 EXC_MESSAGE;
    rec_indicator RS_RI_1;
    rec_indicator RS_RI_2;
    rec_indicator RS_RI_3;
    rec_indicator RS_RI_4;

    rec_prim_identity pi;// primary identity

    // associated data
    rec_name AD_N_1;
    rec_name AD_N_2;
    rec_ssn AD_SSN;
    rec_dob AD_DOB;
    rec_address AD_ADDR_1;
    rec_address AD_ADDR_2;

    //imposters
    rec_assoc_identity imposter_1;
    rec_assoc_identity imposter_2;
    integer MoreAssociatedIdentities;
  end;


  export rec_src_slim := record
    iesp.identityfraudreport.t_IFRLinkIdSources src_1;
    iesp.identityfraudreport.t_IFRLinkIdSources src_2;
    iesp.identityfraudreport.t_IFRLinkIdSources src_3;
    iesp.identityfraudreport.t_IFRLinkIdSources src_4;
    iesp.identityfraudreport.t_IFRLinkIdSources src_5;
  end;

  export rec_info_slim := record // t_IFRInfo
    iesp.share.t_Date DateFirstSeen;
    iesp.share.t_Date DateLastSeen;
    integer2 SourceCount;
    rec_indicator RI_1;
    rec_indicator RI_2;
    rec_indicator RI_3;
    rec_src_slim SRC;
  end;

  export rec_linkid_slim := record (rec_info_slim)
    string12 UniqueId;
    string _Type {maxlength(32)}; //use typof...
  end;

  export rec_name_slim := record (rec_info_slim)
    iesp.share.t_Name NAME;
  end;

  export rec_address_slim := record (rec_info_slim)
    iesp.share.t_Address ADDRESS;
    iesp.share.t_GeoLocation Location;
  end;

  export rec_phone_slim := record (rec_info_slim)
    string10 Phone10 {xpath('Phone10')};
    string ListedName {xpath('ListedName'), maxlength(120)};
    string4 TimeZone {xpath('TimeZone')};
    string12 PhoneType {xpath('PhoneType')};
    string30 CarrierName {xpath('CarrierName')};
    string25 CarrierCity {xpath('CarrierCity')};
    string2 CarrierState {xpath('CarrierState')};
    string1 ListingType; // we will use only one
  end;

  export rec_dob_slim := record (rec_info_slim)
    iesp.share.t_Date DOB;
  end;

  export rec_ssn_slim := record (rec_info_slim)
    iesp.share.t_SSNInfo SSNData;
  end;

  export rec_assoc_identity_slim := record
    rec_linkid_slim LII;
    rec_name_slim NI;
    rec_address_slim AI;
    rec_phone_slim PI;
    rec_dob_slim DI;
    iesp.share.t_Date DOD;
    string7 Gender;
    rec_ssn_slim SI;
    string24 InferredAssociation;
  end;

  export rec_in_slim := record
    string32 TABLE_NAME;
    string30 ACCOUNT;
    string20 firstname;
    string20 lastname;
    string5 zip5; 
    string9 ssn; 
    string10 phone; 

    // header and summary; not used
    string2 H_STATUS;
    string2 H_MESSAGE;
    string2 QUERY_ID;
    string2 TRANSACTIONID;
    string2 EXC_SOURCE;
    string2 EXC_CODE;
    string2 EXC_LOCATION;
    string2 EXC_MESSAGE;

    rec_prim_identity pi;// primary identity

    // associated data
    rec_name AD_N_1;
    rec_name AD_N_2;
    rec_ssn AD_SSN;
    rec_dob AD_DOB;
    rec_address AD_ADDR_1;
    rec_address AD_ADDR_2;

    //imposters
    rec_assoc_identity_slim imposter_1;
    rec_assoc_identity_slim imposter_2;
    integer MoreAssociatedIdentities;
  end;

END;