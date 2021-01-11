EXPORT BusinessShell_Attributes_V2_XML_Macro(roxie_ip, Gateway_dummy, Thread, Timeout, Retry, Input_file_name, Output_file_name, records_ToRun):= FUNCTIONMACRO

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT, RiskProcessing, Scoring, Gateway, Business_Risk_BIP;

		unsigned8 no_of_records := records_ToRun;
		integer retry := retry;
		integer timeout := timeout;
		integer threads := Thread;
		String roxieIP := roxie_ip ; 
		String Infile_name :=  Input_file_name;
		String outfile_name :=  Output_file_name ;
		
		//*********** SETTINGS ********************************

		GLB :=scoring_project_pip.User_Settings_Module.BusinessShell_Attributes_V2_XML_Generic_settings.GLB;  
		DRM :=scoring_project_pip.User_Settings_Module.BusinessShell_Attributes_V2_XML_Generic_settings.DRM;  
		DPM :=scoring_project_pip.User_Settings_Module.BusinessShell_Attributes_V2_XML_Generic_settings.DPM;  
		DPPA:=scoring_project_pip.User_Settings_Module.BusinessShell_Attributes_V2_XML_Generic_settings.DPPA;
		Version := scoring_project_pip.User_Settings_Module.BusinessShell_Attributes_V2_XML_Generic_settings.Version;
		historydateyyyymm:=999999;
		
		// This set's what level to run the Business Shell at.  Options are:
		link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.Default; // Searches at the default level (SeleID)
		// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.PowID; // Searches at the PowID level
		// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.ProxID; // Searches at the ProxID level
		// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.SeleID; // Searches at the SeleID level
		// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.OrgID; // Searches at the OrgID level
		// link_Search_Level := Business_Risk_BIP.Constants.LinkSearch.UltID; // Searches at the UltID level

		BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.Default; // Append Nothing, use what was input
		// BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.AllBlankFields; // Append any missing BII with our "best" company information
		// BIPBestAppend := Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest; // Overwrite any input BII with our "best" company information

		SIC_Code:='';
		NAIC_Code:='';
		PowID:=0;
		ProxID:=0;
		SeleID:=0;
		OrgID:=0;
		UltID:=0;
	
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************
		
		// layout_input := RECORD
		  // Scoring_Project_Macros.Regression.global_layout;
			// Scoring_Project_Macros.Regression.pii_layout;
			// Scoring_Project_Macros.Regression.bus_layout;
			// Scoring_Project_Macros.Regression.runtime_layout;
		// END;
		
		layout_input := Scoring_Project_Macros.Regression.Business_shell_PII;


    ds_raw_input := distribute(IF(no_of_records > 0, CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records),
                            DATASET( infile_name, layout_input, thor)),(integer)acctno);

		//*********** BusinessShell SETUP AND SOAPCALL ******************

		layout_soap_input := RECORD
			INTEGER Seq;
			string AcctNo;
			STRING CompanyName;
			STRING AltCompanyName;
			STRING StreetAddress1;
			STRING StreetAddress2;
			STRING City;
			STRING State;
			STRING Zip9;
			STRING Prim_Range;
			STRING PreDir;
			STRING Prim_Name;
			STRING Addr_Suffix;
			STRING PostDir;
			STRING Unit_Desig;
			STRING Sec_Range;
			STRING Zip5;
			STRING Zip4;
			STRING Lat;
			STRING Long;
			STRING Addr_Type; 
			STRING Addr_Status;
			STRING County;
			STRING Geo_Block;
			STRING FEIN;
			STRING Phone10;
			STRING IPAddr;
			STRING CompanyURL;
			STRING Rep_FullName;
			STRING Rep_NameTitle;
			STRING Rep_FirstName;
			STRING Rep_MiddleName;
			STRING Rep_LastName;
			STRING Rep_NameSuffix;
			STRING Rep_FormerLastName;
			STRING Rep_StreetAddress1;
			STRING Rep_StreetAddress2;
			STRING Rep_City;
			STRING Rep_State;
			STRING Rep_Zip;
			STRING Rep_Prim_Range;
			STRING Rep_PreDir;
			STRING Rep_Prim_Name;
			STRING Rep_Addr_Suffix;
			STRING Rep_PostDir;
			STRING Rep_Unit_Desig;
			STRING Rep_Sec_Range;
			STRING Rep_Zip5;
			STRING Rep_Zip4;
			STRING Rep_Lat;
			STRING Rep_Long;
			STRING Rep_Addr_Type;
			STRING Rep_Addr_Status;
			STRING Rep_County;
			STRING Rep_Geo_Block;
			STRING Rep_SSN;
			STRING Rep_DateOfBirth;
			STRING Rep_Phone10;
			STRING Rep_Age;
			STRING Rep_DLNumber;
			STRING Rep_DLState;
			STRING Rep_Email;
			integer Rep_LexID;
			INTEGER DPPA_Purpose;
			INTEGER GLBA_Purpose;
			STRING Data_Restriction_Mask;
			STRING Data_Permission_Mask;
			INTEGER HistoryDate;
			INTEGER LinkSearchLevel;
			INTEGER BIPBestAppend;
			STRING SIC_Code;
			STRING NAIC_Code;
			integer busshellversion;
			UNSIGNED6 PowID;
			UNSIGNED6 ProxID;
			UNSIGNED6 SeleID;
			UNSIGNED6 OrgID;
			UNSIGNED6 UltID;
		END;

		layout_soap_input make_XML_in(ds_raw_input le, integer c) := TRANSFORM
			self.seq := c;
			SELF.acctno := (string)le.acctno;
			SELF.Rep_LexID := (integer)le.Rep_LexID;
		  // SELF.CompanyName := le.name_company;
			// SELF.AltCompanyName := le.alt_company_name;
			// SELF.StreetAddress1 := le.street_addr2;
			// SELF.StreetAddress2;
			// SELF.City := le.p_city_name_2;
			// SELF.State := le.st_2;
			// SELF.Zip9 := le.z5_2 + le.zip4_2;
			// SELF.Prim_Range;
			// SELF.PreDir;
			// SELF.Prim_Name;
			// SELF.Addr_Suffix;
			// SELF.PostDir;
			// SELF.Unit_Desig;
			// SELF.Sec_Range;
			// SELF.Zip5;
			// SELF.Zip4;
			// SELF.Lat;
			// SELF.Long;
			// SELF.Addr_Type; 
			// SELF.Addr_Status;
			// SELF.County;
			// SELF.Geo_Block;
			// SELF.FEIN := le.fein;
			// SELF.Phone10 := le.workphone;
			// SELF.IPAddr := le.BusinessIPAddress;
			// SELF.CompanyURL;
			// SELF.Rep_FullName;
			// SELF.Rep_NameTitle;
			// SELF.Rep_FirstName := le.firstname;
			// SELF.Rep_MiddleName := le.middlename;
			// SELF.Rep_LastName := le.lastname;
			// SELF.Rep_NameSuffix := le.RepresentativeNameSuffix;
			// SELF.Rep_FormerLastName := le.FormerName;
			// SELF.Rep_StreetAddress1 := le.streetaddress;
			// SELF.Rep_StreetAddress2;
			// SELF.Rep_City := le.city;
			// SELF.Rep_State := le.State;
			// SELF.Rep_Zip := le.Zip;
			// SELF.Rep_Prim_Range;
			// SELF.Rep_PreDir;
			// SELF.Rep_Prim_Name;
			// SELF.Rep_Addr_Suffix;
			// SELF.Rep_PostDir;
			// SELF.Rep_Unit_Desig;
			// SELF.Rep_Sec_Range;
			// SELF.Rep_Zip5;
			// SELF.Rep_Zip4;
			// SELF.Rep_Lat;
			// SELF.Rep_Long;
			// SELF.Rep_Addr_Type;
			// SELF.Rep_Addr_Status;
			// SELF.Rep_County;
			// SELF.Rep_Geo_Block;
			// SELF.Rep_SSN := le.SSN;
			// SELF.Rep_DateOfBirth := le.dateofbirth;
			// SELF.Rep_Phone10 := le.HomePhone;
			// SELF.Rep_Age := le.RepresentativeAge;
			// SELF.Rep_DLNumber := le.DLNumber;
			// SELF.Rep_DLState := le.DLState;
			// SELF.Rep_Email := le.email;
			
			SELF.DPPA_Purpose := DPPA;
			SELF.GLBA_Purpose := GLB;
			SELF.Data_Restriction_Mask := DRM;
			SELF.Data_Permission_Mask := DPM;
			SELF.HistoryDate := historydateyyyymm;
			SELF.LinkSearchLevel := link_Search_Level;
			SELF.SIC_Code := SIC_Code;
			SELF.NAIC_Code := NAIC_Code;
			SELF.BIPBestAppend := BIPBestAppend;
			SELF.PowID := PowID;
			SELF.ProxID := ProxID;
			SELF.SeleID := SeleID;
			SELF.OrgID := OrgID;
			SELF.UltID := UltID;
			self.busshellversion := Version;
			self:=le;
			SELF := [];
    END;

		//ds_soap_in
		soap_in := DISTRIBUTE(PROJECT(ds_raw_input, make_XML_in(LEFT, counter)), RANDOM());

		//Soap output layout
		layout_Soap_output := RECORD
		  string acctno;
			Business_Risk_BIP.Layouts.OutputLayout;
	    unsigned8 time_ms{xpath('_call_latency_ms')} := 0;  // picks up timing
			STRING errorcode;
		END;

		layout_Soap_output myFail(soap_in le) := TRANSFORM
			SELF.errorcode := FAILCODE + FAILMESSAGE;
			self.acctno:= le.acctno;
			SELF := le;
			SELF := [];
		END;

		//*********** PERFORMING SOAPCALL TO ROXIE ************

		Soap_output := SOAPCALL(soap_in, roxieIP,
						'Business_Risk_BIP.Business_Shell_Service', {soap_in}, 
						DATASET(layout_Soap_output),
						PARALLEL(threads), onFail(myFail(LEFT)));			
						
		// ***************************************************************************************************
		// *********************** Transform into layout for use in daily reports ****************************
		// ***************************************************************************************************
				
	  //GLOBAL OUTPUT LAYOUT
		Global_output_lay:= RECORD	 
		  Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout;		
		END;				
		
    Soap_output_pjt:=project(soap_output,transform(Global_output_lay,self.acctno:=left.input_echo.acctno;self:=left));
		
		// final file out to thor
	  final_output := output(Soap_output_pjt ,,outfile_name, thor, compressed, overwrite);
		
		// output(choosen(ds_raw_input,50),named('ds_raw_input'));
		// output(choosen(soap_in,50),named('soap_in'));
		
		RETURN final_output;

ENDMACRO;