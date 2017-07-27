/*********************************************************************
**  Intended for submissions via builder window, into scheduler
*********************************************************************/
import AID_Support, lib_StringLib, lib_WorkunitServices, Std;

gWhichCache				:=	AID_Support.Constants.eCache.ForHeader;

#if(gWhichCache = AID_Support.Constants.eCache.ForHeader)
	#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForHeader);
	lJobName				:=	AID_Support.Constants.JobName.CacheConsolidate;			// This is used in WU search below to confirm only instance
#elseif(gWhichCache = AID_Support.Constants.eCache.ForNonHeader)
	#constant(AID_Support.Constants.StoredWhichAIDCache, AID_Support.Constants.eCache.ForNonHeader);
	lJobName				:=	AID_Support.Constants.NonHeaderPrefix + AID_Support.Constants.JobName.CacheConsolidate;			// This is used in WU search below to confirm only instance
#else
	FAIL('Which "gWhichCache" value are you using?');
#end

#workunit('name', lJobName);
#workunit('protect' ,true);

lAddNewCacheFilesRunningName		:=	'dAddNewCacheFilesWorkunits';
zOutputAddNewCacheFilesRunning	:=	output(nothor(lib_WorkunitServices.WorkunitServices.WorkUnitList('', '', '', '', AID_Support.Constants.JobName.AddNewCacheFiles))(lib_StringLib.StringLib.StringToUpperCase(state) = AID_Support.Constants.WorkunitState.RunningState), all, named(lAddNewCacheFilesRunningName), overwrite);
dAddNewCacheFilesRunning				:=	sort(dataset(workunit(lAddNewCacheFilesRunningName), recordof(lib_WorkunitServices.WsWorkunitRecord)), -WUID);
lIsAddNewCacheFilesRunning			:=	count(dAddNewCacheFilesRunning) <> 0;
zSleepAndCheckRunningAgain			:=	sequential(Std.System.Debug.Sleep(30000),
																								zOutputAddNewCacheFilesRunning
																							 );
zCheckAddNewCacheFilesRunning		:=	if(lIsAddNewCacheFilesRunning, FAIL('AddNewCacheFiles workunit is running.'), OUTPUT('Okay, go.')) : RECOVERY(zSleepAndCheckRunningAgain, 20);

zGo	:=	if(AID_Support.Common.fIsJobActive(lJobName),
					 fail('Abort:  Another workunit with name "' + lJobName + '" is already active.'),
					 if(not AID_Support.Common.fValidEnvironment(),
							fail('Abort:  This Dali/Environment is not recognized.  See AID_Support ECL.'),
						  sequential(zOutputAddNewCacheFilesRunning,
													zCheckAddNewCacheFilesRunning,
													AID_Support.ProcCacheConsolidate
												 )
						 )
					);

#if(gWhichCache = AID_Support.Constants.eCache.ForHeader)
	// zGo : when(cron(AID_Support.Constants.CronTrigger.CacheConsolidate));
	zGo : when(event(AID_Support.Constants.EventTrigger.CacheConsolidate, '*'));
#elseif(gWhichCache = AID_Support.Constants.eCache.ForNonHeader)
	// zGo : when(cron(AID_Support.Constants.CronTrigger.CacheConsolidate));
	zGo : when(event(AID_Support.Constants.NonHeaderPrefix + AID_Support.Constants.EventTrigger.CacheConsolidate, '*'));
#else
	FAIL('Which "gWhichCache" value are you using?');
#end
