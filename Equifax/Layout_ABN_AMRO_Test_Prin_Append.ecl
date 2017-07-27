import didville;

export Layout_ABN_AMRO_Test_Prin_Append := record
string1 record_type; // '1' - Equifax, '2' - Seisint
unsigned4 seq;
unsigned6 bdid := 0;
unsigned2 bdid_score := 0;
string1   bdid_from_contact := 'N';
unsigned6 did := 0;
unsigned2 score := 0;
// Original ABN AMRO data
string PROSPECT_HOUSEHOLD_KEY;
string COMPNAME;
string STREET;
string CITY;
string STATE;
string ZIP;
string ZIP4_ORIG;
// principal clean name
string5  title := '';
string20 fname := '';
string20 mname := '';
string20 lname := '';
string5  name_suffix := '';
string3  name_score := '';
// principal clean address
string10        prin_prim_range := '';
string2         prin_predir := '';
string28        prin_prim_name := '';
string4         prin_addr_suffix := '';
string2         prin_postdir := '';
string10        prin_unit_desig := '';
string8         prin_sec_range := '';
string25        prin_p_city_name := '';
string25        prin_v_city_name := '';
string2         prin_st := '';
string5         prin_zip := '';
string4         prin_zip4 := '';
string4         prin_cart := '';
string1         prin_cr_sort_sz := '';
string4         prin_lot := '';
string1         prin_lot_order := '';
string2         prin_dbpc := '';
string1         prin_chk_digit := '';
string2         prin_rec_type := '';
string2         prin_fips_state := '';
string3         prin_fips_county := '';
string10        prin_geo_lat := '';
string11        prin_geo_long := '';
string4         prin_msa := '';
string7         prin_geo_blk := '';
string1         prin_geo_match := '';
string4         prin_err_stat := '';
// best information
didville.layout_best_append;
// company information
qstring35 company_title := '';   // Title of Contact at Company if available
qstring35 company_department := '';
qstring120 company_name := '';
qstring10 company_prim_range := '';
string2   company_predir := '';
qstring28 company_prim_name := '';
qstring4  company_addr_suffix := '';
string2   company_postdir := '';
qstring5  company_unit_desig := '';
qstring8  company_sec_range := '';
qstring25 company_city := '';
string2   company_state := '';
unsigned3 company_zip := 0;
unsigned2 company_zip4 := 0;
unsigned6 company_phone := 0;
unsigned4 company_fein := 0;
unsigned6 contact_phone := 0;
string60  contact_email_address := '';
unsigned4 contact_ssn := 0;
end;