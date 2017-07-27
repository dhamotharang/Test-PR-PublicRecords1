import doxie;

la := doxie.layout_comp_addresses;

address_child := record
	la.shared_address;
	la.address_seq_no;
	la.did;
	la.dt_first_seen;
	la.dt_last_seen;
	la.title;
	la.fname;
	la.mname;
	la.lname;
	la.name_suffix;
	la.prim_range;
	la.predir;
	la.prim_name;
	la.suffix;
	la.postdir;
	la.unit_desig;
	la.sec_range;
	la.city_name;
	la.st;
	la.zip;
	la.zip4;
	la.county;
	la.county_name;
	la.phone;
	la.listed_phone;
	la.geo_blk;
	la.tnt;
	la.isSubject;
	STRING4 hri;
	STRING150 desc;
end;

addresses := record
	address_child addr1;
	address_child addr2;
	address_child addr3;
	address_child addr4;
	address_child addr5;
	address_child addr6;
	address_child addr7;
	address_child addr8;
	address_child addr9;
	address_child addr10;
	address_child addr11;
	address_child addr12;
	address_child addr13;
	address_child addr14;
	address_child addr15;
end;

lb := doxie.layout_best;

// just inherit the types from each field instead of importing the entire layout
best_layout := record
	lb.did;
	lb.phone;
	lb.timezone;
	lb.ssn;
	lb.ssn_unmasked;
	lb.dob;
	lb.title;
	lb.fname;
	lb.mname;
	lb.lname;
	lb.name_suffix;
	lb.prim_range;
	lb.predir;
	lb.prim_name;
	lb.suffix;
	lb.postdir;
	lb.unit_desig;
	lb.sec_range;
	lb.city_name;
	lb.st;
	lb.zip;
	lb.zip4;
	lb.addr_dt_last_seen;
	lb.DOD;
	lb.Prpty_deed_id;
	lb.Vehicle_vehnum;
	lb.Bkrupt_CrtCode_CaseNo;
	lb.DL_number;
	lb.run_date;
	lb.total_records;
  lb.age;
  lb.valid_ssn;
end;

export Layout_BS_Services := record
	string20 dataset_name;
	string30 acctNo;
	string20 fname;
	string20 lname;
	string5 zipCode;
	string9 ssn;
	string10 phone10;
	string12 outtransaction_id;
	best_layout best_data;	
	addresses address_children;
end;