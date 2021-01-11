//HPCC Systems KEL Compiler Version 1.1.0
IMPORT KEL11 AS KEL;
IMPORT RiskIntelligenceNetwork_Analytics;
IMPORT * FROM KEL11.Null;
EXPORT CFG_Graph := MODULE, VIRTUAL
  // **** The __Part field in parameter datasets is for internal use.  Any value assigned to this  ****;
  // **** field will be ignored.                                                                   ****;
  EXPORT Input_Rin_Params_Layout := RECORD
    KEL.typ.uid __QueryId := 0;
    DATASET(RECORDOF(RiskIntelligenceNetwork_Analytics.Layouts.KelInputLayout)) Input_P_I_I_Dataset_ := DATASET([],RECORDOF(RiskIntelligenceNetwork_Analytics.Layouts.KelInputLayout));
    UNSIGNED4 __Part := 0;
  END;
END;
