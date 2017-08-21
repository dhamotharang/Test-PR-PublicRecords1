EXPORT Layouts := module

// ProxID Slim Layout
export slimRec_layout := RECORD
  // unsigned6 rcid;
  unsigned6 dotid;
  unsigned6 proxid;
	string75 contact_name;
  string120 company_name;
  string250 cnp_name;
	string150 company_address;
  string2 source;
  string9 company_fein;
  string10 company_phone;
  string2 company_charter_state;
  string32 company_charter_number;
END;
 
end;