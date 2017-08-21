export layout_click_id := module 
export infile := record
     string55 i_address;
	 string5  i_zip;
	 string32 i_lname ;
	 string25 i_housenum ;
	 string55 i_streetname ;
	 string10 i_apt ; 
	 integer  i_addr_chng ;
end ; 
export out_rec := record 
    string55 i_address;
	string5  i_zip;
	string32 i_lname ;
	string25 i_housenum ;
	string55 i_streetname ;
	string10 i_apt ; 
	integer  i_addr_chng;
    string60 i_hhid      := '';
end ; 
end;
