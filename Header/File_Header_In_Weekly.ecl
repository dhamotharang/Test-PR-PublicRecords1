EXPORT file_header_in_weekly := MODULE

EXPORT Layout := record

 ebcdic string15 first_name;
 ebcdic string15 middle_initial;
 ebcdic string25 last_name;
 ebcdic string2  suffix;
 ebcdic string15 former_first_name;
 ebcdic string15 former_middle_initial;
 ebcdic string25 former_last_name;
 ebcdic string2  former_suffix;
 ebcdic string15 former_first_name2;
 ebcdic string15 former_middle_initial2;
 ebcdic string25 former_last_name2;
 ebcdic string2  former_suffix2;
 ebcdic string15 aka_first_name;     //Per vendor, this will hold newest former name
 ebcdic string15 aka_middle_initial; //Per vendor, this will hold newest former name
 ebcdic string25 aka_last_name;      //Per vendor, this will hold newest former name
 ebcdic string2  aka_suffix;         //Per vendor, this will hold newest former name
 ebcdic string57 current_address;
 ebcdic string20 current_city;
 ebcdic string2  current_state;
 ebcdic string5  current_zip;
 ebcdic string6  current_address_date_reported;
 ebcdic string8  current_address_date_last_reported;
 ebcdic string57 former1_address;
 ebcdic string20 former1_city;
 ebcdic string2  former1_state;
 ebcdic string5  former1_zip;
 ebcdic string6  former1_address_date_reported;
 ebcdic string8  former1_address_date_last_reported;
 ebcdic string57 former2_address;
 ebcdic string20 former2_city;
 ebcdic string2  former2_state;
 ebcdic string5  former2_zip;
 ebcdic string6  former2_address_date_reported;
 ebcdic string8  former2_address_date_last_reported;
 ebcdic string6  blank1;
 ebcdic string9  ssn;
 ebcdic string9  cid;
 ebcdic string1  ssn_confirmed;
 ebcdic string10 filler1;
 ebcdic string1  name_change;
 ebcdic string1  addr_change;
 ebcdic string1  ssn_change;
 ebcdic string1  former_name_change;
 ebcdic string1  new_rec;
 ebcdic string38 filler2;
end;
 
weekly_file  := dataset('~thor400_84::in::eq_weekly',Layout,flat);

r_append_dt := record
 string8 eq_as_of_dt;
 weekly_file;
end;

r_append_dt t_append_dt(weekly_file le) := transform
 self.eq_as_of_dt := header.sourcedata_month.v_eq_as_of_date;
 self             := le;
end;

export File := project(weekly_file,t_append_dt(left)) : persist('persist::eq_weekly_with_as_of_date');
END;