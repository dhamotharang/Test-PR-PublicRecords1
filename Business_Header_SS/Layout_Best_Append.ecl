EXPORT Layout_Best_Append := RECORD
  string10  best_phone := '';
  string9   best_fein := '';
  string120 best_CompanyName := '';
  string120 best_addr1 := '';
//  string120 best_addr2 := '';
  string30	best_city := '';
  string2	best_state := '';
  string5	best_zip :='';
  string4	best_zip4 := '';
  unsigned1 verify_best_phone := 255;
  unsigned1 verify_best_fein := 255;
  unsigned1 verify_best_address := 255;
  unsigned1 verify_best_CompanyName := 255;
END;