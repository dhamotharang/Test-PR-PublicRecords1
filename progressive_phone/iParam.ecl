EXPORT iParam :=
MODULE

	EXPORT Batch :=
	INTERFACE
		EXPORT BOOLEAN ExcludeDeadContacts       := FALSE;
		EXPORT BOOLEAN SkipPhoneScoring          := FALSE;
		EXPORT BOOLEAN DedupInputPhones          := FALSE;
		EXPORT BOOLEAN KeepAllPhones             := FALSE;
		EXPORT BOOLEAN DedupOutputPhones         := FALSE;
		EXPORT BOOLEAN BlankOutDuplicatePhones   := FALSE;

    EXPORT BOOLEAN BlankOutLineTypeCell      := FALSE;
    EXPORT BOOLEAN BlankOutLineTypePotsLand  := FALSE;
    EXPORT BOOLEAN BlankOutLineTypePager     := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeVOIP      := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeIsland    := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeTollFree  := FALSE;
    EXPORT BOOLEAN BlankOutLineTypeUnknown   := FALSE;
		
		EXPORT BOOLEAN NameMatch                 := FALSE;
		EXPORT BOOLEAN StreetAddressMatch        := FALSE;
		EXPORT BOOLEAN CityMatch                 := FALSE;
		EXPORT BOOLEAN StateMatch                := FALSE;
		EXPORT BOOLEAN ZipMatch                  := FALSE;
		EXPORT BOOLEAN SSNMatch                  := FALSE;
		EXPORT BOOLEAN DIDMatch                  := FALSE;
		
		EXPORT INTEGER MaxPhoneCount             := 1000;
		EXPORT INTEGER DIDConfidenceThreshold    := 75;
		EXPORT STRING  SXMatchRestrictionLimit   := '';
		EXPORT INTEGER CountES                   := 0;
		EXPORT INTEGER CountSE                   := 0;
		EXPORT INTEGER CountAP                   := 0;
		EXPORT INTEGER CountSP                   := 0;
		EXPORT INTEGER CountMD                   := 0;
		EXPORT INTEGER CountCL                   := 0;
		EXPORT INTEGER CountCR                   := 0;
		EXPORT INTEGER CountSX                   := 0;
		EXPORT INTEGER CountPP                   := 0;
		EXPORT INTEGER Count7                    := 0;
		EXPORT INTEGER CountNE                   := 0;
		EXPORT INTEGER CountWK                   := 0;
		EXPORT INTEGER CountRL                   := 0;
		EXPORT INTEGER CountTH                   := 0;
		
		EXPORT BOOLEAN DynamicOrderFlag          := FALSE;
		EXPORT INTEGER OrderES                   := 0;
		EXPORT INTEGER OrderSE                   := 0;
		EXPORT INTEGER OrderAP                   := 0;
		EXPORT INTEGER OrderSP                   := 0;
		EXPORT INTEGER OrderMD                   := 0;
		EXPORT INTEGER OrderCL                   := 0;
		EXPORT INTEGER OrderCR                   := 0;
		EXPORT INTEGER OrderSX                   := 0;
		EXPORT INTEGER OrderPP                   := 0;
		EXPORT INTEGER Order7                    := 0;
		EXPORT INTEGER OrderNE                   := 0;
		EXPORT INTEGER OrderWK                   := 0;
		EXPORT INTEGER OrderRL                   := 0;
		EXPORT INTEGER OrderTH                   := 0;
		
		EXPORT BOOLEAN IncludeBusinessPhones     := FALSE;
		EXPORT BOOLEAN IncludeLandlordPhones     := FALSE;
		EXPORT BOOLEAN ExcludeNonCellPPData      := FALSE;
		EXPORT BOOLEAN StrictAPSX                := FALSE;
		EXPORT BOOLEAN Include7DigitPhones       := FALSE;
		EXPORT BOOLEAN IncludeLastResort         := FALSE;
		EXPORT BOOLEAN IncludeRelativeCellPhones := FALSE;
		EXPORT BOOLEAN IncludeCellFirstForPP     := FALSE;
	END;

END;