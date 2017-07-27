import census_data;

export Boca_Shell_Prop_Census(GROUPED dataset(layout_relat_prop) inf) := function

layout_relat_prop get_property_census(layout_relat_prop le, Census_Data.Key_Smart_Jury ri, boolean loose) :=
TRANSFORM
	SELF.census_age := IF(le.census_age<>''	OR (loose AND le.geo_blk[1..6]<ri.tract),
						le.census_age,ri.age);
	SELF.census_income := IF(le.census_income<>'' OR (loose AND le.geo_blk[1..6]<ri.tract),
						le.census_income,ri.income);
	SELF.census_home_value := IF(le.census_home_value<>'' OR (loose AND le.geo_blk[1..6]<ri.tract),
							le.census_home_value,ri.home_value);
	SELF.census_education := IF(le.census_education<>'' OR (loose AND le.geo_blk[1..6]<ri.tract),
							le.census_education,ri.education);
	SELF.census_loose := IF(le.census_loose=TRUE AND le.st=ri.stusab, 
							loose, 
							le.census_loose);
	SELF := le;
END;


// No census calculations on relatives, only on principals 
Property_with_census := JOIN(inf(~isrelat), Census_Data.Key_Smart_Jury, 
							keyed(LEFT.st = RIGHT.stusab) and 
							keyed(left.county = right.county) and
							keyed(left.geo_blk[1..6] = right.tract) and 
							keyed(left.geo_blk[7] = right.blkgrp), 
					    get_property_census(LEFT,RIGHT,false), LEFT OUTER, keep(1));

Property_with_census2 := JOIN(Property_with_census, Census_Data.Key_Smart_Jury,
							LEFT.census_loose AND
							keyed(LEFT.st = RIGHT.stusab) and 
							keyed(left.county = right.county) and
							keyed(left.geo_blk[1..4] = right.tract[1..4]), 
						get_property_census(LEFT,RIGHT,true), LEFT OUTER, keep(1));


	
Property_grouped := GROUP(SORT(Property_with_census2 + inf(isrelat), seq), seq);

Single_Property := SORT(Property_grouped,prim_name,prim_range,zip5,sec_range,census_loose, dataSrce);

return single_property;

end;
