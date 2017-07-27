import WorldCheck;

export Normalize_and_Rollup_Keywords (string filedate) := function

in_file := WorldCheck.File_WorldCheck_In;

// Shared parsing pieces for keywords
pattern SingleKeyword := pattern('[^~]+');

// Invalid values which should be skipped
Invalid_Values        := [''             ,','
						 ,'NONE'         ,'N/A'
						 ,'NOT AVAILABLE','UNAVAILABLE'
						 ,'UNKNOWN'      ,'NONE REPORTED'];

layout_Keywords      := WorldCheck.Layout_WorldCheck_Cleaned.layout_Keywords;
Layout_WorldCheck_temp   := record, maxlength(300)
    string    UID;
	string255 Category;
	string30  Keyword := ''; // Normalized for child dataset
end;
Layout_WorldCheck_rollup := record
    string  UID;
end;

MyParsedKeyRecord := record
	in_file;
	string CompleteKeyword := TRIM(MATCHTEXT(SingleKeyword),left,right);
end;

/* Parse the Keyword values */
MyParsedKeywordsds := PARSE(in_file,Keywords,SingleKeyword,MyParsedKeyRecord,scan,first);
/* Transform the Keyword values while specifying the invalid Keyword values */
Layout_WorldCheck_temp trfKeyword(MyParsedKeywordsds l) := transform
	self.Keyword := IF(stringlib.StringToUpperCase(TRIM(l.CompleteKeyword,left,right)) in Invalid_Values
							 ,SKIP
							 ,TRIM(l.CompleteKeyword,left,right));
	self := l;
end;
/* Normalize the Keyword values */
ds_NormKeywords := NORMALIZE(MyParsedKeywordsds
						,1
						,trfKeyword(left));
/* Join with the keyword lookup table */
keyword_lookup := WorldCheck.File_WorldCheck_Keywords;

Layout_Keyword_temp := record
   Layout_WorldCheck_temp;
   string150 Source_Name       := '';
   string30  Authority_Country := '';
end;

Layout_Keyword_temp keyword_details_added(ds_NormKeywords L
                                            ,keyword_lookup  R) := TRANSFORM
   self.Source_Name       := R.Source_Full_Name;
   self.Authority_Country := R.Authority_Country;
   self                   := L;
end;

j_Keyword := JOIN(ds_NormKeywords
                 ,keyword_lookup
			     ,left.Keyword = right.Keyword
			     ,keyword_details_added(left,right)
			     ,LEFT OUTER
			     ,LOOKUP);

WorldCheck.Out_Keywords_Stats_Population(j_Keyword
                                        ,filedate
										,do_STRATA);
do_STRATA;

count_ds_Keywords_with_extra := count(j_Keyword);
output('Keyword plus count: ' + count_ds_Keywords_with_extra);
ds_NormKeywords_sorted := sort(j_Keyword,UID);

/* Rollup of Places of Birth////////*/
Keyword_rollup := record, maxlength(10000)
	Layout_WorldCheck_rollup;
	dataset(layout_Keywords) Keyword_detail;
end;

Keyword_rollup t_Keyword(ds_NormKeywords_sorted L) := transform
	self.Keyword_detail := row(L,WorldCheck.Layout_WorldCheck_Cleaned.layout_Keywords);
	self := L;
end;

p_Keyword := project(ds_NormKeywords_sorted, t_Keyword(left));

Keyword_rollup  t_Keyword_child(p_Keyword L, p_Keyword R) := transform
	self.Keyword_detail       := L.Keyword_detail + row({r.Keyword_detail[1].Keyword
														,r.Keyword_detail[1].Source_name
														,r.Keyword_detail[1].Authority_Country}
											   ,WorldCheck.Layout_WorldCheck_Cleaned.layout_Keywords);
	self                  := L;
end;

Keyword_out := rollup(sort(p_Keyword,record)
				 ,t_Keyword_child(left,right)
				 ,uid);	
count_ds_Keywords_rollup := count(Keyword_out);
output('Keyword rollup count: ' + count_ds_Keywords_rollup);

Keyword_out_dist := distribute(Keyword_out,hash32(UID)) : persist(WorldCheck.cluster_name + 'Persist::WorldCheck::Keyword::rollup');

return Keyword_out_dist;

end;