﻿IMPORT ut;
EXPORT Proc_BuildAll(string version = ut.getdate) := 

SEQUENTIAL(
														score_logs.fn_SprayFiles();
														Score_Logs.fn_Validate.dall;
														score_logs.proc_CreateBaseFile(); //parameters let you choose to not output a certain base file (transaction, accounting, intermediate)
														Score_Logs.TransactionID_stats();
														Score_Logs.Proc_CreateKeys(version);
														Score_Logs.proc_buildstrata(version)
													);

