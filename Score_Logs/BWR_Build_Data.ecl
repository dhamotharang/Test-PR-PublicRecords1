#Workunit('name','Score Attribute and Outcome Build');

parallel(
Score_Logs.proc_CreateTransactionIDFile,
score_logs.proc_CreateBaseFile(false,true);
Score_Logs.Proc_CreateKeys(version, true), //boolean - create temp keys for QA - no XPath
Score_Logs.proc_buildstrata(version)
);
