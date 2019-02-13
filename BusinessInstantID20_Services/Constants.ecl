﻿
EXPORT Constants := MODULE
	EXPORT RESTRICTED_SET := ['0',''];
	
	EXPORT BVI_NOHIT_VALUES := ['','0'];
	
	EXPORT BVI_DESC_KEY_NOHIT_VALUES := ['311','411','412'];
	
	EXPORT SUPPRESSABLE_RISK_CODES := ['10','11','12','13','14','15','16','18','23','24','25','29','36','38','39','40','41','42','47','48','49','50'];

	EXPORT INCLUDE_AUTHREP_IN_BIP_APPEND := TRUE;

	EXPORT IS_BIID_20	:= TRUE;
  
  EXPORT EXCLUDEWATCHLISTS := FALSE;
  
	EXPORT DEFAULT_OFAC_VERSION := 2; // Change to "4" after MBS sweep.
  
	EXPORT MAX_OFAC_VERSION := 4;
END;