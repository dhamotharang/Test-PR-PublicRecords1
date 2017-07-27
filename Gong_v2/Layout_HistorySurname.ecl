import gong;
export Layout_HistorySurname := RECORD
	// definition of fields from SurnameSearch to return to caller
			typeof(gong.File_Gong_History_full.listed_name) listed_name,
			typeof(gong.File_Gong_History_full.prim_range) prim_range,
			typeof(gong.File_Gong_History_full.predir) predir,
			typeof(gong.File_Gong_History_full.prim_name) prim_name,
			typeof(gong.File_Gong_History_full.suffix) suffix,
			typeof(gong.File_Gong_History_full.postdir) postdir,
			typeof(gong.File_Gong_History_full.unit_desig) unit_desig,
			typeof(gong.File_Gong_History_full.sec_range) sec_range,
			typeof(gong.File_Gong_History_full.p_city_name) p_city_name,
			typeof(gong.File_Gong_History_full.st) st,
			typeof(gong.File_Gong_History_full.z5) z5,
			typeof(gong.File_Gong_History_full.z4) z4,
			typeof(gong.File_Gong_History_full.phone10) phone10,
			typeof(gong.File_Gong_History_full.county_code) county_code,
			typeof(gong.File_Gong_History_full.name_prefix) name_prefix,
			typeof(gong.File_Gong_History_full.name_first) name_first,
			typeof(gong.File_Gong_History_full.name_middle) name_middle,
			typeof(gong.File_Gong_History_full.name_last) name_last,
			typeof(gong.File_Gong_History_full.name_suffix) name_suffix,
			typeof(gong.File_Gong_History_full.did) did,
END;