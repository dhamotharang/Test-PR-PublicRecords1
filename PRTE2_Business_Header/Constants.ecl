import std;

_PRTE_BUILD := false;  // CONFIGURE HEADER FOR PRTE BUILD BY CHNAGING THIS VALUE.

/* How to use:
   ----------
   1) Add the following 2 lines to the attribute that will conditionally input PRTE data:
   import PRTE2_Business_Header;
   #IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);

   2) Add attribute assignment for PRTE case (e.g. EXPORT my_attribute:=PRTE...files..PRTE_file
   3) Add #ELSE and then the existing attribute assignment for a non-PRTE build
   4) Add #END

*/

EXPORT Constants := MODULE
	
	      str := '** WARNING: PRTE BUILD!! (CHECK: PRTE2_Business_Header.constants _PRTE_BUILD) ** ';
        EXPORT PRTE_BUILD_WARN_MSG  := str+str+str+str+str+str+str+str+str+str;
        #IF (_PRTE_BUILD) #WARNING(PRTE_BUILD_WARN_MSG) #END;
        EXPORT check_prte_build := '#IF (_PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG) #END';
        EXPORT PRTE_BUILD				:= _PRTE_BUILD;
				EXPORT BASE_PREFIX			:= '~prte::base::';
        EXPORT KEY_PREFIX				:= '~prte::key::business_header::';
				EXPORT KEY_PREFIX2			:= '~prte::key::';
        //EXPORT KEY_PREFIX_FCRA := '~prte::key::business_header::filtered::fcra::';
				EXPORT dops_name := 'BusinessHeaderKeys';

	
END;