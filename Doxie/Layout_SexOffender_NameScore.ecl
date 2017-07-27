import sexoffender;
export Layout_SexOffender_NameScore := RECORD,maxlength(200000)
	unsigned penalt;
	SexOffender.layout_so_search_main;
	DATASET(sexoffender.Layout_Out_Alt) Alternate_Address_Search_Results;
	dataset(doxie.Layout_SexOffender_Name) name;
  unsigned4		name_score;
	unsigned1		addr_score;
	unsigned1		addr_pref;
	unsigned1		Best_Mismatch;
END;