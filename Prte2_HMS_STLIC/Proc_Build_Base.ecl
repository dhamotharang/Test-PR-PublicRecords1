Import Prte2,UT, PromoteSupers, std, Prte2, PRTE2_Corp, Address, AID, AID_Support;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION


d_HMS:=Project(files.HMS_in,Layouts.HMS_Base_Layout);

PRTE2.CleanFields(d_hms, d_hms_clean);

 PromoteSupers.MAC_SF_BuildProcess(d_hms_clean,constants.HMS_Base, writefile_base,,,,filedate);

RETURN writefile_base;

End;