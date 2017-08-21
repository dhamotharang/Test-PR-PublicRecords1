import ut,flaccidents;

#option('skipFileFormatCrcCheck', 1);

format_date(string indate) := function
    DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';	
	in_Date := trim(indate, left,right);
	outDate := if(regexfind(DateFinder,in_Date),
				  intformat((integer)regexfind(DateFinder,in_Date,3),4,1) +
				  intformat((integer)regexfind(DateFinder,in_Date,1),2,1) +
				  intformat((integer)regexfind(DateFinder,in_Date,2),2,1),
				  '');						  
	return (outDate);
end;

inp_ds := misc.rawlings_file;

// 0 => accident_date
// 4=> incident state
d0 := flaccidents.Key_NtlCrash0;
d4 := flaccidents.Key_NtlCrash4;
layout_0_4 := record
    unsigned6	l_acc_nbr;
	string2 	report_code;
	string25 	report_category;
	string65 	report_code_desc;
	string1    	rec_type_o,
	string10    accident_nbr,
	string8    	accident_date,
	string2 	vehicle_incident_st;
end;
layout_0_4 to_j_0_4(d0 l, d4 r) := transform
	self:= l;
	self:= r;
end;
d_0_4 := distribute(join(d0,d4, left.l_acc_nbr =right.l_acc_nbr, to_j_0_4(left,right), keyed,keep(1)),hash(l_acc_nbr));


d5 := flaccidents.Key_NtlCrash5;
d6 := flaccidents.Key_NtlCrash6;
d7 := flaccidents.Key_NtlCrash7;
layout_p := record
	unsigned6	l_acc_nbr;
	string2		report_code;
    string25	report_category;
    string65	report_code_desc;
 	string12	did,
	string1   	rec_type_x,
	string10  	accident_nbr,
	//
	string10  prim_range;
	string2   predir;
	string28  prim_name;
	string4   addr_suffix;
	string2   postdir;
	string10  unit_desig;
	string8   sec_range;
	string25  p_city_name;
	string25  v_city_name;
	string2   st;
	string5   zip;
	string4   zip4;
	//
	string5   title;
	string20  fname;
	string20  mname;
	string20  lname;
	string5   suffix;
	//
	string8	  dob;
end;
layout_p to_p_4(d4 l) := transform
	self.rec_type_x := l.rec_type_4;
	self.dob := l.driver_dob;
	self := l;
end;
d_p_4 := project(d4,to_p_4(left));
layout_p to_p_5(d5 l) := transform
	self.rec_type_x := l.rec_type_5;
	self.dob := '';
	self := l;
end;
d_p_5 := project(d5,to_p_5(left));
layout_p to_p_6(d6 l) := transform
	self.rec_type_x := l.rec_type_6;
	self.dob := l.ded_dob;
	self := l;
end;
d_p_6 := project(d6,to_p_6(left));
layout_p to_p_7(d7 l) := transform
	self.rec_type_x := l.rec_type_7;
	self.dob := '';
	self := l;
end;
d_p_7 := project(d7,to_p_7(left));	

d_p_x := d_p_4+d_p_5+d_p_6+d_p_7;
d_p := distribute(d_p_x(lname<>''),hash(l_acc_nbr));

layout_m := record
    unsigned6	l_acc_nbr;
	string2 	report_code;
	string25 	report_category;
	string65 	report_code_desc;
	string1    	rec_type_o,
	string10    accident_nbr,
	string8    	accident_date,
	string2 	vehicle_incident_st;
	//
 	string12	did,
	string1   	rec_type_x,
	//
	string10  prim_range;
	string2   predir;
	string28  prim_name;
	string4   addr_suffix;
	string2   postdir;
	string10  unit_desig;
	string8   sec_range;
	string25  p_city_name;
	string25  v_city_name;
	string2   st;
	string5   zip;
	string4   zip4;
	//
	string5   title;
	string20  fname;
	string20  mname;
	string20  lname;
	string5   suffix;
	//
	string8   dob;
end;
layout_m to_m(d_0_4 l,d_p r) := transform
	self := l;
	self := r;
end;
d_m := join(d_0_4,d_p,left.l_acc_nbr=right.l_acc_nbr,to_m(left,right),local);


layout_join := record
	string 		inp_RAWLINGS_KEY;
	string 		inp_FIRST_NAME;
	string20 	fname;
	string 		inp_LAST_NAME;
	string20	Lname;	

	string 		inp_orig_SSN;
	string8 	inp_DOB;
	string8 	dob;
	
	string25  	inp_p_city_name;
	string25	p_city_name;
	string25  	inp_v_city_name;
	string25 	v_city_name;
	string2  	inp_state;
	string2 	st;
	string 		vehicle_incident_st;
	string5   	inp_zip5;
	string5		zip;
	//
	string12	inp_did;
	string12 	did;
	//
	string8 	inp_DOL;
	string8		accident_date;
	unsigned4	dol_difference;
	//
	string25 	report_category;
	string65 	report_code_desc;
	string1		rec_type_x;
	unsigned6	l_acc_nbr;
	//
end;

layout_join to_j1(d_m l, inp_ds r) := transform
	self.dol_difference := ut.DaysApart(l.accident_date,r.inp_dol);
	self.inp_did := intformat(r.inp_did,12,1);
	self := l;
	self := r;
	end;
res1 := join(d_m,inp_ds,
			(unsigned6) left.did<>0 and (unsigned6) left.did= (unsigned6) right.inp_did,
			to_j1(left,right),lookup);
res2 := join(d_m,inp_ds,
			(left.dob<>'' and left.dob=right.inp_dob) 
					and 
			(left.lname<>'' and left.lname=right.inp_lname and left.fname<>'' and left.fname=right.inp_fname),
			 to_j1(left,right),lookup);

res_dedup := dedup(sort(res1+res2,record),all);

res_st := res_dedup(vehicle_incident_st=inp_state or st=inp_state);

res_dol := res_st(dol_difference<=365);	

inp_c := count(inp_ds);
o1 := output(inp_c,named('count_input'));
res1_c := count(res1);
o2a := output(res1_c,named('count_res1'));
res2_c := count(res2);
o2b := output(res2_c,named('count_res2'));
res_dedup_c:= count(res_dedup);
o2c := output(res_dedup_c,named('count_res_dedup'));
res_st_c := count(res_st);
o2d := output(res_st_c,named('count_res_st'));
res_dol_c := count(res_dol);
o2e := output(res_dol_c,named('count_res_dol'));

o3a:=output(res_dedup);
o3b:=output(res_st);
o3c:=output(res_dol);

export rawlings_append2 := sequential(o1,o2a,o2b,o2c,o2d,o2e,o3a,o3b,o3c);
