IMPORT ProfileBooster.ProfileBoosterV2_KEL;

EXPORT Input_Layout_Slim := RECORD
  INTEGER G_ProcUID;
  ProfileBoosterV2_KEL.ECL_Functions.Input_Layout AND NOT [ BALANCE, CHARGEOFFD, FormerName, employername ];
END;
