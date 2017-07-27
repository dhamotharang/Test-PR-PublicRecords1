import business_header, header;

sic_code_set2 := [	 '01' ,'02' ,'07' ,'08' ,'09' ,'10' ,'12'
					,'13' ,'14' ,'20' ,'27' ,'28' ,'29' ,'30'
					,'33' ,'34' ,'35' ,'40' ,'41' ,'42' ,'43'
					,'44' ,'45' ,'46' ,'48' ,'49' ,'51' ,'60'
					,'61' ,'70' ,'80' ,'82' ,'83' ,'84' ,'91' 
					,'92' ,'93' ,'96' ,'97'
				];
			  
sic_code_set4 := ['8351','8211'];

f_bdid_sic := business_header.bh_bdid_sic;

sic_rec := record
	unsigned6 bdid;
	string2 source;
	string4 sic_code;
end;

sic_rec get_sic2(f_bdid_sic l) := transform
	self.sic_code := if(l.sic_code[1..2] in sic_code_set2, l.sic_code[1..4], '');
	self := l;
end;

f_bdid_sic_slim2 := project(f_bdid_sic, get_sic2(left))(sic_code<>'',source<>'D');

sic_rec get_sic4(f_bdid_sic l) := transform
	self.sic_code := if(l.sic_code[1..4] in sic_code_set4, l.sic_code[1..4], '');
	self := l;
end;

f_bdid_sic_slim4 := project(f_bdid_sic, get_sic4(left))(sic_code<>'',source<>'D');

f_bdid_sic_valid := f_bdid_sic_slim2 + f_bdid_sic_slim4;

f_bdid_sic_dist := distribute(f_bdid_sic_valid,hash(bdid,sic_code));
f_bdid_sic_sort := sort(f_bdid_sic_dist,bdid,sic_code,local);
f_bdid_sic_dedup := dedup(f_bdid_sic_sort,bdid,sic_code,local) : persist('per_f_bdid_sic_dedup2');

f_bdid_dist := distribute(f_bdid_sic_dedup, hash(bdid));
b_h_best_dist := distribute(business_header.file_business_header_best,hash(bdid));

f_sic_addr_out := join(f_bdid_dist, b_h_best_dist,
                       left.bdid = right.bdid, left outer, local) ;

f_sic_addr_valid := f_sic_addr_out(prim_name<>'') : persist('per_f_sic_addr_valid2');

f_sic_addr_dist := distribute(f_sic_addr_valid,hash(prim_range,predir,prim_name,
	                                               addr_suffix,postdir,unit_desig,
                                                    sec_range,city,state,zip,zip4,sic_code));
	 
f_sic_addr_sort := sort(f_sic_addr_dist,prim_range,predir,prim_name,
	                                   addr_suffix,postdir,unit_desig,
                                        sec_range,city,state,zip,zip4,sic_code,local);

f_sic_addr_dedup := dedup(f_sic_addr_sort,prim_range,predir,prim_name,
	                                     addr_suffix,postdir,unit_desig,
                                          sec_range,city,state,zip,zip4,sic_code,local) : persist('per_f_sic_addr_dedup2');

out_addr_rec := record
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	string5 zip;
	string4 zip4;
     string4   sic_code;
	unsigned6  bdid;
     string4   addr_type;
end;

out_addr_rec slim_addr(f_sic_addr_dedup l) := transform
	self.addr_type := '2240';
	self.zip := intformat(l.zip,5,1);
	self.zip4 := intformat(l.zip4,4,1);
	self.bdid := l.bdid;
	self := l;
end;

f_addr_slim := project(f_sic_addr_dedup, slim_addr(left));

export BWR_Create_HRI_Addr_Sic2 := f_addr_slim;