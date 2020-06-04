//
// Email_DataV2.Prep_Build
//

EXPORT Prep_Build := Module

		EXPORT EmailV2_NonFCRA(dsn) := functionmacro
				Import Suppress, Email_DataV2;
				//'~thor_data400::base::email_dataV2'		
				return(Email_DataV2.Regulatory.apply_email(dsn));				
		endmacro;

		EXPORT EmailV2_FCRA(dsn) := functionmacro
				Import Suppress, Email_DataV2;
				//'~thor_data400::base::email_dataV2_fcra'			
				return(Email_DataV2.Regulatory.apply_email(dsn));				
		endmacro;

end;