import fsm;

export fn_remove_companies(dataset(recordof(header.Layout_Header)) in_hdr) := function

//also removes other junk data via the fsm.labelvalid function
check_for_junk := (fsm.LabelValid(in_hdr.fname) > 5 and length(trim(in_hdr.fname))>1) or (fsm.LabelValid(in_hdr.lname) > 5);
not_junk       := in_hdr(not check_for_junk);
    junk       := in_hdr(    check_for_junk);

r_redefine_name_fields := record
 unsigned6 did := 0;
 unsigned6 rid;
 string1   pflag1 := '';
 string1   pflag2 := '';
 string1   pflag3 := '';
 string2   src;
 unsigned3 dt_first_seen;
 unsigned3 dt_last_seen;
 unsigned3 dt_vendor_last_reported;
 unsigned3 dt_vendor_first_reported;
 unsigned3 dt_nonglb_last_seen;
 string1   rec_type;
 qstring18 vendor_id;
 qstring10 phone;
 qstring9  ssn;
 integer4  dob;
 qstring5  title;
 //qstring20 fname;
 //qstring20 mname;
 //qstring20 lname;
 string20  fname;
 string20  mname;
 string20  lname;
 qstring5  name_suffix;
 qstring10 prim_range;
 string2   predir;
 qstring28 prim_name;
 qstring4  suffix;
 string2   postdir;
 qstring10 unit_desig;
 qstring8  sec_range;
 qstring25 city_name;
 string2   st;
 qstring5  zip;
 qstring4  zip4;
 string3   county;
 qstring7  geo_blk;
 qstring5  cbsa := '';
 string1   tnt := ' ';
 string1   valid_SSN := '';
 string1   jflag1 := '';
 string1   jflag2 := '';
 string1   jflag3 := '';
end;

r_redefine_name_fields t_qstring_to_string(not_junk le) := transform
 self.fname := trim(le.fname);
 self.mname := trim(le.mname);
 self.lname := trim(le.lname);
 self       := le;
end;

fsm_prc          := distribute(fsm.PeopleReallyCompanies,hash(fname,mname,lname));
not_junk_patched := distribute(project(not_junk,t_qstring_to_string(left)),hash(fname,mname,lname));

r_set_bus_flag := record
 boolean is_bus;
 not_junk_patched;
end;

r_set_bus_flag t_set_bus_flag(not_junk_patched le, fsm_prc ri) := transform
 //self.is_bus := if(le.fname=ri.fname and le.mname=ri.mname and le.lname=ri.lname,true,false);
 self.is_bus := if(ri.fname<>'' or ri.mname<>'' or ri.lname<>'',true,false);
 self        := le;
end;

j1 := join(not_junk_patched,fsm_prc,
           left.fname=right.fname and left.mname=right.mname and left.lname=right.lname,
		   t_set_bus_flag(left,right),
		   left outer, local
		  );

good_names0 := j1(is_bus=false);
companies0  := j1(is_bus=true);

good_names := project(good_names0,header.layout_header);
companies  := project(companies0,header.layout_header);

output(count(good_names),named('people'));
output(count(companies),named('companies'));

output(junk,,'~thor_dell400_2::base::fsm.labelvalid_in_header' +thorlib.wuid(),__compressed__,overwrite);
output(companies,,'~thor_dell400_2::base::companies_in_header' +thorlib.wuid(),__compressed__,overwrite);

fileservices.addsuperfile('~thor_data400::base::other_junk_in_header','~thor_dell400_2::base::fsm.labelvalid_in_header'+thorlib.wuid());
fileservices.addsuperfile('~thor_data400::base::companies_in_header', '~thor_dell400_2::base::companies_in_header'+thorlib.wuid());

return good_names;
		  
end;