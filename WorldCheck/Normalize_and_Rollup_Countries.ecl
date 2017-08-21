export Normalize_and_Rollup_Countries (string filedate) := function

in_f 		:= WorldCheck.File_WorldCheck_In;

in_file 	:= distribute(in_f, random());

// Shared parsing patterns for most
pattern SingleValue   := pattern('[^;]+');

// Invalid values which should be skipped
Invalid_Values        := [''             ,','
						 ,'NONE'         ,'N/A'
						 ,'NOT AVAILABLE','UNAVAILABLE'
						 ,'UNKNOWN'      ,'NONE REPORTED'];

layout_Countries := WorldCheck.Layout_WorldCheck_Cleaned.layout_Countries;
Layout_WorldCheck_temp := record
    string    UID;
	string255 Category;
    string50  Country := ''; // Normalized for child dataset
end;
Layout_WorldCheck_rollup := record
    string  UID;
end;

MyParsedRecord := record, maxlength(10000)
	in_file;
	string CompleteValue := TRIM(MATCHTEXT(SingleValue),left,right);
end;

/* Parse the Country values	*/
MyParsedCountriesds := PARSE(in_file,Countries,SingleValue,MyParsedRecord,scan,first);
/* Transform the Country values while specifying the invalid Country values */
Layout_WorldCheck_temp trfCountry(MyParsedCountriesds l) := transform
	self.Country := IF(stringlib.StringToUpperCase(TRIM(l.CompleteValue,left,right)) in Invalid_Values
							 ,SKIP
							 ,TRIM(l.CompleteValue,left,right));
	self := l;
end;
/* Normalize the Country values */
ds_NormCountries := NORMALIZE(MyParsedCountriesds
						,1
						,trfCountry(left));

WorldCheck.Out_Countries_Stats_Population(ds_NormCountries
                                         ,filedate
										 ,do_STRATA);
do_STRATA;

count_ds_Countries := count(ds_NormCountries);
output('Country count: ' + count_ds_Countries);
ds_NormCountries_sorted := sort(ds_NormCountries,UID);

/* Rollup of Places of Birth////////*/
Country_rollup := record, maxlength(10000)
	Layout_WorldCheck_rollup;
	dataset(layout_Countries) Country_detail;
end;

Country_rollup t_Country(ds_NormCountries_sorted L) := transform
	self.Country_detail := row(L,WorldCheck.Layout_WorldCheck_Cleaned.layout_Countries);
	self := L;
end;

p_Country := project(ds_NormCountries_sorted, t_Country(left));

Country_rollup  t_Country_child(p_Country L, p_Country R) := transform
	self.Country_detail       := L.Country_detail + row({r.Country_detail[1].Country}
											   ,WorldCheck.Layout_WorldCheck_Cleaned.layout_Countries);
	self                  := L;
end;

Country_out := rollup(sort(p_Country,record)
				 ,t_Country_child(left,right)
				 ,uid);	
count_ds_Countries_rollup := count(Country_out);
output('Country rollup count: ' + count_ds_Countries_rollup);

Country_out_dist := sort(distribute(Country_out, hash32(UID)), uid, local) : persist(WorldCheck.cluster_name + 'Persist::WorldCheck::Country::rollup');

return Country_out_dist;

end;