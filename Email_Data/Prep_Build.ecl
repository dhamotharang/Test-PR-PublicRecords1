﻿EXPORT Prep_Build := Module

		EXPORT Email_NonFCRA(dsn) := functionmacro
				Import Suppress;
				//'~thor_data400::base::email_data'		
				return(Email_Data.Regulatory.apply_email(dsn));				
		endmacro;

		EXPORT Email_FCRA(dsn) := functionmacro
				Import Suppress;
				//'~thor_data400::base::email_data_fcra'			
				return(Email_Data.Regulatory.apply_email(dsn));				
		endmacro;

end;