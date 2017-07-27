export Layout_Did_Update_Out := record
  string12	cust_code;
  unsigned6 did;
  unsigned6 current_did;  
  string120 best_name := '';
  string120 best_addr1 := '';
  string120 best_addr2 := '';
  unsigned3	best_addr_date := 0;
  string12  best_dob := '';
  string9   best_ssn := '';
  string10  best_phone := '';
  string12  best_dod := '';
  end;