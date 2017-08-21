//This attribute was originally not a module and it was originally named Layout_DL_TX_Update2.
//It was renamed on Dataland and made a module.  The original Production attribute was trashed.
//This renamed attribute was migrated to Production.

export Layouts_DL_TX_Update := module

export Layout_DL_TX_Update_Raw := record
string        line;
end;

export Layout_DL_TX_Update2 := record
string8  			process_date;
string1  			trans_indicator;
string2  			card_type;
string10 			dl_number;
string40 			last_name;
string40 			first_name;
string40 			middle_name;
string5  			suffix_name;
string8  			date_of_birth;
string32 			street_addr1;
string32 			street_addr2;
string33 			city;
string2  			in_state;
string5  			zip;
string4  			in_zip4; 
string8  			issue_date;
string5          title;
string20         fname;
string20         mname;
string20         lname;
string5          suffix;
string3          name_score;
string10         prim_range;
string2          predir;
string28         prim_name;
string4          addr_suffix;
string2          postdir;
string10         unit_desig;
string8          sec_range;
string25         p_city_name;
string25         v_city_name;
string2          state;
string5          zip5;
string4          zip4;
string4          cart;
string1          cr_sort_sz;
string4          lot;
string1          lot_order;
string2          dpbc;
string1          chk_digit;
string2          rec_type;
string2          ace_fips_st;
string3          county;
string10         geo_lat;
string11         geo_long;
string4          msa;
string7          geo_blk;
string1          geo_match;
string4          err_stat;
  end;
  
//The following structure defines an 8-character dl_number to be compatible with the old
//TX layout.
export Layout_TX_Update2 := record
string8  			process_date;
string1  			trans_indicator;
string2  			card_type;
string8 			dl_number;
string40 			last_name;
string40 			first_name;
string40 			middle_name;
string5  			suffix_name;
string8  			date_of_birth;
string32 			street_addr1;
string32 			street_addr2;
string33 			city;
string2  			in_state;
string5  			zip;
string4  			in_zip4; 
string8  			issue_date;
string5          title;
string20         fname;
string20         mname;
string20         lname;
string5          suffix;
string3          name_score;
string10         prim_range;
string2          predir;
string28         prim_name;
string4          addr_suffix;
string2          postdir;
string10         unit_desig;
string8          sec_range;
string25         p_city_name;
string25         v_city_name;
string2          state;
string5          zip5;
string4          zip4;
string4          cart;
string1          cr_sort_sz;
string4          lot;
string1          lot_order;
string2          dpbc;
string1          chk_digit;
string2          rec_type;
string2          ace_fips_st;
string3          county;
string10         geo_lat;
string11         geo_long;
string4          msa;
string7          geo_blk;
string1          geo_match;
string4          err_stat;
  end;
 
end;