EXPORT mac_Status_Per_ID(

   pProxStats
  ,pPowStats
  ,pSeleStats
  ,pOrgStats 
  ,pUltStats 

) :=
functionmacro

  fmapstatus(string pSegType,string pSegSubType) := 
    map(  trim(pSegType,all) = 'TOTAL'     and trim(pSegSubType,all) = 'Active'           => 'Total Active'
         ,trim(pSegType,all) = 'INACTIVE'  and trim(pSegSubType,all) = 'NoActivity'       => 'Total Inactive'
         ,trim(pSegType,all) = 'INACTIVE'  and trim(pSegSubType,all) = 'ReportedInactive' => 'Total Defunct'
         ,''
    );
                     
  ds_all := 
      table(pProxStats  ,{string status := fmapstatus(segtype,segsubtype)  ,string BIP_ID := 'Proxid' ,unsigned8 countgroup := total,unsigned8 cnt := total})(status != '')
    + table(pPowStats   ,{string status := fmapstatus(segtype,segsubtype)  ,string BIP_ID := 'Powid'  ,unsigned8 countgroup := total,unsigned8 cnt := total})(status != '')
    + table(pSeleStats  ,{string status := fmapstatus(segtype,segsubtype)  ,string BIP_ID := 'Seleid' ,unsigned8 countgroup := total,unsigned8 cnt := total})(status != '')
    + table(pOrgStats   ,{string status := fmapstatus(segtype,segsubtype)  ,string BIP_ID := 'Orgid'  ,unsigned8 countgroup := total,unsigned8 cnt := total})(status != '')
    + table(pUltStats   ,{string status := fmapstatus(segtype,segsubtype)  ,string BIP_ID := 'Ultid'  ,unsigned8 countgroup := total,unsigned8 cnt := total})(status != '')
  ;
  
  return ds_all;
  
endmacro;