party_raw := uccv2_services.layout_ucc_party_raw;

EXPORT layout_ucc_party_parsed := RECORD
  party_raw.bdid;
  party_raw.DotID;
  party_raw.EmpID;
  party_raw.POWID;
  party_raw.ProxID;
  party_raw.SELEID;
  party_raw.OrgID;
  party_raw.UltID;
  party_raw.did;
  
  party_raw.title;
  party_raw.lname;
  party_raw.fname;
  party_raw.mname;
  party_raw.name_suffix;
  
  party_raw.ssn;
  party_raw.fein;
  party_raw.Incorp_state;
  party_raw.corp_number;
  party_raw.corp_type;
END;
