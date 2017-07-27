import header, infutor;
export Layouts := module

	export Address := RECORD
		header.layout_header.did;
		string12 GeoLink;
		real4 latitude;
		real4 longitude;
		unsigned4 dt_first_seen; // header uses unsigned3 (YYYYMM); we want unsigned4 (YYYYMMDD)
		unsigned4 dt_last_seen;
		header.layout_header.prim_range;
		header.layout_header.predir;
		header.layout_header.prim_name;
		header.layout_header.suffix;
		header.layout_header.postdir;
		header.layout_header.unit_desig;
		header.layout_header.sec_range;
		header.layout_header.city_name;
		header.layout_header.st;
		header.layout_header.zip;
		header.layout_header.geo_blk;
		header.layout_header.county;
	end;

	export Occupancy := record
		unsigned2 occupants;
		unsigned2 occupants_1yr;
		unsigned2 occupants_2yr;
		unsigned2 occupants_3yr;
		unsigned2 occupants_4yr;
		unsigned2 occupants_5yr;
		
		unsigned2 turnover_1yr_in;
		unsigned2 turnover_1yr_out;
		unsigned2 turnover_2yr_in;
		unsigned2 turnover_2yr_out;
		unsigned2 turnover_3yr_in;
		unsigned2 turnover_3yr_out;
		unsigned2 turnover_4yr_in;
		unsigned2 turnover_4yr_out;
		unsigned2 turnover_5yr_in;
		unsigned2 turnover_5yr_out;
	end;
	
	export Crimes := record
		unsigned2 crimes;
		unsigned2 crimes_1yr;
		unsigned2 crimes_2yr;
		unsigned2 crimes_3yr;
		unsigned2 crimes_4yr;
		unsigned2 crimes_5yr;
	end;

	export Liens := record
		unsigned2 liens;
		unsigned2 liens_1yr;
		unsigned2 liens_2yr;
		unsigned2 liens_3yr;
		unsigned2 liens_4yr;
		unsigned2 liens_5yr;
	end;

	export Foreclosures := record
		unsigned2 foreclosures;
		unsigned2 foreclosures_1yr;
		unsigned2 foreclosures_2yr;
		unsigned2 foreclosures_3yr;
		unsigned2 foreclosures_4yr;
		unsigned2 foreclosures_5yr;
	end;
	
	export SexOffenders := record
		unsigned2 sexoffenders;
		unsigned2 sexoffenders_1yr;
		unsigned2 sexoffenders_2yr;
		unsigned2 sexoffenders_3yr;
		unsigned2 sexoffenders_4yr;
		unsigned2 sexoffenders_5yr;
	end;


	
	export Scores := record
		real Crime_Index;
		real Poverty_Index;
		real Foreclosure_Index;
		real Disruption_Index;
		real Mobility_Index;
		integer2 Risk_Index;
	end;
	export AddrRisk_Key := RECORD
		string12 GeoLink;
		real4 Latitude;
		real4 Longitude;
		Occupancy;
		Crimes;
		Foreclosures;
		SexOffenders;
	END;
	export AddrRisk_Geolinks := RECORD
		string12 GeoLink;
		real4 Latitude;
		real4 Longitude;
	END;
	export AddrRisk_Scored := RECORD
		AddrRisk_Key;
		Scores;
		real4 miles;
	END;
	
	export Infutor_geolink := record
		string12 geolink;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		infutor.infutor_layout_main.layout_base_tracker;
	end;
	
end;