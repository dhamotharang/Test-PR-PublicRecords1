 	 import RiskWise;
import sghatti;
import ut ;

//Here are the URLs to run data collections for testing non-FCRA OSS roxie
// cert130 OSS - roxiecertossvip.sc.seisint.com:9876
// cert128 702 - roxiestaging.sc.seisint.com:9876

// staging_roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert
// QA_roxieIP := RiskWise.shortcuts.QA_neutral_roxieIP; //  QA Roxie --- 'http://roxieqavip.br.seisint.com:9876'; 


// cert130_OSS_roxieIP := 'http://roxiecertossvip.sc.seisint.com:9876';

// fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;//staging
// fcra_roxieIP := RiskWise.Shortcuts.prod_batch_fcra; //prod batch
fcra_roxieIP := RiskWise.Shortcuts.Dev196; //prod batch
// neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;
// neutralroxieIP := RiskWise.shortcuts.prod_batch_neutral;//prod neutral
neutralroxieIP := RiskWise.shortcuts.Dev196;//prod neutral

no_of_threads := 20;

Timeout := 120;
Retry_time := 3;
no_of_recs_to_run := 5;

filetag := 'test';  // i.e. vehicles_cert_130



RV_Scores_V4_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Scores_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_generic_allflagships_v4' + filetag + '_' + ut.GetDate  ;

  RV_Scores_V3_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
RV_Scores_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_generic_allflagships_v3' + filetag + '_' +  ut.GetDate  ;

RV_Attributes_V4_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version4_20140528';
RV_Attributes_V4_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v4' + filetag + '_' +  ut.GetDate  ;

RV_Attributes_V3_XML_infile_name :=  '~scoring_project::in::riskview_xml_generic_version3_20140528';
RV_Attributes_V3_XML_outfile_name := '~ScoringQA::out::FCRA::RiskView_xml_generic_attributes_v3' + filetag + '_' +  ut.GetDate  ;


RV_Attributes_V4_XML := Scoring_Project_Macros_new.RV_Attributes_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V4_XML_infile_name,RV_Attributes_V4_XML_outfile_name,no_of_recs_to_run);

RV_Attributes_V3_XML := Scoring_Project_Macros_new.RV_Attributes_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Attributes_V3_XML_infile_name,RV_Attributes_V3_XML_outfile_name,no_of_recs_to_run);

		 
RV_Scores_V4_XML := Scoring_Project_Macros_new.RV_Scores_V4_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V4_XML_infile_name,RV_Scores_V4_XML_outfile_name,no_of_recs_to_run);

RV_Scores_V3_XML := Scoring_Project_Macros_new.RV_Scores_V3_XML_Macro(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,RV_Scores_V3_XML_infile_name,RV_Scores_V3_XML_outfile_name,no_of_recs_to_run);

		 a:= sequential(RV_Attributes_V4_XML,RV_Attributes_V3_XML,RV_Scores_V4_XML,RV_Scores_V3_XML);
		 
		 
/* 		    			
      RVScores30 := sghatti.RVScores_30 ; //version30
      RVScores := sghatti.RVScores ; //version40

RVAttributes30 := sghatti.RVAttributes_30 ;  //version 30
RVAttributes := sghatti.RVAttributes ;  //version 40


*/

a;