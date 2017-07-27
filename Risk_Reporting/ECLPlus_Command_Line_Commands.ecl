/* ******************************************************************************************************************
 *  This file is simply an archive of how to run the ECLPlus.exe tool from the command line.  In order to use these *
 * commands you must have a copy of the ECLPlus.exe file on your computer somewhere.  By default it is located under*
 * C:\Program Files (x86)\HPCC Systems\HPCC\bin\eclplus.exe                                                         *
 ********************************************************************************************************************
 *                                                   OPTIONS                                                        *
 ********************************************************************************************************************
 * Cluster: The name of the cluster to use.                                                                         *
 * Server: The URL or IP address of the ECL Watch server.                                                           *
 * Queue: The name of the ECL server queue.                                                                         *
 * Timeout: How long eclplus.exe should wait for input.  Set to 0 to just kick off a job and let it run.            *
 * Ecl: The ECL code to execute. Optionally, this may be replaced by the name of an input file containing ECL to run*
 ********************************************************************************************************************
  Sample Dataland Clusters: infinband_hthor
														thor40_241
														thor5_241_10a
	Sample Production Clusters:	pound_option_thor
															hthor_pound_option
															thor_200
															thor400_84

	Sample Dataland ECL Watch Server: 10.241.3.241
	Sample Production ECL Watch Server: 10.173.84.202
 ********************************************************************************************************************/
 
 /************************************************
  ************************************************
	**     Risk View Daily Score Monitor          **
	************************************************
	** Change owner to your ECL IDE login, and    **
	** password to your ECL IDE password.         **
	************************************************
	************************************************/
eclplus.exe action=query owner=score_tracking password=P@ssword cluster=thor400_84 server=10.173.84.202 timeout=0 ecl=Risk_Reporting.BWR__RiskView__Daily_Score_Monitor

 /************************************************
  ************************************************
	**    Fraud Advisor Daily Score Monitor       **
	************************************************
	** Change owner to your ECL IDE login, and    **
	** password to your ECL IDE password.         **
	************************************************
	************************************************/
eclplus.exe action=query owner=score_tracking password=P@ssword cluster=thor400_84 server=10.173.84.202 timeout=0 ecl=Risk_Reporting.BWR__Fraud_Advisor__Daily_Score_Monitor

 /************************************************
  ************************************************
	**     Instant ID Daily Score Monitor         **
	************************************************
	** Change owner to your ECL IDE login, and    **
	** password to your ECL IDE password.         **
	************************************************
	************************************************/
eclplus.exe action=query owner=score_tracking password=P@ssword cluster=thor400_84 server=10.173.84.202 timeout=0 ecl=Risk_Reporting.BWR__Instant_ID__Daily_Monitor