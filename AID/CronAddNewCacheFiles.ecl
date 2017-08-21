/*********************************************************************
**  Intended for submissions via builder window, into scheduler
*********************************************************************/

#warning('Deprecated:  See AID.EventAddNewCacheFiles instead');

import AID, lib_WorkunitServices;

lWorkunitName		:=	'AIDWork: CRON - Add New Cache Files';		// This is used in WU search to confirm only one instance
lWorkunitStates	:=	['RUNNING','WAIT'];
lCRONString			:=	'0-59/4 * * * *';							// 0-59/4 means every 4 minutes
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
	 fail('Abort:  Another workunit with "' + lWorkunitName + '" is active.'),
	 AID.ProcAddNewCacheFiles
  ) : when(cron(lCRONString));

