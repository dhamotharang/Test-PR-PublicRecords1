/*2005-09-08T11:14:49Z (Ananth Vankatachalam)
added thor_dell400_2 in the persist to make the process faster ( reason slimsorts)
*/
import watchdog,gong,did_add,header_slimsort,ut,didville,fair_isaac;

gong_did_rec := record
	unsigned6 did := 0;
	layout_bscurrent_raw;
end;

g_full := gong.File_Daily_Full;

matchset := ['A','P'];

//DID gong file
DID_Add.MAC_Match_Flex(g_full,matchset,foo,foo,name_first,name_middle,
	name_last,name_suffix,prim_range,prim_name,sec_range,z5,st,phone10,
	did,gong_did_rec,false,foo, 
	75,g_full_out)

export file_gong_did_add := g_full_out : persist('~thor_data400::persist::file_gong_did_add');