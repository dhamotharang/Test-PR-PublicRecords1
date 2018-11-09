IMPORT std;

_PRTE_BUILD := FALSE;  // CONFIGURE HEADER FOR PRTE BUILD BY CHNAGING THIS VALUE.

/* How to use:
   ----------
   1) Add the following 2 lines to the attribute that will conditionally input PRTE data:
   import PRTE2_Header;
   #IF (PRTE2_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG);

   2) Add attribute assignment for PRTE case (e.g. EXPORT my_attribute:=PRTE...files..PRTE_file
   3) Add #ELSE and then the existing attribute assignment for a non-PRTE build
   4) Add #END

*/

EXPORT constants := MODULE
        str := '** WARNING: PRTE BUILD!! (CHECK: PRTE2_Header.constants _PRTE_BUILD) ** ';
        EXPORT PRTE_BUILD_WARN_MSG  := str+str+str+str+str+str+str+str+str+str;
        #IF (_PRTE_BUILD) #WARNING(PRTE_BUILD_WARN_MSG) #END;
        EXPORT check_prte_build := '#IF (_PRTE_BUILD) #WARNING(PRTE2_Header.constants.PRTE_BUILD_WARN_MSG) #END';
        EXPORT PRTE_BUILD      := _PRTE_BUILD;
        EXPORT KEY_PREFIX      := '~prte::key::header::';
        EXPORT KEY_PREFIX_FCRA := '~prte::key::fcra::header::';
        EXPORT filename_prct_personrecs := 'prte::in::header::prct_personrecs';

				EXPORT KEY_PREFIX_SLIMSORT 	:= 	'~prte::key::header_slimsort::'; 
        

END;