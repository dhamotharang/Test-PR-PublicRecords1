import official_records;

base_file := official_records.File_Base_Party;
base_file_prev := official_records.File_Base_Party_Prev;
			
fn_Norm(dataset(official_records.Layout_Base_Party) infile):=function

official_records.Layout_Base_Party norm_xform1(infile l, integer C) := transform	
	self.cname1        := if(C=1,l.cname1,l.entity_nm);
	self.cname2        := if(C=1,l.cname2,'');
	self.cname3        := if(C=1,l.cname3,'');
	self.cname4        := if(C=1,l.cname4,'');
	self.cname5        := if(C=1,l.cname5,'');
  self :=l;	
end;

// Normalize the first time for the case where:
// company name1 has something in it and company name2 is blank and 
// company name1 data is not the same as the data in the entity name field.
norm_file_cnames := normalize(infile,if(
               left.cname1 <>'' and left.cname2=' ' and 
               trim(StringLib.StringToUpperCase(left.entity_nm),left,right) <>
               trim(StringLib.StringToUpperCase(left.cname1),left,right)
               ,2,1),
               norm_xform1(left,counter));
// remove any duplicate records after the normalize
dedup_file_cnames := dedup(sort(norm_file_cnames,official_record_key,record),
                           record);
return dedup_file_cnames;
end;

base_norm := Fn_Norm(base_file): persist('~thor_200::persist::official_records_autokey_norm');
base_prev_norm := Fn_Norm(base_file_prev): persist('~thor_200::persist::official_records_autokey_prev_norm');

base_increment := join(distribute(base_norm,hash(official_record_key)), distribute(base_prev_norm,hash(official_record_key)),
left.official_record_key = right.official_record_key and 
left.state_origin = right.state_origin and
left.county_name = right.county_name and
left.fname1 = right.fname1 and
left.fname2 = right.fname2 and
left.fname3 = right.fname3 and
left.fname4 = right.fname4 and
left.fname5 = right.fname5 and
left.mname1 = right.mname1 and
left.mname2 = right.mname2 and
left.mname3 = right.mname3 and
left.mname4 = right.mname4 and
left.mname5 = right.mname5 and
left.lname1 = right.lname1 and
left.lname2 = right.lname2 and
left.lname3 = right.lname3 and
left.lname4 = right.lname4 and
left.lname5 = right.lname5 and
left.cname1 = right.cname1 and
left.cname2 = right.cname2 and
left.cname3 = right.cname3 and
left.cname4 = right.cname4 and
left.cname5 = right.cname5,
transform(official_records.Layout_Base_Party, self := left),left only, local);																		 

// An interim record layout with just the fields needed to build the autokeys
ak_rec := record
	string60  official_record_key;
	string20  fname;
	string20  mname;
	string20  lname;
	string70  cname;
	string25  city;
	string2		per_state;
	string2		bus_state;
	unsigned1 zero             := 0;
	unsigned6 zeroDID          := 0;
	unsigned6 zeroBDID         := 0;
	string1   blank            := '';
	string1   blank_prim_name  := '';
	string1   blank_prim_range := '';
	string1   blank_st         := '';
	string1   blank_city       := '';
	string1   blank_zip5       := '';
	string1   blank_sec_range  := '';
end;

ak_rec norm_xform2(base_increment l, integer C) := transform
	self.fname        := choose(C,l.fname1,l.fname2,l.fname3,l.fname4,l.fname5);
	self.mname        := choose(C,l.mname1,l.mname2,l.mname3,l.mname4,l.mname5);
	self.lname        := choose(C,l.lname1,l.lname2,l.lname3,l.lname4,l.lname5);
	self.cname        := choose(C,l.cname1,l.cname2,l.cname3,l.cname4,l.cname5);
	
	// NOTE:  County name intentionally stored as the city so the citystname autokey file 
	// will be built to assist in searches where a name & state & county are entered.
	self.city         := l.county_name;
	self.per_state    := choose(C,if(l.lname1<>'',l.state_origin,''),
	                              if(l.lname2<>'',l.state_origin,''),
	                              if(l.lname3<>'',l.state_origin,''),
	                              if(l.lname4<>'',l.state_origin,''),
	                              if(l.lname5<>'',l.state_origin,''));
	self.bus_state    := choose(C,if(l.cname1<>'',l.state_origin,''),
	                              if(l.cname2<>'',l.state_origin,''),
	                              if(l.cname3<>'',l.state_origin,''),
	                              if(l.cname4<>'',l.state_origin,''),
	                              if(l.cname5<>'',l.state_origin,''));
	self :=l;
end;

// Normalize for up to 5 possible person and/or company names
norm_file_allnames := normalize(base_increment,
                                       if(left.lname5<>'' or left.cname5<>'',5,
													                if(left.lname4<>'' or left.cname4<>'',4,
														                 if(left.lname3<>'' or left.cname3<>'',3,
														                    if(left.lname2<>'' or left.cname2<>'',2,
																							   	 1)))),
                                norm_xform2(left,counter));

// remove any duplicate records after the normalize
dedup_file_allnames := dedup(sort(norm_file_allnames,official_record_key,record),
                           record);

export File_Autokey_Party_Delta := dedup_file_allnames;
