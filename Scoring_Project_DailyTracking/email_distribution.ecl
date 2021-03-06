/*2017-12-08T02:14:32Z (Bridgett Braaten)
updated BSS_Success_list
*/
EXPORT email_distribution := MODULE

	SHARED at := '@lexisnexis.com,';
	
	SHARED ECL_Developers :=  
										'David.Schlangen' + at +
										'Todd.Steil' + at +
										'Michele.Walklin' + at +
										'Kevin.Huls' + at +
										'Christopher.Albee' + at +
										'Frank.Allen' + at +
										'Andi.Koenen' + at +
										'Laura.Weiner' + at +
										'Brandon.Helm' + at +
										'Laure.Fischer' + at +
									  '';
	
	
										
	SHARED ECL_Developers_Slim :=  
										'Todd.Steil' + at +
										'Michele.Walklin' + at +
										'David.Schlangen' + at +
										'';		
										
	SHARED Product := 
										// 'Mike.Woodberry' + at +
										'Brad.Dolesh' + at +
										'Jeff.Butler' + at +
										'';
	SHARED Product2 := 	
										'Haley.Vicchio' + at +
										'lea.smith' + at +
										'';	
	
	SHARED PR_QA := 
										'Randy.Niemeyer' + at +
										'Benjamin.Karnatz' + at +
										'Bridgett.Braaten' + at +
										'Robert.Connors' + at +
										'Matthew.Ludewig' + at +
										'';
	
	SHARED INS_QA := 
										'Joseph.Nassar' + at +
										'Jonathan.Deurlein' + at +
										'';
	
	SHARED Other_QA := 
										'Nathan.Koubsky' + at +
										'Karthik.Reddy' + at +
										'';
										
	SHARED Modeling := 
										'Nicholas.Montpetit' + at +
										'Darrin.Udean' + at +
										'Brent.Sorenson' + at +
										'Heather.Mccarl' + at +
										'Benjamin.Weiner' + at +
										'';

	SHARED Engineering_QA := 
										'Apaar.Sinha' + at +
										'Brandon.Walker' + at +
										'';
										
  SHARED INS_Engineering := 	
										'Martin.Clary' + at +
										'';

EXPORT general_list := PR_QA + Other_QA + ECL_Developers_Slim;
					
EXPORT general_list_all := PR_QA + Other_QA + INS_QA + Modeling + ECL_Developers_Slim;

EXPORT busshell_list_all := PR_QA + Other_QA + INS_QA + Modeling + ECL_Developers_Slim + Product2;

//EXPORT fail_list := PR_QA + Other_QA;

EXPORT DDT_general_list := PR_QA + Other_QA + Modeling + Product + ECL_Developers_Slim + Engineering_QA + INS_Engineering;

						
// EXPORT Bocashell_collections_success_list := PR_QA + Other_QA + INS_QA + ECL_Developers_Slim;

// EXPORT Bocashell_collections_fail_list := PR_QA + Other_QA + INS_QA;

// EXPORT Daily_Data_collections_fail_list := PR_QA + Other_QA;

// EXPORT KS_Success_list:=	PR_QA + Other_QA + ECL_Developers_Slim + Engineering_QA;

// EXPORT BSS_Success_list:=	PR_QA + Other_QA + Engineering_QA;

// EXPORT BSS_Capone_Specific_Success_list:= PR_QA + Other_QA;		 


// EXPORT general_list := 
					// 'nathan.koubsky@lexisnexis.com;david.schlangen@lexisnexis.com;karthik.pareddy@lexisnexis.com;jayson.alayay@lexisnexis.com;ben.karnatz@lexisnexis.com';
					// 'nathan.koubsky@lexisnexis.com;karthik.reddy@lexisnexis.com;jayson.alayay@lexisnexis.com;benjamin.karnatz@lexisnexis.com;todd.steil@lexisnexis.com;mike.woodberry@lexisnexis.com;Nicholas.Montpetit@lexisnexis.com';
// 'nathan.koubsky@lexisnexis.com;karthik.reddy@lexisnexis.com;jayson.alayay@lexisnexis.com;benjamin.karnatz@lexisnexis.com;todd.steil@lexisnexis.com;frank.allen@lexisnexis.com;apaar.sinha@lexisnexis.com;Bridgett.Braaten@lexisnexis.com;Jonathan.Deurlein@Lexisnexis.com';
					// 'nathan.koubsky@lexisnexis.com';
					
