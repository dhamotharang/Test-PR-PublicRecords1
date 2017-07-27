len(STRING inputvalue) := MIN(39,LENGTH(TRIM(inputvalue)));


export is_CNameIndicMatch(string keyfield, string inputvalue) := 
keyfield[1..len(inputvalue)+1] in [inputvalue[1..len(inputvalue)+1],inputvalue[1..len(inputvalue)]+' '];