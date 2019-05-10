import liensv2;
export Convert_Liens_Party_Func := function 
	

ds :=  dedup(sort(dataset('~thor_data400::base::override::fcra::qa::liensv2_party',FCRA.Layout_Override_Liens_Party_In,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt),tmsid,rmsid,-flag_file_id),except flag_file_id,keep(1));

FCRA.Layout_Override_Liensv2_party proj_func(ds l) := transform
	self := l;
end;	

proj_out := project(ds,proj_func(left));

return proj_out;

end;