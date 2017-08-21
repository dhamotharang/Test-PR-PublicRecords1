import STD;

EXPORT PreprocessDeletes(dataset(layout_Neustar) deletes) := function

	ds := PROJECT(deletes, TRANSFORM(layout_gongMaster,
						self.filedate := ExtractDate(Left.filename);
						self.deletion_date := REGEXFIND('(\\d{8})\\.txt', left.filename, 1);
						
						self.name_first := ToUpper(left.first_name);
						self.name_middle := ToUpper(left.middle_name);
						self.name_last := ToUpper(left.last_name);
						self.name_suffix := ToUpper(left.suffix_name);
						self.company_name := ToUpper(left.business_name);
						self.phone10 := left.telephone;
						// address data
						self.prim_range := ToUpper(left.PRIMARY_STREET_NUMBER);
						self.prim_name := ToUpper(left.primary_street_name);
						self.suffix := ToUpper(left.primary_street_suffix);
						self.v_city_name := ToUpper(left.city);
						self.st := ToUpper(left.state);
						self := LEFT;
				));

	return ds;
end;