// Schedule on dataland
IMPORT _control;
#WORKUNIT('NAME','UPDATE PERSON HEADER FULL AND IKB LINKING KEYS TO DATALAND');
DAILY_AT_1AM:= '01 1 * * *';
_control.fSubmitNewWorkunit(
  
  '#WORKUNIT(\'NAME\',\'UPDATE PERSON HEADER FULL AND IKB LINKING KEYS TO DATALAND\');\n'
 +'Header.Proc_Copy_Keys_To_Dataland.Incrementals;\n'
 +'Header.Proc_Copy_Keys_To_Dataland.FULL;'
  
,'hthor_sta_eclcc'):WHEN(CRON(DAILY_AT_1AM));