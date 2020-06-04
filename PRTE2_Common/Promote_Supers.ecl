/* ****************************************************************************************************
CustomerTest_Common.Promote_Supers
Created this because we can take all our use of PromoteSupers and move those to this and easily add 
the compress option, which most of them do NOT use.  
ALSO we can have the build process automatically do a createSF if missing. 

Some strange behavior seemed to require importing the local folder and doing the create in here had issues.
The odd issues seem to come and go as platforms and compilers change versions.
**************************************************************************************************** */

EXPORT Promote_Supers := MODULE
			// for some reason, this EXPORT function name cannot match the PromoteSupers macro name or compiler gets confused?? (Current platform anyway)
			EXPORT mac_SFBuildProcess( baseDS, SFName ) := FUNCTIONMACRO
          IMPORT PromoteSupers;
					PS_Mac_CreateSF := PRTE2_Common.SuperFiles.Create_PromoteSupers(SFName,3);
					PromoteSupers.Mac_SF_BuildProcess(baseDS, SFName, PS_Mac_Build,,,TRUE); // last TRUE = compress
					RETURN SEQUENTIAL(PS_Mac_CreateSF ,PS_Mac_Build);
			ENDMACRO;

END;