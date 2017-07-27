import ut, Address, Business_Header;

layout_edgar :=

RECORD
  integer8 fluff;
  boolean newrec;
  boolean keeprec;
  string100 ed_co_company;
  string100 ed_co_street1;
  string100 ed_co_street2;
  string100 ed_co_city;
  string100 ed_co_state;
  string100 ed_co_zip;
  string30 ed_co_phone;
 END;

file_edgar := dataset('~thor_marketing::edgar::companydemo', layout_edgar, flat);

Address.MAC_CleanPhone_Append(file_edgar, ed_co_phone, phone10, edgar_init_phone)

layout_edgar_clean := record
unsigned6 bdid := 0;
layout_edgar;
string10 phone10;
string120 addr1;
string120 addr2;
Address.Layout_Address_Clean_Return;
end;

layout_edgar_clean InitAddress(edgar_init_phone L) := transform
self.ed_co_company := Stringlib.StringToUpperCase(L.ed_co_company);
//self.phone10 := Address.CleanPhone(L.ed_co_phone);
self.addr1 := trim(Stringlib.StringToUpperCase(L.ed_co_street1)) + ' ' +
              trim(Stringlib.StringToUpperCase(L.ed_co_street2));
self.addr2 := trim(Stringlib.StringToUpperCase(L.ed_co_city)) + ', ' +
              Address.Map_State_Name_To_Abbrev(Stringlib.StringToUpperCase(L.ed_co_state)) + ' ' +
              L.ed_co_zip[1..5];
self := L;
end;

edgar_init := project(edgar_init_phone, InitAddress(left));

Address.MAC_Address_Clean_Standard(edgar_init, addr1, addr2, true, edgar_clean)

BDID_Matchset := ['A','P'];

Business_Header.MAC_Add_BDID_Flex(edgar_clean,
                                  BDID_Matchset,
                                  ed_co_company,
                                  prim_range, prim_name, sec_range, zip5,
                                  phone10, fein_field,
                                  bdid, layout_edgar_clean,
                                  FALSE, BDID_score_field,
                                  FALSE, debug_filename,
                                  edgar_clean_bdid)

count(edgar_clean_bdid(bdid<>0));
output(edgar_clean_bdid,,'TMTEMP::edgar_test_clean', overwrite);