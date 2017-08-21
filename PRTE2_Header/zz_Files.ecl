IMPORT ut, PRTE;
IMPORT PRTE_CSV, PRTE2_Common;

EXPORT Files := MODULE
		EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;	// a function
	
		EXPORT Base_Name							:= 'PeopleHeader_Base';
		EXPORT Audit_Name							:= 'PeopleHeader_Audit';
		EXPORT Relationship_Suffix		:= 'PeopleHeader_Base_Relatives';
		EXPORT Base_Prefix						:= '~prct::BASE::ct::alpharetta';
		EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::header::';
		EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::header::';
		EXPORT KEY_PREFIX_NAME				:= '~prte::key::header::';
		EXPORT HDR_CSV_FILE						:= IN_PREFIX_NAME + 'CSV::' + Base_Name;

		EXPORT Base_Layout 						:= prte_csv.ge_header_base.layout_payload;
		EXPORT Relative_Layout 				:= prte_csv.ge_header_base.layout_payload-rtitle;
		// ----------------------------------------------------------------------------------------------------------------------------------
		EXPORT FILE_SPRAY_NAME	:= SPRAYED_PREFIX_NAME + Base_Name+ '_' + ThorLib.Wuid();
		EXPORT SPRAYED_DS				:= DATASET(FILE_SPRAY_NAME, Base_Layout,
	                                CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

		// ----------------------------------------------------------------------------------------------------------------------------------
		// Originally base file built from processing the XREF data ... we can comment this out once we're sure all is good.
		EXPORT HDR_BASE_ALPHA_NAME0		:= Base_Prefix+'::'+base_name;
		EXPORT HDR_BASE_ALPHA_DS0			:= DATASET(HDR_BASE_ALPHA_NAME0,Base_Layout,THOR);

		// ----------------------------------------------------------------------------------------------------------------------------------
		// Feb 2015, this now should be the new Alpharetta Spreadsheet base - built from XREF_Enhanced by PRTE2_Header.U_BWR_CreateInitialFile
		EXPORT HDR_BASE_ALPHA_NAME 		:= Base_Prefix+'::qa::'+base_name;
		EXPORT HDR_BASE_ALPHA_DS			:= DATASET(HDR_BASE_ALPHA_NAME,Base_Layout,THOR);
		// ----------------------------------------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------------------------------------
		// Feb 2015, this should be the Alpharetta PRTE Boca Header build base file ... the above PLUS the relationship join expansion.
		// During the build, the Boca code references PRTE2_
		EXPORT HDR_BASE_ALPHA_RELATES_Name	:= Base_Prefix+'::qa::'+Relationship_Suffix;
		EXPORT HDR_BASE_ALPHA_RELATES_DS		:= DATASET(HDR_BASE_ALPHA_RELATES_Name,Relative_Layout,THOR);

		
		// Obsolete mentioned in z attributes, but moved into PRTE2_PropertyScramble.
		// EXPORT Orig_50k_name		:= 'Orig_50k_Base';
		// EXPORT SPRAY_50_Name		:=  SPRAYED_PREFIX_NAME+Orig_50k_name+ '_' + ThorLib.Wuid();
		// EXPORT SPRAY_50_DS			:=	DATASET(SPRAY_50_Name,layouts.Original_50k_Layout,
	                                // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
		// EXPORT BASE_50k_Name		:=  Base_Prefix+Orig_50k_name;
		// EXPORT BASE_50k_DS			:=	DATASET(BASE_50k_Name,layouts.Original_50k_Layout,THOR);

/*
Boca header keys are prefixed as follows:
prte::key::header*
and 
prte::key::fcra::header*
*/
		// Boca has one main payload + about 4 smaller files that makes up it's entire header data.
		//  This reference is mainly just here for reference to find where this is referenced.
		EXPORT BOCA_MAIN_PAYLOAD_NAME	:=	'~prte::in::header::payload';
		EXPORT BOCA_MAIN_PAYLOAD_DS		:=	PRTE_CSV.Header.dthor_data400__key__header__data;

		// ------- Prod names are solely for the purpose of doing CT desprays from Dev, but getting the prod file. --------------------------
		EXPORT HDR_BASE_ALPHA_Prod_NAME 		:= Add_Foreign_prod(HDR_BASE_ALPHA_NAME);
		EXPORT HDR_BASE_ALPHA_DS_Prod				:= DATASET(HDR_BASE_ALPHA_Prod_NAME,Base_Layout,THOR);
		EXPORT HDR_BASE_ALPHA_REL_Prod_Name	:= Add_Foreign_prod(HDR_BASE_ALPHA_RELATES_Name);
		EXPORT HDR_BASE_ALPHA_DS_RELS_Prod	:= DATASET(HDR_BASE_ALPHA_REL_Prod_Name,Relative_Layout,THOR);
		// ----------------------------------------------------------------------------------------------------------------------------------

END;