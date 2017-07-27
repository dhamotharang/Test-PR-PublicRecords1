export Layout_ACA_Clean := record
	aca.Layout_ACA_IN;
	//*** Name, title, Clean name fields and Addr2 are all set to blank as the name, title and addr2
	//*** fields are not provided by the vendor with the new layout any more.
	string50	name	:= '';
	string70	title	:= '';
	string20	fname := '';
	string20	mname := '';
	string20	lname := '';
	string5		name_suffix := '';
	string120 Addr2 := '';
	
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		addr_suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	string25	p_city_name;
	string25	v_city_name;
	string2		st;
	string5		z5;
	string4		zip4;
	string10	phone;
	string10	Inst_Type_exp;	
	string1		addr_type;
end;
