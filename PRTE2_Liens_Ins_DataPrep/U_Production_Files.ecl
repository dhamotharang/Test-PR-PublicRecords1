// PRTE2_Liens_Ins_DataPrep.U_Production_Files.Tmp_Prod_SF_Main_DS0

IMPORT PRTE2_Common, PRTE2_Liens_Ins, PRTE2_Liens_Ins_DataPrep, LiensV2_preprocess, LiensV2;

EXPORT U_Production_Files := MODULE

		EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
		SHARED Common_Naming					:= PRTE2_Common.Cross_Module_Files;
		SHARED MODULE_SUFFIX					:= Common_Naming.LiensV2_MODULE_SUFFIX;
		EXPORT TMP_PREFIX_NAME				:= Common_Naming.MASTER_TMP_PREFIX+'_Gather'+MODULE_SUFFIX+'::';

		EXPORT ReadOnly_Prod_SF_MainName	:= Add_Foreign_prod('~thor_data400::base::liensv2::main::all_sources');
		EXPORT ReadOnly_Prod_SF_Main_DS		:= DATASET(ReadOnly_Prod_SF_MainName,PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Main_Layout,THOR);

		EXPORT ReadOnly_Prod_SF_PartyName	:= Add_Foreign_prod('~thor_data400::base::liensv2::party::all_sources');
		EXPORT ReadOnly_Prod_SF_Party_DS	:= DATASET(ReadOnly_Prod_SF_PartyName,PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Party_Layout,THOR);

		EXPORT ReadOnly_Prod_SF_PartyKName	:= Add_Foreign_prod('thor_data400::key::liensv2::party::tmsid.rmsid_qa');
		EXPORT ReadOnly_Prod_SF_MainKName		:= Add_Foreign_prod('thor_data400::key::liensv2::main::tmsid.rmsid_qa');
		EXPORT ReadOnly_Prod_SF_PartyDidKName := Add_Foreign_prod('thor_data400::key::liensv2::did_qa');		
		EXPORT ReadOnly_Prod_SF_Party_Key	:= INDEX({PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Layout_PartyKeyI}, 
																								PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Layout_PartyKeyM, 
																								ReadOnly_Prod_SF_PartyKName);
		// EXPORT ReadOnly_Prod_SF_Main_Key	:= INDEX({PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Layout_MainKeyI}, 
																								// PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Layout_MainKeyM, 
																								// ReadOnly_Prod_SF_MainKName);
		EXPORT ReadOnly_Prod_SF_Main_Key	:= INDEX(LiensV2.key_liens_main_ID_FCRA,ReadOnly_Prod_SF_MainKName);
		EXPORT ReadOnly_Prod_SF_Partydid := INDEX(LiensV2.key_liens_DID,ReadOnly_Prod_SF_PartyDidKName);
		EXPORT ReadOnly_Prod_SF_PartyTms := INDEX(LiensV2.key_liens_party_ID,ReadOnly_Prod_SF_PartyKName);
		// -------------------------------------------------------------------------------------------------
		
		EXPORT Tmp_Main_Prod_File0		:= Add_Foreign_prod(TMP_PREFIX_NAME+'Prod_Main0');
		EXPORT Tmp_Main_Prod_File			:= Add_Foreign_prod(TMP_PREFIX_NAME+'Prod_Main');
		EXPORT Tmp_Party_Prod_File		:= Add_Foreign_prod(TMP_PREFIX_NAME+'Prod_Party');

		EXPORT Tmp_Prod_SF_Main_DS0		:= DATASET(Tmp_Main_Prod_File0,PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Main_Layout,THOR);
		EXPORT Tmp_Prod_SF_Main_DS		:= DATASET(Tmp_Main_Prod_File,PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Main_Layout,THOR);
		EXPORT Tmp_Prod_SF_Party_DS		:= DATASET(Tmp_Party_Prod_File,PRTE2_Liens_Ins_DataPrep.U_Production_Layouts.Prod_Party_Layout,THOR);
		// -------------------------------------------------------------------------------------------------
		RawLayout := PRTE2_Liens_Ins.Layouts.BaseMain_in_raw;
		RawLayout wrkTrxMain(Tmp_Prod_SF_Main_DS L) := TRANSFORM
				SELF.filing_status 			:= L.filing_status[1].filing_status;
				SELF.filing_status_desc := L.filing_status[1].filing_status_desc;
				SELF := L;
		END;
		EXPORT Tmp_Prod_SF_Main_DS_Raw := PROJECT(Tmp_Prod_SF_Main_DS,wrkTrxMain(LEFT)); 
		// -------------------------------------------------------------------------------------------------
		//Hogan Lookups
		EXPORT HG_FileType(string code) := LiensV2_preprocess.Code_lkps.HG_FileType(code);
		HG_FileCodeDict := DICTIONARY(LiensV2_preprocess.Files_lkp.HGFiling_type(filetype_desc<>''), {filetype_desc => filetype_cd});
		EXPORT HG_FTCode(String desc) := IF(TRIM(desc)='','',HG_FileCodeDict[desc].filetype_cd);
		// -------------------------------------------------------------------------------------------------

END;