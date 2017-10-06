IMPORT scrubs, scrubs_uccv2, tools, std, ut;

EXPORT fn_RunScrubs(STRING pVersion, STRING tempEmailList) := FUNCTION

emailList := tempEmailList + ',Kent.Wolf@lexisnexisrisk.com,Rosemary.Murphy@lexisnexisrisk.com';

RETURN PARALLEL(
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_CA_Main',  'CA_Main',  pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_CA_Party', 'CA_Party', pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_IL_Main',  'IL_Main',  pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_IL_Party', 'IL_Party', pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_MA_Main',  'MA_Main',  pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_MA_Party', 'MA_Party', pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_NYC_Main', 'NYC_Main', pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_NYC_Party','NYC_Party',pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_TX_Main',  'TX_Main',  pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_TX_Party', 'TX_Party', pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_WA_Main',  'WA_Main',  pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_WA_Party', 'WA_Party', pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_DNB_Party','DNB_Party',pVersion,emailList,false),
  scrubs.ScrubsPlus('UCCV2','Scrubs_UCCV2','Scrubs_UCCV2_DNB_Main', 'DNB_Main', pVersion,emailList,false)
);

END;