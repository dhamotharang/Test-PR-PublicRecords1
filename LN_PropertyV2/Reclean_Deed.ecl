#workunit('name', 'Reclean Property Deed');

import address;

ds_layout := RECORD
  string12 ln_fares_id;
  string2 source_code;
  integer8 cnt;
  integer8 search_count;
 END;
 
ds_isolated_recs 	:= dedup(sort(distribute(dataset('~thor_data400::jltemp::prop_missing_names',ds_layout,flat),hash(ln_fares_id)),ln_fares_id,local),ln_fares_id,local);
ds_file_deed   		:= sort(distribute(LN_PropertyV2.File_Deed,hash(ln_fares_id)),ln_fares_id,local);

ds_slim_layout := record
string12 	ln_fares_id;
string8		process_date;
string8   	recording_date;
string1   	vendor_source_flag;
string2		source_code;
string1   	buyer_or_borrower_ind; 
string80  	name1; 
string80  	name2; 
string10  	phone_number; 
string40  	mailing_care_of; 
string70  	mailing_street; 
string6   	mailing_unit_number; 
string51  	mailing_csz; 
string1   	mailing_address_cd; 
string80  	seller1;
string80  	seller2;
string1   	seller_addendum_flag;
string70  	seller_mailing_full_street_address;
string6   	seller_mailing_address_unit_number;
string51  	seller_mailing_address_citystatezip;
string70  	property_full_street_address;
string6   	property_address_unit_number;
string51  	property_address_citystatezip;
string1   	property_address_code;
string1		prop_addr_propagated_ind;
end;

ds_slim_layout ds_reformat(ds_file_deed l, ds_isolated_recs r) := transform 
self.source_code := r.source_code;
self := l;
end ; 

ds 	:= join(ds_file_deed, ds_isolated_recs,  
						left.ln_fares_id = right.ln_fares_id,
						ds_reformat(left,right),local);

//Normalize Seller Records 						
new_search_seller := ds((seller1<>'' or seller2<>'') and
						(seller_mailing_full_street_address<>'' and
						 seller_mailing_address_citystatezip<>'' or
						 property_address_citystatezip<>'' and 
						 property_full_street_address<>''));

sell_norm_layout := record
 string12 	ln_fares_id;
 string5  	vendor_source_flag;
 string8  	process_date;
 string80 	name;
 string2  	source_code;
 string70 	mailing_street;
 string51 	mailing_csz;
 string70  	seller_mailing_full_street_address;
 string51  	seller_mailing_address_citystatezip;
 string70 	property_full_street_address;
 string51 	property_address_citystatezip;
 string10  	phone_number;
 unsigned3 	dt_first_seen; 
 unsigned3 	dt_last_seen; 
 unsigned3 	dt_vendor_first_reported; 
 unsigned3 	dt_vendor_last_reported; 
 string1   	conjunctive_name_seq; 
end;

sell_norm_layout sell_norm_trans(new_search_seller le, integer c) := transform
 self.name                      	:= choose(c,le.seller1,le.seller2);
 self.dt_first_seen            		:= (integer)le.recording_date[1..6]; 
 self.dt_last_seen             		:= (integer)le.recording_date[1..6]; 
 self.dt_vendor_first_reported 		:= (integer)le.recording_date[1..6]; 
 self.dt_vendor_last_reported  		:= (integer)le.process_date[1..6]; 
 self.conjunctive_name_seq     		:= '1'; 
 self           			   		:= le;						 
end;

sell_norm := normalize(new_search_seller,2,sell_norm_trans(left,counter))(trim(name)<>'');

sell_norm_layout sell_add_norm_trans(sell_norm le, integer c) := transform
 self.source_code					:= choose(c, 'SS','SP');
 self.property_full_street_address	:= choose(c,le.seller_mailing_full_street_address,le.property_full_street_address);                                               				
 self.property_address_citystatezip	:= choose(c,le.seller_mailing_address_citystatezip,le.property_address_citystatezip); 	 						 
 self           					:= le;						 
end;

sell_add_norm 		:= normalize(sell_norm,2,sell_add_norm_trans(left,counter))(trim(property_full_street_address)<>'' and trim(property_address_citystatezip)<>'');

//Normalize Buyer Records
new_search_buyer 	:= ds((name1<>'' or name2<>'') and
						 ((mailing_street<>'' and mailing_csz<>'') or
						  (property_address_citystatezip<>'' and property_full_street_address<>'')));

buy_norm_layout := record
 string12 	ln_fares_id;
 string5  	vendor_source_flag;
 string8  	process_date;
 string80 	name;
 string2  	source_code;
 string70 	mailing_street;
 string51 	mailing_csz;
 string70  	seller_mailing_full_street_address;
 string51  	seller_mailing_address_citystatezip;
 string70 	property_full_street_address;
 string51 	property_address_citystatezip;
 string10  	phone_number;
 unsigned3 	dt_first_seen; 
 unsigned3 	dt_last_seen; 
 unsigned3 	dt_vendor_first_reported; 
 unsigned3 	dt_vendor_last_reported; 
 string1   	conjunctive_name_seq; 
