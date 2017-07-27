import header, business_header, address, _control,AID;
d := dataset('~thor_data400::Base::UtilityHeader_Building',utilfile.layout_util.base,flat)
	(prim_name <> '', v_city_name <> '', 
	 fname <> '', lname <> '',
	 name_flag = 'P',
	 id<>'396560000173759'	 ,ssn<>'653325555' //block bad util record from being re-ingested bug #39714
	);

//project data thru the old layout -> only difference is the csa_indicator field
//csa_indicator not relevant for display and/or worth changing the src key for
OLD_Layout_Utility_In := record
	string15        id;
	string10        exchange_serial_number;
	string8         date_added_to_exchange;
	string8         connect_date;
	string8         date_first_seen;
	string8         record_date;
	string10        util_type;
	string25        orig_lname;
	string20        orig_fname;
	string20        orig_mname;
	string5         orig_name_suffix;
	string1         addr_type;
	string1         addr_dual;
	string10        address_street;
	string100       address_street_Name;
	string5         address_street_Type;
	string2         address_street_direction;
	string10        address_apartment;
	string20        address_city;
	string2         address_state;
	string10        address_zip;
	string9         ssn;
	string10        work_phone;
	string10        phone;
	string8         dob;
	string2         drivers_license_state_code;
	string22        drivers_license;
	//string1		csa_indicator := '';
	address.Layout_Clean182;
	string12        did;
	string5         title;
	string20        fname;
	string20        mname;
	string20        lname;
	string5         name_suffix;
	string3         name_score;
	AID.Common.xAID							Append_RawAID;        

end;

src_rec := record
 header.Layout_Source_ID;
 OLD_Layout_Utility_In;
end;

src_rec asSrc(d l, boolean iswork) := transform
 //csa_indicator='U' represent inquiries, not true connections
 self.date_first_seen := if(l.csa_indicator='U','',l.date_first_seen);
 self.uid := 0;
 self.src := if(iswork, 'UW', 'UT');
 self := l;
end;

util_dups := project(d,asSrc(left, false)) + 
			 project(d((integer)work_phone > 1000000),asSrc(LEFT, true));

util_dis := distribute(util_dups,hash(id));
util_noID := dedup(util_dis, all,local);

header.Mac_Set_Header_Source(util_noID(src='UW'),src_rec,src_rec,'UW',withID1)
header.Mac_Set_Header_Source(util_noID(src='UT'),src_rec,src_rec,'UT',withID2)

export Util_as_Source := withID1 + withID2 : persist('persist::headerbuild_util_src',_control.TargetQueue.adl_400);