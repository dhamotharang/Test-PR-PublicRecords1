import _Control;

metadata := project(dataset('~thor400_data::persist::emailage::hdr_metadata', $.Layouts.rMetadata, thor)
			 ,transform({$.Layouts.rMetadata - [crlf]}, self := left;));
names := project(dataset('~thor400_data::persist::emailage::hdr_names', $.Layouts.rNames, thor)
			 ,transform({$.Layouts.rNames - [crlf]}, self := left;));
addr := project(dataset('~thor400_data::persist::emailage::hdr_address', $.Layouts.rAddress, thor)
			 ,transform({$.Layouts.rAddress - [crlf]}, self := left;));
emails := project(dataset('~thor400_data::persist::emailage::hdr_emails', $.Layouts.rEmail, thor)
			 ,transform({$.Layouts.rEmail - [crlf]}, self := left;));
phones := project(dataset('~thor400_data::persist::emailage::hdr_phones', $.Layouts.rPhone, thor)
			 ,transform({$.Layouts.rPhone - [crlf]}, self := left;));
relatives := project(dataset('~thor400_data::persist::emailage::hdr_relatives', $.Layouts.rRelative, thor)
			 ,transform({$.Layouts.rRelative - [crlf]}, self := left;));
fraudflags := dataset('~thor400_data::persist::emailage::hdr_fraudflags', $.Layouts.rFraudFlags, thor);

seq_out_csv := SEQUENTIAL(
				 OUTPUT(metadata,,'~thor400_data::out::emailage::hdr_metadata',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT(names,,'~thor400_data::out::emailage::hdr_names',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT(addr,,'~thor400_data::out::emailage::hdr_address',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT(emails,,'~thor400_data::out::emailage::hdr_emails',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT(phones,,'~thor400_data::out::emailage::hdr_phones',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT(relatives,,'~thor400_data::out::emailage::hdr_relatives',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT(fraudflags,,'~thor400_data::out::emailage::hdr_fraudflags',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				);
seq_despray := SEQUENTIAL(
				fileservices.Despray('~thor400_data::out::emailage::hdr_metadata',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/metadata.csv',,,,TRUE)
			   ,fileservices.Despray('~thor400_data::out::emailage::hdr_names',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/names.csv',,,,TRUE)
			   ,fileservices.Despray('~thor400_data::out::emailage::hdr_address',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/address.csv',,,,TRUE)
			   ,fileservices.Despray('~thor400_data::out::emailage::hdr_emails',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/emails.csv',,,,TRUE)
			   ,fileservices.Despray('~thor400_data::out::emailage::hdr_phones',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/phones.csv',,,,TRUE)
			   ,fileservices.Despray('~thor400_data::out::emailage::hdr_relatives',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/relatives.csv',,,,TRUE)
			   ,fileservices.Despray('~thor400_data::out::emailage::hdr_fraudflags',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/fraudflags.csv',,,,TRUE)	
		   		);				

EXPORT Despray := SEQUENTIAL(/*seq_out_csv, */seq_despray);
