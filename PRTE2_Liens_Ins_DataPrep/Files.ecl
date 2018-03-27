/* ************************************************************************************************************
PRTE2_Liens_Ins_DataPrep.Files
NOTE: for purposes of just doing data prep and research, I am only using 2 generations of SFs
************************************************************************************************************ */
IMPORT PRTE2_Liens_Ins_DataPrep, PRTE2_Liens_Ins;

Layouts := PRTE2_Liens_Ins_DataPrep.Layouts;

EXPORT Files := MODULE
			SHARED MODULE_Prefix	:= '~prct::gather::DataPrep::ct::LiensV2_Alpha';		// Production data to pick from
			SHARED INCOMING_Prefix	:= '~prct::gather::DataPrep::ct::LiensV2_Alpha::IN';	//Incoming data handed to us

			EXPORT Spray_TU_Name	:= INCOMING_Prefix+'::TU_SPRAY';
			EXPORT Spray_TU_DS		:= DATASET(Spray_TU_Name, Layouts.Spray_TU_Layout,
																									CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
			EXPORT Save_TU_Name		:= INCOMING_Prefix+'::TU_BASE';
			EXPORT Save_TU_DS			:= DATASET(Save_TU_Name,Layouts.New_TU_Layout,THOR);
			EXPORT TMP_TU_Name		:= INCOMING_Prefix+'::TU_BASE_WIP';
			EXPORT TMP_TU_DS			:= DATASET(TMP_TU_Name,Layouts.New_TU_Layout,THOR);

			EXPORT Spray_EQ_Name	:= INCOMING_Prefix+'::EQ_SPRAY';
			EXPORT Spray_EQ_DS		:= DATASET(Spray_EQ_Name, Layouts.Spray_EQ_Layout,
																									CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
			EXPORT Save_EQ_Name		:= INCOMING_Prefix+'::EQ_BASE';
			EXPORT Save_EQ_DS			:= DATASET(Save_EQ_Name,Layouts.New_EQ_Layout,THOR);
			EXPORT TMP_EQ_Name		:= INCOMING_Prefix+'::EQ_BASE_WIP';
			EXPORT TMP_EQ_DS			:= DATASET(TMP_EQ_Name,Layouts.New_EQ_Layout,THOR);

			EXPORT Spray_IIHDR_Name	:= INCOMING_Prefix+'::IDHR_SPRAY';
			EXPORT Spray_IIHDR_DS		:= DATASET(Spray_IIHDR_Name, Layouts.IHDR_DL_Death,
																									CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));
			EXPORT Incoming_IHDR_Name		:= MODULE_Prefix+'::IHDR_Incoming';
			EXPORT Incoming_IHDR_DS			:= DATASET(Incoming_IHDR_Name,Layouts.IHDR_DL_Death_Joinable,THOR);

			EXPORT Incoming_BocaHit_Name		:= MODULE_Prefix+'::Incoming_BocaHits';
			EXPORT Incoming_BocaHit_DS			:= DATASET(Incoming_BocaHit_Name,Layouts.BasePartyBocaHit,THOR);

			// WARNING - these have PII in them!!!!!! - direct gather from Prod
			EXPORT Save_ProdParty_Name	:= MODULE_Prefix+'::Prod_Party_PII_Samples';
			EXPORT Save_ProdParty_DS		:= DATASET(Save_ProdParty_Name,Layouts.BasePartyInJoin,THOR);
			EXPORT Save_ProdParty_PARTIAL	:= MODULE_Prefix+'::Prod_Party_PII_Samples_PARTIAL';

			EXPORT Save_ProdMain_Name	:= MODULE_Prefix+'::Prod_Main_PII_Samples';
			EXPORT Save_ProdMain_DS			:= DATASET(Save_ProdMain_Name,Layouts.BaseMainInJoin,THOR);
			EXPORT Save_ProdMain_PARTIAL	:= MODULE_Prefix+'::Prod_Main_PII_Samples_PARTIAL';

			EXPORT Save_PartyWIP_Name	:= MODULE_Prefix+'::Party_WIP_Data';
			EXPORT Save_PartyWIP_DS		:= DATASET(Save_PartyWIP_Name,Layouts.BasePartyExtraJoin,THOR);
			EXPORT Save_PartyWIP_PARTIAL	:= MODULE_Prefix+'::Party_WIP_Data_PARTIAL';

			EXPORT Save_MainWIP_Name	:= MODULE_Prefix+'::Main_WIP_Data';
			EXPORT Save_MainWIP_DS			:= DATASET(Save_MainWIP_Name,Layouts.BaseMainRenumberJoin,THOR);
			EXPORT Save_MainWIP_PARTIAL	:= MODULE_Prefix+'::Main_WIP_Data_PARTIAL';

END;