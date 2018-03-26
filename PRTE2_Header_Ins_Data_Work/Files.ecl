/* ***********************************************************************************
NOTE: Because Boca Header build is so Critical - I'm keeping any surplus stuff out of the 
standards "Files" and "Layouts" attributes and none of the rest of this U_* stuff needs to 
be migrated to PROD THOR.  That keeps our portion of the BHDR code in production as small 
as possible.  I did these that hit an error real quickly - there may be more in the Files
Attribute that can also come over here as well, but Layouts is pretty small now.
*********************************************************************************** */

IMPORT ut, PRTE;
IMPORT PRTE_CSV, PRTE2_Common;


EXPORT Files := MODULE
		SHARED Base_Prefix := Files.Base_Prefix;
		SHARED base_name := Files.base_name;
		
		// ----------------------------------------------------------------------------------------------------------------------------------
		EXPORT HDR_BASE_Missing_MHDR		 		:= Base_Prefix+'::'+base_name+'_Study_Missing_MHDR';
		EXPORT HDR_BASE_Missing_MHDR_DS			:= DATASET(HDR_BASE_Missing_MHDR,Layouts.Header_Missing_MHDR_Layout,THOR);

		// ----------------------------------------------------------------------------------------------------------------------------------
		// MAR 2015, this now should be an enhanced audit file, not used in the build, just for research
		EXPORT HDR_AUDIT_ALPHA_NAME 	:= Base_Prefix+'::TMP::'+Files.Audit_Name;
		EXPORT HDR_AUDIT_ALPHA_DS			:= DATASET(HDR_AUDIT_ALPHA_NAME,Layouts.Expanded_Audit_Header_Layout,THOR);
		// ----------------------------------------------------------------------------------------------------------------------------------

END;