end;

buy_norm_layout buy_norm_trans(new_search_buyer le, integer c) := transform
 self.name      				:= choose(c,le.name1,le.name2);
 self.phone_number             	:= choose(c,le.phone_number,le.phone_number);  //check this 
 self.dt_first_seen            	:= (integer)le.recording_date[1..6]; 
 self.dt_last_seen             	:= (integer)le.recording_date[1..6]; 
 self.dt_vendor_first_reported 	:= (integer)le.recording_date[1..6]; 
 self.dt_vendor_last_reported  	:= (integer)le.process_date[1..6]; 
 self.conjunctive_name_seq     	:= '1'; 
 self           			   	:= le;						 
end;

buy_norm 		:= normalize(new_search_buyer,2,buy_norm_trans(left,counter))(trim(name)<>'');

buy_norm_layout buy_add_norm_trans(buy_norm le, integer c) := transform
 self.source_code					:= choose(c, 'BO','BP');
 self.property_full_street_address	:= choose(c,le.mailing_street,le.property_full_street_address);                                               				
 self.property_address_citystatezip	:= choose(c,le.mailing_csz,le.property_address_citystatezip); 	 						 
 self           					:= le;						 
end;

buy_add_norm 	:= normalize(buy_norm,2,buy_add_norm_trans(left,counter))(trim(property_full_street_address)<>'' and trim(property_address_citystatezip)<>'');

//Concat records and clean 
concat_rec 	:= sell_add_norm + buy_add_norm;

r_clean := record
 buy_norm_layout;
 
 string5   title;
 string20  fname;
 string20  mname;
 string20  lname;
 string5   name_suffix;
 string70  cname;
 
 string80  nameasis;
 
 string10  prim_range;
 string2   predir;
 string28  prim_name;
 string4   suffix;
 string2   postdir;
 string10  unit_desig;
 string8   sec_range;
 string25  p_city_name;
 string25  v_city_name;
 string2   st;
 string5   zip;
 string4   zip4;
 string4   cart;
 string1   cr_sort_sz;
 string4   lot;
 string1   lot_order;
 string2   dbpc;
 string1   chk_digit;
 string2   rec_type;
 string5   county;
 string10  geo_lat;
 string11  geo_long;
 string4   msa;
 string7   geo_blk;
 string1   geo_match;
 string4   err_stat;
end;

r_clean t_clean(concat_rec le) := transform
 
 string73  v_pname      := address.cleanpersonlfm73(le.name);
 string182 v_clean_addr := address.cleanaddress182(le.property_full_street_address,le.property_address_citystatezip);
 
 integer   v_pname_score := (integer)v_pname[71..73];
 
 self.title       := if(v_pname_score>=85,v_pname[ 1.. 5],'');
 self.fname       := if(v_pname_score>=85,v_pname[ 6..25],'');
 self.mname       := if(v_pname_score>=85,v_pname[26..45],'');
 self.lname       := if(v_pname_score>=85,v_pname[46..65],'');
 self.name_suffix := if(v_pname_score>=85,v_pname[66..70],'');
 
 self.cname       := if(v_pname_score<85,le.name,'');
 self.nameasis    := le.name;
 
 self.prim_range  := v_clean_addr[ 1..  10];
 self.predir      := v_clean_addr[ 11.. 12];
 self.prim_name   := v_clean_addr[ 13.. 40];
 self.suffix      := v_clean_addr[ 41.. 44];
 self.postdir     := v_clean_addr[ 45.. 46];
 self.unit_desig  := v_clean_addr[ 47.. 56];
 self.sec_range   := v_clean_addr[ 57.. 64];
 self.p_city_name := v_clean_addr[ 65.. 89];
 self.v_city_name := v_clean_addr[ 90..114];
 self.st          := v_clean_addr[115..116];
 self.zip         := v_clean_addr[117..121];
 self.zip4        := v_clean_addr[122..125];
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
 
 self             := le;
end;

p_clean := project(concat_rec, t_clean(left));

LN_PropertyV2.layout_deed_mortgage_property_search t_map_to_search(p_clean le) := transform
 self             := le;
end;

ds1 := project(p_clean,t_map_to_search(left));

p_dedup := dedup(sort(distribute(ds1,hash(ln_fares_id)),ln_fares_id,title,fname,mname,lname,name_suffix,cname,nameasis,
					prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,local),
					ln_fares_id,title,fname,mname,lname,name_suffix,cname,nameasis,
					prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,p_city_name,v_city_name,st,zip,zip4,local) : PERSIST('~thor_dell400::persist::File_Deed_dedup');

//output(choosen(p_dedup,100));
export Reclean_Deed := p_dedup;