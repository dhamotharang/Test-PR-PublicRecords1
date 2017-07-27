import Business_Header_SS;

export Layout_ABN_AMRO_C2BTest_Base := record
unsigned4 seq;
unsigned6 did := 0;
unsigned2 score := 0;
Layout_ABN_AMRO_C2BTest_In;
// consumer clean address
string10        prim_range;
string2         predir;
string28        prim_name;
string4         addr_suffix;
string2         postdir;
string10        unit_desig;
string8         sec_range;
string25        p_city_name;
string25        v_city_name;
string2         st;
string5         zip;
string4         zip4;
string4         cart;
string1         cr_sort_sz;
string4         lot;
string1         lot_order;
string2         dbpc;
string1         chk_digit;
string2         rec_type;
string2         fips_state;
string3         fips_county;
string10        geo_lat;
string11        geo_long;
string4         msa;
string7         geo_blk;
string1         geo_match;
string4         err_stat;
// consumer clean name
string5  title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
string3  name_score;
// clean phone
string10  phone10;
// Associated Business info
unsigned6 bdid := 0;
unsigned6 group_id := 0;
unsigned1 confidence_level := 0;
string10  best_phone := '';
string9   best_fein := '';
string120 best_CompanyName := '';
string120 best_addr1 := '';
string30	best_city := '';
string2	best_state := '';
string5	best_zip :='';
string4	best_zip4 := '';
// Associated Business Demographic Data
string4  SIC_Code1 := '';
string4  SIC_Code2 := '';
string4  SIC_Code3 := '';
string9  Number_Of_Employees := '';
string12 Annual_Sales := '';
end;