export MAC_Shake_N_Bake(infile,outfile) := macro
// reclean some records using the shake and bakd (tm) method
#uniquename(orig_records)

%orig_records% := infile(err_stat[1] = 'E' and current_record_flag = 'Y' and 
				trim(orig_loc+orig_strt+orig_zip+orig_state) != '');


#uniquename(temp_layout)
#uniquename(create_rec)

%temp_layout% := record
// to hold fields to be cleaned
string 		address1:= '';
string 		address2:= '';	
string1 should_clean := 'N';
integer permutation := 0; // which permutatuin we are using .... see table "normalize records below
infile;
end;  
 
%temp_layout% %create_rec%(infile l) := transform
self := l;
end;
#uniquename(target_recs)

%target_recs% := project(%orig_records%,%create_rec%(left));

// normalize records
// 1 = replace loc
// 2 = replace strt
// 3 = replace strt and loc
// 4 = replace loc an zip
// 5 = replace zip
// 6 = replace state
#uniquename(norm_them)
%temp_layout% %norm_them%(%temp_layout% l, integer c) := transform
self.permutation := c;
self.should_clean := map(c = 1 => if(l.orig_loc = '','N','Y'),
					c = 2 => if(l.orig_strt = '','N','Y'),
					c = 3 => if((l.orig_loc = ''and l.orig_strt = ''),'N','Y'),
					c = 4 => if((l.orig_loc = ''and l.orig_zip = ''),'N','Y'),
					c = 5 => if(l.orig_zip = '','N','Y'),
					c = 6 => if(l.orig_state = '','N','Y'),'N');
					
self.address1 := map(
					c = 1 => l.hseno + ' ' + l.hsesx + ' ' + l.strt,
					c = 2 => l.hseno + ' ' + l.hsesx + ' ' + l.orig_strt,
					c = 3 => l.hseno + ' ' + l.hsesx + ' ' + l.orig_strt,
					c = 4 => l.hseno + ' ' + l.hsesx + ' ' + l.strt,
					c = 5 => l.hseno + ' ' + l.hsesx + ' ' + l.strt,
					c = 6 => l.hseno + ' ' + l.hsesx + ' ' + l.strt,
					'');
					
self.address2 := map(
					c = 1 => l.orig_loc + ' ' + l.state+' '+ l.zip,
					c = 2 => l.locnm + ' ' + l.state+' '+ l.zip,
					c = 3 => l.orig_loc + ' ' + l.state+' '+ l.zip,
					c = 4 => l.orig_loc + ' ' + l.state+' '+ l.orig_zip,
					c = 5 => l.locnm + ' ' + l.state+' '+ l.orig_zip,
					c = 6 => l.locnm + ' ' + l.orig_state+' '+ l.zip,
					'');					
self := l					
end;


#uniquename(norm_records)
%norm_records% := normalize(%target_recs%,6,%norm_them%(left,counter));
#uniquename(to_clean)
%to_clean% := %norm_records%(should_clean = 'Y');
#uniquename(clean_records)
Address.MAC_Address_Clean(%to_clean%,address1,address2,true,%clean_records%);


 
// normalize records
// 1 = replace loc
// 2 = replace strt
// 3 = replace strt and loc
// 4 = replace loc an zip
// 5 = replace zip
// 6 = replace state


#uniquename(split_address)
%temp_layout% %split_address%(%clean_records% input) := transform
self.prim_range 			:= input.clean[1..10]; 
self.predir 				:= input.clean[11..12];					   
self.prim_name 				:= input.clean[13..40];
self.suffix 				:= input.clean[41..44];
self.postdir 				:= input.clean[45..46];
self.unit_desig 			:= input.clean[47..56];
self.sec_range 				:= input.clean[57..64];

self.p_city_name 			:= input.clean[65..89];
self.v_city_name 			:= input.clean[90..114];
self.st 					:= input.clean[115..116];

