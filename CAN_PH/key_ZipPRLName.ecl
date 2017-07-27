import CanadianPhones_v2,CanadianPhones,doxie;

export key_ZipPRLName(boolean isV2 = false) := function 
//boolean isV2 := stored('isCP_V2') : false ;

name_prefix := if (isV2, CanadianPhones_v2.Constants.FILE_NAME_MASK_QA, CanadianPhones.Constants.FILE_NAME_MASK_QA);

ds := DATASET([], CanadianPhones.layouts.zipPRLname);

i:= 
	if(
		stringlib.stringfind (trim(name_prefix),'::qa::',1) > 0,
    INDEX(d, {ds}, TRIM(t)+'ZipPRLname'), 
		INDEX(d, {ds}, TRIM(t)+'ZipPRLname' + '_' + doxie.Version_SuperKey)
	);

return i;
end;
//export key_ZipPRLName := 