import LN_Mortgage,LN_Property,ut,LN_Propertyv2 ;

export Propagate_Property_Address_Deed(
	dataset(recordof(LN_PropertyV2.layout_deed_mortgage_common_model_base)) deed_in0,
	dataset(recordof(LN_PropertyV2.layout_deed_mortgage_property_search))   search_in0) :=
MODULE

// POPULATE APN FOR DAYTON DATA 

LN_PropertyV2.layout_deed_mortgage_common_model_base getdeeds(deed_in0 L) := transform
	self.fares_unformatted_apn := if(
		L.ln_fares_id[1]!='R',
		fn_strip_pnum(L.apnt_or_pin_number),
		fn_strip_pnum(L.fares_unformatted_apn)
	);
	self := L;
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


LN_PropertyV2.layout_deed_mortgage_common_model_base reformat( deeds l, fips_data_county_name r ) := transform 

self.county_name := if(l.vendor_source_flag in ['F','S'],StringLib.StringToUpperCase(r.county_alpha),StringLib.StringToUpperCase(l.county_name)) ; 
self.state       := if(l.vendor_source_flag in ['F','S'],StringLib.StringToUpperCase(r.state_alpha),StringLib.StringToUpperCase(l.state)) ; 
self := l ; 
end ; 

deeds_county := join(deeds ,fips_data_county_name,  
                       left.fips_code[1..2] = right.state_code
                   and left.fips_code[3..5] = right.county_code,
				   reformat(left,right) ,left outer,lookup);


//PULL CLEAN ADDRESS FROM SEARCH FILE 

dist_deeds  := distribute(deeds_county,hash(ln_fares_id)); 

search_in := distribute(search_in0(source_code[2]='P' /*and err_stat[1] ='S'*/),hash(ln_fares_id)); ;

temp_rec := record

LN_PropertyV2.layout_deed_mortgage_common_model_base ; 
  search_in.prim_range;
  search_in.predir;
  search_in.prim_name;
  search_in.suffix;
  search_in.err_stat;
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
deeds_address_dist.err_stat;
boolean dummy_flag:= TRUE;
string1 source := if(deeds_address_dist.ln_fares_id[1] != 'R', 'D', 'F') ;
end;

deeds_slim    := table(deeds_address_dist,newrec) ;

deeds_property := dedup(sort(deeds_slim(property_full_street_address <> '' and property_address_citystatezip <> ''),fares_unformatted_apn,state,county_name,source,prim_range,predir,prim_name,suffix,err_stat,local),fares_unformatted_apn,state,county_name,source,prim_range,predir,prim_name,suffix,local);

newrec trans(newrec l,newrec r) := transform
self.fares_unformatted_apn := l.fares_unformatted_apn;
self.dummy_flag := if(((trim(l.prim_range,left,right)+trim(l.predir,left,right)+
                    trim(l.prim_name,left,right) + trim(l.suffix,left,right)) <> 
					(trim(r.prim_range,left,right)+trim(r.predir,left,right)+
					trim(r.prim_name,left,right)+trim(r.suffix,left,right))) or l.dummy_flag=FALSE,FALSE,TRUE); 
self := l;
end;

deeds_property_flag := rollup(deeds_property,trans(left,right),fares_unformatted_apn,state,county_name,source,local);

dist_deeds_apn_filled	:=	distribute(dist_deeds(fares_unformatted_apn<>''),hash(fares_unformatted_apn));
dist_deeds_apn_empty	:=	dist_deeds(fares_unformatted_apn='');
// Propagate within source D => Dayton F=> Fares 

rec_temp := record 
LN_PropertyV2.layout_deed_mortgage_common_model_base ;
string1 src; 
end; 

rec_temp  treformat(LN_PropertyV2.layout_deed_mortgage_common_model_base l) := transform 
self.src :=  if(l.ln_fares_id[1] != 'R', 'D', 'F') ;
self := l ; 
end; 

