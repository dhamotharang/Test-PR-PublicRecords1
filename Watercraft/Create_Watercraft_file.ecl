import header, watercraft, text_search;

export create_watercraft_file(string wc_filedate) := function

cg_file := watercraft.File_Base_Coastguard_Dev;
srch_file := watercraft.File_Base_Search_Dev;
main_file := watercraft.File_Base_Main_Dev;


dis_srch := distribute(srch_file,hash(state_origin,watercraft_key,sequence_key));
dis_main := distribute(main_file,hash(state_origin,watercraft_key,sequence_key));
dis_cg := distribute(cg_file,hash(state_origin,watercraft_key,sequence_key));

srchmain_rec := record
	Watercraft.Layout_Watercraft_Main_Base;
	Watercraft.Layout_Watercraft_Search_Base and not [watercraft_key,state_origin,sequence_key,source_code,history_flag,persistent_record_id];
end;


srchmain_rec getall(dis_srch L, dis_main R) := transform
 self := r;
 self := l;
 self := [];
end;

j1 := join(dis_srch,dis_main,
				left.state_origin = right.state_origin 
				and	left.watercraft_key = right.watercraft_key
				and	left.sequence_key = right.sequence_key,
				getall(left,right),local);

watercraft.Layout_Watercraft_Full getall1(j1 L, dis_cg R) := transform
 self.watercraft_key := l.watercraft_key;
 self.sequence_key := l.sequence_key;
 self.state_origin := l.state_origin;
 self.hull_number := if(l.hull_number <> '',l.hull_number,r.hull_number);
 self.source_code := if(l.source_code <> '',l.source_code,r.source_code);
 self := l; 
 self := r;
 self := [];
end;

j := join(j1,dis_cg,
				left.state_origin = right.state_origin 
				and	left.watercraft_key = right.watercraft_key
				and	left.sequence_key = right.sequence_key,
				getall1(left,right),left outer,local);

header.Mac_Set_Header_Source(j,watercraft.Layout_Watercraft_Full,watercraft.Layout_Watercraft_Full,watercraft.Header_Source_Code(l.source_code,l.State_Origin),withID)

// only get the OH and FL data for starters

wc_sub_d := DISTRIBUTE(withID, HASH32(uid));

return wc_sub_d;

end;