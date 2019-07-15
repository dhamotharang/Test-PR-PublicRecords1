EXPORT Get_Wuid_List(
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
  ,string   pesp          = WsWorkunits._Config.LocalEsp
) := 
function

  UseWuid    := if(pLowWuid = pHighWuid  or (pLowWuid != '' and pHighWuid = ''),true ,false);
  StartDate  := if(UseWuid ,'' ,regexreplace('^W([[:digit:]]{4})([[:digit:]]{2})([[:digit:]]{2})[-]([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{2})([-][[:digit:]]*)?$',pLowWuid ,'$1-$2-$3T$4:$5:$6Z',nocase));
  EndDate    := if(UseWuid ,'' ,regexreplace('^W([[:digit:]]{4})([[:digit:]]{2})([[:digit:]]{2})[-]([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{2})([-][[:digit:]]*)?$',pHighWuid,'$1-$2-$3T$4:$5:$6Z',nocase));
  
  // W20140624-093929
  // 2014-06-24T09:39:29Z

  lesp := pesp;
  
  ds_WUQuery := 
    WsWorkunits.soapcall_WUQuery(
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
    );

  ds_norm := normalize(ds_WUQuery,left.Workunits,transform(WsWorkunits.Layouts.eclworkunit,self := right));

  ds_WuidList := project(global(ds_norm,few),transform(WsWorkunits.Layouts.WsWorkunitRecord,
    self.wuid           := left.wuid;
    self.owner          := left.owner;
    self.cluster        := left.cluster;
    self.roxiecluster   := left.roxiecluster;
    self.job            := left.jobname;
    self.state          := left.state;
    self.priority       := '';//not sure yet how this maps
    self.priorityvalue  := 0;//not sure how this maps
    self.created        := '';
    self.modified       := '';
    self.online         := ~left.Archived;
    self.protected      := left.protected;
    
  ));

  
  return ds_WuidList;

end;

