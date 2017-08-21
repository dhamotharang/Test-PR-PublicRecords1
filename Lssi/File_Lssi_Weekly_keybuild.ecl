//This attribute is used by LSSIWeeklyKeys 
import ut;

lssi_weekly := lssi.File_Hhid_Did_Lssi(did<>0, trim(clean_phone)<>'');

//macro to suppress WA cell phone numbers                              
ut.mac_suppress_by_phonetype(lssi_weekly,clean_phone,state,lssi_recs_out,true,did);

lssi_after_phSuppress := lssi_recs_out(trim(clean_phone)<>'');

//export File_Lssi_Weekly_keybuild := lssi_after_phSuppress: persist('persist::lssi_weeklyKeybuild');

layout_minus_aid := record
               layout_hhid_did_lssi and not rawaidin;
							 end;
							 
export File_Lssi_Weekly_keybuild := Project(lssi_after_phSuppress, transform(layout_minus_aid,
																							self := left));
																							

																						
