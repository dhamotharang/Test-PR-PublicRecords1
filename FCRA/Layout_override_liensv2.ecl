export Layout_override_liensv2 := record
	string50 rmsid := '';
	string12 DID  := '';
		
	string2 filetypeid;
	string50 filingtype_desc;
	string17 casenumber;
	string8 filing_date;
	string8 release_date;
	string9 amount;

	string120 plaintiff;
	string5 plain_title;
	string20 plain_fname;
	string20 plain_mname;
	string20 plain_lname;
	string5 plain_name_suffix;
	string3 plain_name_score;
	string34 plain_company;
	
	string120 defname;
	string5 def_title;
	string20 def_fname;
	string20 def_mname;
	string20 def_lname;
	string5 def_name_suffix;
	string3 def_name_score;
	string34 def_company;
	
	string10        prim_range :='';
	string2         predir :='';
	string28        prim_name :='';
	string4         addr_suffix :='';
	string2         postdir :='';
	string10        unit_desig :='';
	string8         sec_range :='';
	string25        p_city_name :='';
	string25        v_city_name :='';
	string2         state :='';
	string5         zip :='';
	string4         zip4 :='';
	string4         cart :='';
	string1         cr_sort_sz :='';
	string4         lot :='';
	string1         lot_order :='';
	string2         dbpc :='';
	string1         chk_digit :='';
	string2         rec_type :='';
	string5         county :='';
	string10        geo_lat :='';
	string11        geo_long :='';
	string4         msa :='';
	string7         geo_blk :='';
	string1         geo_match :='';
	string4         err_stat :='';
	
	string10 phone := '';
	string9 ssn := '';
	string9 taxid := '';
	
	string20 flag_file_id := '';
end;
