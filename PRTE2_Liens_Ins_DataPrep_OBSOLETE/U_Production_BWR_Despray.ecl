/* *********************************************************************************************
	 PRTE2_Liens_Ins.BWR_Despray_All
	 This is for despraying base data to csv files
********************************************************************************************* */

IMPORT PRTE2_Liens_Ins, PRTE2_Common, PRTE2_Liens_Ins_DataPrep;
#workunit('name', 'Boca PRTE2 Alpha Liens Despray');

STRING dateString := PRTE2_Common.Constants.TodayString+'';

// OUTPUT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Main_DS0);
// ----- DEV DESPRAY ---------------------------------------------------------
desprayNameMain	:= 'Liens_Main_Gather_'+dateString+'.csv';
desprayNameParty	:= 'Liens_Party_Gather_'+dateString+'.csv';
Main_In		:=	SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Main_DS,tmsid,rmsid,process_date);
Party_in		:=	SORT(PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Party_DS,tmsid,rmsid,date_first_seen);

// ---------------------------------------------------------------------------
BaseMain_Layout_raw := PRTE2_Liens_Ins.Layouts.BaseMain_in_raw;
Baseparty_Layout_in := PRTE2_Liens_Ins.Layouts.Baseparty_in;
BaseMain_Layout_raw workTrxMain(Main_In L) := TRANSFORM
		SELF.filing_status := L.filing_status[1].filing_status;
		SELF.filing_status_desc := L.filing_status[1].filing_status_desc;
		SELF := L;
END;
Baseparty_Layout_in workTrxParty(Party_in L) := TRANSFORM
		SELF.ultid := 0;
		SELF.orgid := 0;
		SELF.seleid := 0;
		SELF.proxid := 0;
		SELF.powid := 0;
		SELF.empid := 0;
		SELF.dotid := 0;
		SELF.ultscore := 0;
		SELF.orgscore := 0;
		SELF.selescore := 0;
		SELF.proxscore := 0;
		SELF.powscore := 0;
		SELF.empscore := 0;
		SELF.dotscore := 0;
		SELF.ultweight := 0;
		SELF.orgweight := 0;
		SELF.seleweight := 0;
		SELF.proxweight := 0;
		SELF.powweight := 0;
		SELF.empweight := 0;
		SELF.dotweight := 0;
		SELF.fp := '';
		SELF := L;
END;
Export_Main := PROJECT(Main_In,workTrxMain(LEFT));
Export_Party := PROJECT(Party_in,workTrxParty(LEFT));
// ---------------------------------------------------------------------------

LandingZoneIP 	:= PRTE2_Liens_Ins.Constants.LandingZoneIP;
TempCSV1				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_1';
TempCSV2				:= PRTE2_Liens_Ins.Files.FILE_SPRAY+'_2';
pathFile				:= PRTE2_Liens_Ins.Constants.SourcePathForCSV;

PRTE2_Common.DesprayCSV(Export_Main, TempCSV1, LandingZoneIP, pathFile+desprayNameMain);
PRTE2_Common.DesprayCSV(Export_Party, TempCSV2, LandingZoneIP, pathFile+desprayNameParty);
// ---------------------------------------------------------------------------