#workunit('name','RVA v4 XML Collection');
import ut, RiskWise, Scoring_Project_Macros, Scoring_Project_PIP;
 

historydate := 201604;   //Change this to what archive date you want in YYYYMM format.  999999 for realtime.
filetag := '_1';  //change filetag name for runs on the same day and historydate or they will overwrite


//**********SETTINGS **********************
no_of_threads := 20;         //20 threads when running on an hthor
fcra_roxieIP := riskwise.shortcuts.staging_fcra_roxieip ;        //staging
neutralroxieIP := RiskWise.shortcuts.QA_neutral_roxieIP;         //QA Neutral
Timeout := 120;
Retry_time := 3;
DPPA:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V4_XML_Generic_settings.DPPA;   // 0
GLB:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V4_XML_Generic_settings.GLB;     // 5
DRM:=Scoring_Project_PIP.User_Settings_Module.RV_Attributes_V4_XML_Generic_settings.DRM;     // '100001000100'
message:=output('RVA_v4_XML_Collection_Failed');


RV_V4_Generic_infile :=  scoring_project_pip.Input_Sample_Names.RV_V4_Generic_infile;

		layout_input := RECORD
			Scoring_Project_Macros.Regression.global_layout;
			Scoring_Project_Macros.Regression.pii_layout;
			Scoring_Project_Macros.Regression.runtime_layout;
		END;

Input_dataset := DATASET(RV_V4_Generic_infile, layout_input, thor);


RV_Attributes_V4_XML_Generic_outfile := scoring_project_pip.Output_Sample_Names.RV_Attributes_V4_XML_Generic_outfile + ut.GetDate + '_ArchiveDate' + historydate + filetag;


//********************************

RV_Attributes_V4_XML := zz_bkarnatz.RV_Attributes_V4_XML_Macro_HistoryDate(fcra_roxieIP, neutralroxieIP,no_of_threads,Timeout,Retry_time,Input_dataset,RV_Attributes_V4_XML_Generic_outfile, historydate, DPPA, GLB, DRM):RECOVERY(message,10);

RV_Attributes_V4_XML;