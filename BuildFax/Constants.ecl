IMPORT ut, doxie,_control;

EXPORT Constants(STRING sFileName = '', STRING build_date = '', BOOLEAN FCRA = FALSE) := MODULE
  SHARED sProdID            := PRODUCT_NAME;
	SHARED wid                := WORKUNIT;
	SHARED FileSeparator			:= '/';
	EXPORT RecordTerminator   := ['\n'];
	EXPORT FieldSeparator     := '\t';
	EXPORT CommaFieldSeparator := ',';
	EXPORT QuoteBack			    := '\"';
	EXPORT landingzone        := IF(_control.ThisEnvironment.Name!='Prod','10.121.146.129','10.194.64.250');
	EXPORT SENDER_EMAILID			:= IF (_control.ThisEnvironment.Name = 'Prod', 'HPCC@Alpharetta.Production.LexisNexis.com', 'HPCC@Alpharetta.Dev.LexisNexis.com');

	EXPORT contractor         := 'contractor.txt';
	EXPORT correction         := 'correction.txt';
	EXPORT inspection         := 'inspection.txt';
	EXPORT permit            	:= 'permit.txt';
	EXPORT property		        := 'property.txt';
	EXPORT permitcontractor   := 'permitcontractor.txt';
	EXPORT jurisdiction		  	:= 'jurisdiction.txt';
	EXPORT streetlookup		  	:= 'street_lookup.txt';

	EXPORT fcontractor        := '*contractor*.txt';
	EXPORT fcorrection	      := '*corrections*.txt';
	EXPORT finspection        := '*inspection*.txt';
	EXPORT fpermit		        := '*permit*.txt';
	EXPORT fproperty        	:= '*property*.txt';
	EXPORT fpermitcontractor  := '*permitandcontractor*.txt';
	EXPORT fjurisdiction		  := '*jurisdiction*.txt';
	EXPORT fstreetlookup		 	:= '*street_lookup*.txt';
	
	EXPORT fname            	:= case (
															sFileName,
															contractor 				=> fcontractor,
															correction	 			=> fcorrection,
															inspection 				=> finspection,
															permit	 					=> fpermit,
															property	 				=> fproperty,
															permitcontractor 	=> fpermitcontractor,
															jurisdiction 			=> fjurisdiction,
															streetlookup 			=> fstreetlookup,
															'NA'
															);
	EXPORT processDir         := IF(_control.ThisEnvironment.Name!='Prod','/hds_2/buildfax/in/' + trim(build_date,left,right), '/hds_2/buildfax/in/' + trim(build_date,left,right));
	EXPORT processfile        := processDir + FileSeparator + TRIM(fName,left,right); 
	EXPORT devespserverIPport := 'http://'+_control.ThisEnvironment.ESP_IPAddress+':8010/FileSpray';
	EXPORT thor_dest          := if(_control.ThisEnvironment.Name!='Prod','thor40_241',_control.TargetQueue.Thor400_20);
	EXPORT QC_email_target		:= IF (_control.ThisEnvironment.Name = 'Prod', 'Sanjay.Kumar@lexisnexis.com, InsDataBuilds@lexisnexis.com, Gavin.Witz@lexisnexis.com',
	                                 'Sanjay.Kumar@lexisnexis.com');
	EXPORT MAX_RECORD_SIZE		:= 750000;
	
	EXPORT spray_str := '~thor::spray::' + sProdID + '::' + sFileName;
	EXPORT spray_file := spray_str;
	EXPORT spray_subfile := spray_str + '::' + wid;
	
	EXPORT base_str := '~thor::base::' + sProdID;
	EXPORT base_file := base_str + '::qa::' + sFileName;
	EXPORT base_subFile := base_str + '::' + build_date + '::' + sFileName;
	
	EXPORT key_str := '~thor::key::' + sProdID;
	EXPORT key_file := key_str + '::qa::' + sFileName;
	EXPORT key_subFile := key_str + '::' + build_date + '::' + sFileName;

END;