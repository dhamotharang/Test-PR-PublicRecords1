// Schedule on dataland
IMPORT _control;
#WORKUNIT('NAME','COPY LINKING KEYS TO DATALAND');
DAILY_AT_1AM:= '01 1 * * *';
_control.fSubmitNewWorkunit(
  
  '#WORKUNIT(\'NAME\',\'COPY LINKING KEYS TO DATALAND\');'
 +'Header.Proc_Copy_Keys_To_Dataland.Incrementals;'
  
,'hthor_sta_eclcc'):WHEN(CRON(DAILY_AT_1AM));