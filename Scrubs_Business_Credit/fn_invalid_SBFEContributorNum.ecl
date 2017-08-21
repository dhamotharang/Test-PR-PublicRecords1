EXPORT fn_invalid_SBFEContributorNum(string SBFENum) := function
isInvalidSBFENum := case(SBFENum,
	'0047050111WBS0106' => TRUE,
	false);
return if(isInvalidSBFENum,0,1);
end;
