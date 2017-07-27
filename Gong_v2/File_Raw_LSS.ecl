import ut;

export File_Raw_LSS := 
	dataset(Gong_v2.thor_cluster+'in::gongv2_update',Gong_v2.Layout_Raw_LSS,csv(terminator('\n'), separator(','),quote('"')));