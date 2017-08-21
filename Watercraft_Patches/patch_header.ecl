import header;

watercraft_src := [
'1W','2W','3W','4W','5W','6W','7W','8W','9W',
'BW','CW','DW','EW','FW','GW','HW','IW','JW','KW','LW','NW','OW','PW','QW','RW','SW','TW','VW','WW','XW','YW','ZW',
'#W','[W','!W','@W',
'CG'];                

//wc_jr       := watercraft_patches.file_jr_patch;
//wc_jr_sort  := sort (wc_jr     ,rc_title,rc_fname,rc_mname,rc_lname,rc_name_suffix);
//wc_jr_dedup := dedup(wc_jr_sort,rc_title,rc_fname,rc_mname,rc_lname,rc_name_suffix);

header_in := dataset('~thor_data400::base::header5_noirs',header.Layout_Header,flat);
output(count(header_in),NAMED('Header_File_Ct'));

    watercraft_header := header_in(src     in watercraft_src);
not_watercraft_header := header_in(src not in watercraft_src);
output(count(watercraft_header(prim_range='',prim_name='',zip='')),NAMED('Blank_Watercraft_Addresses_Before_Patch'));

header.Layout_Header tHeaderPatch1(header.Layout_Header l, watercraft_patches.layout_address_patch r) := transform
 
 boolean has_right_record := if(r.clean_address<>'',true,false);
 
 self.prim_range := if(has_right_record,r.clean_address[1..   10],l.prim_range);
 self.predir     := if(has_right_record,r.clean_address[11..  12],l.predir);
 self.prim_name  := if(has_right_record,r.clean_address[13..  40],l.prim_name);
 self.suffix     := if(has_right_record,r.clean_address[41..  44],l.suffix);
 self.postdir    := if(has_right_record,r.clean_address[45..  46],l.postdir);
 self.unit_desig := if(has_right_record,r.clean_address[47..  56],l.unit_desig);
 self.sec_range  := if(has_right_record,r.clean_address[57..  64],l.sec_range);
 self.city_name  := if(has_right_record,r.clean_address[90.. 114],l.city_name);
 self.st         := if(has_right_record,r.clean_address[115..116],l.st);
 self.zip        := if(has_right_record,r.clean_address[117..121],l.zip);
 self.zip4       := if(has_right_record,r.clean_address[122..125],l.zip4);
 self.county     := if(has_right_record,r.clean_address[143..145],l.county);
 self.geo_blk    := if(has_right_record,r.clean_address[171..177],l.geo_blk);
 self            := l;
end;

dHeaderPatch1 := join(watercraft_header,watercraft_patches.file_address_patch,
                                             (left.prim_range = right.prim_range      and
							                  left.predir     = right.predir          and
							                  left.prim_name  = right.prim_name       and
							                  left.suffix     = right.suffix          and
							                  left.postdir    = right.postdir         and
							                  left.unit_desig = right.unit_desig      and
							                  left.sec_range  = right.sec_range       and
							                  left.city_name  = right.v_city_name     and
							                  left.st         = right.st              and
							                  left.zip        = right.zip5            and
							                  left.zip4       = right.zip4            and
							                  left.county     = right.ace_fips_county and
							                  left.geo_blk    = right.geo_blk),
							                 tHeaderPatch1(left,right)
							               ,left outer, keep(1));
output(count(dHeaderPatch1(prim_range='',prim_name='',zip='')),NAMED('Blank_Watercraft_Addresses_After_Patch'));
/*
    dHeaderPatch1_JR := dHeaderPatch1(trim(lname) ='JR');
not_dHeaderPatch1_JR := dHeaderPatch1(trim(lname)!='JR');

header.Layout_Header tHeaderPatch2(header.Layout_Header l, watercraft_patches.layout_jr_patch r) := transform
 self.title       := r.rc_title;
 self.fname       := r.rc_fname;
 self.mname       := r.rc_mname;
 self.lname       := r.rc_lname;
 self.name_suffix := r.rc_name_suffix;
 self             := l;
end;

dHeaderPatch2_JR := join(dHeaderPatch1_JR,wc_jr_dedup,
                         (left.title=right.title and
						  left.fname=right.fname and
						  left.mname=right.mname and
						  left.lname=right.lname and
						  left.name_suffix=right.name_suffix),
						 tHeaderPatch2(left,right),
						 left outer
						);

dHeaderPatch2 := not_watercraft_header+not_dHeaderPatch1_JR+dHeaderPatch2_JR;
output(count(dHeaderPatch2),NAMED('Header_File_Ct_After_Name_Patch'));					
*/
//dHeaderPatch3 := dHeaderPatch2(did not in [114274725991,114405601600]);
dHeaderPatch3 := dHeaderPatch1+not_watercraft_header((string12)did not in ['114274725991','114405601600']);
output(count(dHeaderPatch3),NAMED('Header_File_Ct_After_DID_Removal'));

//    dHeaderPatch3_Targus := dHeaderPatch3(src ='WP');
//not_dHeaderPatch3_Targus := dHeaderPatch3(src!='WP');

header.Layout_Header tPhoneToBlank(header.Layout_Header l) := transform
 self.phone := if(l.src='WP','',l.phone);
 //self.phone := '';
 self       := l;
end;

//dHeaderPatch4_Targus := project(dHeaderPatch3_Targus,tPhoneToBlank(left));

//dHeaderPatch4 := not_dHeaderPatch3_Targus+dHeaderPatch4_Targus;
dHeaderPatch4 := project(dHeaderPatch3,tPhoneToBlank(left));
output(count(dHeaderPatch4),NAMED('Header_File_Ct_After_Targus'));
output(dHeaderPatch4,,'~thor_data400::base::header5_noirs_patched',overwrite);
