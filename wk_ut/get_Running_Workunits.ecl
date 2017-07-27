import std,ut;

thecurrentdate  := ut.getdate;       //20130822
monthago        := 'W' + ut.date_math(thecurrentdate,-30) + '-000001';
monthahead      := 'W' + ut.date_math(thecurrentdate, 30) + '-000001';

EXPORT get_Running_Workunits(

   string pLowWuid    = monthago
  ,string pHighWuid   = monthahead
  ,string pState      = 'running'
  ,string pesp        = _constants.LocalEsp
) :=
wk_ut.get_WorkunitList ( 
   pLowWuid        
  ,pHighWuid                
  ,//pOwner       
  ,//pCluster     
  ,//pJobname[1]       
  ,pState//pState       
  ,//pPriority    
  ,//pFileread      
  ,//pFilewritten   
  ,//pRoxiecluster
  ,//pEclcontains    
  ,true//pOnline      
  ,//pArchived 
  ,pesp
);