self.z5 					:= input.clean[117..121];
self.z4 					:= input.clean[122..125];
self.cart 					:= input.clean[126..129];
self.cr_sort_sz 			:= input.clean[130];//need to switch for moxie
self.lot 					:= input.clean[131..134];
self.lot_order 				:= input.clean[135];
self.dpbc 					:= input.clean[136..137];
self.chk_digit 				:= input.clean[138];
self.rec_type 				:= input.clean[139..140];
self.county_code			:= input.clean[141..145];
self.geo_lat 				:= input.clean[146..155];
self.geo_long 				:= input.clean[156..166];
self.msa 					:= input.clean[167..170];
self.geo_blk 				:= input.clean[171..177];
self.geo_match 				:= input.clean[178];
self.err_stat 				:= input.clean[179..182];

self := input;
end;
#uniquename(cleaned_split)
%cleaned_split% := project(%clean_records%,%split_address%(left));
#uniquename(cleaned_deduped)
%cleaned_deduped% := dedup(sort(distribute(%cleaned_split%(err_stat[1] = 'S'),
			hash(group_id)),group_id,group_seq,local),group_id,group_seq,left);
			
outfile := %cleaned_deduped%;
#uniquename(dist_input)
%dist_input% := sort(distribute(infile,hash(group_id)),group_id,group_seq,local);
#uniquename(join_input)
// join cleaned records to original records, only replacing the ones that cleaned
infile %join_input%(infile l, %temp_layout% r) := transform

self.prim_range 			:= if(r.err_stat[1] = 'S' ,r.prim_range, l.prim_range); 
self.predir 				:= if(r.err_stat[1] = 'S' ,r.predir,l.predir);					   
self.prim_name 				:= if(r.err_stat[1] = 'S' ,r.prim_name,l.prim_name);
self.suffix 				:= if(r.err_stat[1] = 'S' ,r.suffix,l.suffix);
self.postdir 				:= if(r.err_stat[1] = 'S' ,r.postdir,l.postdir);
self.unit_desig 			:= if(r.err_stat[1] = 'S' ,r.unit_desig,l.unit_desig);
self.sec_range 				:= if(r.err_stat[1] = 'S' ,r.sec_range,l.sec_range);

self.p_city_name 			:= if(r.err_stat[1] = 'S' ,r.p_city_name,l.p_city_name);
self.v_city_name 			:= if(r.err_stat[1] = 'S' ,r.v_city_name,l.v_city_name);
self.st 					:= if(r.err_stat[1] = 'S' ,r.st,l.st);

self.z5 					:= if(r.err_stat[1] = 'S' ,r.z5,l.z5);
self.z4 					:= if(r.err_stat[1] = 'S' ,r.z4,l.z4);
self.cart 					:= if(r.err_stat[1] = 'S' ,r.cart,l.cart);
self.cr_sort_sz 			:= if(r.err_stat[1] = 'S' ,r.cr_sort_sz,l.cr_sort_sz);
self.lot 					:= if(r.err_stat[1] = 'S' ,r.lot,l.lot);
self.lot_order 				:= if(r.err_stat[1] = 'S' ,r.lot_order,l.lot_order);
self.dpbc 					:= if(r.err_stat[1] = 'S' ,r.dpbc,l.dpbc);
self.chk_digit 				:= if(r.err_stat[1] = 'S' ,r.chk_digit,l.chk_digit);
self.rec_type 				:= if(r.err_stat[1] = 'S' ,r.rec_type,l.rec_type);
self.county_code			:= if(r.err_stat[1] = 'S' ,r.county_code,l.county_code);;
self.geo_lat 				:= if(r.err_stat[1] = 'S' ,r.geo_lat,l.geo_lat);
self.geo_long 				:= if(r.err_stat[1] = 'S' ,r.geo_long,l.geo_long);
self.msa 					:= if(r.err_stat[1] = 'S' ,r.msa,l.msa);
self.geo_blk 				:= if(r.err_stat[1] = 'S' ,r.geo_blk,l.geo_blk);
self.geo_match 				:= if(r.err_stat[1] = 'S' ,r.geo_match,l.geo_match);
self.err_stat 				:= if(r.err_stat[1] = 'S' ,r.err_stat,l.err_stat);
self := l;
end;
// outfile := join(%dist_input%,%cleaned_deduped%,
					// left.group_id = right.group_id and
					// left.group_seq = right.group_seq,
					// %join_input%(left,right),left outer);

endmacro;
