import Risk_Indicators, header_services;


File_Telcordia_tds_Base := DATASET('~thor_data400::base::tdsdata',Risk_Indicators.Layout_Telcordia_tds,flat);


string_layout := RECORD
				Layout_Telcordia_tds ;
				string1		eor;	
		end;
  
	header_services.Supplemental_Data.mac_verify('file_telcordia_inj.txt', 
																								string_layout	, 
																								attr );
	Base_File_In := attr();
	
	
	Layout_Telcordia_tds xToTelcordia (Base_File_In L) := TRANSFORM
	     SELF := L ;
		  SELF := [] ;	  
	END ;
	
	Base_To_Telcordia := PROJECT(Base_File_In, xToTelcordia (left)) ;
	ds_Telcordia := File_Telcordia_tds_Base + Base_To_Telcordia ;
	
	export File_Telcordia_tds := ds_Telcordia ;