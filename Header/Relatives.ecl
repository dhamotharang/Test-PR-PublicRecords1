/*					Relatives
==============================================================	
Generate did pairs based on same address, ssn, business	associate, 
	property, and vehicle, and being relative of the same 3rd person. 
Split the original address logic to Header.Relatives_By_Address, to avoid 
	repeating the big self join upon changes of other relative conditions.
*/

import business_header,mdr;

export Relatives := module

shared h := (header.File_Headers + Header.File_Transunion_did + Header.file_TUCS_did + Header.File_TN_did)(mdr.sourceTools.SourceIsOnProbation(src)=false);
shared oldr	:= header.File_Relatives_v3;

newr := header.fn_Relatives(h, oldr, IncludeOutsideMatches := true);

export Relatives1 := newr;//for roxie key

end;