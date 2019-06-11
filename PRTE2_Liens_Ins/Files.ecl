/* ************************************************************************************
PRTE2_Liens_Ins_Ins.Files

For the moment both we and Boca code are referencing Cross_Module_Files for file naming conventions.
NOTE: We only need file info here for a) Spray/DeSpray and b) Our Base file

Here's the overview for this to work with the new Boca Build:
1. status is appended to the main spreadsheet - two fields filing_status & filing_status_desc
2. For both main and party - there are the following files.
	a. spray file - temporary - these should be removed right after spraying
		OR for add-new spray in Linda's data, convert to the "IN" layout and append to the prod base file.
	b. IN files - these are in the spreadsheet layout which isn't the Boca compatible layout. (CSV_Base)
			* Main has the two fields (which must be turned into a sub-dataset) plus CT reference fields
			* Party - normal layout plus CT reference fields.
			In Files created by PRTE2_Liens_Ins.fSprays (You can spray 1 file without changing the other)
	c. BASE files - Final Boca Compatible base files - created by PRTE2_Liens_Ins.proc_build_base
			Reads both IN file super files so you don't have to spray both each time, but uses latest to build base files
************************************************************************************ */

//   NOTE: from PRTE2_Liens.Constants		'prte::key::liensV2::'
// 	'prct::BASE::ct::LiensV2_Alpha'

