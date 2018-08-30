EXPORT files := MODULE
	IMPORT Data_Services;

//Business files - DF-21679
  EXPORT Email_Business     :=  DATASET(Data_Services.foreign_prod+'thor::in::acquireweb::business', layouts.Business_raw, CSV(HEADING(1),TERMINATOR('\n'),SEPARATOR('|'),QUOTE('')));
  EXPORT Email_Busi_dedup   :=  DISTRIBUTE(DEDUP(SORT(Email_Business,RECORD)),HASH32(awid_business));
	EXPORT Email_IPAddress    :=  DATASET(Data_Services.foreign_prod+'thor::in::acquireweb::ipaddress', layouts.Acquireweb_IPAddress, CSV(HEADING(1),TERMINATOR('\n'),SEPARATOR('|'),QUOTE('')));	
	EXPORT Business_w_BIP			:=	DATASET('~thor_data200::base::acquireweb_business_w_bip',layouts.Base_w_bip,THOR,OPT);
	EXPORT Business_Base      :=  PROJECT(Business_w_BIP,TRANSFORM(layouts.Business_Base, SELF := LEFT));

END;