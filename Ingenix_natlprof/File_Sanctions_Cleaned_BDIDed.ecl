layout_in3 := record
string12 bdid;
Ingenix_NatlProf.Layout_in_Cleaned_Sanctions;
end;	

export File_Sanctions_Cleaned_BDIDed := dataset('~thor_data400::base::Ingenix_Cleaned_Sanctions_BDID',layout_in3,flat);