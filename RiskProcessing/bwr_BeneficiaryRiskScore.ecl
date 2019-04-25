#WORKUNIT('name','Beneficiary Risk Score');
#OPTION('hthorMemoryLimit',1000);

// NOTES! 
//   o   If running this script as a Builder Window, point to Target: thor5_241_10a
//   o   This script is fully configured and will run successfully if you just hit
//       "Submit". Of course, the source file specified below as sourcefile_name must 
//       be present.
//   o   Those comments that specify "-----> INPUT:" indicate code where you may change
//       one or more values to suit your requirements and/or constraints.

/* ********************************************************************************

     Product Description and (very) High-Level Design

Beneficiary Risk Score will help customers identify potential fraud in their bene-
ficiary population. The score will be based on attributes indicating possible deceased 
or incarcerated individuals, individuals primarily residing in a different state, and 
possible wealth indicators such as property or luxury vehicle ownership.

Generally speaking, the output for this product consists of the results of 
PostBeneficiaryFraud batch appended to the end of the results from Boca Shell. 

******************************************************************************** */

IMPORT Models, RiskWise;

// 1. -----> INPUT: Specify the name of the source file to read from and the 
// name of the file to write the results to; and the name of the file containing 
// those records that incited an error. 
sourcefile_name     := '~albee::out::Completed_Cases_forLexis_v2';
outfile_name        := '~albee::out::Cases_forLexis_v2_thru_BeneficiaryRiskScore';
outfile_errors_name := '~albee::out::Cases_forLexis_v2_thru_BeneficiaryRiskScore_errors';

// Define the layout for the sourcefile.
layout_source_file := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    STRING DLNumber;
    STRING DLState;
    STRING BALANCE; 
    STRING CHARGEOFFD;  
    STRING FormerName;
    STRING EMAIL;  
    STRING employername;
    INTEGER historydateyyyymm;
END;

// Read sourcefile into a dataset for processing...
ds_sourcefile := DATASET( sourcefile_name, layout_source_file, CSV(QUOTE('"')) );

// ...and distribute it across the Thor.
ds_sourcefile_dist := DISTRIBUTE( ds_sourcefile, RANDOM() );

// 2. -----> INPUT: Specify the number_of_records_to_run. If you want to process 
// all of the records in the sourcefile, specify zero (0).
number_of_records_to_run := 0;

ds_sourcefile_limited := 
		CHOOSEN( ds_sourcefile_dist, IF( number_of_records_to_run != 0, number_of_records_to_run, CHOOSEN:ALL ) );