IMPORT PRTE2_Common;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;
	SHARED Common_Naming					:= PRTE2_Common.Cross_Module_Files;

	SHARED MODULE_SUFFIX					:= Common_Naming.LiensV2_MODULE_SUFFIX;
	EXPORT Full_Prefix					:= Common_Naming.LiensV2_Full_Prefix;

	EXPORT IN_PREFIX_NAME				:= Common_Naming.MASTER_IN_PREFIX+MODULE_SUFFIX+'::';
	EXPORT BASE_PREFIX_NAME				:= Common_Naming.MASTER_BASE_PREFIX+MODULE_SUFFIX+'::';


	// ************************************************************************************************
	// ******** SPRAY FILES ******* these are temporary so not using Cross_Module naming 100% *************
	// ************************************************************************************************
			EXPORT SPRAY_MODULE_NAME	:= Common_Naming.MASTER_SPRAY_PREFIX+MODULE_SUFFIX+'::';

			// name to use for desprays - temp file name
			EXPORT FILE_SPRAY				:= SPRAY_MODULE_NAME + ThorLib.Wuid();

			EXPORT main_TmpFile_Name	:=	SPRAY_MODULE_NAME + 'main' + '::' +  WORKUNIT;
			EXPORT main_TmpFile_DS		:=	DATASET(main_TmpFile_Name, PRTE2_Liens_Ins.Layouts.BaseMain_in_raw,
															CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')))(tmsid != 'tmsid');

			EXPORT party_TmpFile_Name	:=	SPRAY_MODULE_NAME + 'party' + '::' +  WORKUNIT;
			EXPORT party_TmpFile_DS		:=	DATASET(party_TmpFile_Name, PRTE2_Liens_Ins.Layouts.BaseParty_in,
															CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')))(tmsid != 'tmsid');

	// ************************************************************************************************
	// ******** NEW TEMP "ADD-NEW" DATA SPRAY FILES From Linda's generation process *******************
	// ------------ NEW GENERATED ADDING PROCESS -- this is not in the CSV layout, but a Boca-type Layout.
	// We do NOT create thor files - just use temp CSV --- NOTE: Linda hands files with tab deliminated not comma
	// ************************************************************************************************
			SHARED GeneratedLayouts 		:= PRTE2_Liens_Ins.Layouts_Generate_Data;
			EXPORT TmpGeneratedMAIN_Name	:=	SPRAY_MODULE_NAME + 'G_main' + '::' +  WORKUNIT;
			EXPORT TmpGeneratedMAIN_DS		:=	DATASET(TmpGeneratedMAIN_Name, GeneratedLayouts.GeneratedAdd_MAIN_in,
															CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(tmsid != 'tmsid');
			EXPORT TmpGeneratedPARTY_Name	:=	SPRAY_MODULE_NAME + 'G_party' + '::' +  WORKUNIT;
			EXPORT TmpGeneratedPARTY_DS	:=	DATASET(TmpGeneratedPARTY_Name, GeneratedLayouts.GeneratedAdd_PARTY_in,
															CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')))(tmsid != 'tmsid');
	// ------------------------------------------------ 
	// Then we will convert Linda's layout to our CSV "IN" layout, initializing fields as needed, append to Prod IN base file
	// ************************************************************************************************


	// *********************************************************************************************
	// ******** IN FILES *** Insurance group's CSV spray/despray files ************************** 
	//     (CSV Base File - spray/despray CSV compatible base file, not final base file)
	// *********************************************************************************************
			EXPORT Main_IN_Name	:= IN_PREFIX_NAME + 'main';
			EXPORT Main_IN_DS 	:=	DATASET(Main_IN_Name, PRTE2_Liens_Ins.Layouts.BaseMain_in_raw,THOR);	// no filter here so spray in = CSV out
			EXPORT Party_IN_Name	:= IN_PREFIX_NAME + 'party';
			EXPORT Party_IN_DS	:=	DATASET(Party_IN_Name, PRTE2_Liens_Ins.Layouts.BaseParty_in,THOR); 		// no filter here so spray in = CSV out
			EXPORT srt_main 		:= SORT(Main_IN_DS,TMSID, RMSID, -PROCESS_DATE, record_code);

	// *********************************************************************************************
	// ******** BASE OUTPUT FILES ******* BOCA COMPATIBLE BASE FILES *****************************
	// *********************************************************************************************
			EXPORT Main_Name_SF				:= Common_Naming.LiensV2_Base_SF_Main;
			EXPORT Main_Base_SF_DS			:= DATASET(Main_Name_SF, Layouts.Boca_main_base, THOR);
			EXPORT Party_Name_SF				:= Common_Naming.LiensV2_Base_SF_Party;
			EXPORT Party_Base_SF_DS			:= DATASET(Party_Name_SF, Layouts.Boca_party_base, THOR);
	// *********************************************************************************************

	// ****** Production file pointers for despray from DEV ****************************************
	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	// *********************************************************************************************
			EXPORT Main_IN_Name_Prod		:= Add_Foreign_prod(Main_IN_Name);
			EXPORT Main_IN_DS_Prod			:= DATASET(Main_IN_Name_Prod, Layouts.BaseMain_in_raw, THOR);
			EXPORT Party_IN_Name_Prod		:= Add_Foreign_prod(Party_IN_Name);
			EXPORT Party_IN_DS_Prod			:= DATASET(Party_IN_Name_Prod, Layouts.BaseParty_in, THOR);
			
			EXPORT Main_Name_Prod			:= Add_Foreign_prod(Main_Name_SF);
			EXPORT Main_DS_Prod				:= DATASET(Main_Name_Prod, Layouts.Boca_main_base, THOR);
			EXPORT Party_Name_Prod			:= Add_Foreign_prod(Party_Name_SF);
			EXPORT Party_Base_DS_Prod		:= DATASET(Party_Name_Prod, Layouts.Boca_party_base, THOR);

			// Just used this waiting for code migration of new layout, not checking in Layouts_Old, sandbox only.
			// EXPORT Main_IN_DS_Prod_OLD			:= DATASET(Main_IN_Name_Prod, Layouts_OLD.BaseMain_in_raw, THOR);
			// EXPORT Party_IN_DS_Prod_OLD			:= DATASET(Party_IN_Name_Prod, Layouts_OLD.BaseParty_in, THOR);
			// EXPORT Main_DS_Prod_OLD					:= DATASET(Main_Name_Prod, Layouts_OLD.Boca_main_base, THOR);
			// EXPORT Party_Base_DS_Prod_OLD		:= DATASET(Party_Name_Prod, Layouts_OLD.Boca_party_base, THOR);

			// Not needed often but handy if we need to despray a father or grandfather "IN" version.
			EXPORT Main_Father_Prod			:= Add_Foreign_prod('prct::IN::ct::LiensV2_Alpha::main_father');
			EXPORT Party_Father_Prod		:= Add_Foreign_prod('prct::IN::ct::LiensV2_Alpha::party_father');
			EXPORT Main_GFather_Prod		:= Add_Foreign_prod('prct::IN::ct::LiensV2_Alpha::main_Grandfather');
			EXPORT Party_GFather_Prod		:= Add_Foreign_prod('prct::IN::ct::LiensV2_Alpha::party_Grandfather');
			EXPORT Main_Father_ProdDS		:= DATASET(Main_Father_Prod, Layouts.Boca_main_base, THOR);
			EXPORT Party_Father_ProdDS		:= DATASET(Party_Father_Prod, Layouts.Boca_party_base, THOR);
			EXPORT Main_GFather_ProdDS		:= DATASET(Main_GFather_Prod, Layouts.Boca_main_base, THOR);
			EXPORT Party_GFather_ProdDS	:= DATASET(Party_GFather_Prod, Layouts.Boca_party_base, THOR);

END;