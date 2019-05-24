/*
This function removes leading zero's from number strings ('0006736526709') or alphanumeric strings ('000DFSFfs0234s3').
The ut.rmv_ld_zeros version only handled number strings.
This version has been tested to be more efficient than a simple regex - REGEXREPLACE('^0+(?!$)' ,alpha_num_str,'');
The platform is currenlty expanding the TRIM function to handle any char after which we will be able to depricate 
this function as well as ut.rmv_ld_zeros and possibly many others.
https://track.hpccsystems.com/browse/HPCC-22152
*/
IMPORT STD;
export string rmv_ld_0_alp_num (string s) := Function
  InLen := LENGTH(s);
  Zero2Space := STD.Str.SubstituteIncluded(s,'0',' ');
  TrimLen := LENGTH(TRIM(Zero2Space,LEFT));
  ZeroLen := InLen-TrimLen;
  RETURN IF(ZeroLen=0,s,s[ZeroLen+1 ..]); 
End;