// Define the SOAP interface for Models.BeneficiaryRiskScore_Service.
layout_BeneficiaryRiskScore_input := RECORD

	// =====[ Record-level or SearchBy fields ]=====
	STRING UniqueClientID;            
	STRING DID;                       
	STRING FullName;                  
	STRING FirstName;                 
	STRING MiddleName;                
	STRING LastName;                  
	STRING NameSuffix;                
	STRING StreetAddress1;            
	STRING StreetAddress2;            
	STRING City;                      
	STRING State;                     
	STRING Zip5;                      
	STRING Country;                   
	STRING SocialSecurityNumber;      
	STRING DateOfBirth;               
	UNSIGNED1 Age;                       
	STRING DLNumber;                  
	STRING DLState;                   
	STRING Email;                     
	STRING IPAddress;                 
	STRING HomePhone;                 
	STRING WorkPhone;                 
	STRING EmployerName;              
	STRING FormerName;                
	STRING CaseNumber;                
	STRING BenefitClaimAmount;        
	STRING BenefitsIssuedState;       
	STRING DateAppliedForBenefits;    
	STRING MVRVehicleValue;           
	STRING NumberMVRsReported;        
	STRING NumberPropertiesReported;  
	STRING NumberOfAdultsInHousehold; 
	STRING FillerField1;              
	
	// =====[ Options section ]=====
	
	// =====[ Options: filter by date ]===== 
	INTEGER HistoryDateYYYYMM;         
	STRING historyDateTimeStamp;      
	STRING LastSeenThreshold;         
	STRING SelectTimeFrame;           

	// =====[ Options: include (or not) attributes associated with the subject]===== 
	BOOLEAN IncludeAllAttributeCategories;    
	BOOLEAN IncludeRelativeAndAssociates;     
	BOOLEAN IncludeDriversLicense;            
	BOOLEAN IncludeProperty;                  
	BOOLEAN IncludeInHouseMotorVehicle;       
	BOOLEAN IncludeRealTimeMotorVehicle;      
	BOOLEAN IncludeWatercraftAndAircraft;     
	BOOLEAN IncludeProfessionalLicense;       
	BOOLEAN IncludeBusinessAffiliations;      
	BOOLEAN IncludePeopleAtWork;              
	BOOLEAN IncludeBankruptcyLiensJudgements; 
	BOOLEAN IncludeCriminalSOFR;              
	BOOLEAN IncludeUCCFilings;                

	// =====[ Options: bocashell things ]===== 
	BOOLEAN ExcludeRelatives;       
	BOOLEAN IncludeScore;           
	BOOLEAN ADLBasedShell;          
	BOOLEAN RemoveFares;            
	BOOLEAN LeadIntegrityMode;      

	// =====[ System section ]===== 

	// =====[ System: Permissions ]===== 
	UNSIGNED1 DPPAPurpose;            
	UNSIGNED1 GLBPurpose;             

	// =====[ System: Restrictions ]===== 
	STRING DataRestrictionMask;    
	STRING DataPermissionMask;     
	STRING IndustryClass;          

	// =====[ Miscellany ]=====
	
	// =====[ Miscellany: Query behavior ]===== 
	INTEGER BSVersion;              
	UNSIGNED1 RelativeDepthLevel;     

	// =====[ Miscellany: Gateways ]===== 
	STRING RealTimePermissibleUse; 
	STRING Gateways;               
END;

// 3. -----> INPUT: Convert the sourcefile to the input layout required to run
// Models.BeneficiaryRiskScore_Service. Modify the values inside the transform
// below.
layout_BeneficiaryRiskScore_input xfm_into_BeneficiaryRiskScore_input(layout_source_file le) := TRANSFORM

	// =====[ Record-level or SearchBy fields ]=====
	SELF.UniqueClientID       := le.Account;            
	SELF.DID                  := '';                       
	SELF.FullName             := '';                  
	SELF.FirstName            := le.FirstName;                 
	SELF.MiddleName           := le.MiddleName;   // blank
	SELF.LastName             := le.LastName;                  
	SELF.NameSuffix           := '';                
	SELF.StreetAddress1       := le.StreetAddress;            
	SELF.StreetAddress2       := '';            
	SELF.City                 := le.City;                      
	SELF.State                := le.State;                     
	SELF.Zip5                 := le.Zip;                      
	SELF.Country              := '';                   
	SELF.SocialSecurityNumber := le.SSN;      
	SELF.DateOfBirth          := le.DateOfBirth;               
	SELF.Age                  := 0;                       
	SELF.DLNumber             := le.DLNumber;     // blank
	SELF.DLState              := le.DLState;      // blank
	SELF.Email                := le.Email;        // blank
	SELF.IPAddress            := '';                 
	SELF.HomePhone            := le.HomePhone;    // blank
	SELF.WorkPhone            := le.WorkPhone;    // blank
	SELF.EmployerName         := le.EmployerName; // blank
	SELF.FormerName           := le.FormerName;   // blank
	SELF.CaseNumber           := '';                
	SELF.BenefitClaimAmount   := '';        
	SELF.BenefitsIssuedState   := '';       
	SELF.DateAppliedForBenefits := '';    
	SELF.MVRVehicleValue        := '';           
	SELF.NumberMVRsReported      := '';        
	SELF.NumberPropertiesReported := '';  
	SELF.NumberOfAdultsInHousehold := ''; 
	SELF.FillerField1              := '';              

	// =====[ Options section ]=====
	
	// =====[ Options: filter by date ]===== 
	SELF.HistoryDateYYYYMM    := le.historydateyyyymm;         
	SELF.historyDateTimeStamp := '';      
	SELF.LastSeenThreshold    := '';         
	SELF.SelectTimeFrame      := '';   // i.e. '0'

	// =====[ Options: include (or not) attributes associated with the subject]===== 
	SELF.IncludeAllAttributeCategories    := TRUE;    
	SELF.IncludeRelativeAndAssociates     := TRUE;     
	SELF.IncludeDriversLicense            := TRUE;            
	SELF.IncludeProperty                  := TRUE;                  
	SELF.IncludeInHouseMotorVehicle       := TRUE;       
	SELF.IncludeRealTimeMotorVehicle      := FALSE;      // FALSE !!!
	SELF.IncludeWatercraftAndAircraft     := TRUE;     
	SELF.IncludeProfessionalLicense       := TRUE;       
	SELF.IncludeBusinessAffiliations      := TRUE;      
	SELF.IncludePeopleAtWork              := TRUE;              
	SELF.IncludeBankruptcyLiensJudgements := TRUE; 
	SELF.IncludeCriminalSOFR              := TRUE;              
	SELF.IncludeUCCFilings                := TRUE;                

	// =====[ Options: bocashell things ]===== 
	SELF.ExcludeRelatives  := TRUE;       
	SELF.IncludeScore      := FALSE;           
	SELF.ADLBasedShell     := TRUE;    // Keep this set to TRUE if no LexID/DID is provided in the input.
	SELF.RemoveFares       := FALSE;            
	SELF.LeadIntegrityMode := TRUE;      

	// =====[ System section ]===== 

	// =====[ System: Permissions ]===== 
	SELF.DPPAPurpose := 1;            
	SELF.GLBPurpose  := 1;             

	// =====[ System: Restrictions ]===== 
	SELF.DataRestrictionMask := '00000000000000000000';    
	SELF.DataPermissionMask  := '11111111111111111111';     
	SELF.IndustryClass       := '';          

	// =====[ Miscellany ]=====

	// =====[ Miscellany: Query behavior ]===== 
	SELF.BSVersion          := 50;              
	SELF.RelativeDepthLevel :=  2;     

	// =====[ Miscellany: Gateways ]===== 
	SELF.RealTimePermissibleUse := 'GOVERNMENT'; 
	SELF.Gateways               := [];               
