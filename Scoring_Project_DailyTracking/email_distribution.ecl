/*2017-12-08T02:14:32Z (Bridgett Braaten)
updated BSS_Success_list
*/
EXPORT email_distribution := MODULE

	SHARED at := '@lexisnexisrisk.com,';
	
	SHARED ECL_Developers :=  
										// 'David.Schlangen' + at +
										// 'Todd.Steil' + at +
										// 'Michele.Walklin' + at +
										// 'Kevin.Huls' + at +
										// 'Christopher.Albee' + at +
										// 'Frank.Allen' + at +
										// 'Andi.Koenen' + at +
										// 'Laura.Weiner' + at +
										// 'Laure.Fischer' + at +
									  '';
	
	
										
	SHARED ECL_Developers_Slim :=  
										// 'Todd.Steil' + at +
										// 'Michele.Walklin' + at +
										// 'David.Schlangen' + at +
										// 'andi.koenen' + at +
										// 'christopher.albee' + at +
										'';		
										
	SHARED Product := 
										// 'Mike.Woodberry' + at +
										// 'Brad.Dolesh' + at +
										// 'Jeff.Butler' + at +
										'';
	SHARED Product2 := 	
										// 'Haley.Vicchio' + at +
										// 'lea.smith' + at +
										'';	
	//2/24/2020 edited PR_QA
	SHARED PR_QA := 
										'isabel.ma' + at +
										'Matthew.Ludewig' + at +
										'Apaar.Sinha' + at +
										'Daniel.Harkins' + at +
										'Sheryl.Ramos' + at +
										'Noah.Lahr' + at +
										'Lucky.Mores' + at +
										'Vishesh.Dosaj' + at +
          'alexander.garcia' + at +
					     'Crayton.Hudspeth' + at +
										'';
	
	// SHARED INS_QA := 
// ;
	
//2/1/2020 added Scoring_QA for boca_54
//2/24/20  edited Scoring_QA
	  SHARED Scoring_QA	:= 
		                 //'isabel.ma' + at +
										         //'Matthew.Ludewig' + at +
 		                //'alexander.garcia' + at + 
	                   '';
	SHARED Other_QA := 
										// 'Nathan.Koubsky' + at +
										'';
										
	SHARED Modeling := 
										// 'Nicholas.Montpetit' + at +
										// 'Darrin.Udean' + at +
										// 'Brent.Sorenson' + at +
										// 'Benjamin.Weiner' + at +
										'';

	SHARED Engineering_QA := 
										// 'Apaar.Sinha' + at +
										'';
										
  SHARED INS_Engineering := 	
										// 'Martin.Clary' + at +
										'';

EXPORT general_list := PR_QA + Other_QA + ECL_Developers_Slim;
					
EXPORT general_list_all := PR_QA + Other_QA +  Modeling + ECL_Developers_Slim;

EXPORT busshell_list_all := PR_QA + Other_QA +  Modeling + ECL_Developers_Slim + Product2;

//EXPORT fail_list := PR_QA + Other_QA;

EXPORT DDT_general_list := PR_QA + Other_QA + Modeling + Product + ECL_Developers_Slim + Engineering_QA + INS_Engineering;

//2/11/2020 added email distribution for boca_54
EXPORT boca_54_list	:= Scoring_QA;
export addr_reports :=               'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com; Todd.Steil@lexisnexisrisk.com;Michele.Walklin@lexisnexisrisk.com;David.Schlangen@lexisnexisrisk.com'	;					
export business_reports :=           'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com; lea.smith@lexisnexisrisk.com; Lewis.Hughes@lexisnexisrisk.com;Todd.Steil@lexisnexisrisk.com;Michele.Walklin@lexisnexisrisk.com;David.Schlangen@lexisnexisrisk.com;Zachary.Fredenberg@lexisnexisrisk.com;Noah.Lahr@lexisnexisrisk.com,Wei.Liu@lexisnexisrisk.com;Samantha.Shepler@lexisnexisrisk.com';					
export business_reports_detailed :=  'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com; Lewis.Hughes@lexisnexisrisk.com; apaar.sinha@lexisnexisrisk.com; lea.smith@lexisnexisrisk.com;Zachary.Fredenberg@lexisnexisrisk.com;Noah.Lahr@lexisnexisrisk.com, Wei.Liu@lexisnexisrisk.com,Samantha.Shepler@lexisnexisrisk.com';					
export prod_reports :=               'Apaar.Sinha@lexisnexisrisk.com; Isabel.Ma@lexisnexisrisk.com; Matthew.Ludewig@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com; Lucky.Mores@lexisnexisrisk.com; Vishesh.Dosaj@lexisnexisrisk.com';					



EXPORT fail_list :=
					'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com;apaar.sinha@lexisnexisrisk.com;Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com;Noah.Lahr@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com;Vishesh.Dosaj@lexisnexisrisk.com';

		
EXPORT DDT_fail_list :=
					'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com;apaar.sinha@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com;Vishesh.Dosaj@lexisnexisrisk.com';
					
