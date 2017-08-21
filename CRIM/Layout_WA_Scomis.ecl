export Layout_WA_Scomis := module



export layout_case := record

   string12 superior_court_name;
   string9 case_number;
   string25 name_of_indiv;
   string10 date_of_birth;
   string1 gender;
   string10 case_filing_date;
   string1 case_type_code;
   string50 case_title;
   string4 resolution_code;
   string30 resolution_description;
   string10 resolution_date;
   string4 completion_code;
   string32 completion_description;
   string10 completion_date;
   string4 status_code;
   string23 status_description;
   string10 status_date;
   string1 clj_appeal_flag;
   string9 unkown;
   string2 crlf;
end;




export layout_charge := record
   string12 superior_court_name;
   string9 case_number;
   string5 entry_sequance_number;
   string10 violation_date;
   string3 count_number;
   string15 law_number;
   string40 law_descritpion;
   string2 rcw_category;
   string1 rcw_class;
   string2 charge_result_code;
   string2 charge_weapon_result_code;
   string15 charge_weapon_code;
   string15 charge_modified_code;
   string15 charge_other1_code;
   string15 charge_other2_code;
   string15 charge_other3_code;
   string11 unkown;
   string2 crlf;
end;

export layout_charge_dated := record
	string8 filedate;
	layout_charge;
end;

end;
