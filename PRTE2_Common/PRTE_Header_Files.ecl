IMPORT PRTE;

EXPORT PRTE_Header_Files := MODULE

	// Leaving this till we can get the LNProperty and Foreclosure modules references rewritten
	EXPORT LNPForeclosureDIDPersistedHeaderData :=PRTE.Get_Header_Base.LNPForeclosureDIDPersistData;
	// EXPORT BocaCTHeader_BocaOnly := PRTE.Get_Header_Base.Boca_Only;
	// EXPORT BocaCTHeader_ALL := PRTE.Get_Header_Base.payload;
END;