import address,header_slimsort,did_add,didville,ut;

r_ca := record
 string orig_Ixid;
 string orig_Firstname;
 string orig_Middleinitial;
 string orig_Lastname;
 string orig_Address;
 string orig_City;
 string orig_State;
 string orig_Zip;
 string orig_zip4;
 string orig_dob;
 unsigned8 aid;
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
 string5   county;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string8   dob;
 unsigned6 pid:=0;
end;

r_ca t1(ixi.files.f_vendor le) := transform
 
 string prep_str  := stringlib.stringtouppercase(stringlib.stringcleanspaces(le.orig_address));
 string prep_city := stringlib.stringtouppercase(stringlib.stringcleanspaces(le.orig_city));
 string prep_st   := stringlib.stringtouppercase(stringlib.stringcleanspaces(le.orig_state));
 
 string182 v_ca := address.CleanAddress182(prep_str,prep_city+' '+prep_st+' '+le.orig_zip+' '+le.orig_zip4);
 string73  v_cn := address.CleanPersonLFM73(le.orig_lastname+', '+le.orig_firstname+' '+le.orig_middleinitial);
 
 self.prim_range  := v_ca[ 1..  10];
 self.predir      := v_ca[ 11.. 12];
 self.prim_name   := v_ca[ 13.. 40];
 self.addr_suffix := v_ca[ 41.. 44];
 self.postdir     := v_ca[ 45.. 46];
 self.unit_desig  := v_ca[ 47.. 56];
 self.sec_range   := v_ca[ 57.. 64];
 self.p_city_name := v_ca[ 65.. 89];
 self.v_city_name := v_ca[ 90..114];
 self.st          := v_ca[115..116];
 self.zip         := v_ca[117..121];
 self.zip4        := v_ca[122..125];
 self.county      := v_ca[141..145];
 
 self.aid         := ixi.fn_address_hash(self.prim_range,self.prim_name,self.sec_range,self.zip);
 
 self.fname       := v_cn[ 6..25];
 self.mname       := v_cn[26..45];
 self.lname       := v_cn[46..65];
 self.name_suffix := v_cn[66..70];
 
 self.dob := if(length(trim(le.orig_dob))=8,le.orig_dob,
             if(length(trim(le.orig_dob))=6,le.orig_dob+'00',
			 if(length(trim(le.orig_dob))=4,le.orig_dob+'0000',
			 '')));
			 
 self             := le;
 
end;

p1      := project(ixi.files.f_vendor,t1(left));

matchset := ['A','Z','D'];

did_add.MAC_Match_Flex
	(p1, matchset,					
	 '', dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, '', 
	 PID, r_ca, false, DID_Score_field,
	 75, ixi_did)

ixi_did_dist := distribute(ixi_did,hash(aid));
ixi_did_dupd := dedup(ixi_did_dist,record,all,local);

export ixi_clean := ixi_did_dupd : persist('persist::ixi_clean');