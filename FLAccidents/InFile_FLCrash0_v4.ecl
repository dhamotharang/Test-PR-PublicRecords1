// 11/18/11 - No longer receiving the DOT file *slucero
// flc0_v3_in:= dataset('~thor_data400::sprayed::flcrash0'
									// ,FLAccidents.Layout_FLCrash0_v3, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));
Import FLAccidents,STD;
/////////////////////////////////////////////////////////////////////////
//Get fields from Events to backfill old DOT layout
/////////////////////////////////////////////////////////////////////////								
flc1_v4_in := dataset('~thor_data400::sprayed::flcrash1'
									,FLAccidents.Layout_FLCrash1_v4, csv(Heading(1),separator(','),terminator(['\n','\r\n']),quote('')));
									
/////////////////////////////////////////////////////////////////////////
FLAccidents.Layout_FLCrash0_v2 flc0_convert_to_old(flc1_v4_in l) := transform

	self.accident_date				:= STD.date.ConvertDateFormat( l.crash_date, '%Y%m%d','%m/%d/%Y');

	self.rec_type_o           := '0';
	self.st_road_hhwy_name		:= l.st_road_hhwy_name;
  self.ft_miles_from_intersect := map(l.ft_from_intersect <> '0000' => l.ft_from_intersect,
                                        l.miles_from_intersect <> '0000' => l.miles_from_intersect,'');
  self.ft_miles_code2       := map(	l.ft_from_intersect <> '0000' => 'F',
                                         l.miles_from_intersect <> '0000' => 'M','');
	self.intersect_dir_of		:= l.intersect_dir_of;
	self.of_intersect_of		:= l.of_intersect_of;
	self.dot_site_loc				:= l.dot_site_loc;
	self.dot_milepost				:= l.from_milepost_nbr;
	self.dot_fixture_type		:= l.first_harmful_event;
	self.city_town_name     := l.city_name ;
	self.city_nbr           := trim(l.county_code,left,right) + trim(l.city_code,left,right);
	self                := l;
	self                := [];
end;


jrecs := project(flc1_v4_in,flc0_convert_to_old(left));

export InFile_FLCrash0_v4 := jrecs; 