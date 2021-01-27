import infutor, ut, did_add;

ds := infutor.File_Infutor;

output(choosen(enth(ds,1,30000,1),10000),named('Infutor_Raw_Sample'));

r_slim := record
 string3  orig_name_prefix;
 string15 orig_first_name;
 string15 orig_middle_name;
 string25 orig_last_name;
 string3  orig_name_suffix;
 string40 orig_addr_street_blob;
 string10 orig_house_number;
 string2  orig_predir;
 string28 orig_street_name;
 string4  orig_street_suffix;
 string2  orig_postdir;
 string8  orig_apt_no;
 string27 orig_city;
 string2  orig_st;
 string5  orig_zip;
 string4  orig_zip4;
 string9  ssn1;
 string9  ssn2;
 string10 phone;
 //string6  orig_dob;
 string8  orig_dob_dd_appended;
 string1  orig_gender;
 string6  effective_dt;//Looks like it could be LOR

 unsigned6 boca_id:=0;
 string1   infutor_or_mktg_ind;

end;

r_slim t_slim(infutor.layout_in_fixed l, integer c) := transform

 string40 v_replace1 := stringlib.stringfindreplace(l.orig_addr_street_blob,' PO BOX ST ',  ' ST PO BOX ');
 string40 v_replace2 := stringlib.stringfindreplace(v_replace1,             ' POB ST ',     ' ST PO BOX ');
 string40 v_replace3 := stringlib.stringfindreplace(v_replace2,             ' P O BOX ST ', ' ST PO BOX ');
 string40 v_replace4 := stringlib.stringfindreplace(v_replace3,             ' COUNTY RD # ',' COUNTY ROAD ');
 string40 v_replace5 := stringlib.stringfindreplace(v_replace4,             ' CNTY RD ',    ' COUNTY ROAD ');
 string40 v_replace6 := stringlib.stringfindreplace(v_replace5,             ' COUNTY RD ',  ' COUNTY ROAD ');

 self.orig_addr_street_blob := v_replace6;
 self.orig_dob_dd_appended  := if(l.orig_dob<>'',l.orig_dob+'00','');
 self.boca_id               := c+1;
 self.infutor_or_mktg_ind   := '1';
 self                       := l;
end;

d_slim := project(infutor.File_Infutor(orig_first_name<>'',orig_last_name<>''),t_slim(left,counter));

r_norm := record
 string3  orig_name_prefix;
 string15 orig_first_name;
 string15 orig_middle_name;
 string25 orig_last_name;
 string3  orig_name_suffix;
 string40 orig_addr_street_blob;
 string10 orig_house_number;
 string2  orig_predir;
 string28 orig_street_name;
 string4  orig_street_suffix;
 string2  orig_postdir;
 string8  orig_apt_no;
 string27 orig_city;
 string2  orig_st;
 string5  orig_zip;
 string4  orig_zip4;
 //string9  ssn1;
 //string9  ssn2;
 string9  ssn;
 string10 phone;
 //string6  orig_dob;
 string8  orig_dob_dd_appended;
 string1  orig_gender;
 string6  effective_dt;

 unsigned6 boca_id:=0;
 string1   infutor_or_mktg_ind;

 string1 which_ssn:='';
end;

r_norm t_norm(r_slim l, integer c) := transform
 self.ssn       := choose(c,l.ssn1,l.ssn2);
 self.which_ssn := choose(c,'1','2');
 self           := l;
end;

d_norm := normalize(d_slim,2,t_norm(left,counter));

d_ssn1 := d_norm(which_ssn='1');
d_ssn2 := d_norm(which_ssn='2',ssn<>'');

d_ssn1_ssn2 := d_ssn1+d_ssn2;

invalid_prim_name := [
'NONE',
'UNKNOWN',
'UNKNWN',
'UNKNOWEN',
'UNKNONW',
'UNKNON',
'UNKNWON',
'UNKONWN',
'UNEKNOWN',
'UN KNOWN',
'GENERAL DELIVERY'
];

infutor.Layout_DID t_clean(r_norm l) := transform

 string73  v_pname      := addrcleanlib.cleanpersonfml73(l.orig_first_name+' '+l.orig_middle_name+' '+l.orig_last_name+' '+l.orig_name_suffix);
 string182 v_clean_addr := addrcleanlib.cleanaddress182(l.orig_addr_street_blob,l.orig_city+' '+l.orig_st+' '+l.orig_zip+if(l.orig_zip<>'',l.orig_zip4,''));

 string28  v_prim_name := v_clean_addr[13..40];
 string5   v_zip       := v_clean_addr[117..121];
 string4   v_zip4      := v_clean_addr[122..125];

 self.title       := v_pname[ 1.. 5];
 self.fname       := v_pname[ 6..25];
 self.mname       := v_pname[26..45];
 self.lname       := v_pname[46..65];
 self.name_suffix := v_pname[66..70];
 self.name_score  := v_pname[71..73];
 self.prim_range  := v_clean_addr[ 1..  10];
 self.predir      := v_clean_addr[ 11.. 12];
 //self.prim_name   := v_clean_addr[ 13.. 40];
 self.prim_name   := if(trim(v_prim_name) in invalid_prim_name,'',v_prim_name);
 self.addr_suffix := v_clean_addr[ 41.. 44];
 self.postdir     := v_clean_addr[ 45.. 46];
 self.unit_desig  := v_clean_addr[ 47.. 56];
 self.sec_range   := v_clean_addr[ 57.. 64];
 self.p_city_name := v_clean_addr[ 65.. 89];
 self.v_city_name := v_clean_addr[ 90..114];
 self.st          := v_clean_addr[115..116];
 //self.zip         := v_clean_addr[117..121];
 self.zip         := if(v_zip='00000','',v_zip);
 //self.zip4        := v_clean_addr[122..125];
 self.zip4        := if(v_zip4='0000','',v_zip4);
 self.cart        := v_clean_addr[126..129];
 self.cr_sort_sz  := v_clean_addr[130..130];
 self.lot         := v_clean_addr[131..134];
 self.lot_order   := v_clean_addr[135..135];
 self.dbpc        := v_clean_addr[136..137];
 self.chk_digit   := v_clean_addr[138..138];
 self.rec_type    := v_clean_addr[139..140];
 self.county      := v_clean_addr[141..145];
 self.geo_lat     := v_clean_addr[146..155];
 self.geo_long    := v_clean_addr[156..166];
 self.msa         := v_clean_addr[167..170];
 self.geo_blk     := v_clean_addr[171..177];
 self.geo_match   := v_clean_addr[178..178];
 self.err_stat    := v_clean_addr[179..182];

 self               := l;

end;

d_clean := project(d_ssn1_ssn2,t_clean(left)) : persist('~thor_dell400_2::persist::infutor_clean');

d_clean_filt := d_clean(fname<>'',
                        lname<>'',
						zip<>'',
						(phone<>'' or (prim_range<>'' and prim_name<>'')),
						~(stringlib.stringfind(prim_name,'PO BOX',1)>0 and trim(zip4)='')
					   );

matchset := ['A','P','Z','D','S'];

did_add.MAC_Match_Flex
	(d_clean_filt, matchset,
	 ssn, orig_dob_dd_appended, fname, mname, lname, name_suffix,
	 prim_range, prim_name, sec_range, zip, st, phone,
	 DID, infutor.Layout_DID, false, DID_Score_field,
	 75, d_did)

ut.mac_sf_buildprocess(d_did, '~thor_data400::base::infutor', build_infutor_base, 2);

export Proc_Clean_and_DID := build_infutor_base;
