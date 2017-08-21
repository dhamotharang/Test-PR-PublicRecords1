import ut, tools;

EXPORT Files(STRING  pversion = '',
             BOOLEAN pUseOtherEnvironment = FALSE) := MODULE

	//////////////////////////////////////////////////////////////////
	// -- Input File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Input := MODULE
	
		tools.mac_FilesInput(Corp2_Raw_SD.Filenames(pversion, pUseOtherEnvironment).Input.Vendor_Main, Corp2_Raw_SD.Layouts.vendor_mainLayout, Vendor_Main,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);	
												 
		ds_rawMain		:= project(Vendor_Main.logical, TRANSFORM(Corp2_Raw_SD.Layouts.vendor_mainLayout,SELF := LEFT))((integer)org_corporate_id[3..] <> 0);// ex:RS000000 -Do not Map according to the vendor doc
			
		Corp2_Raw_SD.Layouts.Temp_mainLayout	trfFixCharacters(Corp2_Raw_SD.Layouts.vendor_mainLayout l) := transform
			  
	  	//marking the records with Drop ,when accent symbols found in company names;
		  self.flag	:= if( regexfind('Ã‚|Â²|Ã¢|Â¢|Ãƒ|Âº|Â®|Â¥|Â©',l.org_name),'DROP','GOOD');
		  self      := l;
				
		end;
			
		valid_rawMain						 := project(ds_rawMain,trfFixCharacters(left))(flag <> 'DROP') ;//Per CI:Droping accent symbols included in company names;
			
		Export ds_vendor_rawMain := project(valid_rawMain,transform(Corp2_Raw_SD.Layouts.vendor_mainLayout,self:=left;));
			
		tools.mac_FilesInput(Corp2_Raw_SD.Filenames(pversion, pUseOtherEnvironment).Input.Vendor_Amendments, Corp2_Raw_SD.Layouts.vendor_amendLayout, Vendor_Amend,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);
		tools.mac_FilesInput(Corp2_Raw_SD.Filenames(pversion, pUseOtherEnvironment).Input.Vendor_AR, Corp2_Raw_SD.Layouts.vendor_arLayout, Vendor_AR,
		                     'CSV', , pQuote := '"', pTerminator := ['\n','\r\n'], pSeparator := '|', pHeading := 1);	
	
	END;
	
	
	//////////////////////////////////////////////////////////////////
	// -- Base File Versions
	//////////////////////////////////////////////////////////////////
	EXPORT Base := MODULE
	
		tools.mac_FilesBase(Corp2_Raw_SD.Filenames(pversion, pUseOtherEnvironment).Base.vendor_main, Corp2_Raw_SD.Layouts.vendor_mainLayoutBase, vendor_main);
		tools.mac_FilesBase(Corp2_Raw_SD.Filenames(pversion, pUseOtherEnvironment).Base.vendor_amendments, Corp2_Raw_SD.Layouts.vendor_amendLayoutBase, vendor_amend);	
		tools.mac_FilesBase(Corp2_Raw_SD.Filenames(pversion, pUseOtherEnvironment).Base.vendor_ar, Corp2_Raw_SD.Layouts.vendor_arLayoutBase, vendor_ar);	

	END;

END;