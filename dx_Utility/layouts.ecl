IMPORT bipv2;
EXPORT layouts := MODULE

EXPORT i_DID_daily := RECORD  
  unsigned6  s_did;
  $.layout_DID_out;
END;

EXPORT i_did := RECORD
  unsigned6  s_did;
  $.layout_DID_out AND NOT [fdid,HHID];
END;

EXPORT i_fdid_daily := RECORD
  $.layout_DID_out;
END;

EXPORT i_address := RECORD
  $.layout_DID_out AND NOT [fdid,HHID];
END;

EXPORT i_LinkIDs := RECORD
  $.Layout_Utility_In;
  string100  company_name := '';
  string12   bdid := '';
  unsigned1  bdid_score := 0;   //Added for BIP project
  string2    source := '';
  bipv2.IDlayouts.l_xlink_ids;	 //Added for BIP project
  unsigned8  source_rec_id := 0; //Added for BIP project	
END;
END;