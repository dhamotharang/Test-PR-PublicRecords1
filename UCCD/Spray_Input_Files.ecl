import _control, versioncontrol;
FilesToSpray := DATASET([
// DNB
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_DnB*event.d00'
   ,sizeof(uccd.Layout_ucc_Event_In)
   ,'~thor_data400::in::ucc_direct_dnb_@version@_event'
   ,[{'~thor_data400::in::ucc_direct_event'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_DnB*filing*.d00'
   ,sizeof(uccd.Layout_ucc_filing_In)
   ,'~thor_data400::in::ucc_direct_dnb_@version@_filing'
   ,[{'~thor_data400::in::ucc_direct_filing'}]
   ,'thor_dell400'
   },
   
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_DnB*collateral*.d00'
   ,sizeof(uccd.Layout_ucc_collateral_In)
   ,'~thor_data400::in::ucc_direct_dnb_@version@_collateral'
   ,[{'~thor_data400::in::ucc_direct_collateral'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_DnB*party*.d00'
   ,sizeof(uccd.Layout_ucc_party_In)
   ,'~thor_data400::in::ucc_direct_dnb_@version@_party'
   ,[{'~thor_data400::in::ucc_direct_party'}]
   ,'thor_dell400'
   },

// TX
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_TX*event.d00'
   ,sizeof(uccd.Layout_ucc_Event_In)
   ,'~thor_data400::in::ucc_direct_tx_@version@_event'
   ,[{'~thor_data400::in::ucc_direct_event'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_TX*filing*.d00'
   ,sizeof(uccd.Layout_ucc_filing_In)
   ,'~thor_data400::in::ucc_direct_tx_@version@_filing'
   ,[{'~thor_data400::in::ucc_direct_filing'}]
   ,'thor_dell400'
   },
   
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_TX*collateral*.d00'
   ,sizeof(uccd.Layout_ucc_collateral_In)
   ,'~thor_data400::in::ucc_direct_tx_@version@_collateral'
   ,[{'~thor_data400::in::ucc_direct_collateral'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_TX*party*.d00'
   ,sizeof(uccd.Layout_ucc_party_In)
   ,'~thor_data400::in::ucc_direct_tx_@version@_party'
   ,[{'~thor_data400::in::ucc_direct_party'}]
   ,'thor_dell400'
   },

// TH
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new/harris'
   ,'ucc_direct_TX*event.d00'
   ,sizeof(uccd.Layout_ucc_Event_In)
   ,'~thor_data400::in::ucc_direct_tx_harris_@version@_event'
   ,[{'~thor_data400::in::ucc_direct_event'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new/harris'
   ,'ucc_direct_TX*filing*.d00'
   ,sizeof(uccd.Layout_ucc_filing_In)
   ,'~thor_data400::in::ucc_direct_tx_harris_@version@_filing'
   ,[{'~thor_data400::in::ucc_direct_filing'}]
   ,'thor_dell400'
   },
   
// no collateral for TX harris
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new/harris'
   ,'ucc_direct_TX*party*.d00'
   ,sizeof(uccd.Layout_ucc_party_In)
   ,'~thor_data400::in::ucc_direct_tx_harris_@version@_party'
   ,[{'~thor_data400::in::ucc_direct_party'}]
   ,'thor_dell400'
   },

// IL
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_IL*event.d00'
   ,sizeof(uccd.Layout_ucc_Event_In)
   ,'~thor_data400::in::ucc_direct_il_@version@_event'
   ,[{'~thor_data400::in::ucc_direct_event'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_IL*filing*.d00'
   ,sizeof(uccd.Layout_ucc_filing_In)
   ,'~thor_data400::in::ucc_direct_il_@version@_filing'
   ,[{'~thor_data400::in::ucc_direct_filing'}]
   ,'thor_dell400'
   },
   
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_IL*collateral*.d00'
   ,sizeof(uccd.Layout_ucc_collateral_In)
   ,'~thor_data400::in::ucc_direct_il_@version@_collateral'
   ,[{'~thor_data400::in::ucc_direct_collateral'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_IL*party*.d00'
   ,sizeof(uccd.Layout_ucc_party_In)
   ,'~thor_data400::in::ucc_direct_il_@version@_party'
   ,[{'~thor_data400::in::ucc_direct_party'}]
   ,'thor_dell400'
   },

// CA
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_CA*event.d00'
   ,sizeof(uccd.Layout_ucc_Event_In)
   ,'~thor_data400::in::ucc_direct_ca_@version@_event'
   ,[{'~thor_data400::in::ucc_direct_event'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_CA*filing*.d00'
   ,sizeof(uccd.Layout_ucc_filing_In)
   ,'~thor_data400::in::ucc_direct_ca_@version@_filing'
   ,[{'~thor_data400::in::ucc_direct_filing'}]
   ,'thor_dell400'
   },
   
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_CA*collateral*.d00'
   ,sizeof(uccd.Layout_ucc_collateral_In)
   ,'~thor_data400::in::ucc_direct_ca_@version@_collateral'
   ,[{'~thor_data400::in::ucc_direct_collateral'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out/new'
   ,'ucc_direct_CA*party*.d00'
   ,sizeof(uccd.Layout_ucc_party_In)
   ,'~thor_data400::in::ucc_direct_ca_@version@_party'
   ,[{'~thor_data400::in::ucc_direct_party'}]
   ,'thor_dell400'
   },

// MA
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out'
   ,'ucc_direct_MA*event.d00'
   ,sizeof(uccd.Layout_ucc_Event_In)
   ,'~thor_data400::in::ucc_direct_ma_@version@_event'
   ,[{'~thor_data400::in::ucc_direct_event'}]
   ,'thor_dell400'
   },

   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out'
   ,'ucc_direct_MA*filing*.d00'
   ,sizeof(uccd.Layout_ucc_filing_In)
   ,'~thor_data400::in::ucc_direct_ma_@version@_filing'
   ,[{'~thor_data400::in::ucc_direct_filing'}]
   ,'thor_dell400'
   },
   
   {_Control.IPAddress.edata10
   ,'/ucc_new_build/work/DEV/out'
   ,'ucc_direct_MA*party*.d00'
   ,sizeof(uccd.Layout_ucc_party_In)
   ,'~thor_data400::in::ucc_direct_ma_@version@_party'
   ,[{'~thor_data400::in::ucc_direct_party'}]
   ,'thor_dell400'
   }
], VersionControl.Layout_Sprays.Info);

export Spray_Input_Files := VersionControl.fSprayInputFiles(FilesToSpray);