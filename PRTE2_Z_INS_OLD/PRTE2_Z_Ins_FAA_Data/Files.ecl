IMPORT PRTE2_Common, PRTE2_FAA_Data;
Layouts := PRTE2_FAA_Data.Layouts;
Constants := PRTE2_FAA_Data.Constants;

EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;		// a function

	EXPORT ALPHA_BASE_NAME				:= 'Alpha_FAA';
	EXPORT aircraft_reg_Name      := 'aircraft_reg';
	EXPORT airmen_Name            := 'airmen';
	EXPORT airmen_certs_Name     	:= 'airmen_certs';
	
	SHARED ModuleName							:= 'faa';
	EXPORT IN_PREFIX_NAME					:= '~prct::IN::ct::'+ModuleName;
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::'+ModuleName;
	EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::'+ModuleName;
	EXPORT KEY_PREFIX 						:= '~prte::key::'+ModuleName;
	
  //Raw Sprayed File:
	EXPORT FILE_SPRAY(STRING FileName)			:= SPRAYED_PREFIX_NAME + '::'+ FileName + '_' + ThorLib.Wuid();
	EXPORT SPRAY_aircraft_reg_DS            := DATASET(FILE_SPRAY(aircraft_reg_Name), Layouts.AlphaBase_aircraft_reg, CSV(HEADING(1), SEPARATOR(Constants.CSVSprayFieldSeparator), QUOTE(Constants.CSVSprayQuote), MAXLENGTH(Constants.CSVMaxCount)));
	EXPORT SPRAY_airmen_DS                  := DATASET(FILE_SPRAY(airmen_Name), Layouts.AlphaBase_airmen, CSV(HEADING(1), SEPARATOR(Constants.CSVSprayFieldSeparator),  QUOTE(Constants.CSVSprayQuote), MAXLENGTH(Constants.CSVMaxCount)));
	EXPORT SPRAY_airmen_certs_DS            := DATASET(FILE_SPRAY(airmen_certs_Name), Layouts.AlphaBase_airmen_certs, CSV(HEADING(1), SEPARATOR(Constants.CSVSprayFieldSeparator),  QUOTE(Constants.CSVSprayQuote), MAXLENGTH(Constants.CSVMaxCount)));
  //Despray File:	
	EXPORT FILE_Despray(STRING FileName)    := IN_PREFIX_NAME + '::CSV::' + FileName;
	EXPORT FILE_DESPRAY_aircraft_reg_CSV		:= FILE_Despray(aircraft_reg_Name);
	EXPORT FILE_DESPRAY_airmen_CSV			  	:= FILE_Despray(airmen_Name);
	EXPORT FILE_DESPRAY_airmen_certs_CSV		:= FILE_Despray(airmen_certs_Name);
	
	// EXPORT FILE_DESPRAY_aircraft_reg_CSV		:= IN_PREFIX_NAME + '::CSV::' + aircraft_reg_Name;
	// EXPORT FILE_DESPRAY_airmen_CSV			  	:= IN_PREFIX_NAME + '::CSV::' + airmen_Name;
	// EXPORT FILE_DESPRAY_airmen_certs_CSV		:= IN_PREFIX_NAME + '::CSV::' + airmen_certs_Name;
	
  /*	
	// EXPORT FILE_SPRAY_PATH				:= SPRAYED_PREFIX_NAME + '::';
	// EXPORT SPRAYED_DS						:= DATASET(FILE_SPRAY, Layouts.AlphaBase,
	                                // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// This is the full Base SF if we can at all join the three records into one spreadsheet.
	EXPORT FAA_Base_SF			:= BASE_PREFIX_NAME + '::qa::' + BASE_NAME;
	EXPORT FAA_Base_SF_DS	  := DATASET(FAA_Base_SF, Layouts.AlphaBase, THOR);
  */
	
	// !!! This SF base DS is what the Boca build will need to read and append.
	EXPORT FAA_aircraft_reg_Base_SF			:= BASE_PREFIX_NAME + '::qa::' + aircraft_reg_Name;
	EXPORT FAA_aircraft_reg_Base_SF_DS	:= DATASET(FAA_aircraft_reg_Base_SF, Layouts.AlphaBase_aircraft_reg, THOR);
	
	EXPORT FAA_airmen_Base_SF		      	:= BASE_PREFIX_NAME + '::qa::' + airmen_Name;
	EXPORT FAA_airmen_Base_SF_DS      	:= DATASET(FAA_airmen_Base_SF, Layouts.AlphaBase_airmen, THOR);
	
	EXPORT FAA_airmen_certs_Base_SF			:= BASE_PREFIX_NAME + '::qa::' + airmen_certs_Name;
	EXPORT FAA_airmen_certs_Base_SF_DS	:= DATASET(FAA_airmen_certs_Base_SF, Layouts.AlphaBase_airmen_certs, THOR);

	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	// EXPORT FAA_Base_SF_Prod			   	   := Add_Foreign_prod(FAA_Base_SF);
	// EXPORT FAA_Base_SF_DS_Prod		       := DATASET(FAA_Base_SF_Prod, Layouts.AlphaBase, THOR);
	
	EXPORT FAA_aircraft_reg_Base_SF_Prod		:= Add_Foreign_prod(FAA_aircraft_reg_Base_SF);
	EXPORT FAA_aircraft_reg_Base_SF_DS_Prod	:= DATASET(FAA_aircraft_reg_Base_SF_Prod, Layouts.AlphaBase_aircraft_reg, THOR);
	
	EXPORT FAA_airmen_Base_SF_Prod			    := Add_Foreign_prod(FAA_airmen_Base_SF);
	EXPORT FAA_airmen_Base_SF_DS_Prod		    := DATASET(FAA_airmen_Base_SF_Prod, Layouts.AlphaBase_airmen, THOR);
	
	EXPORT FAA_airmen_certs_Base_SF_Prod		:= Add_Foreign_prod(FAA_airmen_certs_Base_SF);
	EXPORT FAA_airmen_certs_Base_SF_DS_Prod := DATASET(FAA_airmen_certs_Base_SF_Prod, Layouts.AlphaBase_airmen_certs, THOR);

  //Temp Boca PRTE Dataset  
	EXPORT Temp_Boca_PRTE_data_aircraft_reg_DS := DATASET('~thor_data400::in::prte_csv::faa_aircraft_reg::used::data',Layouts.AlphaBase_aircraft_reg, 
                                                        CSV(QUOTE(['\'"\'']) ,TERMINATOR(['\n']), SEPARATOR('\t'), HEADING(1), MAXLENGTH(4096)));
	EXPORT Temp_Boca_PRTE_data_airmen_DS       := DATASET('~thor_data400::in::prte_csv::faa_airmen::used::data',Layouts.AlphaBase_airmen, 
                                                        CSV(QUOTE(['\'"\'']) ,TERMINATOR(['\n']), SEPARATOR('\t'), HEADING(1), MAXLENGTH(4096)));
	EXPORT Temp_Boca_PRTE_data_airmen_certs_DS := DATASET('~ 	thor_data400::in::prte_csv::faa_airmen_certs::used::data',Layouts.AlphaBase_airmen_certs, 
                                                        CSV(QUOTE(['\'"\'']) ,TERMINATOR(['\n']), SEPARATOR('\t'), HEADING(1), MAXLENGTH(4096)));

END;

