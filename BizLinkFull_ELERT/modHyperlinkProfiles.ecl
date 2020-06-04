EXPORT modHyperlinkProfiles := MODULE
  //Change all of this to match your data. -ZRS 4/8/2019    
   EXPORT dProfiles := DATASET([
       {'http://10.173.149.21:8002','roxie_149_dev','healthcare_provider_header_externallinking.meow_xlnpid_service','NEW','MEOW'}
      ,{'http://10.173.149.21:8002','roxie_149_dev','healthcare_provider_header_externallinking.xlnpid_header_service','NEW','HEADER'}
      ,{'http://10.173.7.11:8002','roxie_01','healthcare_provider_header_externallinking.meow_xlnpid_service','ORIG','MEOW'}
      ,{'http://10.173.7.11:8002','roxie_01','healthcare_provider_header_externallinking.xlnpid_header_service','ORIG','HEADER'}
    ], modLayouts.lHyperlinkProfile);
END;