// EXPORT general_list_all := 'nathan.koubsky@lexisnexis.com;Nicholas.Montpetit@lexisnexis.com;darrin.udean@lexisnexis.com;Brent.Sorenson@lexisnexis.com;mike.woodberry@lexisnexis.com;jeffrey.feinstein@lexisnexis.com;Todd.Steil@lexisnexis.com;David.Schlangen@lexisnexis.com;Kenneth.Hill@lexisnexis.com;Brenton.Pahl@lexisnexis.com;Michele.Walklin@lexisnexis.com;heather.mccarl@lexisnexis.com;Robert.Perez@lexisnexis.com;Randy.Niemeyer@lexisnexis.com;Kevin.Huls@lexisnexis.com;InsurView.IV-QA@risk.lexisnexis.com;LNDataQA@risk.lexisnexis.com;rob.mcgee@lexisnexis.com;Nathan.Koubsky@lexisnexis.com;Benjamin.Weiner@lexisnexis.com;Benjamin.Karnatz@lexisnexis.com;Frank.Allen@lexisnexis.com;Apaar.Sinha@lexisnexis.com;Bridgett.Braaten@lexisnexis.com;Jonathan.Deurlein@Lexisnexis.com;Joseph.Nassar@lexisnexis.com';

// EXPORT busshell_list_all := 'nathan.koubsky@lexisnexis.com;Nicholas.Montpetit@lexisnexis.com;darrin.udean@lexisnexis.com;Brent.Sorenson@lexisnexis.com;mike.woodberry@lexisnexis.com;jeffrey.feinstein@lexisnexis.com;Todd.Steil@lexisnexis.com;David.Schlangen@lexisnexis.com;Kenneth.Hill@lexisnexis.com;Brenton.Pahl@lexisnexis.com;Michele.Walklin@lexisnexis.com;heather.mccarl@lexisnexis.com;Robert.Perez@lexisnexis.com;Randy.Niemeyer@lexisnexis.com;Kevin.Huls@lexisnexis.com;InsurView.IV-QA@risk.lexisnexis.com;LNDataQA@risk.lexisnexis.com;rob.mcgee@lexisnexis.com;Nathan.Koubsky@lexisnexis.com;Benjamin.Weiner@lexisnexis.com;Benjamin.Karnatz@lexisnexis.com;Frank.Allen@lexisnexis.com;Apaar.Sinha@lexisnexis.com;Bridgett.Braaten@lexisnexis.com;lea.smith@lexisnexis.com;Jonathan.Deurlein@Lexisnexis.com';
					
EXPORT fail_list :=
					'nathan.koubsky@lexisnexis.com;Joseph.Nassar@lexisnexis.com;benjamin.karnatz@lexisnexis.com;apaar.sinha@lexisnexis.com;karthik.reddy@lexisnexis.com; Bridgett.Braaten@lexisnexis.com;Jonathan.Deurlein@Lexisnexis.com';

// EXPORT DDT_general_list := 
					// 'nathan.koubsky@lexisnexis.com';
// 'nathan.koubsky@lexisnexis.com; karthik.reddy@lexisnexis.com; benjamin.karnatz@lexisnexis.com; frank.allen@lexisnexis.com; suman.burjukindi@lexisnexis.com; Brandon.Walker@lexisnexis.com; Vikram.Pareddy@lexisnexis.com; mike.woodberry@lexisnexis.com; Nicholas.Montpetit@lexisnexis.com; Benjamin.Weiner@lexisnexis.com; Apaar.Sinha@lexisnexis.com; Bridgett.Braaten@lexisnexis.com; Todd.Steil@lexisnexis.com; Martin.Clary@lexisnexis.com;Jonathan.Deurlein@Lexisnexis.com';
					
EXPORT DDT_fail_list :=
					'benjamin.karnatz@lexisnexis.com;apaar.sinha@lexisnexis.com; Bridgett.Braaten@lexisnexis.com;Matthew.Ludewig@lexisnexisrisk.com;Joseph.Nassar@lexisnexis.com;';
					
EXPORT Bocashell_collections_success_list :=
           'Apaar.Sinha@lexisnexis.com,Joseph.Nassar@lexisnexis.com,Benjamin.Karnatz@lexisnexis.com, Nathan.Koubsky@lexisnexis.com ,Bridgett.Braaten@lexisnexis.com,  Matthew.Ludewig@lexisnexisrisk.com';					 
					
EXPORT Bocashell_collections_fail_list :=
					'benjamin.karnatz@lexisnexis.com;Apaar.Sinha@lexisnexis.com;Bridgett.Braaten@lexisnexis.com ;Matthew.Ludewig@lexisnexisrisk.com;Joseph.Nassar@lexisnexis.com;';

EXPORT test_list :=
					'Jonathan.Deurlein@lexisnexis.com';

EXPORT test_list_suman :=
					'suman.burjukindi@lexisnexis.com';	
					
EXPORT test_list_karthik:=
					'karthik.reddy@lexisnexis.com';						
					
Export Runway_test_list :=
						'nathan.koubsky@lexisnexis.com;benjamin.karnatz@lexisnexis.com; apaar.sinha@lexisnexis.com; Bridgett.Braaten@lexisnexis.com';
						
EXPORT Daily_Data_collections_fail_list :=
           'Apaar.Sinha@lexisnexis.com,Benjamin.Karnatz@lexisnexis.com,Bridgett.Braaten@lexisnexis.com,Joseph.Nassar@lexisnexis.com, Matthew.Ludewig@lexisnexisrisk.com;';

