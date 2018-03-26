// PRTE2_PropertyInfo.BWR__View_PropertyInfo_Records
// I added this because WS-ECL page seems to not work showing PII data, maybe too many fields.

IMPORT PRTE2_PropertyInfo as PII;
IMPORT PRTE2_X_Ins_PropertyScramble as SCR;
#workunit('name', 'Boca CT PropertyInfo View');
//----------- Prepare the Export_DS desired --------------------------
PII_Base_SF_DS_DEV		:= PII.Files.PII_ALPHA_BASE_SF_DS;
PII_Base_SF_DS_PROD		:= PII.Files.PII_ALPHA_BASE_SF_DS_Prod;
EXPORT_DS := PROJECT(PII_Base_SF_DS_PROD,PII.Transforms.Gateway_Reduce(LEFT));

// VIEW_RECS := CHOOSEN(EXPORT_DS,1000);
// VIEW_RECS := CHOOSEN(PII_Base_SF_DS_DEV,1000);
VIEW_RECS := CHOOSEN(PII_Base_SF_DS_PROD,1000);

OUTPUT(VIEW_RECS);

