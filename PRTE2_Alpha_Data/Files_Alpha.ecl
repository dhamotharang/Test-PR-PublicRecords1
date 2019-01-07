/* ***********************************************************************************************************
PRTE2_Alpha_Data.Files_Alpha
Commented out all MHDR that I saw - it should all be obsolete
*********************************************************************************************************** */
IMPORT _control, ut;

EXPORT Files_Alpha := MODULE

	SHARED IPAddress := _Control.IPAddress;
	SHARED AlphaDevThor 				:= IPAddress.adataland_esp;
	SHARED AlphaDevDali 				:= IPAddress.adataland_dali; 	// SHARED adataland_dali	:=	'10.194.10.1';			// 10.173.28.12	
	SHARED AlphaProdThor 				:= IPAddress.aprod_thor_esp;
	SHARED AlphaProdDali 				:= IPAddress.aprod_thor_dali;
	// Why isn't this in Data_Services??   EG:	Data_Services.foreign_dataland
	EXPORT foreign_alpha_dev 		:= '~foreign::' + AlphaDevDali + '::';
	EXPORT foreign_alpha_PROD 	:= '~foreign::' + AlphaProdDali + '::';
	SHARED removeTildeFN(STRING fn2) := REGEXREPLACE('~',fn2,'', NOCASE);
	EXPORT addForeignAlpDev(STRING fn) := foreign_alpha_dev+removeTildeFN(fn);
	EXPORT addForeignAlpProd(STRING fn) := foreign_alpha_PROD+removeTildeFN(fn);
	
	// Copied from _Control.IPAddress in DEV because Boca PROD doesn't contain them
		EXPORT PrimDriver_prefix			:= 'thor::custtest::base';
		SHARED QA := '::qa::';
		EXPORT primaryDriverSuffix 	:= 'primDrivers::alldata';
		EXPORT primaryDriverCleanSfx	:= 'primDrivers_cleaned';

		// ----- MHDR is Dev only --------------------------------------------------------------------
		// ---- new promoteSupers MHDR is final after I added official Bocadids to IHDR --------------
		// EXPORT PS_Merged_Headers_SF 	:= foreign_alpha_dev+'thor::base::customertest_cleanse::Merged_IHDR_BHDR';
		// EXPORT Boca_HDR_Dup377_Name	:= foreign_alpha_dev+'thor::base::customertest_cleanse::Merged_IHDR_BHDR_Dup_377';
		// EXPORT Boca_HDR_Dup363_Name	:= foreign_alpha_dev+'thor::base::customertest_cleanse::Merged_IHDR_BHDR_Dup_363';
		// EXPORT PS_Merged_Headers_DS	:= DATASET(PS_Merged_Headers_SF, Layouts_Alpha.Layout_Merged_IHDR_BHDR, THOR);
		// EXPORT Boca_HDR_Dup377_DS			:= DATASET(Boca_HDR_Dup377_Name, Layouts_Alpha.Layout_Merged_IHDR_BHDR, THOR);
		// EXPORT Boca_HDR_Dup363_DS			:= DATASET(Boca_HDR_Dup363_Name, Layouts_Alpha.Layout_Merged_IHDR_BHDR, THOR);

		// The above MHDR data filtered to be 1 record per person and only the required ones for BC3800
		// EXPORT MHDR_Primary_Recs_DS			:= PS_Merged_Headers_DS(required_bc='Y' AND ((INTEGER)addr_ind=1) );
		// Alpha_Error_File_Name := foreign_alpha_dev+'thor::base::customertest_cleanse::DID_ERRORS_MHDR';
		// EXPORT TMP_DID_ERR_MHDR_SF_DS			:= DATASET(Alpha_Error_File_Name, Layouts_Alpha.Layout_Merged_IHDR_BHDR, THOR);
		// ------------------------------------------------------------------------
		EXPORT InsHeadDLDeath_base_Prefix		:= '~thor::base::ct::InsHeadDLDeath';
		EXPORT AllData_Suffix										:= 'alldata';
		EXPORT InsHeadDLDeath_Base_SF					:= addForeignAlpDev(InsHeadDLDeath_base_Prefix + '::qa::' + AllData_Suffix);
		EXPORT InsHeadDLDeath_Base_SF_PROD		:= addForeignAlpProd(InsHeadDLDeath_base_Prefix + '::qa::' + AllData_Suffix);
		EXPORT InsHeadDLDeath_Base_DS					:= DATASET(InsHeadDLDeath_Base_SF, Layouts_Alpha.IHDR_DL_Death, THOR);
		EXPORT InsHeadDLDeath_Base_DS_PROD		:= DATASET(InsHeadDLDeath_Base_SF_PROD, Layouts_Alpha.IHDR_DL_Death, THOR);

		EXPORT InsHead_Suffix					:= 'InsHead';
		EXPORT InsHead_Base_SF					:= addForeignAlpDev(InsHeadDLDeath_base_Prefix + '::qa::' + InsHead_Suffix);
		EXPORT InsHead_Base_SF_PROD	:= addForeignAlpProd(InsHeadDLDeath_base_Prefix + '::qa::' + InsHead_Suffix);
		EXPORT InsHead_Base_DS					:= DATASET(InsHead_Base_SF, Layouts_Alpha.Layout_InsHead, THOR);
		EXPORT InsHead_Base_DS_PROD	:= DATASET(InsHead_Base_SF_PROD, Layouts_Alpha.Layout_InsHead, THOR);
		// ------------------------------------------------------------------------

		// ------------------------------------------------------------------------
		EXPORT X_Data_Gather_PREFIX_NAME	:= foreign_alpha_dev+'thor::base::customertest_data_gathering';
		EXPORT SUFFIX_VINs_USED 					:= '::ALL_CT_VINs_In_Use';			
		EXPORT Gathered_VINS_Name 				:= X_Data_Gather_PREFIX_NAME+SUFFIX_VINs_USED;		
		EXPORT ALL_CT_VINs_IN_USE_DS 			:= DATASET(Gathered_VINS_Name,Layouts_Alpha.VIN_Simple_Layout,THOR);
		// ------------------------------------------------------------------------
		
		// ------------------------------------------------------------------------
		// NOTE: as of 11/17, out of 47,464 records, 141 of them are not in Boca PHDR		
		EXPORT primaryDriverFile		:= foreign_alpha_dev+PrimDriver_prefix + QA + primaryDriverSuffix;
		EXPORT primaryDriverDS			:= DATASET(primaryDriverFile, Layouts_Alpha.primary_Driver_Rec, THOR, OPT);
		EXPORT primDriverCleanName	:= foreign_alpha_dev+PrimDriver_prefix + QA + primaryDriverCleanSfx;
		EXPORT primDriverCleanDS		:= DATASET(primDriverCleanName, Layouts_Alpha.primary_Driver_Clean_Rec, THOR, OPT);
		// 47,323 have a bocaDID, 141 do not.
		// ------------------------------------------------------------------------
		
		// ------------------------------------------------------------------------
		// ------------------------------------------------------------------------
		// ------------------------------------------------------------------------
		// ------------------------------------------------------------------------
	
END;


