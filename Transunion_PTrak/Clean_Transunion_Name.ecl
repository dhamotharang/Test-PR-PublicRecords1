IMPORT  address, ut;

EXPORT Clean_Transunion_Name(STRING Full_filedate,STRING Update_filedate) := FUNCTION

norm_names:=  Transunion_PTrak.Normalize_Transunion_Update(Full_filedate,Update_filedate);


namerec := RECORD
   string15 firstname;
   string15 middlename;
   string2 middleinitial;
   string25 lastname;
   string3 suffix;
   string gender;
   string2 dob_mm;
   string2 dob_dd;
   string4 dob_yyyy;
   string deathindicator;
  END;
	
name_layout := record
 NameRec currentname;
Transunion_PTrak.Layout_Transunion_Out.NormCleandNameRec and not [CleanName];
end;


norm_names_filt := project(norm_names(TRIM(Name, LEFT,RIGHT) <> '' AND TRIM(Name, LEFT,RIGHT) <> ',' ), name_layout);

//-----------------------------------------------------------------
//DEDUP Names
//-----------------------------------------------------------------
d_names:= DISTRIBUTE(norm_names_filt, HASH(Name)); 
dedup_names := DEDUP(SORT(d_names,Name,LOCAL),Name, LOCAL) ; 

//-----------------------------------------------------------------
//STANDARDIZE NAMES: clean names
//-----------------------------------------------------------------
Transunion_PTrak.Layout_Transunion_Out.NormCleandNameRec t_CleanName(dedup_names L) := TRANSFORM
	suffix := ['SR', 'JR'];
	mname_temp := if(trim(L.currentname.MIDDLENAME, left, right) = trim(L.currentname.SUFFIX, left, right) or trim(L.currentname.MIDDLENAME, left, right) in suffix, '', L.currentname.MIDDLENAME);
	CleanName1 := address.cleanpersonlfm73(L.Name);
	CleanName2 := if(StringLib.StringCleanSpaces(L.currentname.LASTNAME+', '+L.currentname.FIRSTNAME+' '+ mname_temp +' '+ L.currentname.SUFFIX) = L.Name, 
						address.cleanpersonfml73(L.currentname.FIRSTNAME+ ' '+ mname_temp + ' ' + L.currentname.LASTNAME + ' ' + L.currentname.SUFFIX), 
						address.cleanperson73(L.Name));
	CleanName3 := address.cleanpersonlfm73(StringLib.StringFindReplace(L.Name, ',', ' '));
	CleanName4 := address.cleanperson73(StringLib.StringFindReplace(L.Name, ',', ' '));
	self.CleanName := map((unsigned1)CleanName1[71..73] > 0  => CleanName1, 
				     (unsigned1)CleanName2[71..73] > 0  => CleanName2,      
					 (unsigned1)CleanName3[71..73] > 0  => CleanName3,
					 (unsigned1)CleanName4[71..73] > 0 and trim(CleanName4[46..65], all) not in suffix  => CleanName4,
					 CleanName1);
	SELF := L;	
END;

name_clean := PROJECT(dedup_names, t_CleanName(LEFT)):persist('~thor_data400::persist::transunionptrak_clean_names'); 

return name_clean;

END;