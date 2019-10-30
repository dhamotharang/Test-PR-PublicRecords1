import prte2_Vehicle, ut, standard,prte2;

//Autokey Search File- make orig_ssn and append_ssn searchable; split the party file

dsParty := project(files.party_building, transform(layouts.Party_Building - [src_first_date, src_last_date], self := left));
dsparty_diff_ssn_fein := dsParty(((unsigned)orig_ssn <> (unsigned)append_ssn and (unsigned)orig_ssn <> 0 	and (unsigned)append_ssn <> 0) or
																((unsigned)orig_fein <> (unsigned)append_fein and (unsigned)orig_fein <> 0 and (unsigned)append_fein <> 0));


Layouts.Autokey 	tra(dsParty l) := transform
look1 := (unsigned4) ut.bit_set(0,if(l.orig_name_type = '2',0,1 ));
age 	:= ut.Age((UNSIGNED) l.orig_dob);
look2 := (unsigned4) ut.bit_set(look1,if(age=0 or age>=18,2,0));

self.addr.st 			:= l.Append_Clean_Address.st;
self.lookup_bit 	:= look2;
self.addr.zip5 		:= l.Append_Clean_Address.zip5;
self.addr 				:= l.Append_Clean_Address;
self.addr 				:= [];
self.name 				:= l.Append_Clean_Name;
self.append_ssn  	:= if((unsigned)L.orig_ssn <> 0, L.orig_ssn, L.append_ssn);
self.append_FEIN 	:= if((unsigned)L.orig_fein <> 0, L.orig_fein, L.append_fein);
self.Reg_Latest_Effective_Date 	:= (unsigned4) l.Reg_Latest_Effective_Date;
self.Reg_Latest_Expiration_Date := (unsigned4) l.Reg_Latest_Expiration_Date;
self.Ttl_Latest_Issue_Date 			:= (unsigned4) l.Ttl_Latest_Issue_Date;
self := l;
end;

dsParty_out1 := project(dsParty,tra(left));

Layouts.Autokey tra1(dsparty_diff_ssn_fein l) := transform
look1 := (unsigned4) ut.bit_set(0,if(l.orig_name_type = '2',0,1 ));
age := ut.Age((UNSIGNED) l.orig_dob);
look2 := (unsigned4) ut.bit_set(look1,if(age=0 or age>=18,2,0));

self.addr.st 			:= l.Append_Clean_Address.st;
self.lookup_bit 	:= look2;
self.addr.zip5 		:= l.Append_Clean_Address.zip5;
self.addr 				:= l.Append_Clean_Address;
self.addr 				:= [];
self.name 				:= l.Append_Clean_Name;
self.append_ssn  	:= L.append_ssn;
self.append_FEIN 	:= L.append_fein;
self.Reg_Latest_Effective_Date 	:= (unsigned4) l.Reg_Latest_Effective_Date;
self.Reg_Latest_Expiration_Date := (unsigned4) l.Reg_Latest_Expiration_Date;
self.Ttl_Latest_Issue_Date 			:= (unsigned4) l.Ttl_Latest_Issue_Date;
self := l;
end;

dsParty_out2 := project(dsParty_diff_ssn_fein,tra1(left));

d2 := dedup(distribute(dsParty_out1 + dsParty_out2, hash(Vehicle_Key,Iteration_Key,Sequence_Key)), all, local);

d3 :=	sort(d2,vehicle_key,iteration_key,sequence_key,local);

Layouts.Autokey get_dates(Layouts.Autokey l, Layouts.Autokey r):=	transform
self.Reg_Latest_Effective_Date 	:= max(L.Reg_Latest_Effective_Date,R.Reg_Latest_Effective_Date);
self.Reg_Latest_Expiration_Date := max(L.Reg_Latest_Expiration_Date,R.Reg_Latest_Expiration_Date);		
self.Ttl_Latest_Issue_Date 			:= max(L.Ttl_Latest_Issue_Date, R.Ttl_Latest_Issue_Date);
self.orig_name_type 						:= if(r.orig_name_type in ['4','5'], r.orig_name_type,l.orig_name_type);
self.history 										:= if(r.history='' and r.vehicle_key<>'',r.history,l.history);
self := l;
END;

d4 := rollup(d3,get_dates(left,right),vehicle_key,iteration_key,sequence_key,local);

Layouts.Autokey 	populate_dates(Layouts.Autokey l, Layouts.Autokey r):=transform
self.Reg_Latest_Effective_Date := R.Reg_Latest_Effective_Date;
self.Reg_Latest_Expiration_Date	:= R.Reg_Latest_Expiration_Date;
self.Ttl_Latest_Issue_Date := R.Ttl_Latest_Issue_Date;
self.orig_name_type := R.orig_name_type;
self.history := r.history;
self := l;
END;

d5 := join(d2,d4,
						left.vehicle_key=right.vehicle_key and 
						left.iteration_key=right.iteration_key and 
						left.sequence_key=right.sequence_key,
						populate_dates(left,right), keep(1),local);

//split into debtor and creditor and make a double-wide record by joining on tmsid rmsid
p := d5(Append_Clean_CName = '');
c := d5(Append_Clean_CName <> '');


dwr := record
  d2.Vehicle_Key;
	d2.Iteration_Key;
	d2.Sequence_Key;
	d2.zero;
	d2.lookup_bit;
	d2.source_code;
	d2.Append_DID;
	d2.Append_BDID;
	d2.Append_Clean_CName;
	d2.Append_SSN;
	d2.Append_FEIN;
	standard.Addr company_addr;
	standard.Addr person_addr;
	standard.Name person_name;
	dsParty.Orig_Name_Type;
	dsParty.history;
	dsParty.global_sid;
	dsParty.record_sid;
	unsigned4 Reg_Latest_Effective_Date;
	unsigned4 Reg_Latest_Expiration_Date;
	unsigned4 Ttl_Latest_Issue_Date;

end;

dwr mdw(p l, c r) := transform
self.Append_DID 				:= l.Append_DID;
self.Append_BDID 				:= r.Append_BDID;
self.Append_SSN 				:= l.Append_SSN;
self.Append_FEIN 				:= r.Append_FEIN;
self.company_addr 			:= r.addr;
self.person_addr 				:= l.addr;
self.person_name 				:= l.name;
self.Append_Clean_CName := r.Append_Clean_CName;  																				
self	:= if(L.Vehicle_Key = '' and L.Iteration_Key = '', R, L);
end;

b := join(sort(p,Vehicle_Key,Iteration_Key,Sequence_Key,local),
					sort(c,Vehicle_Key,Iteration_Key,Sequence_Key,local),
              left.Vehicle_Key = right.Vehicle_Key and 
							left.Iteration_Key = right.Iteration_Key and
							left.Sequence_Key = right.Sequence_Key,
							mdw(left, right), 
							full outer, local);

export file_SearchAutokey_Party := b;