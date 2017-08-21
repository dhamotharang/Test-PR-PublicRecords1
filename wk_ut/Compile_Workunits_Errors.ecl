import std;

EXPORT Compile_Workunits_Errors(

   string pLowWuid
  ,string pHighWuid
  ,string pJobname
  ,string pversion
  ,string pOwner    = ''
  ,string pCluster  = ''

) :=
function

  dgetwuidlist := global(nothor(STD.System.Workunit.WorkunitList (
   pLowWuid      
  ,pHighWuid             
  ,pOwner       
  ,pCluster   
  ,pJobname        
  ,//pState      
  ,//pPriority  
  ,//pFileread  
  ,//pFilewritten   
  ,//pRoxiecluster  
  ,//pEclcontains   
  ,//pOnline        
  ,//pArchived      
  )),few)(wuid != '');      
  
  //do up to 20 for now
  dchildwuids := nothor(global(project(dgetwuidlist,transform({dataset(wk_ut.layouts.wks_slim) children}
    ,self.children := if(regexfind('rows',wk_ut.get_Scalar_Result(left.wuid,'Workunits'),nocase),wk_ut.get_DS_Result(left.wuid,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim));  
  )),few));
  
  dparentwuids := nothor(global(project(dgetwuidlist,transform({dataset(wk_ut.layouts.wks_slim) children}
    ,self.children := wk_ut.get_Workunits_ds(left.wuid,pversion,'0');  
  )),few));
  
  dnorm := normalize(dchildwuids + dparentwuids ,left.children,transform(wk_ut.layouts.wks_slim,self := right));
  
  dsort     := sort(dnorm,wuid);
  dproj     := project(dsort,transform(recordof(left),self.Run_Total_Time_secs := left.total_time_secs,self := left));
  diterate  := iterate(dproj,transform(recordof(left),self.Run_Total_Time_secs := left.Run_Total_Time_secs + right.Run_Total_Time_secs,self.Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)self.Run_Total_Time_secs),self := right)); 
  // dadderrors := global(nothor(project(diterate,transform({recordof(left),string errors},self.errors := global(wk_ut.get_Errors(left.wuid),few),self := left))),few);
  // dgetworkunits := project(dgetwuidlist,transform({dataset(wk_ut.layouts.wks_slim) workunits}
    // ,self.workunits := if(wk_ut.get_Scalar_Result(left.wuid,'Workunits') != '',wk_ut.get_DS_Result(left.wuid,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim))  ));
  // dnorm := normalize(dgetworkunits,left.workunits,transform(wk_ut.layouts.wks_slim,self := right));


  // dgetworkunits := project(dgetwuidlist,transform({dataset(wk_ut.layouts.wks_slim) workunits}
    // ,self.workunits := if(wk_ut.get_Scalar_Result(left.wuid,'Workunits') != '',wk_ut.get_DS_Result(left.wuid,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim))  ));
  // dnorm := normalize(dgetworkunits,left.workunits,transform(wk_ut.layouts.wks_slim,self := right));
  // thiswuid            := if(wk_ut.get_Scalar_Result(pWuid       ,'Workunits',pesp) != '',wk_ut.get_DS_Result(pWuid        ,'Workunits',wk_ut.layouts.wks_slim),dataset([],wk_ut.layouts.wks_slim));
  // Run_Total_Time_secs := sum(thiswuid,Total_Time_secs) + thor_time_secs;
  // Run_Total_Thor_Time := wk_ut.ConvertSecs2ReadableTime((real8)Run_Total_Time_secs);
  
  return output(dchildwuids,all);
  
  // return iff(count(dgetwuidlist) > 50 ,output('The number of wuids is over 50.  it is ' + (string)count(dgetwuidlist)) ,output(diterate,all));


end;