EXPORT Bocashell_collections_success_list :=
					'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com;benjamin.karnatz@lexisnexisrisk.com;apaar.sinha@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com;Vishesh.Dosaj@lexisnexisrisk.com';
					
EXPORT Bocashell_collections_fail_list :=
					'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com;apaar.sinha@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com;Vishesh.Dosaj@lexisnexisrisk.com;alexander.garcia@lexisnexisrisk.com';

EXPORT test_list :=
					'isabel.ma@lexisnexisrisk.com';

EXPORT test_list_suman :=
					'suman.burjukindi@lexisnexis.com';	
					
EXPORT test_list_karthik:=
					'karthik.reddy@lexisnexis.com';						
					
Export Runway_test_list :=
						'Matthew.Ludewig@lexisnexisrisk.com; apaar.sinha@lexisnexisrisk.com';
						
EXPORT Daily_Data_collections_fail_list :=
					'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com;apaar.sinha@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com;Vishesh.Dosaj@lexisnexisrisk.com';

EXPORT KS_Success_list:=					 
					'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com; apaar.sinha@lexisnexisrisk.com;Vishesh.Dosaj@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Crayton.Hudspeth@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com';				 
					 
EXPORT BSS_Success_list:=						 
					'Matthew.Ludewig@lexisnexisrisk.com;Isabel.Ma@lexisnexisrisk.com; apaar.sinha@lexisnexisrisk.com;Vishesh.Dosaj@lexisnexisrisk.com; Sheryl.Ramos@lexisnexisrisk.com;Daniel.Harkins@lexisnexisrisk.com; Noah.Lahr@lexisnexisrisk.com;Lucky.Mores@lexisnexisrisk.com';				 

EXPORT BSS_Capone_Specific_Success_list:=					 
					 'Apaar.Sinha@lexisnexisrisk.com, Matthew.Ludewig@lexisnexisrisk.com,isabel.ma@lexisnexisrisk.com';
					 
// EXPORT ISS_Email_list:=					 
					 // 'Bridgett.Braaten@lexisnexis.com';
					 
EXPORT TriCompanyHeader_Alert_List :=
					 'narasimha.peruka@lexisnexis.com,Neetha.Pagala@lexisnexis.com,manish.shah@lexisnexis.com,amy.gohdes@lexisnexis.com,kathy.bardeen@lexisnexis.com,Steven.Mullin@risk.lexisnexis.com,Ayeesha.Kayttala@lexisnexis.com,Apaar.Sinha@lexisnexis.com,Jeremy.Bowden@lexisnexis.com,heather.huff@lexisnexis.com,Michael.Mcveigh@lexisnexisrisk.com,Derek.Frankhouser@lexisnexisrisk.com,michele.mcraith@lexisnexisrisk.com,alan.bergman@lexisnexisrisk.com,brianne.olin@lexisnexisrisk.com,Nadia.Simmons@lexisnexisrisk.com,Abigayle.Assetto@lexisnexisrisk.com,John.Markloff@lexisnexisrisk.com,Scott.McDonald@lexisnexisrisk.com,dawn.michels@lexisnexisrisk.com,robert.zimmerman@lexisnexisrisk.com,Venkateswara.Adusumilli@lexisnexisrisk.com,Vinay.Madhadi@lexisnexisrisk.com';

EXPORT HCOHeader_Alert_List :=
					 'narasimha.peruka@lexisnexis.com,Neetha.Pagala@lexisnexis.com,manish.shah@lexisnexis.com,kathy.bardeen@lexisnexis.com,Steven.Mullin@risk.lexisnexis.com,Ayeesha.Kayttala@lexisnexis.com,Apaar.Sinha@lexisnexis.com,Jeremy.Bowden@lexisnexis.com,heather.huff@lexisnexis.com,Michael.Mcveigh@lexisnexisrisk.com,Derek.Frankhouser@lexisnexisrisk.com,michele.mcraith@lexisnexisrisk.com,alan.bergman@lexisnexisrisk.com,brianne.olin@lexisnexisrisk.com,Nadia.Simmons@lexisnexisrisk.com,Abigayle.Assetto@lexisnexisrisk.com,John.Markloff@lexisnexisrisk.com,Scott.McDonald@lexisnexisrisk.com,dawn.michels@lexisnexisrisk.com,robert.zimmerman@lexisnexisrisk.com,Venkateswara.Adusumilli@lexisnexisrisk.com,Vinay.Madhadi@lexisnexisrisk.com';
					 
EXPORT BocaHeader_Alert_List :=
					 'narasimha.peruka@lexisnexis.com,Gabriel.Marcan@lexisnexis.com,Apaar.Sinha@lexisnexis.com';
					
EXPORT SOCIO_Daily_Monitoring_Success_List :=
				   'Daniel.Harkins@lexisnexisrisk.com,Matthew.Ludewig@lexisnexisrisk.com,Isabel.Ma@lexisnexisrisk.com,Sheryl.Ramos@lexisnexisrisk.com,Crayton.Hudspeth@lexisnexisrisk.com,Noah.Lahr@lexisnexisrisk.com';


END;