IMPORT Data_Services;

EXPORT Constants := module
 EXPORT dops_name := 'PhonesMetadataMonthlyKeys';
 
 EXPORT in_carrier_reference					:= Data_Services.foreign_prod + 'thor_data400::base::phones::source_reference_main';
	
 EXPORT base_carrier_reference 			 	:= '~prte::base::phones::phones::source_reference_main';
	
 EXPORT KeyName_phones := '~prte::key::';

  EXPORT KeyName_carrier_reference:= 	'phonesmetadata::carrier_reference'; 
 
 Export KeyName_lerg6 :='phones_lerg6';
	 
END;