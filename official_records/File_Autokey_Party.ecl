import standard;

base_file := official_records.File_Base_Party;

dist_base_file := distribute(base_file,hash(official_record_key));

official_records.Layout_Base_Party norm_xform1(dist_base_file l, integer C) := transform	
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
norm_file_cnames := normalize(dist_base_file,if(
               left.cname1 <>'' and left.cname2=' ' and 
               trim(StringLib.StringToUpperCase(left.entity_nm),left,right) <>
               trim(StringLib.StringToUpperCase(left.cname1),left,right)
               ,2,1),
               norm_xform1(left,counter));

// remove any duplicate records after the normalize
dedup_file_cnames := dedup(sort(norm_file_cnames,official_record_key,record),
                           record);

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

ak_rec norm_xform2(dedup_file_cnames l, integer C) := transform
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
norm_file_allnames := normalize(dedup_file_cnames,
                                       if(left.lname5<>'' or left.cname5<>'',5,
													                if(left.lname4<>'' or left.cname4<>'',4,
														                 if(left.lname3<>'' or left.cname3<>'',3,
														                    if(left.lname2<>'' or left.cname2<>'',2,
																							   	 1)))),
                                norm_xform2(left,counter));

// remove any duplicate records after the normalize
dedup_file_allnames := dedup(sort(norm_file_allnames,official_record_key,record),
                           record);

export File_Autokey_Party := dedup_file_allnames;
