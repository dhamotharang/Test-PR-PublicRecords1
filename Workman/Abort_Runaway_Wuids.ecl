import std,ut;

thecurrentdate  := ut.getdate;       //20130822
monthago        := 'W' + ut.date_math(thecurrentdate,-30) + '-000001';
monthahead      := 'W' + ut.date_math(thecurrentdate, 30) + '-000001';

EXPORT Abort_Runaway_Wuids(

   string   pLowWuid    = monthago
  ,string   pHighWuid   = monthahead
  ,string   pState      = 'running'
  ,string   pOwner      = STD.System.Job.User ( ) //defaults to your workunits
  ,boolean  pProtected  = false
  ,string   pJobRegex   = ''
  ,boolean  pIsTesting  = true                    //true = output workunits matched, false = do the abort on those wuids
  ,string   pesp        = _Config.LocalEsp


) :=
function

  // WorkMan.UnProtect_Wuid('');

  // mywuids := WorkMan.get_Running_Workunits('W20080111-111018','W20141231-111018','')(protected = true,owner = 'lbentley_prod',not regexfind('stat|dashboard|sample|segment',job,nocase));
  mywuids := WorkMan.get_Running_Workunits(pLowWuid,pHighWuid,'')(
     protected = pProtected
    ,pOwner    = '' or regexfind(pOwner   ,owner,nocase)
    ,pState    = '' or regexfind(pState   ,state,nocase)
    ,pJobRegex = '' or regexfind(pJobRegex,job  ,nocase)  
  );
  // mywuids := WorkMan.get_Running_Workunits('W20150313-090118','W20151231-111018','')(owner = 'lbentley_prod',regexfind('running|wait|compiling',state,nocase),wuid != workunit);

  return sequential(
    output(mywuids,all)
   ,iff(pIsTesting = false
      ,apply(mywuids ,output(WorkMan.Abort_Workunit(wuid),named('AbortWuids'),extend))
   )
  );
  
end;