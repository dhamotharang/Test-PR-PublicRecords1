maxval := 999999;  //stats hold 6 digits right now

export isStatOverflow(Layout_Business_Header_Stat s) := 
 s.base_record_count  > maxval OR
 s.corp_charter_number_relative_count > maxval OR
 s.business_registration_relative_count  > maxval OR
 s.bankruptcy_filing_relative_count  > maxval OR
 s.duns_number_relative_count  > maxval OR
 s.duns_tree_relative_count  > maxval OR
 s.edgar_cik_relative_count  > maxval OR
 s.name_relative_count  > maxval OR
 s.name_address_relative_count  > maxval OR
 s.name_phone_relative_count  > maxval OR
 s.gong_group_relative_count  > maxval OR
 s.ucc_filing_relative_count  > maxval OR
 s.fbn_filing_relative_count  > maxval OR
 s.fein_relative_count  > maxval OR
 s.phone_relative_count  > maxval OR
 s.addr_relative_count  > maxval OR
 s.mail_addr_relative_count  > maxval;