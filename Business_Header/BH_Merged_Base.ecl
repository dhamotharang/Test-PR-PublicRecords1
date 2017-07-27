IMPORT ut;

file_bh_previous := Business_Header.File_Business_Header_Previous;

// Clear out Group IDs for existing business header file
// Clear vendor_id for Gong records
Business_Header.Layout_Business_Header ClearGroupID(file_bh_previous L) := TRANSFORM
SELF.group1_id 					:= 0;
SELF.vendor_id 					:= IF(L.source not in Set_Source_Vendor_Id_Unique, '', L.vendor_id);
SELF.fein 						:= if(ValidFEIN(l.fein), l.fein, 0);  // Zero the FEIN if prefix is invalid
self.dt_first_seen 				:= if(l.source = 'D' and (integer)l.dt_first_seen 				< 10000000 and (integer)l.dt_first_seen 			!= 0, 0, l.dt_first_seen);
self.dt_last_seen 				:= if(l.source = 'D' and (integer)l.dt_last_seen 				< 10000000 and (integer)l.dt_last_seen 				!= 0, 0, l.dt_last_seen);
self.dt_vendor_first_reported 	:= if(l.source = 'D' and (integer)l.dt_vendor_first_reported 	< 10000000 and (integer)l.dt_vendor_first_reported 	!= 0, 0, l.dt_vendor_first_reported);
self.dt_vendor_last_reported 	:= if(l.source = 'D' and (integer)l.dt_vendor_last_reported 	< 10000000 and (integer)l.dt_vendor_last_reported 	!= 0, 0, l.dt_vendor_last_reported);
SELF := L;
END;

BH_Current := PROJECT(file_bh_previous(Business_Header.BH_Fix_Filter), ClearGroupID(LEFT));

// Combine Business Header Matches with current Business Headers
BH_Add := BH_Current + Business_Header.BH_Matches;

// Rollup the current Headers
BH_Rollup := Business_Header.BH_Initial_Rollup;

ut.MAC_Patch_Id(BH_Add, rcid, BH_Rollup, old_rid, new_rid, BH_Patched)

Business_Header.MAC_Merge_ByRid(BH_Patched, BH_Merged)

EXPORT BH_Merged_Base := BH_Merged : PERSIST('TEMP::BH_Merged_Base');