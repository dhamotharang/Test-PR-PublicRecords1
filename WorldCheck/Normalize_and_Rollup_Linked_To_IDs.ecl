export Normalize_and_Rollup_Linked_To_IDs (string filedate) := function

in_file := WorldCheck.File_WorldCheck_In;

// Shared parsing patterns for most
pattern SingleValue   := pattern('[^;]+');

// Invalid values which should be skipped
Invalid_Values        := [''             ,','
													,'NONE'         ,'N/A'
													,'NOT AVAILABLE','UNAVAILABLE'
													,'UNKNOWN'      ,'NONE REPORTED'];

layout_Linked_To_IDs     := WorldCheck.Layout_WorldCheck_Cleaned.layout_Linked_To_IDs;

Layout_WorldCheck_temp   := record, maxlength(500)
    string    UID;
		string255 Category;
    string50  Linked_To         := ''; // Normalized for child dataset
end;

Layout_WorldCheck_rollup := record
    string  UID;
end;

MyParsedRecord := record,maxlength(10000)
	in_file;
	string CompleteValue := TRIM(MATCHTEXT(SingleValue),left,right);
end;

/* Parse the Linked To values */
MyParsedLinked_Tosds := PARSE(in_file,Linked_Tos,SingleValue,MyParsedRecord,scan,first);

/* Transform the Linked To values while specifying the invalid Linked To values */
Layout_WorldCheck_temp trfLinked_To(MyParsedLinked_Tosds l) := transform
	self.Linked_To := IF(stringlib.StringToUpperCase(TRIM(l.CompleteValue,left,right)) in Invalid_Values
												,SKIP
												,TRIM(l.CompleteValue,left,right));
	self := l;	
end;

/* Normalize the Linked To values */
ds_NormLinked_Tos := NORMALIZE(MyParsedLinked_Tosds
																,1
																,trfLinked_To(left))(trim(linked_to, left, right)<>'');

WorldCheck.Out_Linked_To_Stats_Population(ds_NormLinked_Tos
                                          ,filedate
																					,do_STRATA);
do_STRATA;

count_ds_Linked_Tos := count(ds_NormLinked_Tos);
output('Linked To count: ' + count_ds_Linked_Tos);

ds_NormLinked_Tos_sorted := sort(ds_NormLinked_Tos,UID);
// output(ds_NormLinked_Tos_sorted);

ds_filter := ds_NormLinked_Tos_sorted(regexfind('[A-Z]+|'+'[a-z]+',linked_to,0)='');

Layout_WorldCheck_temp CompP(ds_filter l, in_file r) := TRANSFORM
	self.Linked_To := if(TRIM(r.first_name,left,right)='',
												StringLib.StringToUpperCase(TRIM(r.last_name,left,right)),
												StringLib.StringToUpperCase(TRIM(r.last_name,left,right)+', '+TRIM(r.first_name,left,right))
												);
	SELF 						:= l;
END;

NormLinked := JOIN(sort(distribute(ds_filter, hash(linked_to)), linked_to, local),
                   sort(distribute(in_file, hash(uid)), uid, local),
										LEFT.Linked_To = RIGHT.UID,
										CompP(LEFT,RIGHT),
										LEFT OUTER, NOSORT, LOCAL);

ds_filter_2 := ds_NormLinked_Tos_sorted(regexfind('[A-Z]+|'+'[a-z]+',linked_to,0)<>'');

ds_normcompanies_concat := NormLinked + ds_filter_2;

/* Rollup of Linked to IDs ////////*/
Linked_To_rollup := record,maxlength(30900)
	Layout_WorldCheck_rollup;
	dataset(layout_Linked_To_IDs) Linked_To_detail;
end;

Linked_To_rollup t_Linked_To(ds_normcompanies_concat L) := transform
	self.Linked_To_detail := row(L,WorldCheck.Layout_WorldCheck_Cleaned.layout_Linked_To_IDs);
	self := L;
end;

p_Linked_To := project(ds_normcompanies_concat, t_Linked_To(left));

Linked_To_rollup  t_Linked_To_child(p_Linked_To L, p_Linked_To R) := transform
	self.Linked_To_detail := L.Linked_To_detail + row({r.Linked_To_detail[1].Linked_To}
														,WorldCheck.Layout_WorldCheck_Cleaned.layout_Linked_To_IDs);
	self                  := L;
end;

Linked_To_out := rollup(sort(p_Linked_To,record)
														 ,t_Linked_To_child(left,right)
														 ,uid);	
														 
count_ds_Linked_Tos_rollup := count(Linked_To_out);
output('Linked To rollup count: ' + count_ds_Linked_Tos_rollup);
// output(Linked_To_out);

Linked_To_out_dist := sort(distribute(Linked_To_out, hash32(UID)), uid, local) : persist(WorldCheck.cluster_name + 'Persist::WorldCheck::Linked_To::rollup');

return Linked_To_out_dist;

end;