import Address;

EXPORT _fns_AddressCleaner(dataset(recordof(hygenics_crim.layout_temp_offender)) input) := function 

crim_address_cache   :=  dataset('~thor_data400::base::crim::address_cache_public',hygenics_crim.Layout_Address_cache,flat);

layout_temp_offender clean_name_add (input l ) := transform

 self.j_RecordID 				:= l.recordid;
 self.j_StateCode 			:= l.statecode;
 self.name_type_hd      := l.nametype; // added this b/c NID cleaner over writes this field.

 self.name              := MAP(l.name ='' => l.firstname+' '+l.middlename+' '+l.lastname+' '+l.suffix ,
                                   l.name);
 clean_addr 				    := If(l.street_address_1 <>'' or l.street_address_2 <> '' , Address.CleanAddress182(l.street_address_1, l.street_address_2),
                              '');
 
 self.prim_range 		  	:= clean_addr[1..10];
 self.predir 			      := clean_addr[11..12];
 self.prim_name 		  	:= clean_addr[13..40];
 self.addr_suffix 		  := clean_addr[41..44];
 self.postdir 			  	:= clean_addr[45..46];
 self.unit_desig 		  	:= clean_addr[47..56];
 self.sec_range 		  	:= clean_addr[57..64];
 self.p_city_name 			:= clean_addr[65..89];
 self.v_city_name 			:= clean_addr[90..114];
 self.state 			      := clean_addr[115..116];
 self.zip5 				      := clean_addr[117..121];
 self.zip4 				      := clean_addr[122..125];
 self.cart 				      := clean_addr[126..129];
 self.cr_sort_sz 		  	:= clean_addr[130];
 self.lot 				      := clean_addr[131..134];
 self.lot_order 		  	:= clean_addr[135];
 self.dpbc 				      := clean_addr[136..137];
 self.chk_digit 		  	:= clean_addr[138];
 self.rec_type 			  	:= clean_addr[139..140];
 self.ace_fips_st 			:= clean_addr[141..142];
 self.ace_fips_county		:= clean_addr[143..145];
 self.geo_lat 			  	:= clean_addr[146..155];
 self.geo_long 			  	:= clean_addr[156..166];
 self.msa 				      := clean_addr[167..170];
 self.geo_blk 			  	:= clean_addr[171..177];
 self.geo_match 		 	  := clean_addr[178];
 self.err_stat 			  	:= clean_addr[179..182]; 

 self 						:= l;
 self 						:= [];
end;


layout_temp_offender join_with_Cache (crim_address_cache L,input R) := transform
 self.j_RecordID 				:= R.recordid;
 self.j_StateCode 			:= R.statecode;
 self.name_type_hd      := R.nametype;
 self.prim_range 		   	:= L.prim_range;
 self.predir 			      := L.predir;
 self.prim_name 		  	:= L.prim_name;
 self.addr_suffix 		  := L.addr_suffix;
 self.postdir 			  	:= L.postdir;
 self.unit_desig 		  	:= L.unit_desig;
 self.sec_range 		  	:= L.sec_range;
 self.p_city_name 			:= L.p_city_name;
 self.v_city_name 			:= L.v_city_name;
 self.state 			      := L.state;
 self.zip5 				      := L.zip5;
 self.zip4 				      := L.zip4;
 self.cart 				      := L.cart;
 self.cr_sort_sz 		    := L.cr_sort_sz;
 self.lot 				      := L.lot;
 self.lot_order 		  	:= L.lot_order;
 self.dpbc 				      := L.dpbc;
 self.chk_digit 		  	:= L.chk_digit;
 self.rec_type 			  	:= L.rec_type;
 self.ace_fips_st 			:= '';
 self.ace_fips_county		:= L.ace_fips_county;
 self.geo_lat 			  	:= L.geo_lat;
 self.geo_long 			  	:= L.geo_long;
 self.msa 				      := L.msa;
 self.geo_blk 			  	:= L.geo_blk;
 self.geo_match 		 	  := L.geo_match;
 self.err_stat 			  	:= L.err_stat;
 
 self.address_in_cache  := If(l.street_address_1 = r.street_address_1 and l.street_address_2 = r.street_address_2, 'Y','N');
 self.street_address_2  := R.street_address_2;
 self.street_address_1  := R.street_address_1;
 self 						:= l;
 self 						:= r;

end;

Joined_w_cache :=  If(nothor(FileServices.GetSuperFileSubCount('~thor_data400::base::crim::address_cache_public') <> 0), 
                       join(distribute(crim_address_cache,hash(street_address_1,street_address_2)),
  										      distribute(input(street_address_1 <> '' or street_address_2 <> ''),hash(street_address_1,street_address_2)),
														left.street_address_1 = right.street_address_1 and left.street_address_2 = right.street_address_2,
											 join_with_Cache(left,right),right outer,local),
											 input(street_address_1 <> '' or street_address_2 <> '')
											);
											
No_address      := input(street_address_1 = '' and street_address_2 = '');					
cleanedAddress  := Joined_w_cache(address_in_cache ='Y');
recleanAddress  := Joined_w_cache(address_in_cache <> 'Y') + No_address;
cleannewAddress := project(recleanAddress, clean_name_add(left),local);

cleanAddress := cleannewAddress + cleanedAddress ;

return(cleanAddress);
End;