END;

// Convert to input format for Beneficiary Risk Score service.
ds_BeneficiaryRiskScore_input := 
	PROJECT( ds_sourcefile_limited, xfm_into_BeneficiaryRiskScore_input(LEFT) );

// -----> INPUT: Specify the Roxie cluster where the Beneficiary Risk Score service
// lives.
roxieIP := RiskWise.shortcuts.Dev194; // Dev 194 Roxie
// roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876'; // Cert Roxie

// Define the SOAPCALL failure transform.
Models.BeneficiaryRiskScore_Layouts.Search_Final myFail(layout_BeneficiaryRiskScore_input le) :=	
	TRANSFORM
		SELF.accountnumber := le.UniqueClientID;
		SELF.RCDescription10 := FAILCODE + FAILMESSAGE;
		SELF := [];
	END;

// Run the job.
ds_results := 
	SOAPCALL(
		ds_BeneficiaryRiskScore_input, 
		roxieIP,
		'Models.BeneficiaryRiskScore_Service', 
		{ds_BeneficiaryRiskScore_input},
		DATASET(Models.BeneficiaryRiskScore_Layouts.Search_Final),
		PARALLEL(2), 
		onFail(myFail(LEFT))
	);

// -----> INPUT: Uncomment any of the OUTPUT statements below to view that dataset 
// generated during the job.

// OUTPUT( CHOOSEN(ds_sourcefile,100), NAMED('sourcefile') );
// OUTPUT( CHOOSEN(ds_BeneficiaryRiskScore_input,100), NAMED('BeneficiaryRiskScore_input') );
// OUTPUT( CHOOSEN(ds_results,100), NAMED('results') );

// Write results to file. High-five self.
OUTPUT(ds_results, , outfile_name, CSV( /* HEADING, */ QUOTE('"')), OVERWRITE);
OUTPUT(ds_results(errorcode != ''), , outfile_errors_name, CSV( /* HEADING, */ QUOTE('"')), OVERWRITE);
