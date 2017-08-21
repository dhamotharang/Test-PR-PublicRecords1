export Normalize_and_Rollup_POBs (string filedate) := function

in_f 	:= WorldCheck.File_WorldCheck_In;

in_file	:= distribute(in_f, random());

// Shared parsing patterns for most
pattern SingleValue   := pattern('[^;]+');

// Invalid values which should be skipped
Invalid_Values        := [''             ,','
						 ,'NONE'         ,'N/A'
						 ,'NOT AVAILABLE','UNAVAILABLE'
						 ,'UNKNOWN'      ,'NONE REPORTED'];

layout_POB               := WorldCheck.Layout_WorldCheck_Cleaned.layout_POB;
Layout_WorldCheck_temp   := record,maxlength(10000)
    string    UID;
	string255 Category;
    string70  Place_Of_Birth := ''; // Normalized for child dataset
end;
Layout_WorldCheck_rollup := record,maxlength(10000)
    string  UID;
end;

MyParsedRecord := record, maxlength(10000)
	in_file;
	string CompleteValue := TRIM(MATCHTEXT(SingleValue),left,right);
end;

/* Parse the POB values	*/
MyParsedPOBds := PARSE(in_file,Places_of_Birth,SingleValue,MyParsedRecord,scan,first);
/* Transform the POB values while specifying the invalid POB values */
Layout_WorldCheck_temp trfPOB(MyParsedPOBDS l) := transform
	self.Place_Of_Birth := IF(stringlib.StringToUpperCase(TRIM(l.CompleteValue,left,right)) in Invalid_Values
							 ,SKIP
							 ,TRIM(l.CompleteValue,left,right));
	self := l;
end;
/* Normalize the POB values */
ds_NormPOBs := NORMALIZE(MyParsedPOBDS
						,1
						,trfPOB(left));

WorldCheck.Out_POBs_Stats_Population(ds_NormPOBs
                                    ,filedate
									,do_STRATA);
do_STRATA;

count_ds_POBs := count(ds_NormPOBs);
output('Place of Birth count: ' + count_ds_POBs);
ds_NormPOBs_sorted := sort(ds_NormPOBs,UID);

/* Rollup of Places of Birth////////*/
POB_rollup := record
	Layout_WorldCheck_rollup;
	dataset(layout_POB) POB_detail;
end;

POB_rollup t_POB(ds_NormPOBs_sorted L) := transform
	self.POB_detail := row(L,WorldCheck.Layout_WorldCheck_Cleaned.layout_POB);
	self := L;
end;

p_POB := project(ds_NormPOBs_sorted, t_POB(left));

POB_rollup  t_POB_child(p_POB L, p_POB R) := transform
	self.POB_detail       := L.POB_detail + row({r.POB_detail[1].Place_Of_Birth}
											   ,WorldCheck.Layout_WorldCheck_Cleaned.layout_POB);
	self                  := L;
end;

POB_out := rollup(sort(p_POB,record)
				 ,t_POB_child(left,right)
				 ,uid);	
count_ds_POBs_rollup := count(POB_out);
output('Place of Birth rollup count: ' + count_ds_POBs_rollup);

POB_out_dist := sort(distribute(POB_out,hash32(UID)), uid, local) : persist(WorldCheck.cluster_name + 'Persist::WorldCheck::POB::rollup');

return POB_out_dist;

end;