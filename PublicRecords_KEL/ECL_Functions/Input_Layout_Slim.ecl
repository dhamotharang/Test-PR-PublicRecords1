IMPORT PublicRecords_KEL;

EXPORT Input_Layout_Slim := RECORD
  INTEGER InputID;
  PublicRecords_KEL.ECL_Functions.Input_Layout AND NOT [ BALANCE, CHARGEOFFD, FormerName, employername ];
END;
