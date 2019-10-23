import std,ut;

thecurrentdate  := ut.getdate;       //20130822
monthago        := 'W' + ut.date_math(thecurrentdate,-30) + '-000001';
monthahead      := 'W' + ut.date_math(thecurrentdate, 30) + '-000001';

EXPORT get_FilesRead_Multiple(

   string pLowWuid      = monthago
  ,string pHighWuid     = monthahead
  ,string pFilterFiles  = ''
  ,string pState        = 'running'
  
) :=
function

  drunningwuids := global(nothor(WorkMan.get_Running_Workunits(pLowWuid,pHighWuid,pState)));
  
  WsFileRead := RECORD
  STRING name{MAXLENGTH(256)};
  STRING cluster{MAXLENGTH(64)};
  BOOLEAN isSuper;
  UNSIGNED4 usage;
  END;
  
  dproj  := nothor(project(global(drunningwuids,few),transform({string wuid,string job,string state,dataset(WsFileRead) filesread},self.filesread := STD.System.Workunit.WorkunitFilesRead (trim(left.wuid,all)),self := left)));
  dnorm  := normalize(dproj,left.filesread,transform({string wuid,string job,string state,WsFileRead},self.isSuper := true,self := right,self := left));
  dproj2 := nothor(project(global(dnorm,few),transform(recordof(left),self.isSuper := std.file.superfileexists('~' + trim(left.name,left,right)),self := left)));
  dproj3 := project(dproj2,transform(recordof(left),self.job := WorkMan.get_Jobname(trim(left.wuid,all)),self := left));
  dfilt  := dproj3(pFilterFiles = '' or regexfind(pFilterFiles,name,nocase));
  return dfilt;
  // return sequential(
     // output(drunningwuids  ,named('drunningwuids'))
    // ,output(dproj  ,named('dproj'))
    // ,output(dnorm  ,named('dnorm'))
    // ,output(dfilt  ,named('dfilt'))
  // );
end;