import census_data;

first_data.layout_fatrec t_get_census(first_data.layout_fatrec l, census_data.Layout_Smart_Jury r) := transform
 self.census_age    := r.age;
 self.census_income := r.income;
 self               := l;
end;

export Get_Census := join(first_data.Join_to_Address_Indicators,census_data.File_Smart_Jury,
                          (left.geo_blk=right.tract+right.blkgrp),
		                  t_get_census(left,right),
		                  left outer, lookup
		                 );