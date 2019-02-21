IMPORT Data_Services, ut,doxie, iesp, Seed_Files, BusinessCredit_Services;
 
EXPORT BusinessCreditReports_files := MODULE
	SHARED max10k := 10000;
	SHARED max20k := 20000;
	
	
	export get_filename(string section) := FUNCTION
	
//===============================================
//===   set the prefix and middle name of the ===
//===   super file name of the test seed files===
//===============================================

  file_prefix := Data_Services.Data_location.Prefix('BCRTestSeed') + 'thor_data400';		
	middle_name := 'testseed::businesscreditreport';

	
		fn := case (section,
									'InputEcho'						=> file_prefix + '::in::' + middle_name + '::inputecho',           
									'BestInfo'        		=> file_prefix + '::in::' + middle_name + '::bestinfo',
									'Scoring'	      			=> file_prefix + '::in::' + middle_name + '::scoring',
									'Summary'		          => file_prefix + '::in::' + middle_name + '::summary',
									'OwnerGuarantor'			=> file_prefix + '::in::' + middle_name + '::ownguartor',
									'TopBusBankr'			  	=> file_prefix + '::in::' + middle_name + '::bankruptcy',
									'TopBusLiens'				  => file_prefix + '::in::' + middle_name + '::topbusliens',
									'TopBusUCC'				  	=> file_prefix + '::in::' + middle_name + '::topbusucc',
									'TopBusProprty'			  => file_prefix + '::in::' + middle_name + '::topbusprop',
									'TopBusMVehicle'      => file_prefix + '::in::' + middle_name + '::topbusmvehicle',
									'TopBusWCraft'		    => file_prefix + '::in::' + middle_name + '::topbuswcraft',
									'TopBusACraft'		    => file_prefix + '::in::' + middle_name + '::topbusacraft',
									'TopBusLicense'	    	=> file_prefix + '::in::' + middle_name + '::topbuslicense',
									'TopBusIncorp'        => file_prefix + '::in::' + middle_name + '::topbusincorp',
									'TopBusOperations'    => file_prefix + '::in::' + middle_name + '::topbusoper',
									'TopBusParent'        => file_prefix + '::in::' + middle_name + '::topbusparent',
									'TopBusConnected'     => file_prefix + '::in::' + middle_name + '::topbusconnect',
									'TopBusContacts'      => file_prefix + '::in::' + middle_name + '::topbuscontact',
									'TopBusFinal'         => file_prefix + '::in::' + middle_name + '::topbusactivity',
									'MatchInfo'      => file_prefix + '::in::' + middle_name + '::crmatch',
									'' );
		if( fn='', FAIL('Unknown Section') );
		return fn;
	end;
	
//==========================================================
//===           Input Echo section 1                     ===
//==========================================================	
	
	export Section1 := dataset(get_filename('InputEcho'), 
        BusinessCredit_Services.Layouts.InputEcho, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));

 				
//============================================================
//===       Best Info Section 2                            ===
//============================================================	
	export Section2 := dataset(get_filename('BestInfo'), 
				BusinessCredit_Services.Layouts.BestInformation, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));

				
//========================================================
//===   Scoring/BusinessCreditScoring Section 3        ===
//========================================================				
	export Section3 := dataset(get_filename('Scoring'), 
				BusinessCredit_Services.Layouts.Scoring, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
	

//=======================================================
//===            Summary Section 4                    ===
//=======================================================				
	export Section4 := dataset(get_filename('Summary'), 
				BusinessCredit_Services.Layouts.Summary, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));

	
//==========================================================
//===     Owner Guarantor    Section 5                   ===
//==========================================================			
	export Section5 := dataset(get_filename('OwnerGuarantor'), 
				BusinessCredit_Services.Layouts.OwnerGuarantors, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
 	
	

//=========================================================
//===   Top Bus Bankruptcy    Section 6                 ===
//=========================================================				
	export Section6 := dataset(get_filename('TopBusBankr'), 
				BusinessCredit_Services.Layouts.TopBusBankruptcy, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
	

//===========================================================
//===   Top Bus Lien     Section 7                       ===
//===========================================================			
	export Section7 := dataset(get_filename('TopBusLiens'), 
				BusinessCredit_Services.Layouts.TopBusLiens, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
	
	
//========================================================
//===   Top Bus UCC     Section 8                      ===
//========================================================
				
	export Section8 := dataset(get_filename('TopBusUCC'), 
				BusinessCredit_Services.Layouts.TopBusUCC, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max20k)));
		
//=======================================================
//===   Top Bus Property    Section 9                 ===
//=======================================================							
	export Section9 := dataset(get_filename('TopBusProprty'), 
				BusinessCredit_Services.Layouts.TopBusProperty, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max20k)));
				
//=======================================================
//===   Top Bus Motor Vehicle   Section 10            ===
//=======================================================				
	export Section10 := dataset(get_filename('TopBusMVehicle'), 
				BusinessCredit_Services.Layouts.TopBusMV, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
				
//=======================================================
//===  Top Bus Watercraft    Section 11               ===
//=======================================================				
	export Section11 := dataset(get_filename('TopBusWCraft'), 
				BusinessCredit_Services.Layouts.TopBusWCraft, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
				
//=======================================================
//===   Top Bus Aircraft     Section 12               ===
//=======================================================				
	export Section12 := dataset(get_filename('TopBusACraft'), 
				BusinessCredit_Services.Layouts.TopBusACraft, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
				
//=======================================================
//===   Top Bus License     Section 13                ===
//=======================================================				
	export Section13 := dataset(get_filename('TopBusLicense'), 
				BusinessCredit_Services.Layouts.TopBusLic, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
				
				
//=======================================================
//===   Top Bus Incorporation    Section 14           ===
//=======================================================				
	export Section14 := dataset(get_filename('TopBusIncorp'), 
				BusinessCredit_Services.Layouts.TopBusIncorp, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
				
//========================================================
//===  Top Bus Operations Sites    Section 15          ===
//========================================================				
	export Section15 := dataset(get_filename('TopBusOperations'), 
				BusinessCredit_Services.Layouts.TopBusOperSites, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
				
//=======================================================
//===     Top Bus Parent Section 16                   ===
//=======================================================				
	export Section16 := dataset(get_filename('TopBusParent'), 
				BusinessCredit_Services.Layouts.TopBusParent, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));


//================================================================
//===   Top Bus ConnectedBusiness     Section 17               ===
//================================================================				
	export Section17 := dataset(get_filename('TopBusConnected'), 
				BusinessCredit_Services.Layouts.TopBusConnected, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
	
	
//=======================================================
//===  Top Bus Contacts       Section 18              ===
//=======================================================						
	export Section18 := dataset(get_filename('TopBusContacts'), 
				BusinessCredit_Services.Layouts.TopBusContacts, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
				
				
//=======================================================
//===  Other         Section 19                       ===
//=======================================================
	export Section19 := dataset(get_filename('TopBusFinal'), 
				BusinessCredit_Services.Layouts.OtherBusInfo, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));
							
 //=======================================================
//===  Other         Section 20                      ===
//=======================================================
	export Section20 := dataset(get_filename('MatchInfo'), 
				BusinessCredit_Services.Layouts.MatchInfo, 
				CSV (heading(1), separator(','), QUOTE('"'), maxlength (max10k)));

END;