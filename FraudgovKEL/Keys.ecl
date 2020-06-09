
rWeightingChart := RECORD
  INTEGER8 EntityType;
  STRING200 Field; 
  STRING Value; 
  DECIMAL Low;
  DECIMAL High; 
  INTEGER RiskLevel; 
  STRING IndicatorType;
  STRING IndicatorDescription;
  INTEGER Weight; 
  STRING UiDescription;
  UNSIGNED customerid := 0;
  UNSIGNED industrytype := 0;
END;

rMyRules := RECORD
UNSIGNED Customerid;
UNSIGNED industrytype;
INTEGER1 entitytype;
STRING RuleName;
STRING Description;
STRING200 Field;
STRING Value;
DECIMAL Low;
DECIMAL High;
INTEGER RiskLevel
END;

d1	:=dataset([],rWeightingChart);
d2	:=dataset([],rMyRules);

EXPORT key_weightingChart := INDEX(d1, {Field, EntityType, CustomerId, IndustryType}, {d1}, '~fraudgov::in::key::configattributes');

EXPORT key_configRules := INDEX(d2, { CustomerId, IndustryType, Field, EntityType}, {d2}, '~fraudgov::in::key::rinrules');

