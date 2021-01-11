EXPORT FP_v3_Scores_and_Attributes_XML_Macro_Airflow := Module

IMPORT ut, Risk_Indicators, riskwise, models, RiskProcessing, Scoring_Project_Macros, Scoring_Project_PIP;


		//*********** SETTINGS ********************************

shared		DPPA:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.DPPA;
shared		GLB:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.GLB;
shared		DRM:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.DRM;
shared		DPM:=Scoring_Project_PIP.User_Settings_Module.FP_V3_XML_Generic_FP31505_0_settings.DPM;
shared    HISTORYDATE := 999999;
			
		//*****************************************************

	  //************** INPUT FILE GENERATION ****************	

shared	layout_input := RECORD
		Scoring_Project_Macros.Regression.global_layout;
		Scoring_Project_Macros.Regression.pii_layout;
		Scoring_Project_Macros.Regression.runtime_layout;
	END;

	// shared	ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																// CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


		
		//*********** FP Scores and Attributes XML SETUP AND SOAPCALL ******************	
		
shared	Layout_Attributes_In := RECORD
		string name;
	END;

shared	layout_soap_input := RECORD
		STRING AccountNumber;
		STRING FirstName;
		STRING MiddleName;
		STRING LastName;
		STRING NameSuffix;
		STRING StreetAddress;
		STRING City;
		STRING State;
		STRING Zip;
		STRING Country;
		STRING SSN ;
		STRING DateOfBirth;
		STRING Age;
		STRING DLNumber;
		STRING DLState;
		STRING Email;
		STRING IPAddress;
		STRING HomePhone;
		STRING WorkPhone;
		STRING EmployerName;
		STRING FormerName;
		INTEGER GLBPurpose;
		INTEGER DPPAPurpose;
		string DataRestrictionMask;		
		string datapermissionmask;		
		integer HistoryDateYYYYMM;
		dataset(Risk_Indicators.Layout_Gateways_In) gateways;
		dataset(Layout_Attributes_In) RequestedAttributeGroups;
		string Model;
		boolean IncludeRiskIndices;  
		string Channel;
		string Income;
		string OwnOrRent;
		string LocationIdentifier;
		string OtherApplicationIdentifier;
		string OtherApplicationIdentifier2;
		string OtherApplicationIdentifier3;
		string DateofApplication;
		string TimeofApplication;
		unsigned did := 0;
	END;

shared Layout_Attribute := RECORD, maxlength(10000)
		DATASET(Models.Layout_Parameters) Attribute;
END;
		
shared	Layout_AttributeGroup := RECORD, maxlength(70000)
		string name;
		string index;
		DATASET(Layout_Attribute) Attributes;
END;
		
shared	layout_Soap_output := RECORD, maxlength(100000)
	unsigned8 time_ms {xpath('_call_latency_ms')} := 0;  // picks up timing 
	string30 accountnumber;
	Risk_Indicators.Layout_Input input;
	DATASET(models.Layouts.Layout_Score_FP) Scores;
	// DATASET(Layout_AttributeGroup) AttributeGroup;
	string errorcode;
END;

shared Global_output_lay:= RECORD	 
    Scoring_Project_Macros.Global_Output_Layouts.NONFCRA_FraudPoint_V3_Global_Layout;			 		 
END;
	
shared servicename := 'Models.FraudAdvisor_Service'; 



// Export FLAPSD_MACRO := functionmacro
Export FLAPSD_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := distribute(IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records)),(integer)accountnumber);

/*****************************FLAPSD Input****************************/    
		layout_soap_input append_settings_flapsd(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flapsd := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flapsd(LEFT, counter)), Random());
		
		Soap_output_flapsd := Scoring_Project_PIP.Generic_SoapCall(soap_in_flapsd, roxieIP, servicename, layout_soap_output, threads);				
		tag1 := 'flapsd_';
    ds_output_plus_input_flapsd := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flapsd,soap_in_flapsd, tag1);  //this transform joins the soap output with the input file
		run_flapsd :=  output(ds_output_plus_input_flapsd,, Output_file_name + tag1 + filetag, thor, compressed, overwrite );

		return run_flapsd;		
		
	// endmacro;
	end;
	
// Export FLS_macro := functionmacro
Export FLS_macro(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1,string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


/*****************************FLS Input****************************/  
			layout_soap_input append_settings_fls(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.StreetAddress := '';
			self.City := '';
			self.State := '';
			self.Zip := '';
			self.Country := '';
			self.HomePhone := '';
			self.WorkPhone := '';
			self.DateOfBirth := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_fls := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_fls(LEFT, counter)), Random());
		Soap_output_fls := Scoring_Project_PIP.Generic_SoapCall(soap_in_fls, roxieIP, servicename, layout_soap_output, threads);				
		tag2 := 'fls_';
    ds_output_plus_input_fls := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_fls,soap_in_fls, tag2 );  //this transform joins the soap output with the input file
		run_fls :=	output(ds_output_plus_input_fls,, Output_file_name + tag2 + filetag, thor, compressed, overwrite );
		return run_fls;		
		
	// endmacro;
	end;

