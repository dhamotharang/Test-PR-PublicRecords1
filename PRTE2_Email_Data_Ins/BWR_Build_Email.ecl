/* ******************************************************************************************************************
PRTE2_Email_Data_Ins.BWR_Build_Email - call the official Boca Build code to build both Alpha and Boca data into keys
***************************** YOU MUST FIRST SPRAY OUR ALPHA BASE FILE !!!!  ******************************

**** NOTE: Boca owns the build so our Build_MASTER is calling their code, if they change their code we may have to change this.
**************************** BOCA HAS DATA IN THIS, ALWAYS ASK IF WE CAN BUILD ****************************
********************************************************************************************************************* */

IMPORT PRTE2_Email_Data_Ins, PRTE2_Common;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT Email Data Build');

fileVersion := PRTE2_Common.Constants.TodayString+'';

// IF you are in PROD, should DOPS UpdateVersion happen?
DOPS_Indicator := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;		// Yes do DOPS
// DOPS_Indicator := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;	// NO I will manually do DOPS updateVersion

Production_Steps_To_Do := PRTE2_Email_Data_Ins.After_Build_Actions.post_processing_actions(DOPS_Indicator,fileVersion);
BuildSteps := PRTE2_Email_Data_Ins.Build_MASTER(filedate);				// this uses boca build, nothing here.
 Sequential( BuildSteps
						, Production_Steps_To_Do
					); 