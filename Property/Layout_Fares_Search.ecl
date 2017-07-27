export Layout_Fares_Search := record
/*
Vesa Niemela: Source code field in fares_search (OP,SP,OO etc...)
Chad: how do i translate those codes?
Vesa Niemela: XY -> X is Owner/Seller. Y -> Owner..Buyer / Seller Address
Vesa Niemela: So OP would be Owner name / Property address.
Vesa Niemela: OO would be Owner name / Owner Address
*/
string5			vendor;
string12        fares_id;
string8         process_date;
string2         source_code;
string5         title;
string20        fname;
string20        mname;
string20        lname;
string5         name_suffix;
string50        _company;
string30        nameasis;
string10        prim_range;
string2         predir;
string28        prim_name;
string4         suffix;
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
string5         county;
string10        geo_lat;
string11        geo_long;
string4         msa;
string7         geo_blk;
string1         geo_match;
string4         err_stat;
string2         lf;
end;