import address, ut;

//Clean names, addresses, and normalize the Equifax data
Eq_in := file_eq_in;

ut.MAC_Sequence_Records(eq_in,rid,withID)

//Normalize and dedup to remove 'bad' or duplicate data
comp := record
 Layout_Eq_Norm;
 string30 comp2 := '';
end;
 
//Normalize 9 ways to get cross product of names and addresses
comp normed(withID l, integer c) := transform
	self.orig_fname := choose(c,l.first_name,l.first_name,l.first_name,
								l.former_first_name,l.former_first_name,l.former_first_name,
								l.aka_first_name,l.aka_first_name,l.aka_first_name);
	self.orig_minitial := choose(c,l.middle_initial,l.middle_initial,l.middle_initial,
								   l.former_middle_initial,l.former_middle_initial,l.former_middle_initial,
								   l.aka_middle_initial,l.aka_middle_initial,l.aka_middle_initial);
	self.orig_lname := choose(c,l.last_name,l.last_name,l.last_name,
								l.former_last_name,l.former_last_name,l.former_last_name,
								l.aka_last_name,l.aka_last_name,l.aka_last_name);
	self.orig_name_suffix := choose(c,l.suffix,l.suffix,l.suffix,
									  l.former_suffix,l.former_suffix,l.former_suffix,
									  l.aka_suffix,l.aka_suffix,l.aka_suffix);
	self.orig_address := choose(c,l.current_address,l.former1_address,l.former2_address,
								  l.current_address,l.former1_address,l.former2_address,
								  l.current_address,l.former1_address,l.former2_address);
	self.orig_city := choose(c,l.current_city,l.former1_city,l.former2_city,
							   l.current_city,l.former1_city,l.former2_city,
							   l.current_city,l.former1_city,l.former2_city);
	self.orig_state := choose(c,l.current_state,l.former1_state,l.former2_state,
								l.current_state,l.former1_state,l.former2_state,
								l.current_state,l.former1_state,l.former2_state);
	self.orig_zip := choose(c,l.current_zip,l.former1_zip,l.former2_zip,
							  l.current_zip,l.former1_zip,l.former2_zip,
							  l.current_zip,l.former1_zip,l.former2_zip);
	self.comp2 := choose(c,address.Addr2FromComponents(l.current_city,l.current_state,l.current_zip),
							address.Addr2FromComponents(l.former1_city,l.former1_state,l.former1_zip),							
							address.Addr2FromComponents(l.former2_city,l.former2_state,l.former2_zip),
							address.Addr2FromComponents(l.current_city,l.current_state,l.current_zip),
							address.Addr2FromComponents(l.former1_city,l.former1_state,l.former1_zip),
							address.Addr2FromComponents(l.former2_city,l.former2_state,l.former2_zip),
							address.Addr2FromComponents(l.current_city,l.current_state,l.current_zip),
							address.Addr2FromComponents(l.former1_city,l.former1_state,l.former1_zip),
							address.Addr2FromComponents(l.former2_city,l.former2_state,l.former2_zip));
	self.address_date_reported := choose(c,l.current_address_date_reported,
										   l.former1_address_date_reported,
										   l.former2_address_date_reported,
										   l.current_address_date_reported,
										   l.former1_address_date_reported,
										   l.former2_address_date_reported,
										   l.current_address_date_reported,
										   l.former1_address_date_reported,
										   l.former2_address_date_reported);

    self.name_address_type := choose(c,'CC','CF','CG','FC','FF','FG','GC','GF','GG');
	self := l;
 end;
 
intoLayout := normalize(withID,9,normed(left,counter))(orig_lname!='' and orig_address!='' and comp2!='');

//Dedup
srt_a := sort(distribute(intoLayout,hash(comp2,orig_lname)),except rid, except name_address_type,local);

dup_a := dedup(srt_a,except rid, except name_address_type,local) : persist('persist::dups_eq_norm');

//Clean address
split1 := sample(dup_a,2,1);
split2 := sample(dup_a,2,2);

address.MAC_Address_Clean(split1,orig_address,comp2,
							true,clean_out1)

c1 := clean_out1 : persist('persist::c1_eq_norm');

address.MAC_Address_Clean(split2,orig_address,comp2,
							true,clean_out2)

c2 := clean_out2 : persist('persist::c2_eq_norm');

clean_out := c1 + c2;

//Put into final layout
Layout_Eq_Norm getClean(clean_out L) := transform
	self.prim_range := l.clean[1..10];
	self.predir := l.clean[11..12];
	self.prim_name := l.clean[13..40];
	self.suffix := l.clean[41..44];
	self.postdir := l.clean[45..46];
	self.unit_desig := l.clean[47..56];
	self.sec_range := l.clean[57..64];
	self.city := l.clean[90..114];
	self.st := l.clean[115..116];
	self.zip := l.clean[117..121];
	self.zip4 := l.clean[122..125];
	self.county := l.clean[143..145];
	self.msa := l.clean[165..168];
	self := l;
end;
 
clean_a := project(clean_out,getClean(left))(prim_name!='' and zip!= '');

//Dedup valid address records
srt_b := sort(distribute(clean_a,hash(zip,lname)),record,local);

dup_b := dedup(srt_b,local) : persist('persist::cleanAddr_dup_eq_norm');

//Clean all names
names_c := record
	comp;
	string73 clean_name;
end;

names_c cleanNames(dup_b L) := transform
 self.clean_name := address.cleanpersonFML73(l.orig_fname+' '+l.orig_minitial+' '+l.orig_lname+' '+l.orig_name_suffix);
//'postalclean01.br.seisint.com:10000|postalclean02.br.seisint.com:10000|postalclean03.br.seisint.com:10000|postalclean04.br.seisint.com:10000|postalclean05.br.seisint.com:10000|postalclean06.br.seisint.com:10000|postalclean07.br.seisint.com:10000');
 self := l;
 end;

clean_n1 := project(sample(dup_b,4,1),cleanNames(left)) : persist('persist::clean_n1_eq_norm');
clean_n2 := project(sample(dup_b,4,2),cleanNames(left)) : persist('persist::clean_n2_eq_norm');
clean_n3 := project(sample(dup_b,4,3),cleanNames(left)) : persist('persist::clean_n3_eq_norm');
clean_n4 := project(sample(dup_b,4,4),cleanNames(left)) : persist('persist::clean_n4_eq_norm');

clean_n := clean_n1 + clean_n2 + clean_n3 + clean_n4;

//Set clean names
Layout_Eq_Norm cleanName(clean_n l) := transform
  self.title := l.clean_name[1..5];  
  self.fname := l.clean_name[6..25];
  self.mname := l.clean_name[26..45];
  self.lname := l.clean_name[46..65];
  self.name_suffix := l.clean_name[66..70];   
  self := l;
 end;
 
clean_set := project(clean_n,cleanName(left))(lname!='');
 
export Eq_Normalize := clean_set : persist('persist::eq_normalize');