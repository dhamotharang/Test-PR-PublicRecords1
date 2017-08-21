import MFind, did_add, ut, header_slimsort, didville, business_header,business_header_ss, address;

format(string intext) := function
 out_string1 := StringLib.StringFindReplace(trim(intext,left,right) ,'&ast;' ,'') ;
 out_string2 := StringLib.StringFindReplace(trim(out_string1,left,right) ,'&apos;' ,'') ;
 out_string3 := StringLib.StringFindReplace(trim(out_string2,left,right) ,'&lsqb;' ,'[') ;
 out_string4 := StringLib.StringFindReplace(trim(out_string3,left,right) ,'&rsqb;' ,']') ;
 out_string5 := StringLib.StringFindReplace(trim(out_string4,left,right) ,'lt;' ,'') ;
 out_string6 := StringLib.StringFindReplace(trim(out_string5,left,right) ,'&gt;' ,'') ;
 out_string7 := StringLib.StringFindReplace(trim(out_string6,left,right) ,'&quot;' ,'') ;
 out_string8 := StringLib.StringFindReplace(trim(out_string7,left,right) ,'&amp;' ,'&') ;
 
return out_string8;
end ;

MFind.Layout_Military_Personnel tra(MFind.Layout_Military_Personnel l) := transform 

self.ca.STR_ADDR_1 := format(l.ca.STR_ADDR_1) ; 
self.ca.STR_ADDR_2 := format(l.ca.STR_ADDR_2); 
self.ca.CITY       := format(l.ca.CITY ); 
self.ca.STATE      := format(l.ca.STATE); 
self := L; 

end; 

ds_clean := project(MFind.File_MFind,tra(left)) ; 
			
mfind.Layout_Clean_MFind t_clean(MFind.Layout_Military_Personnel l):= transform

 string73  v_concat_name 	:= StringLib.StringCleanSpaces(l.cn.CURR_NAME_LAST+' '+l.cn.CURR_NAME_FIRST+' '+l.cn.CURR_NAME_MIDDLE+' '+l.cn.CURR_NAME_SUFFIX);
 string182 v_ca 	        := address.CleanAddress182(trim(l.ca.STR_ADDR_2,left,right), (trim(l.ca.CITY,left,right)+', '+trim(l.ca.STATE,left,right))+' '+trim(l.ca.ZIP,left,right));  

 string73  v_pname			:= if(l.cn.CURR_NAME_LAST <> '', address.CleanPersonLFM73(v_concat_name), '');

 self.curr_name_last        := l.cn.curr_name_last;
 self.curr_name_first       := l.cn.curr_name_first;
 self.curr_name_middle      := l.cn.curr_name_middle;
 self.curr_name_m_initial   := l.cn.curr_name_m_initial;
 self.curr_name_suffix       := l.cn.curr_name_suffix;
 self.curr_name_gender      := if(L.CN.CURR_NAME_GENDER<>'',
							   L.CN.CURR_NAME_GENDER,
							   MAP(ut.GenderTools.gender(L.CN.CURR_NAME_FIRST,L.CN.CURR_NAME_MIDDLE)='M'=>'MALE',
								   ut.GenderTools.gender(L.CN.CURR_NAME_FIRST,L.CN.CURR_NAME_MIDDLE)='F'=>'FEMALE',
								   ''));
 
 self.str_addr_1            := l.ca.str_addr_1;
 self.str_addr_2            := l.ca.str_addr_2;
 self.city                  := l.ca.city;
 self.state                 := l.ca.state;
 self.orig_zip              := l.ca.zip;
 
 self.prim_occup := l.oc.prim_occup;
 self.duty_occup := l.oc.duty_occup;
 self.scnd_occup := l.oc.scnd_occup;

 self.mil_prim_mos := l.mpm.mil_prim_mos;
 self.mil_duty_mos := l.mpm.mil_duty_mos;
 self.mil_scnd_mos := l.mpm.mil_scnd_mos; 
 
 self.title			:= v_pname[1..5];
 self.fname			:= v_pname[6..25];
 self.mname			:= v_pname[26..45];
 self.lname			:= v_pname[46..65];
 self.name_suffix	:= v_pname[66..70];
 self.name_score	:= v_pname[71..73];
 self.prim_range	:= v_ca[1..10];
 self.predir		:= v_ca[11..12];
 self.prim_name		:= v_ca[13..40];
 self.addr_suffix	:= v_ca[41..44];
 self.postdir		:= v_ca[45..46];
 self.unit_desig	:= v_ca[47..56];
 self.sec_range		:= v_ca[57..64];
 self.st			:= v_ca[115..116];
 self.zip			:= v_ca[117..121];
 self.p_city_name 	:= v_ca[65..89];
 self.v_city_name 	:= v_ca[90..114];
 self.zip4 			:= v_ca[122..125];
 self.cart 			:= v_ca[126..129];
 self.cr_sort_sz 	:= v_ca[130];
 self.lot 			:= v_ca[131..134];
 self.lot_order 	:= v_ca[135];
 self.dbpc 			:= v_ca[136..137];
 self.chk_digit 	:= v_ca[138];
 self.rec_type 		:= v_ca[139..140];
 self.county 		:= v_ca[141..145];
 self.geo_lat 		:= v_ca[146..155];
 self.geo_long 		:= v_ca[156..166];
 self.msa 			:= v_ca[167..170];
 self.geo_blk 		:= v_ca[171..177];
 self.geo_match 	:= v_ca[178];
 self.err_stat 		:= v_ca[179..182];
 
 self.trim_vid		:= trim(l.vid,all);

 self 				:= l;
end;

p1		:= project(ds_clean,t_clean(left))(fname<>'',lname<>'');
p1_dupd := dedup(p1,all);

matchset := ['A','Z'];

did_add.MAC_Match_Flex
	(p1_dupd, matchset,					
	 '', '', fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, '', 
	 DID, mfind.Layout_Clean_MFind, false, DID_Score,
	 75, outfile)

ut.mac_sf_buildprocess(outfile, '~thor_data400::base::mfind', build_mfind_base, 2,,true);

export proc_build_mfind_file := build_mfind_base;