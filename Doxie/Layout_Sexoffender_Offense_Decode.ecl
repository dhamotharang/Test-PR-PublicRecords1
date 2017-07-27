import sexoffender, FFD;
export Layout_Sexoffender_Offense_Decode := record
	sexoffender.layout_common_offense;
	string3 victim_minor_name := '';
	FFD.Layouts.CommonRawRecordElements;
end;