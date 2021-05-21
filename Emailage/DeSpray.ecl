import _Control;

seq_out_csv := SEQUENTIAL(
				 OUTPUT($.AllFiles.dsmetadata,,'~thor::out::emailage::metadata',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT($.AllFiles.dsnames,,'~thor::out::emailage::names',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT($.AllFiles.dsaddress,,'~thor::out::emailage::address',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT($.AllFiles.dsemails,,'~thor::out::emailage::emails',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT($.AllFiles.dsphones,,'~thor::out::emailage::phones',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				,OUTPUT($.AllFiles.dsrelatives,,'~thor::out::emailage::relatives',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				//,OUTPUT($.AllFiles.fraudflags,,'~thor::out::emailage:fraudflags',CSV(HEADING(SINGLE), SEPARATOR('|'),TERMINATOR('\r\n')),OVERWRITE,COMPRESSED)
				);
seq_despray := SEQUENTIAL(
				fileservices.Despray('~thor::out::emailage::metadata',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/metadata.csv',,,,TRUE)
			   ,fileservices.Despray('~thor::out::emailage::names',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/names.csv',,,,TRUE)
			   ,fileservices.Despray('~thor::out::emailage::address',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/address.csv',,,,TRUE)
			   ,fileservices.Despray('~thor::out::emailage::emails',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/emails.csv',,,,TRUE)
			   ,fileservices.Despray('~thor::out::emailage::phones',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/phones.csv',,,,TRUE)
			   ,fileservices.Despray('~thor::out::emailage::relatives',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/relatives.csv',,,,TRUE)
			   //,fileservices.Despray('~thor::out::emailage::fraudflags',_Control.IPAddress.bctlpedata12,'/data/Builds/builds/emailage/data/fraudflags.csv',,,,TRUE)	
		   		);				

EXPORT Despray := SEQUENTIAL(seq_out_csv,seq_despray);
