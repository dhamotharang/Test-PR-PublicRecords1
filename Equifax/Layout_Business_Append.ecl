export Layout_Business_Append := record
unsigned6 rid;
unsigned6 bdid;
string80 business_name;
Layout_Address_Clean;
// Source Data Record Counts
unsigned3 corp_record_cnt := 0;
unsigned3 ucc_record_cnt := 0;
unsigned3 fbn_record_cnt := 0;
unsigned3 busreg_record_cnt := 0;
unsigned3 bk_record_cnt := 0;
unsigned3 lj_record_cnt := 0;
// Best informaton
qstring120 best_company_name := '';
qstring10 best_prim_range := '';
string2   best_predir := '';
qstring28 best_prim_name := '';
qstring4  best_addr_suffix := '';
string2   best_postdir := '';
qstring5  best_unit_desig := '';
qstring8  best_sec_range := '';
qstring25 best_city := '';
string2   best_state := '';
unsigned3 best_zip := 0;
unsigned2 best_zip4 := 0;
unsigned6 best_phone := 0;
unsigned4 best_fein := 0;
end;