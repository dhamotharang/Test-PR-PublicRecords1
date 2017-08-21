import header, address, watercraft;

search_in := watercraft.File_Base_Search_Prod;
output(count(search_in),NAMED('SearchFileCt'));

search_layout := watercraft.Layout_Watercraft_Search_Base;

rSearch_182 := record
 search_layout;
 string182 orig_clean_address;
end;

//Easier to join on string182 versus each segment
rSearch_182 tConcatCleanSegments(search_layout l) := transform
 self := l;
 self.orig_clean_address :=
      l.prim_range
	+ l.predir
	+ l.prim_name 
	+ l.suffix 
	+ l.postdir
	+ l.unit_desig 
	+ l.sec_range 
	+ l.p_city_name
	+ l.v_city_name
	+ l.st
	+ l.zip5
	+ l.zip4
	+ l.cart
	+ l.cr_sort_sz
	+ l.lot
	+ l.lot_order
	+ l.dpbc
	+ l.chk_digit
	+ l.rec_type
	+ l.ace_fips_st
	+ l.ace_fips_county
	+ l.geo_lat
	+ l.geo_long
	+ l.msa
	+ l.geo_blk
	+ l.geo_match
	+ l.err_stat;
end;

search := project(search_in,tConcatCleanSegments(left));

rSearch_182_Slim := record
 search.orig_address_1;
 search.orig_address_2;
 search.orig_city;
 search.orig_state;
 search.orig_zip;
 search.prim_range;
 search.predir;
 search.prim_name;
 search.suffix;
 search.postdir;
 search.unit_desig;
 search.sec_range;
 search.p_city_name;
 search.v_city_name;
 search.st;
 search.zip5;
 search.zip4;
 search.cart;
 search.cr_sort_sz;
 search.lot;
 search.lot_order;
 search.dpbc;
 search.chk_digit;
 search.rec_type;
 search.ace_fips_st;
 search.ace_fips_county;
 search.geo_lat;
 search.geo_long;
 search.msa;
 search.geo_blk;
 search.geo_match;
 search.err_stat;
 search.orig_clean_address;
end;

rSearch_182_Slim tSearch_182_Slim(rSearch_182 l) := transform
 self := l;
end;

dSearch_      := project   (search,tSearch_182_Slim(left));
//dSearch_dist  := distribute(dSearch_,hash(orig_address_1,orig_address_2,orig_city,orig_state,orig_zip,orig_clean_address));
//dSearch_sort  := sort      (dSearch_dist, orig_address_1,orig_address_2,orig_city,orig_state,orig_zip,orig_clean_address,local);
//dSearch_dedup := dedup     (dSearch_sort, orig_address_1,orig_address_2,orig_city,orig_state,orig_zip,orig_clean_address,local);
dSearch_dist  := distribute(dSearch_,hash(orig_clean_address));
dSearch_sort  := sort      (dSearch_dist, orig_clean_address,local);
dSearch_dedup := dedup     (dSearch_sort, orig_clean_address,local);
dSearch       := dSearch_dedup;

watercraft_patches.layout_address_patch tSearch_182_Slim_Clean(rSearch_182_Slim l) := transform
 self := l;
 self.clean_address := address.cleanaddress182(trim(l.orig_address_1)+' '+trim(l.orig_address_2),trim(l.orig_city)+' '+trim(l.orig_state)+' '+trim(l.orig_zip));
end;

dClean_     := project(dSearch,tSearch_182_Slim_Clean(left));
dClean_good := dClean_(clean_address[179]='S',
                       //Not including p_city_name in filter since it is not mapped in the Header (only v_city_name is).
                       clean_address[1..64]+clean_address[90..125]!=orig_clean_address[1..64]+orig_clean_address[90..125]
					  ) : persist('~thor_200::persist::watercraft_address_patch');
output(count(dClean_good),NAMED('Address_Replacements_Ct'));					  