dist_deeds_apn_filled_src := project(dist_deeds_apn_filled, treformat(left));
	 


// DO LEFT OUTER TO KEEP ALL RECORDS(PROPAGATED RECORDS ALONG WITH OTHER RECORDS).P for Propgataion  

propagate_address:=join(dist_deeds_apn_filled_src , deeds_property_flag(dummy_flag = TRUE and err_stat[1] = 'S'),
                left.fares_unformatted_apn=right.fares_unformatted_apn and left.state=right.state and left.county_name= right.county_name and left.src = right.source,
				transform({recordof(LN_PropertyV2.layout_deed_mortgage_common_model_base)},
				self.property_full_street_address := if(left.property_full_street_address = ''and right.property_full_street_address!= '' ,right.property_full_street_address,left.property_full_street_address),
				self.property_address_citystatezip := if(left.property_full_street_address = '' and right.property_full_street_address!= '', right.property_address_citystatezip,left.property_address_citystatezip), // this will overwrite zip if its populated 
		      	self.prop_addr_propagated_ind := if(left.property_full_street_address= '' and right.property_full_street_address!= '' , 'P','');
				self := left),left outer,local) + dist_deeds_apn_empty;// : persist('~thor_data400::persist::propagate_address_deeds','thor_dell400_2'); 

export deed_result := propagate_address ;

Fares_deed    := deed_result(vendor_source_flag in ['F','S']); 
Lexis_deed    := deed_result(vendor_source_flag not in ['F','S']); 

// call current flag function/macro and merge LN,Fares 

Deeds_Wflag  :=  LN_PropertyV2.Fares_Latest_Filing_flag.Deedwflag(Fares_deed) + LN_PropertyV2.Mac_LN_latest_Recflag.current_deeds(Lexis_deed);

// bug 25396 - nameasis in search would begin w/ a leading ", "

export Deeds_resultWflag := LN_PropertyV2.fn_patch_deed(Deeds_Wflag); 


new_search_candidates := deed_result(prop_addr_propagated_ind = 'P');

r_norm := record
 string12 ln_fares_id;
 string5  vendor_source_flag;
 string8  process_date;
 string80 name;
 string1  name_type;
 string70 property_full_street_address;
 string51 property_address_citystatezip;
 string10  phone_number;
 unsigned3 dt_first_seen; 
 unsigned3 dt_last_seen; 
 unsigned3 dt_vendor_first_reported; 
 unsigned3 dt_vendor_last_reported; 
 string1   conjunctive_name_seq; 
end;

r_norm t_norm(new_search_candidates le, integer c) := transform
 self.name      := choose(c,le.name1,le.name2,
                            le.seller1,le.seller2
					     );
 self.name_type := choose(c,le.buyer_or_borrower_ind,le.buyer_or_borrower_ind,
                            'S','S'
						 );
 
 self.phone_number             := choose(c,le.phone_number,le.phone_number,
                                          '','');  //check this 
 self.dt_first_seen            := (integer)le.recording_date[1..6]; 
 self.dt_last_seen             := (integer)le.recording_date[1..6]; 
 self.dt_vendor_first_reported := (integer)le.recording_date[1..6]; 
 self.dt_vendor_last_reported  := (integer)le.process_date[1..6]; 
 self.conjunctive_name_seq     := '1'; 
 self           := le;						 
end;

p_norm := normalize(new_search_candidates,4,t_norm(left,counter))(trim(name)<>'');

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
 
 string73  v_pname      := addrcleanlib.cleanpersonlfm73(le.name);
 string182 v_clean_addr := addrcleanlib.cleanaddress182(le.property_full_street_address,le.property_address_citystatezip);
 
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

LN_PropertyV2.layout_deed_mortgage_property_search t_map_to_search(p_clean le) := transform
 self.source_code := le.name_type+'P';
 self             := le;
end;

p_map_to_search := project(p_clean,t_map_to_search(left));
export new_search_records := p_map_to_search;

end;