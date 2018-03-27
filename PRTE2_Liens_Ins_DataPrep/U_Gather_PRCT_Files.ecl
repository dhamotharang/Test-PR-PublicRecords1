// PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files

IMPORT PRTE2_Common, PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep;

EXPORT U_Gather_PRCT_Files := MODULE

		EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
		SHARED Common_Naming					:= PRTE2_Common.Cross_Module_Files;
		SHARED MODULE_SUFFIX					:= Common_Naming.LiensV2_MODULE_SUFFIX;
		EXPORT TMP_PREFIX_NAME				:= Common_Naming.MASTER_TMP_PREFIX+'_Gather'+MODULE_SUFFIX+'::';
		// prct::TMP::ct_Gather::LiensV2_Alpha
		
		EXPORT primStates := 'primStates';

		//************** THERE IS NO SF FOR THIS MUST JUST CODE FOR THE LATEST LOGICAL KEY ************************
		EXPORT Latest_PRCT_HeaderName := Add_Foreign_prod('prte::key::header::qa::data');	// index with s_did as the LexID
		EXPORT Latest_PRCT_HeaderKey	:= INDEX({U_Gather_Layouts.PHeader_Latest_IDX}, U_Gather_Layouts.PHeader_Latest_Rec, Latest_PRCT_HeaderName);

		//*********************************************************************************************************
		EXPORT primParty_FileName	:= TMP_PREFIX_NAME+'Prim_driver_Parties';
		EXPORT primStates_File		:= TMP_PREFIX_NAME+primStates;
		EXPORT Main_File_1				:= TMP_PREFIX_NAME+'Main_1';
		EXPORT Party_File_1				:= TMP_PREFIX_NAME+'Party_1';
		EXPORT Main_File_2				:= TMP_PREFIX_NAME+'Main_2';
		EXPORT Party_File_2				:= TMP_PREFIX_NAME+'Party_2';

		EXPORT Main_File_Later1		:= TMP_PREFIX_NAME+'Final_Main_Dups_for_Later1';
		EXPORT Main_File_Later2		:= TMP_PREFIX_NAME+'Final_Main_Dups_for_Later2';
		EXPORT Main_File_Final		:= TMP_PREFIX_NAME+'Final_Main';
		EXPORT Party_File_Final		:= TMP_PREFIX_NAME+'Final_Party';
		EXPORT Usable_Main_Final		:= TMP_PREFIX_NAME+'Final_Usable_Main';
		EXPORT Usable_Party_Final		:= TMP_PREFIX_NAME+'Final_Usable_Party';

		EXPORT Prim_Party_DS			:= DATASET(primParty_FileName, U_Gather_Layouts.BaseParty_in_joinable_V2, THOR);

		EXPORT Analy_TmpFile_Name		:=	PRTE2_Liens_Ins.Files.SPRAY_MODULE_NAME + 'Analy' + '::' +  WORKUNIT;
		EXPORT Analy_TmpFile_DS			:=	DATASET(Analy_TmpFile_Name, PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseAnaly_in,
																										CSV(HEADING(1), SEPARATOR('|'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
		EXPORT Analy_TmpFile_DS2		:=	DATASET(Analy_TmpFile_Name, PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseAnaly_in_2,
																										CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));

		EXPORT AnalyticsMain1			:= TMP_PREFIX_NAME+'Analytics_Main_1';
		EXPORT AnalyticsMain2			:= TMP_PREFIX_NAME+'Analytics_Main_2';
		EXPORT AnalyMain1_DS			:= DATASET(AnalyticsMain1, PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseAnaly_Joinable, THOR);
		EXPORT AnalyMain2_DS			:= DATASET(AnalyticsMain2, PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts.BaseAnaly_Joinable_2, THOR);

		EXPORT Main_1_DS			:= DATASET(Main_File_1, U_Gather_Layouts.BaseMain_in_joinable, THOR);
		EXPORT Party_1_DS			:= DATASET(Party_File_1, U_Gather_Layouts.BaseParty_in_joinable, THOR);
		EXPORT Main_2_DS			:= DATASET(Main_File_2, U_Gather_Layouts.BaseMain_in_joinable, THOR);
		EXPORT Party_2_DS			:= DATASET(Party_File_2, U_Gather_Layouts.BaseParty_in_joinable, THOR);
		
		EXPORT Main_Final_DS			:= DATASET(Main_File_Final, U_Gather_Layouts.BaseAnaly_Joinable_2, THOR);
		EXPORT Main_Later1_DS			:= DATASET(Main_File_Later1, U_Gather_Layouts.BaseAnaly_Joinable_2, THOR);
		EXPORT Main_Later2_DS			:= DATASET(Main_File_Later2, U_Gather_Layouts.BaseAnaly_Joinable_2, THOR);
		EXPORT Party_Final_DS			:= DATASET(Party_File_Final, U_Gather_Layouts.BaseParty_in_joinable_V2, THOR);
		// the final files but cut down to 100/state == 5,000 records
		EXPORT Usable_Main_DS			:= DATASET(Usable_Main_Final, U_Gather_Layouts.BaseAnaly_Joinable_2, THOR);
		EXPORT Usable_Party_DS		:= DATASET(Usable_Party_Final, U_Gather_Layouts.BaseParty_in_joinable_V2, THOR);


END;