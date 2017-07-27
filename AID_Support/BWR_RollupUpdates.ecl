/*********************************************************************
**  Intended for submissions via builder window, into scheduler
*********************************************************************/
import AID_Support, lib_StringLib, lib_WorkunitServices;

gWhichCache				:=	AID_Support.Constants.eCache.ForHeader;

#if(gWhichCache = AID_Support.Constants.eCache.ForHeader)
	#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForHeader);
	lJobName				:=	AID_Support.Constants.JobName.RollupUpdates;			// This is used in WU search below to confirm only instance
#elseif(gWhichCache = AID_Support.Constants.eCache.ForNonHeader)
	#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
	lJobName				:=	AID_Support.Constants.NonHeaderPrefix + AID_Support.Constants.JobName.RollupUpdates;			// This is used in WU search below to confirm only instance
#else
	FAIL('Which "gWhichCache" value are you using?');
#end

#workunit('name', lJobName);
#workunit('protect' ,true);

zGo	:=	if(AID_Support.Common.fIsJobActive(lJobName),
					 fail('Abort:  Another workunit with name "' + lJobName + '" is already active.'),
					 if(not AID_Support.Common.fValidEnvironment(),
							fail('Abort:  This Dali/Environment is not recognized.  See AID_Support ECL.'),
							AID_Support.ProcRollupUpdates
						 )
					);

#if(gWhichCache = AID_Support.Constants.eCache.ForHeader)
	zGo : when(cron(AID_Support.Constants.CronTrigger.RollupUpdates));
	zGo : when(event(AID_Support.Constants.EventTrigger.RollupUpdates, '*'));
#elseif(gWhichCache = AID_Support.Constants.eCache.ForNonHeader)
	zGo : when(cron(AID_Support.Constants.CronTrigger.RollupUpdates));
	zGo : when(event(AID_Support.Constants.NonHeaderPrefix + AID_Support.Constants.EventTrigger.RollupUpdates, '*'));
#else
	FAIL('Which "gWhichCache" value are you using?');
#end
