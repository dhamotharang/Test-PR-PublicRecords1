file_in := Fictitious_Business_Names.File_Out_AllFlat(date_last_updated!='');
dist_file_in := distribute(file_in,hash(InfoUSA_FBN_key));
sort_file_in := sort(dist_file_in,InfoUSA_FBN_key,date_last_updated,local);

Fictitious_Business_Names.Layout_In_InfoUSA_Flat xform(Fictitious_Business_Names.Layout_In_InfoUSA_Flat l,Fictitious_Business_Names.Layout_In_InfoUSA_Flat r) := transform
self.date_first_updated_app := if(l.date_last_updated<=r.date_last_updated,l.date_last_updated,r.date_last_updated);
self.date_last_updated_app := if(l.date_last_updated>=r.date_last_updated,l.date_last_updated,r.date_last_updated);
self := l;
end;

export File_Out_AllFlat_Rollup := rollup(sort_file_in,xform(left,right),
																				 record, except date_last_updated,lni,minrev,src,f,local):persist('thor_data400::persist::File_flat_rollup');