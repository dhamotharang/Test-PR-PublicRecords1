IMPORT AutoStandardI;

EXPORT waterfall_phones_options := MODULE(PROJECT(AutoStandardI.GlobalModule(),progressive_phone.iParam.Batch,OPT))
	EXPORT BOOLEAN ExcludeDeadContacts       := TRUE  : STORED('ExcludeDeadContacts');
	EXPORT BOOLEAN SkipPhoneScoring          := FALSE : STORED('SkipPhoneScoring');
	EXPORT BOOLEAN DedupInputPhones          := FALSE : STORED('DedupAgainstInputPhones');
	EXPORT BOOLEAN KeepAllPhones             := FALSE : STORED('KeepSamePhoneInDiffLevels');
	EXPORT BOOLEAN DedupOutputPhones         := IF(~SkipPhoneScoring,FALSE,NOT KeepAllPhones); // We need to keep all phones from all WF levels in order to run the model
	EXPORT BOOLEAN BlankOutDuplicatePhones   := FALSE : STORED('BlankOutDuplicatePhones');

	EXPORT BOOLEAN BlankOutLineTypeCell      := FALSE : STORED('Blankout_Linetype_C_CELL');
  EXPORT BOOLEAN BlankOutLineTypePotsLand  := FALSE : STORED('Blankout_Linetype_P_POTS_Landline');
  EXPORT BOOLEAN BlankOutLineTypePager     := FALSE : STORED('Blankout_Linetype_G_PAGER');
  EXPORT BOOLEAN BlankOutLineTypeVOIP      := FALSE : STORED('Blankout_Linetype_V_VOIP');
  EXPORT BOOLEAN BlankOutLineTypeIsland    := FALSE : STORED('Blankout_Linetype_I_PR_VI');
  EXPORT BOOLEAN BlankOutLineTypeTollFree  := FALSE : STORED('Blankout_Linetype_8_TOLL_FREE');
  EXPORT BOOLEAN BlankOutLineTypeUnknown   := FALSE : STORED('Blankout_Linetype_U_UNKNOWN_OTHER');

	EXPORT BOOLEAN NameMatch                 := FALSE : STORED('Match_Name');
	EXPORT BOOLEAN StreetAddressMatch        := FALSE : STORED('Match_Street_Address');
	EXPORT BOOLEAN CityMatch                 := FALSE : STORED('Match_City');
	EXPORT BOOLEAN StateMatch                := FALSE : STORED('Match_State');
	EXPORT BOOLEAN ZipMatch                  := FALSE : STORED('Match_Zip');
	EXPORT BOOLEAN SSNMatch                  := FALSE : STORED('Match_SSN');
	EXPORT BOOLEAN DIDMatch                  := FALSE : STORED('Match_LinkID');
	
	EXPORT INTEGER MaxPhoneCount             := 1000 : STORED('MaxPhoneCount');
	EXPORT INTEGER DIDConfidenceThreshold    := 75   : STORED('UniqueIDConfidenceTreshold');
	EXPORT STRING  SXMatchRestrictionLimit   := ''   : STORED('SXMatchRestrictionLimit');
	
	EXPORT INTEGER CountES                   := 0 : STORED('CountType1_ES_EDASEARCH');
	EXPORT INTEGER CountSE                   := 0 : STORED('CountType2_SE_SKIPTRACESEARCH');
	EXPORT INTEGER CountAP                   := 0 : STORED('CountType3_AP_PROGRESSIVEADDRESSSEARCH');
	EXPORT INTEGER CountSP                   := 0 : STORED('CountType4_SP_POSSIBLESPOUSE');
	EXPORT INTEGER CountMD                   := 0 : STORED('CountType4_MD_POSSIBLEPARENTS');
	EXPORT INTEGER CountCL                   := 0 : STORED('CountType4_CL_CLOSESTRELATIVE');
	EXPORT INTEGER CountCR                   := 0 : STORED('CountType4_CR_CORESIDENT');
	EXPORT INTEGER CountSX                   := 0 : STORED('CountType5_SX_EXPANDEDSKIPTRACESEARCH');
	EXPORT INTEGER CountPP                   := 0 : STORED('CountType6_PP_PHONESPLUSSEARCH');
	EXPORT INTEGER Count7                    := 0 : STORED('CountType7_UNVERIFIEDPHONE');
	EXPORT INTEGER CountNE                   := 0 : STORED('CountType_NE_CLOSESTNEIGHBOR');
	EXPORT INTEGER CountWK                   := 0 : STORED('CountType_WK_PEOPLEATWORK');
	EXPORT INTEGER CountRL                   := 0 : STORED('CountType_RL_POSSIBLERELOCATION');
	EXPORT INTEGER CountTH                   := 0 : STORED('CountType_Th_TRYHARDER');
	
	EXPORT BOOLEAN DynamicOrderFlag          := FALSE : STORED('DynamicOrdering');
	EXPORT INTEGER OrderES                   := 0 : STORED('OrderType1_ES_EDASEARCH');
	EXPORT INTEGER OrderSE                   := 0 : STORED('OrderType2_SE_SKIPTRACESEARCH');
	EXPORT INTEGER OrderAP                   := 0 : STORED('OrderType3_AP_PROGRESSIVEADDRESSSEARCH');
	EXPORT INTEGER OrderSP                   := 0 : STORED('OrderType4_SP_POSSIBLESPOUSE');
	EXPORT INTEGER OrderMD                   := 0 : STORED('OrderType4_MD_POSSIBLEPARENTS');
	EXPORT INTEGER OrderCL                   := 0 : STORED('OrderType4_CL_CLOSESTRELATIVE');
	EXPORT INTEGER OrderCR                   := 0 : STORED('OrderType4_CR_CORESIDENT');
	EXPORT INTEGER OrderSX                   := 0 : STORED('OrderType5_SX_EXPANDEDSKIPTRACESEARCH');
	EXPORT INTEGER OrderPP                   := 0 : STORED('OrderType6_PP_PHONESPLUSSEARCH');
	EXPORT INTEGER Order7                    := 0 : STORED('OrderType7_UNVERIFIEDPHONE');
	EXPORT INTEGER OrderNE                   := 0 : STORED('OrderType_NE_CLOSESTNEIGHBOR');
	EXPORT INTEGER OrderWK                   := 0 : STORED('OrderType_WK_PEOPLEATWORK');
	EXPORT INTEGER OrderRL                   := 0 : STORED('OrderType_RL_POSSIBLERELOCATION');
	EXPORT INTEGER OrderTH                   := 0 : STORED('OrderType_Th_TRYHARDER');
	
	EXPORT BOOLEAN IncludeBusinessPhones     := FALSE : STORED('IncludeBusinessPhone');
	EXPORT BOOLEAN IncludeLandlordPhones     := FALSE : STORED('IncludeLandlordPhone');
	EXPORT BOOLEAN ExcludeNonCellPPData      := FALSE : STORED('ExcludeNonCellPhonesPlusData');
	EXPORT BOOLEAN StrictAPSX                := FALSE : STORED('StrictAPSXMatch');
	EXPORT BOOLEAN Include7DigitPhones       := FALSE : STORED('IncludeSevenDigitPhones');
	EXPORT BOOLEAN IncludeLastResort         := FALSE : STORED('IncludeLastResort');
	EXPORT BOOLEAN IncludeRelativeCellPhones := FALSE : STORED('IncludeRelativeCellPhones');
	EXPORT BOOLEAN IncludeCellFirstForPP     := FALSE : STORED('IncludeCellFirstforPP');
END;