Export FLA_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


/*****************************FLA Input****************************/  

			layout_soap_input append_settings_fla(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.HomePhone := '';
			self.WorkPhone := '';
			self.DateOfBirth := '';
			self.SSN := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_fla := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_fla(LEFT, counter)), Random());

		Soap_output_fla := Scoring_Project_PIP.Generic_SoapCall(soap_in_fla, roxieIP, servicename, layout_soap_output, threads);				
		tag3 := 'fla_';
		ds_output_plus_input_fla := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_fla,soap_in_fla, tag3);  //this transform joins the soap output with the input file
		run_fla := output(ds_output_plus_input_fla,, Output_file_name + tag3 + filetag , thor, compressed, overwrite );
		return run_fla;		
		
	// endmacro;
	end;

Export FLAPS_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


/*****************************FLAPS Input****************************/  
			layout_soap_input append_settings_flaps(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.DateOfBirth := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flaps := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flaps(LEFT, counter)), Random());
		
		Soap_output_flaps := Scoring_Project_PIP.Generic_SoapCall(soap_in_flaps, roxieIP, servicename, layout_soap_output, threads);				
		tag4 := 'flaps_';
    ds_output_plus_input_flaps := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flaps,soap_in_flaps, tag4);  //this transform joins the soap output with the input file
		run_flaps :=	 output(ds_output_plus_input_flaps,, Output_file_name + tag4 + filetag, thor, compressed, overwrite );
		return run_flaps;		
		
	// endmacro;
	end;
	
Export FLAPD_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));

/*****************************FLAPD Input****************************/  
			layout_soap_input append_settings_flapd(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.SSN := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flapd := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flapd(LEFT, counter)), Random());

		Soap_output_flapd := Scoring_Project_PIP.Generic_SoapCall(soap_in_flapd, roxieIP, servicename, layout_soap_output, threads);				
		tag5 := 'flapd_';
    ds_output_plus_input_flapd := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flapd,soap_in_flapd, tag5);  //this transform joins the soap output with the input file
		run_flapd :=	output(ds_output_plus_input_flapd,, Output_file_name + tag5 + filetag, thor, compressed, overwrite );
		return run_flapd;		
		
	// endmacro;
	end;

Export FLASD_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));



/*****************************FLASD Input****************************/  
		layout_soap_input append_settings_flasd(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.HomePhone := '';
			self.WorkPhone := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flasd := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flasd(LEFT, counter)), Random());
		Soap_output_flasd := Scoring_Project_PIP.Generic_SoapCall(soap_in_flasd, roxieIP, servicename, layout_soap_output, threads);				
		tag6 := 'flasd_';
    ds_output_plus_input_flasd := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flasd,soap_in_flasd, tag6);  //this transform joins the soap output with the input file
		run_flasd := 	output(ds_output_plus_input_flasd,, Output_file_name + tag6 + filetag, thor, compressed, overwrite );
		return run_flasd;		
		
	// endmacro;
	end;

Export FLPSD_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


/*****************************FLPSD Input****************************/  
		layout_soap_input append_settings_flpsd(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.StreetAddress := '';
			self.City := '';
			self.State := '';
			self.Zip := '';
			self.Country := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flpsd := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flpsd(LEFT, counter)), Random());
		Soap_output_flpsd := Scoring_Project_PIP.Generic_SoapCall(soap_in_flpsd, roxieIP, servicename, layout_soap_output, threads);				
		tag7 := 'flpsd_';
    ds_output_plus_input_flpsd := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flpsd,soap_in_flpsd, tag7);  //this transform j		
		run_FLPSD := output(ds_output_plus_input_flpsd,, Output_file_name + tag7 + filetag, thor, compressed, overwrite );
		return run_FLPSD;		
		
	// endmacro;
	end;

Export FLAP_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));

		
/*****************************FLAP Input****************************/  
		layout_soap_input append_settings_flap(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.SSN := '';
			self.DateOfBirth := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flap := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flap(LEFT, counter)), Random());
		Soap_output_flap := Scoring_Project_PIP.Generic_SoapCall(soap_in_flap, roxieIP, servicename, layout_soap_output, threads);			
		tag8 := 'flap_';
    ds_output_plus_input_flap := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flap,soap_in_flap, tag8);  //this transform joins the soap output with the input file
		run_FLAP :=	output(ds_output_plus_input_flap,, Output_file_name + tag8 + filetag, thor, compressed, overwrite );
		return run_FLAP;		
		
	// endmacro;
	end;

