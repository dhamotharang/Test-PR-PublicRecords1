Import PromoteSupers,prte2,std,AID,Address,ut,std,UT, Address, AID, AID_Support;
EXPORT PROC_BUILD_BASE:=Function
 
PromoteSupers.MAC_SF_BuildProcess(files.LaborActions_IN,constants.Base_PersonContext, PersonContextBase);

sequential(PersonContextBase);

Return 'Success';
 End;
 