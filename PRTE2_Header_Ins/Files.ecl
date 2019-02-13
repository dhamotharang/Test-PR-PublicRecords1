/* ********************************************************************************************
PRTE2_Header_Ins.Files
MUST SWITCH TO THE NEW BOCA BUSINESS CASE BUILD PROCESSES - FOR NOW MUST KEEP THE SAME FILE NAMES
NOTE: We only need file info here for 
a) Spray/DeSpray and the data preparation we used to do during the build before the append.
b) Our Base file and 
c) any research/maintenance

Search for:
prct::BASE::ct::alpharetta*peopleheader_Base*
************************************************************************************ */
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

		// NOTE: we never modify or adjust the Boca Person Header base except via the IHDR base, so just save the base in the Boca layout.
		// ----------------------------------------------------------------------------------------------------------------------------------
		// Feb 2015, this now should be the new Alpharetta Spreadsheet base - built from XREF_Enhanced by PRTE2_Header_Ins.U_BWR_CreateInitialFile
		EXPORT HDR_BASE_ALPHA_NAME 		:= Base_Prefix+'::qa::'+base_name;
		EXPORT HDR_BASE_ALPHA_DS			:= DATASET(HDR_BASE_ALPHA_NAME,Base_Layout,THOR);
		// ----------------------------------------------------------------------------------------------------------------------------------

		// ----------------------------------------------------------------------------------------------------------------------------------
		// *** Not certain which base layout the new Boca build uses so save both just in case ***************	BUT WE MAY NOT NEED THIS
		// ----------------------------------------------------------------------------------------------------------------------------------
		// Feb 2015, this should be the Alpharetta PRTE Boca Header build base file ... the above PLUS the relationship join expansion.
		// FEB 2018 - Gabriel says in the new build, they re-generate relations with all combined (legacy+Boca+our data) so this seems to
		// 							be obsolete unless at this time. Gabriel says look at this WU W20180213-102027 in prod thor.		
		EXPORT HDR_BASE_ALPHA_RELATES_Name	:= Base_Prefix+'::qa::'+Relationship_Suffix;
		EXPORT HDR_BASE_ALPHA_RELATES_DS		:= DATASET(HDR_BASE_ALPHA_RELATES_Name,Relative_Layout,THOR);

/*
Boca header keys are prefixed as follows:
prte::key::header*
and 
prte::key::fcra::header*
		// Boca has one main payload + about 4 smaller files that makes up it's entire header data.
		//  This reference is mainly just here for reference to find where this is referenced.
		EXPORT BOCA_MAIN_PAYLOAD_NAME	:=	'~prte::in::header::payload';
		EXPORT BOCA_MAIN_PAYLOAD_DS		:=	PRTE_CSV.Header.dthor_data400__key__header__data;
*/

		// ------- Prod names are solely for the purpose of doing CT desprays from Dev, but getting the prod file. --------------------------
		EXPORT HDR_BASE_ALPHA_Prod_NAME 		:= Add_Foreign_prod(HDR_BASE_ALPHA_NAME);
		EXPORT HDR_BASE_ALPHA_DS_Prod				:= DATASET(HDR_BASE_ALPHA_Prod_NAME,Base_Layout,THOR);
		EXPORT HDR_BASE_ALPHA_REL_Prod_Name	:= Add_Foreign_prod(HDR_BASE_ALPHA_RELATES_Name);
		EXPORT HDR_BASE_ALPHA_DS_RELS_Prod	:= DATASET(HDR_BASE_ALPHA_REL_Prod_Name,Relative_Layout,THOR);
		// ----------------------------------------------------------------------------------------------------------------------------------

END;