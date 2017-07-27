
layout_hwt := record
	string2 st;
	string5 fips_code;
	string5 zipcode;
	string1 land_use;
	real standard_deviation_asrtotalvalue;
	real standard_deviation_bed;
	real standard_deviation_bath;
	real standard_deviation_age;
	real standard_deviation_buildingarea;
	real standard_deviation_stories;
	real standard_deviation_room;
	real standard_deviation_assessedyear;
	real weight_asrtotalvalue;
	real weight_bed;
	real weight_bath;
	real weight_age;
	real weight_buildingarea;
	real weight_stories;
	real weight_room;
	real weight_time;
	real weight_physicaldistance;
	real weight_assessedyear;
end;

hwt_raw := dataset('~thor_data400::in::avm::hedonic_weight_coefficients', layout_hwt, csv(heading(1)));

hwt := project(hwt_raw, transform(layout_hwt, 
							self.fips_code := (string)intformat((integer)left.fips_code,5,1),
							self.zipcode := if(trim(left.zipcode)='', '', (string)intformat((integer)left.zipcode,5,1)),
							self := left));

export File_Hedonic_Weights_Table := hwt;