EXPORT KS_Success_list:=					 
           'Apaar.Sinha@lexisnexis.com,Joseph.Nassar@lexisnexis.com,Benjamin.Karnatz@lexisnexis.com, Nathan.Koubsky@lexisnexis.com ,Bridgett.Braaten@lexisnexis.com,  Matthew.Ludewig@lexisnexisrisk.com';					 
					 
EXPORT BSS_Success_list:=						 
           'Apaar.Sinha@lexisnexis.com,Joseph.Nassar@lexisnexis.com,Benjamin.Karnatz@lexisnexis.com, Nathan.Koubsky@lexisnexis.com ,Bridgett.Braaten@lexisnexis.com,  Matthew.Ludewig@lexisnexisrisk.com';					 

EXPORT BSS_Capone_Specific_Success_list:=					 
					 'Apaar.Sinha@lexisnexis.com,Joseph.Nassar@lexisnexis.com,Benjamin.Karnatz@lexisnexis.com,Nathan.Koubsky@lexisnexis.com,suman.burjukindi@lexisnexis.com,karthik.reddy@lexisnexis.com,Brandon.Walker@lexisnexis.com,Bridgett.Braaten@lexisnexis.com, Venkat.Arani@lexisnexis.com, Jonathan.Deurlein@lexisnexis.com, Matthew.Ludewig@lexisnexisrisk.com';
					 
EXPORT ISS_Email_list:=					 
					 'karthik.reddy@lexisnexis.com,Bridgett.Braaten@lexisnexis.com';
					 
EXPORT TriCompanyHeader_Alert_List :=
					 'Jonathan.Deurlein@lexisnexis.com,Nathan.Koubsky@lexisnexis.com,narasimha.peruka@lexisnexis.com,ursula.rothe@lexisnexis.com,Neetha.Pagala@lexisnexis.com,Adnan.Siddique@lexisnexis.com,manish.shah@lexisnexis.com,amy.gohdes@lexisnexis.com,kathy.bardeen@lexisnexis.com,Steven.Mullin@risk.lexisnexis.com,Ayeesha.Kayttala@lexisnexis.com,Apaar.Sinha@lexisnexis.com,Jeremy.Bowden@lexisnexis.com,heather.huff@lexisnexis.com,Michael.Mcveigh@lexisnexisrisk.com,Derek.Frankhouser@lexisnexisrisk.com,michele.mcraith@lexisnexisrisk.com,alan.bergman@lexisnexisrisk.com,brianne.olin@lexisnexisrisk.com,Nadia.Simmons@lexisnexisrisk.com,Abigayle.Assetto@lexisnexisrisk.com,John.Markloff@lexisnexisrisk.com,Scott.McDonald@lexisnexisrisk.com,dawn.michels@lexisnexisrisk.com,robert.zimmerman@lexisnexisrisk.com,Venkateswara.Adusumilli@lexisnexisrisk.com,Vinay.Madhadi@lexisnexisrisk.com';

EXPORT HCOHeader_Alert_List :=
					 'Jonathan.Deurlein@lexisnexis.com,Nathan.Koubsky@lexisnexis.com,narasimha.peruka@lexisnexis.com,ursula.rothe@lexisnexis.com,Neetha.Pagala@lexisnexis.com,Adnan.Siddique@lexisnexis.com,manish.shah@lexisnexis.com,amy.gohdes@lexisnexis.com,kathy.bardeen@lexisnexis.com,Steven.Mullin@risk.lexisnexis.com,Ayeesha.Kayttala@lexisnexis.com,Apaar.Sinha@lexisnexis.com,Jeremy.Bowden@lexisnexis.com,heather.huff@lexisnexis.com,Michael.Mcveigh@lexisnexisrisk.com,Derek.Frankhouser@lexisnexisrisk.com,michele.mcraith@lexisnexisrisk.com,alan.bergman@lexisnexisrisk.com,brianne.olin@lexisnexisrisk.com,Nadia.Simmons@lexisnexisrisk.com,Abigayle.Assetto@lexisnexisrisk.com,John.Markloff@lexisnexisrisk.com,Scott.McDonald@lexisnexisrisk.com,dawn.michels@lexisnexisrisk.com,robert.zimmerman@lexisnexisrisk.com,Venkateswara.Adusumilli@lexisnexisrisk.com,Vinay.Madhadi@lexisnexisrisk.com';
					 
EXPORT BocaHeader_Alert_List :=
					 'Jonathan.Deurlein@lexisnexis.com,Nathan.Koubsky@lexisnexis.com,narasimha.peruka@lexisnexis.com,ursula.rothe@lexisnexis.com,Adnan.Siddique@lexisnexis.com,Gabriel.Marcan@lexisnexis.com,Apaar.Sinha@lexisnexis.com';
					
					 				 
END;