import std;
EXPORT get_WorkunitList(
   string   pLowWuid     
  ,string   pHighWuid     = ''          
  ,string   pOwner        = ''
  ,string   pCluster      = ''
  ,string   pJobname      = ''
  ,string   pState        = ''
  ,string   pPriority     = ''
  ,string   pFileread     = ''
  ,string   pFilewritten  = ''
  ,string   pRoxiecluster = ''
  ,string   pEclcontains  = ''
  ,boolean  pOnline       = true
  ,boolean  pArchived     = false
  ,string   pesp          = _constants.LocalEsp
) := 
function

  UseWuid    := if(pLowWuid = pHighWuid  or (pLowWuid != '' and pHighWuid = ''),true ,false);
  StartDate  := if(UseWuid ,'' ,regexreplace('^W([[:digit:]]{4})([[:digit:]]{2})([[:digit:]]{2})[-]([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{2})([-][[:digit:]]*)?$',pLowWuid ,'$1-$2-$3T$4:$5:$6Z',nocase));
  EndDate    := if(UseWuid ,'' ,regexreplace('^W([[:digit:]]{4})([[:digit:]]{2})([[:digit:]]{2})[-]([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{2})([-][[:digit:]]*)?$',pHighWuid,'$1-$2-$3T$4:$5:$6Z',nocase));
  
  // W20140624-093929
  // 2014-06-24T09:39:29Z
  
  IsEspLocal := if(pesp in _constants.LocalEsps and wk_ut_dev.Is_Valid_Wuid(pLowWuid) and wk_ut_dev.Is_Valid_Wuid(pHighWuid),true ,false);
  lesp := pesp;
  
  dWuidList := if(IsEspLocal  
    ,STD.System.Workunit.WorkunitList(
       pLowWuid     
      ,if(pHighWuid = ''  ,pLowWuid,pHighWuid)            
      ,pOwner  
      ,pCluster  
      ,pJobname       
      ,pState  
      ,pPriority  
      ,pFileread    
      ,pFilewritten 
      ,pRoxiecluster
      ,pEclcontains  
      ,pOnline
      ,pArchived 
    )
   ,wk_ut_dev.get_WUQuery(
       if(UseWuid   ,pLowWuid  ,'')                         
      ,if(pArchived ,'archived','')                         //archived workunits, non-archived workunits           
      ,pCluster                  
      ,pOwner                    
      ,pState                        
      ,StartDate                   //2014-06-24T09:39:29Z
      ,EndDate                     //2014-06-24T09:39:29Z
      ,0//pLastNDays                
      ,pJobname                  
      ,pEclcontains //pECL                      
      ,pFilewritten //pLogicalFile              
      ,             //pLogicalFileSearchType
      ,pesp := lesp
    ).WuidList
  );
  
  return dWuidList;


end;

