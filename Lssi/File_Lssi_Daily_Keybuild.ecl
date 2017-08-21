//This attribute is used by lssi daily updates keybuilding to create a file 
//that has WA cell phone numbers suppressed.

import ut;
ds1 := lssi.file_hhid_did_add(did<>0, trim(clean_phone)<>'');
                               
ut.mac_suppress_by_phonetype(ds1,clean_phone,state,lssi_recs_out,true,did);

finalRecs := lssi_recs_out(trim(clean_phone)<>'');

layout_minus_aid := record
               layout_hhid_did_lssi and not rawaidin;
							 end;
							 

Prold_file_layout := Project(finalRecs, transform(layout_minus_aid,
																							self := left));

//export File_Lssi_Daily_keybuild := finalRecs : persist('~thor_dell400::persist::lssi_daily_keybuild');

export File_Lssi_Daily_keybuild := prold_file_layout : persist('~thor_dell400::persist::lssi_daily_keybuild');