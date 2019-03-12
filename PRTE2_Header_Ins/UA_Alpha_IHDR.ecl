/* ************************************************************************************
PRTE2_Header_Ins.UA_Alpha_IHDR  (UA = Utility Automated Job code)

Added to Boca Header code to allow access to the Alpharetta Insurance Header base file
************************************************************************************ */

IMPORT _control;

EXPORT UA_Alpha_IHDR := MODULE

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


		EXPORT Layout_InsHead := RECORD
				INTEGER			id;
				UNSIGNED6		RID;
				STRING2 		ADDR_IND;
				STRING9			fb_ssn;
				STRING30		fb_first_name;
				STRING20		fb_mid_name;
				STRING30		fb_last_name;
				STRING30		fb_2lst_name; 
				STRING20		fb_sfx_name;
				STRING20		fb_house_num;
				STRING2     fb_predir;	// Added in Aug 2015
				STRING30		fb_street;
				STRING20		fb_stsfx;
				STRING2     fb_postdir; // Added in Aug 2015
				STRING20		fb_unit_name;
				STRING20		fb_unit_no;
				STRING30		fb_city;
				STRING5			fb_state;
				STRING5			fb_zip;
				STRING4			fb_zip4;
				STRING4 		fb_err_stat;  // Added in Aug 2015
				STRING3			fb_gender;
				STRING8			fb_dob;
				STRING30		fb_dln;
				STRING2			fb_dlstate;
				STRING20		fb_dln_type;										
				STRING1628 	fb_other;
				STRING8   	fb_loaddt;
				STRING4   	fb_score;
				UNSIGNED6 	fb_seq;
				STRING1   	fb_rest;
				STRING8 		fb_first_dt;
				STRING8			fb_last_dt;
				STRING9			fb_src := '';
				STRING2			INSURANCE_TYPE:='PA';
		END;
		
		EXPORT InsHead_Prefix				:= '~thor::base::ct::InsHeadDLDeath';
		EXPORT InsHead_Suffix				:= 'InsHead';
		EXPORT InsHead_Base_SF			:= addForeignAlpDev(InsHead_Prefix + '::qa::' + InsHead_Suffix);
		EXPORT InsHead_Base_SF_PROD	:= addForeignAlpProd(InsHead_Prefix + '::qa::' + InsHead_Suffix);
		EXPORT InsHead_Base_DS			:= DATASET(InsHead_Base_SF, Layout_InsHead, THOR);
		EXPORT InsHead_Base_DS_PROD	:= DATASET(InsHead_Base_SF_PROD, Layout_InsHead, THOR);


END;