search_layout tReplaceAddress(rSearch_182 l, watercraft_patches.layout_address_patch r) := transform

 boolean has_right_record := if(r.clean_address<>'',true,false);

 self.prim_range      := if(has_right_record,r.clean_address[  1.. 10],l.prim_range);
 self.predir          := if(has_right_record,r.clean_address[ 11.. 12],l.predir);
 self.prim_name       := if(has_right_record,r.clean_address[ 13.. 40],l.prim_name);
 self.suffix          := if(has_right_record,r.clean_address[ 41.. 44],l.suffix);
 self.postdir         := if(has_right_record,r.clean_address[ 45.. 46],l.postdir);
 self.unit_desig      := if(has_right_record,r.clean_address[ 47.. 56],l.unit_desig);
 self.sec_range       := if(has_right_record,r.clean_address[ 57.. 64],l.sec_range);
 self.p_city_name     := if(has_right_record,r.clean_address[ 65.. 89],l.p_city_name);
 self.v_city_name     := if(has_right_record,r.clean_address[ 90..114],l.v_city_name);
 self.st              := if(has_right_record,r.clean_address[115..116],l.st);
 self.zip5            := if(has_right_record,r.clean_address[117..121],l.zip5);
 self.zip4            := if(has_right_record,r.clean_address[122..125],l.zip4);
 self.cart            := if(has_right_record,r.clean_address[126..129],l.cart);
 self.cr_sort_sz      := if(has_right_record,r.clean_address[130     ],l.cr_sort_sz);
 self.lot             := if(has_right_record,r.clean_address[131..134],l.lot);
 self.lot_order       := if(has_right_record,r.clean_address[135     ],l.lot_order);
 self.dpbc            := if(has_right_record,r.clean_address[136..137],l.dpbc);
 self.chk_digit       := if(has_right_record,r.clean_address[138     ],l.chk_digit);
 self.rec_type        := if(has_right_record,r.clean_address[139..140],l.rec_type);
 self.ace_fips_st     := if(has_right_record,r.clean_address[141..142],l.ace_fips_st);
 self.ace_fips_county := if(has_right_record,r.clean_address[143..145],l.ace_fips_county);
 self.county          := if(has_right_record,r.clean_address[143..145],l.ace_fips_county);
 self.geo_lat         := if(has_right_record,r.clean_address[146..155],l.geo_lat);
 self.geo_long        := if(has_right_record,r.clean_address[156..166],l.geo_long);
 self.msa             := if(has_right_record,r.clean_address[167..170],l.msa);
 self.geo_blk         := if(has_right_record,r.clean_address[171..177],l.geo_blk);
 self.geo_match       := if(has_right_record,r.clean_address[178     ],l.geo_match);
 self.err_stat        := if(has_right_record,r.clean_address[179..182],l.err_stat);
 self                 := l;
end;

dAddressReplace := join(search,dClean_good,
                            left.orig_clean_address=right.orig_clean_address,
						    tReplaceAddress(left,right),
						    left outer);

//Drop orig_clean_address field added earlier
search_layout tDrop182(search_layout l) := transform 
 self := l;
end;

dPatch1 := project(dAddressReplace,tDrop182(left));
output(count(dPatch1),NAMED('SearchFileCt_AfterAddressPatch'));
output(dPatch1,,Watercraft.Cluster + 'base::watercraft_search_' + Watercraft.Version_Production + '_patched',overwrite);
/*
rSearch_73 := record
 search_layout;
 string5  rc_title;
 string20 rc_fname;
 string20 rc_mname;
 string20 rc_lname;
 string5  rc_name_suffix;
 string3  rc_name_cleaning_score;
end;

rSearch_73 tSearch_73(search_layout l) := transform
 self := l;
 self := [];
end;

dSearch_73 := project(dPatch1,tSearch_73(left));

    dWatercraftJRs   := dSearch_73(trim(lname) ='JR');
not_dWatercraftJRs   := dSearch_73(trim(lname)!='JR');

rSearch_73 tCleanJRs(rSearch_73 l) := transform
 
 string73 v_pname := if(l.orig_name<>'',
                      address.CleanPersonLFM73(l.orig_name),
					  address.CleanPersonLFM73(trim(l.orig_name_last)+' '+trim(l.orig_name_first)+' '+trim(l.orig_name_middle))
					 );
 
 self.rc_title               := v_pname[ 1.. 5];
 self.rc_fname               := v_pname[ 6..25];
 self.rc_mname               := v_pname[26..45];
 self.rc_lname               := v_pname[46..65];
 self.rc_name_suffix         := v_pname[66..70];
 self.rc_name_cleaning_score := v_pname[71..73];
 self                        := l;
end;

dNameRepl_     := project(dWatercraftJRs,tCleanJRs(left));
dNameRepl_good := dNameRepl_(trim(rc_name_suffix)='JR') : persist('~thor_200::persist::watercraft_jr_patch');
dNameRepl_bad  := dNameRepl_(trim(rc_name_suffix)!='JR');

//watercraft_patches.layout_jr_patch tSlimJRs(rSearch_73 l) := transform
// self := l;
//end;

//p1       := project(dNameRepl_good,tSlimJRs(left));
//p1_sort  := sort   (p1,title,fname,mname,lname,name_suffix);
//p1_dedup := dedup  (p1_sort,title,fname,mname,lname,name_suffix);
//count(p1_dedup);

rSearch_73 tNameOverwrite(rSearch_73 l) := transform
 self.title               := l.rc_title;
 self.fname               := l.rc_fname;
 self.mname               := l.rc_mname;
 self.lname               := l.rc_lname;
 self.name_suffix         := l.rc_name_suffix;
 self.name_cleaning_score := l.rc_name_cleaning_score;
 self                     := l;
end;

dNameRepl := project(dNameRepl_good,tNameOverwrite(left));

search_layout tDrop_73(rSearch_73 l) := transform
 self := l;
end;

dPatch2 := project(not_dWatercraftJRs+dNameRepl_bad+dNameRepl,tDrop_73(left));
output(count(dPatch2),NAMED('SearchFileCt_AfterNamePatch'));
output(dPatch2,,Watercraft.Cluster + 'base::watercraft_search_' + Watercraft.Version_Development + '_patched',overwrite);
*/