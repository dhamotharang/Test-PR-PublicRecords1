EXPORT svcBatchNameCleaner := MACRO
  IMPORT BIPV2_Company_Names;
  dInput:=DATASET([],{UNSIGNED rid;STRING250 company_name;}):STORED('input_names');
  BOOLEAN input_alphabetical := FALSE : STORED('input_alphabetical');

  BIPV2_Company_Names.functions.mac_go(dInput,dCnpName,rid,company_name,input_alphabetical);
  
  OUTPUT(dCnpName,NAMED('CleanedNames'));
ENDMACRO;
