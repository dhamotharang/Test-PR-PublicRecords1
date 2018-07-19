

EXPORT macPivotOttoOutput(indata,fieldlist,outputfieldlist):=FUNCTIONMACRO
  IMPORT RAMPS_Functions;
  IMPORT Std;
  
  d := DISTRIBUTE(KELOtto.SlimDataSet(indata, fieldlist,outputfieldlist)); // strip down to only the columns needed
  
  LOADXML('<xml/>');
  #DECLARE(EntityHash) #SET(EntityHash, 'HASH32(LEFT.' + REGEXREPLACE(',', fieldlist, ' + \'|\' + LEFT.') + ')');
  
  d1 := PROJECT(d, TRANSFORM({RECORDOF(LEFT), UNSIGNED8 EntityHash}, SELF.EntityHash := %EntityHash%, SELF := LEFT));
  d2 := RAMPS_Functions.macPivotLiteV2(d1, EntityHash, outputfieldlist);
  d3 := PROJECT(d2, TRANSFORM({RECORDOF(LEFT), STRING indicatortype, STRING indicatordescription, STRING Label, STRING FieldType, UNSIGNED RiskLevel}, 
	                 SELF.indicatordescription := MAP(LEFT.field[1..3] = 'cl_' => 'Cluster', MAP(LEFT.field[1..3] = 'vl_' => 'Velocity', MAP(LEFT.field[1..3] = 'kr_' => 'Known Risk', MAP(LEFT.field[1..3] = 'id_' => 'Identity', 'unk')))),
									 SELF.indicatortype := MAP(LEFT.field[1..3] = 'cl_' => 'CL', MAP(LEFT.field[1..3] = 'vl_' => 'VL', MAP(LEFT.field[1..3] = 'kr_' => 'KR', MAP(LEFT.field[1..3] = 'id_' => 'ID', 'unk')))),
									 SELF.RiskLevel := RANDOM() % 4;
									 
                   SELF.Label := TRIM(Std.Str.ToCapitalCase(Std.Str.FindReplace(LEFT.Field, '_', ' ')), LEFT), 
                   SELF.FieldType := MAP(TRIM(LEFT.Field)[LENGTH(TRIM(LEFT.Field))-7 ..] = 'percent_' => 'Percent', 
                                       MAP(TRIM(LEFT.Field)[LENGTH(TRIM(LEFT.Field))-4 ..] = 'date_' or LEFT.Field[1..4] = 'date' => 'Date',
                                                        'Number')),
                   SELF := LEFT));  

  t1 := TABLE(d1, {#EXPAND(fieldlist), EntityHash, Recs := COUNT(GROUP)}, #EXPAND(fieldlist), EntityHash, MERGE);
  d4 := JOIN(d3, t1, LEFT.EntityHash = RIGHT.EntityHash, HASH);
  d5 := d4(TRIM(Label)[LENGTH(TRIM(Label))-4 ..] != 'Flags' and Label not in ['Recordcount','Entityhash']);

  RETURN d5;
ENDMACRO;