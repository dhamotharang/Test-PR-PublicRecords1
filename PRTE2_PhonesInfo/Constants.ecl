IMPORT Data_Services;

EXPORT Constants := module
 EXPORT dops_name := 'PhonesMetadataKeys';
 
 Export trans_in_name:= '~prte::in::met::metadata_trans';

 Export type_in_name:= '~prte::in::met::metadata_type';

 Export trans_in_prime_name:= '~thor_data400::key::phones_transaction_qa';

 export type_in_prime_name:='~thor_data400::key::phones_type_qa';
 
 Export trans_base_name:= '~prte::base::metadata_trans';

 Export type_base_name:= '~prte::base::metadata_type';
 
 Export KeyName_trans:= 	'~prte::key::phones_transaction_'; 
 
 Export KeyName_type:= 	'~prte::key::phones_type_'; 
 
 END;