import std,wsworkunits;
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
  ,string   pesp          = _Config.LocalEsp
) := 
function

  UseWuid    := if(pLowWuid = pHighWuid  or (pLowWuid != '' and pHighWuid = ''),true ,false);
  StartDate  := if(UseWuid ,'' ,regexreplace('^W([[:digit:]]{4})([[:digit:]]{2})([[:digit:]]{2})[-]([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{2})([-][[:digit:]]*)?$',pLowWuid ,'$1-$2-$3T$4:$5:$6Z',nocase));
  EndDate    := if(UseWuid ,'' ,regexreplace('^W([[:digit:]]{4})([[:digit:]]{2})([[:digit:]]{2})[-]([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{2})([-][[:digit:]]*)?$',pHighWuid,'$1-$2-$3T$4:$5:$6Z',nocase));
  
  // W20140624-093929
  // 2014-06-24T09:39:29Z
  
  IsEspLocal := if(pesp in _Config.LocalEsps and WorkMan.Is_Valid_Wuid(pLowWuid) and WorkMan.Is_Valid_Wuid(pHighWuid),true ,false);
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
   ,WsWorkunits.Get_Wuid_List(
       if(UseWuid   ,pLowWuid  ,'')                         
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
      ,pesp
    )
  );
  
  return dWuidList;


end;

