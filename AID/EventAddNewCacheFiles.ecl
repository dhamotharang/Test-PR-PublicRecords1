/*********************************************************************
**  Intended for submissions via builder window, into scheduler
*********************************************************************/
import AID, lib_WorkunitServices;

lWorkunitName		:=	AID.Common.eEvents.NewCacheFiles;			// This is used in WU search below to confirm only instance
lWorkunitStates	:=	['RUNNING','WAIT'];
#workunit('name',lWorkunitName);

boolean	fIsNoOtherActiveSameJob
 :=
	function
		dOtherWorkunits				:=	lib_WorkunitServices.WorkunitServices.WorkUnitList('','','','',lWorkunitName);
		dOtherWorkunitsActive	:=	dOtherWorkunits(wuid <> workunit and (qstring)state in lWorkunitStates);
		return	count(dOtherWorkunitsActive) = 0;
	end
 ;

if(not fIsNoOtherActiveSameJob,
	 fail('Abort:  Another workunit with name "' + lWorkunitName + '" is already active.'),
	 AID.ProcAddNewCacheFiles
  ) : when(event(AID.Common.eEvents.NewCacheFiles,'*'));
