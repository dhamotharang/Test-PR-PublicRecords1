IMPORT STD;

EXPORT Constants := MODULE

	EXPORT Defaults := MODULE
		EXPORT INTEGER DIDScoreThreshold  := 80;
		//EXPORT STRING1 IndustryClassRestrict := 'UTILI', //restricted by default???
	END;

	EXPORT Days_in_Year             := 365;
	EXPORT STRING1 DEBTOR           := 'D';
	EXPORT STRING4 Last_Day_of_Year := '1231';
	EXPORT max_addresses            := 100;
	EXPORT Max_Total_Addresses      := 4;
	EXPORT Prop_Owner_Join_Limit    := 2000; // from coding turned over from Sree, not sure why???
	EXPORT ScoreThreshold           :=  10; // same as default in AutoStandardI.GlobalModule
	                                        // Only used in Residency_Services.fn_getPhonesPlus
	EXPORT RealTimePermissibleUse   := 'GOVERNMENT';
	EXPORT Year_Only_Length         := 4;
	
  EXPORT STRING8 TodaysDate := (STRING8)STD.Date.Today();

END;
