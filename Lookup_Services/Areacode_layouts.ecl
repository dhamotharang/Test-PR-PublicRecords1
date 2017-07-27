export Areacode_layouts := module
	export Areacode_slim :=record
		string3		AreaCode:='';
		string28	City;
		string2		State;
		string28	County_Name:='';
		string4		Timezone;
	end;
	
	export AreaCodeRecords :=record
		string5		zip;
		string3   areacode;
		string3		timezone;
		integer		occurs;
	end;

	export AreaCodeZipcodeRecords :=record
		string5		zip;
		string3   areacode;
		string3		timezone;
		integer		occurs;
		DECIMAL5_2 POBoxPercent;
	end;

	export AreaCodeRecordsFilter :=record(AreaCodeRecords)
			boolean		good;
	end;
	
end;