Export FLPS_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));
	
		
/*****************************FLPS Input****************************/  
		layout_soap_input append_settings_flps(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.StreetAddress := '';
			self.City := '';
			self.State := '';
			self.Zip := '';
			self.Country := '';
			self.DateOfBirth := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flps := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flps(LEFT, counter)), Random());
		
		Soap_output_flps := Scoring_Project_PIP.Generic_SoapCall(soap_in_flps, roxieIP, servicename, layout_soap_output, threads);	
		tag9 := 'flps_';
		ds_output_plus_input_flps := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flps,soap_in_flps, tag9);  //this transform joins the soap output with the input file
		run_flps :=  output(ds_output_plus_input_flps,, Output_file_name + tag9 + filetag, thor, compressed, overwrite );		
		return run_flps;		
		
	// endmacro;
	end;
		
Export FLSD_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));
	

/*****************************FLSD Input****************************/  
			layout_soap_input append_settings_flsd(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.StreetAddress := '';
			self.City := '';
			self.State := '';
			self.Zip := '';
			self.Country := '';
			self.HomePhone := '';
			self.WorkPhone := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flsd := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flsd(LEFT, counter)), Random());
		
		Soap_output_flsd := Scoring_Project_PIP.Generic_SoapCall(soap_in_flsd, roxieIP, servicename, layout_soap_output, threads);	
		tag10 := 'flsd_';
    ds_output_plus_input_flsd := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flsd,soap_in_flsd, tag10);  //this transform joins the soap output with the input file
		run_flsd := output(ds_output_plus_input_flsd,, Output_file_name + tag10 + filetag, thor, compressed, overwrite );		
		return run_flsd;		
		
	// endmacro;
	end;


Export FLAD_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));


/*****************************FLAD Input****************************/  
		layout_soap_input append_settings_flad(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.SSN := '';
			self.HomePhone := '';
			self.WorkPhone := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flad := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flad(LEFT, counter)), Random());
		
		Soap_output_flad := Scoring_Project_PIP.Generic_SoapCall(soap_in_flad, roxieIP, servicename, layout_soap_output, threads);	
		tag11 := 'flad_';
    ds_output_plus_input_flad := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flad,soap_in_flad, tag11);  //this transform joins the soap output with the input file
		run_flad := output(ds_output_plus_input_flad,, Output_file_name + tag11 + filetag, thor, compressed, overwrite );		
		return run_flad;		
		
	// endmacro;
	end;
		
		
Export FLAS_MACRO(string roxie_ip, string Gateway_dummy, Thread, Timeout_1, Retry_1, string Input_file_name,string Output_file_name, records_ToRun,string filetag) := function

unsigned8 no_of_records := records_ToRun;
unsigned1 eyeball := 10;
integer retry := retry_1;
integer timeout := timeout_1;
integer threads := Thread;
string roxieIP := roxie_ip ; 
String Infile_name :=  Input_file_name;
String outfile_name :=  Output_file_name ;

ds_raw_input := IF(no_of_records <= 0, DATASET(  infile_name, layout_input,thor),
																CHOOSEN(DATASET( infile_name, layout_input,thor), no_of_records));

		
/*****************************FLAS Input****************************/  
		layout_soap_input append_settings_flas(ds_raw_input le, INTEGER c) := TRANSFORM
		  self.accountnumber := (string)le.accountnumber;	
			self.dppapurpose := dppa;
			self.glbpurpose := glb;
			self.historydateyyyymm := historydate;
			self.datarestrictionmask := drm; 
			self.datapermissionmask := dpm; 
			// self.requestedattributegroups := dataset([{'fraudpointattrv2'}], layout_attributes_in);
			self.model := 'FP31505_0'; 
			self.includeriskindices := true;
			self.gateways := dataset([{'', ''}], risk_indicators.layout_gateways_in);
			self.DateOfBirth := '';
			self.HomePhone := '';
			self.WorkPhone := '';
			self := le;
			self := [];
		END;
 

	  //ds_soap_in
	  soap_in_flas := DISTRIBUTE(PROJECT(ds_raw_input, append_settings_flas(LEFT, counter)), Random());
		Soap_output_flas := Scoring_Project_PIP.Generic_SoapCall(soap_in_flas, roxieIP, servicename, layout_soap_output, threads);			
		tag12 := 'flas_';
		ds_output_plus_input_flas := Scoring_Project_PIP.FP_V3_Generic_Transform_Macro(Soap_output_flas,soap_in_flas, tag12);  //this transform joins the soap output with the input file
		run_flas := output(ds_output_plus_input_flas,, Output_file_name + tag12 + filetag, thor, compressed, overwrite );
		return run_flas;		
		

	end;
		


end;
