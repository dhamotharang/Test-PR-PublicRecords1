//HPCC Systems KEL Compiler Version 1.1.0
#OPTION('expandSelectCreateRow',true);
IMPORT KEL11 AS KEL;
IMPORT RiskIntelligenceNetwork_Analytics;
IMPORT CFG_Graph,RQ_Input_Rin FROM RiskIntelligenceNetwork_Analytics;
IMPORT * FROM KEL11.Null;
DATASET(RECORDOF(RiskIntelligenceNetwork_Analytics.Layouts.KelInputLayout)) __PInputPIIDataset := DATASET([],RECORDOF(RiskIntelligenceNetwork_Analytics.Layouts.KelInputLayout)) : STORED('InputPIIDataset');
__RoxieQuery := RQ_Input_Rin(DATASET([{1,__PInputPIIDataset}],CFG_Graph.Input_Rin_Params_Layout));
OUTPUT(__RoxieQuery.Res0,NAMED('Result'));
