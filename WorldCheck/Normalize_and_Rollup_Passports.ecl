export Normalize_and_Rollup_Passports (string filedate) := function

in_file := WorldCheck.File_WorldCheck_In;

// Shared parsing patterns for most
pattern SingleValue   := pattern('[^;]+');

// Invalid values which should be skipped
Invalid_Values        := [''             ,','
						 ,'NONE'         ,'N/A'
						 ,'NOT AVAILABLE','UNAVAILABLE'
						 ,'UNKNOWN'      ,'NONE REPORTED'];

layout_Passports     := WorldCheck.Layout_WorldCheck_Cleaned.layout_Passports;
Layout_WorldCheck_temp   := record
    string    UID;
	string255 Category;
    string50  Passport := ''; // Normalized for child dataset
end;
Layout_WorldCheck_rollup := record
    string  UID;
end;

MyParsedRecord := record, maxlength(10000)
	in_file;
	string CompleteValue := TRIM(MATCHTEXT(SingleValue),left,right);
end;

/* Parse the Passport values */
MyParsedPassportsds := PARSE(in_file,Passports,SingleValue,MyParsedRecord,scan,first);
/* Transform the Passport values while specifying the invalid Passport values */
Layout_WorldCheck_temp trfPassport(MyParsedPassportsds l) := transform
	self.Passport := IF(stringlib.StringToUpperCase(TRIM(l.CompleteValue,left,right)) in Invalid_Values
							 ,SKIP
							 ,TRIM(l.CompleteValue,left,right));
	self := l;
end;
/* Normalize the Passport values */
ds_NormPassports := NORMALIZE(MyParsedPassportsds
						,1
						,trfPassport(left));

WorldCheck.Out_Passports_Stats_Population(ds_NormPassports
                                         ,filedate
									     ,do_STRATA)
do_STRATA;

count_ds_Passports := count(ds_NormPassports);
output('Passport count: ' + count_ds_Passports);
ds_NormPassports_sorted := sort(ds_NormPassports,UID);

/* Rollup of Places of Birth */
Passport_rollup := record, maxlength(10000)
	Layout_WorldCheck_rollup;
	dataset(layout_Passports) Passport_detail;
end;

Passport_rollup t_Passport(ds_NormPassports_sorted L) := transform
	self.Passport_detail := row(L,WorldCheck.Layout_WorldCheck_Cleaned.layout_Passports);
	self := L;
end;

p_Passport := project(ds_NormPassports_sorted, t_Passport(left));

Passport_rollup  t_Passport_child(p_Passport L, p_Passport R) := transform
	self.Passport_detail       := L.Passport_detail + row({r.Passport_detail[1].Passport}
											   ,WorldCheck.Layout_WorldCheck_Cleaned.layout_Passports);
	self                  := L;
end;

Passport_out := rollup(sort(p_Passport,record)
				 ,t_Passport_child(left,right)
				 ,uid);	
count_ds_Passports_rollup := count(Passport_out);
output('Passport rollup count: ' + count_ds_Passports_rollup);

Passport_out_dist := distribute(Passport_out,hash32(UID)) : persist(WorldCheck.cluster_name + 'Persist::WorldCheck::Passport::rollup');

return Passport_out_dist;

end;
