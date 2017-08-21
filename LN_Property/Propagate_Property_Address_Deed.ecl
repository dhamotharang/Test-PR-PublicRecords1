import LN_Mortgage,LN_Property,ut,address;

// POPULATE APN FOR DAYTON DATA 

export propagate_property_address_deed(
	dataset(recordof(ln_mortgage.Layout_Deed_Mortgage_Common_Model_BASE)) deed_in0,
	dataset(recordof(ln_property.Layout_Deed_Mortgage_Property_Search))   search_in0) :=
MODULE

stripFormat(string apn) := stringlib.stringfilter(apn,
						'0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');


LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE getdeeds(deed_in0 L) := transform
 self.fares_unformatted_apn := if(l.ln_fares_id[1]!='R',stripFormat(l.apnt_or_pin_number),l.fares_unformatted_apn);
 self             := l;
end;

deeds := project(deed_in0, getDeeds(left));

// PICK COUNTY NAMES, STATE FROM LOOKUP FOR ONLY FARES DATA
fips_rec := record
 string2  state_alpha;
 string2  state_code;
 string3  county_code;
 string40 county_alpha;
 string2  class;
 string1  crlf;
end;

fips_data_county_name := dataset('~thor_data400::in::fips_code_lookup',fips_rec,flat);


LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE reformat( deeds l, fips_data_county_name r ) := transform 

self.county_name := if(l.vendor_source_flag[1..3]='FAR',StringLib.StringToProperCase(r.county_alpha),StringLib.StringToProperCase(l.county_name)) ; 
self.state       := if(l.vendor_source_flag[1..3]='FAR',StringLib.StringToProperCase(r.state_alpha),StringLib.StringToProperCase(l.state)) ; 
self := l ; 
end ; 

deeds_county := join(deeds ,fips_data_county_name,  
                       left.fips_code[1..2] = right.state_code
                   and left.fips_code[3..5] = right.county_code,
				   reformat(left,right) ,left outer,lookup);


//PULL CLEAN ADDRESS FROM SEARCH FILE 

dist_deeds  := distribute(deeds_county,hash(ln_fares_id)); 

search_in := distribute(search_in0(source_code[2]='P' and err_stat[1] ='S'),hash(ln_fares_id)); ;

temp_rec := record

LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE ; 
  search_in.prim_range;
  search_in.predir;
  search_in.prim_name;
  search_in.suffix;
end; 

temp_rec get_add(dist_deeds l, search_in r ) := transform 

  self := l ;
  self := r ;  
end ; 

join_address := join(dist_deeds ,search_in, left.ln_fares_id = right.ln_fares_id
                                          ,get_add(left,right),keep(1),local); // JOIN SKEWD SO DISTRIBUTED    


deeds_address_dist := distribute(join_address(((integer) fares_unformatted_apn)<>0 ),hash(fares_unformatted_apn));// :persist('joinaddress')  ;

// ROLLUP TO FIND OUT UNIQUE PROPERTY ADDRESS PER APN,STATE,COUNTY

newrec := record
deeds_address_dist.property_full_street_address; 
deeds_address_dist.property_address_citystatezip;
deeds_address_dist.state; 
deeds_address_dist.county_name; 
deeds_address_dist.fares_unformatted_apn;
deeds_address_dist.prim_range;
deeds_address_dist.predir;
deeds_address_dist.prim_name;
deeds_address_dist.suffix;
boolean dummy_flag:= TRUE;
string1 source := if(deeds_address_dist.ln_fares_id[1] != 'R', 'D', 'F') ;
end;

deeds_slim    := table(deeds_address_dist,newrec) ;

deeds_property := dedup(sort(deeds_slim(property_full_street_address <> '' and property_address_citystatezip <> ''),fares_unformatted_apn,state,county_name,source,prim_range,predir,prim_name,suffix,local),fares_unformatted_apn,state,county_name,source,prim_range,predir,prim_name,suffix,local);

newrec trans(newrec l,newrec r) := transform
self.fares_unformatted_apn := l.fares_unformatted_apn;
self.dummy_flag := if((trim(l.prim_range,left,right) <> trim(r.prim_range,left,right) and 
                       trim(l.predir,left,right)<>trim(r.predir,left,right) and 
                       trim(l.prim_name,left,right)<>trim(r.prim_name,left,right) and 
                       trim(l.suffix,left,right)<>trim(r.suffix,left,right)) or l.dummy_flag=FALSE,FALSE,TRUE);
self := l;
end;

deeds_property_flag := rollup(deeds_property,trans(left,right),fares_unformatted_apn,state,county_name,source,local);

dist_deeds_apn_filled	:=	distribute(dist_deeds(fares_unformatted_apn<>''),hash(fares_unformatted_apn));
dist_deeds_apn_empty	:=	dist_deeds(fares_unformatted_apn='');
// Propagate within source D => Dayton F=> Fares 

rec_temp := record 
LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE ;
string1 src; 
end; 

rec_temp  treformat(LN_Mortgage.Layout_Deed_Mortgage_Common_Model_BASE l) := transform 
self.src :=  if(l.ln_fares_id[1] != 'R', 'D', 'F') ;
self := l ; 
end; 

dist_deeds_apn_filled_src := project(dist_deeds_apn_filled, treformat(left));
	 


// DO LEFT OUTER TO KEEP ALL RECORDS(PROPAGATED RECORDS ALONG WITH OTHER RECORDS).P for Propgataion  

propagate_address:=join(dist_deeds_apn_filled_src , deeds_property_flag(dummy_flag = TRUE),
                left.fares_unformatted_apn=right.fares_unformatted_apn and left.state=right.state and left.county_name= right.county_name and left.src = right.source,
				transform({recordof(ln_property.File_Deed)},
				self.property_full_street_address := if(left.property_full_street_address = ''and right.property_full_street_address!= '' ,right.property_full_street_address,left.property_full_street_address),
				self.property_address_citystatezip := if(left.property_full_street_address = '' and right.property_full_street_address!= '', right.property_address_citystatezip,left.property_address_citystatezip), // this will overwrite zip if its populated 
		      	self.dummy_seg := if(left.property_full_street_address= '' and right.property_full_street_address!= '' , 'P','');
				self := left),left outer,local) + dist_deeds_apn_empty;// : persist('~thor_data400::persist::propagate_address_deeds','thor_dell400_2'); 

export deed_result := propagate_address ;

new_search_candidates := deed_result(dummy_seg = 'P');

r_norm := record
 string12 ln_fares_id;
 string5  vendor_source_flag;
 string8  process_date;
 string80 name;
 string1  name_type;
 string70 property_full_street_address;
 string51 property_address_citystatezip;
end;

r_norm t_norm(new_search_candidates le, integer c) := transform
 self.name      := choose(c,le.buyer1,le.buyer2,
                            le.borrower1,le.borrower2,
					        le.seller1,le.seller2
					     );
 self.name_type := choose(c,'O','O',
                            'B','B',
							'S','S'
						 );
 self           := le;						 
end;

p_norm := normalize(new_search_candidates,6,t_norm(left,counter))(trim(name)<>'');

r_clean := record
 p_norm;
 
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

r_clean t_clean(p_norm le) := transform
 
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

p_clean := project(p_norm,t_clean(left));

ln_property.Layout_Deed_Mortgage_Property_Search t_map_to_search(p_clean le) := transform
 self.source_code := le.name_type+'P';
 self             := le;
end;

p_map_to_search := project(p_clean,t_map_to_search(left));// : persist('~thor_data400::persist::ln_property_new_search_recs_after_propagation','thor_dell400_2');

export new_search_records := p_map_to_search;

end;