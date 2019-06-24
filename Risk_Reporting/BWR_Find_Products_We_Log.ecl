IMPORT Score_Logs;

runNonFCRA := TRUE;
runFCRA := TRUE;

#if(runNonFCRA)
key := Score_Logs.Key_ScoreLogs_XMLTransactionID;

keytable	:=	table(pull(key), {Product, unsigned8 RecordCount := count(group)}, Product, few);

sorts := SORT(keyTable, Product, -RecordCount);

OUTPUT(sorts, NAMED('Logged_Products_Non_FCRA'), all);
#end

#if(runFCRA)
FCRAkey := Score_Logs.Key_FCRA_ScoreLogs_XMLTransactionID;

FCRAkeytable	:=	table(pull(FCRAkey), {Product, unsigned8 RecordCount := count(group)}, Product, few);

FCRAsorts := SORT(FCRAkeyTable, Product, -RecordCount);

OUTPUT(FCRAsorts, NAMED('Logged_Products_FCRA'), all);
#end