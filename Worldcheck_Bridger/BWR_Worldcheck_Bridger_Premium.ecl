export BWR_Worldcheck_Bridger_Premium(file_date) := macro
#OPTION('multiplePersistInstances',FALSE);

#workunit('priority','high')
//Inputs
standard          := 'world-check.csv';
prem_plus         := 'premium-world-check.csv';
prem_plus_nat     := 'world-check-native-character-names.csv';
filedate          := file_date;
//Functions
spray_files     := worldcheck_bridger.proc_WorldCheck_Bridger_Spray(standard, prem_plus, prem_plus_nat, filedate);
build_premium   := worldcheck_bridger.Proc_Build_Worldcheck_Premium_Plus(filedate);
//build_standard  := worldcheck_bridger.proc_build_worldcheck_standard(filedate);
//Output
sequential(spray_files,build_premium/*,build_standard*/);

endmacro;
