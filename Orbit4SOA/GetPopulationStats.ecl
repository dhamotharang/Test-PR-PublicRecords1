//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
IMPORT wk_ut;
EXPORT GetPopulationStats(string WUName = '',string WUID = thorlib.wuid()) := function
    
extractedValueRec := RECORD
    STRING value;
    UNSIGNED cnt;
END;

extractedRec := RECORD
  STRING name;
  UNSIGNED cnt;
  DATASET(extractedValueRec) values;
END;

extractedRec2 := RECORD
  STRING Rule;
  UNSIGNED cnt;
END;

STRING NM_Workunit := WUID;

//Post-processing the result with PARSE:
x := DATASET(ROW(TRANSFORM({STRING line},
             SELF.line := wk_ut.get_Scalar_Result(NM_Workunit,WUName))));

extractedRec t1 := TRANSFORM
  SELF.name := XMLTEXT('@name');
  SELF.cnt := (UNSIGNED)XMLTEXT('@distinct');
  SELF.values := XMLPROJECT('Value',
                    TRANSFORM(extractedValueRec,
                              SELF.value := XMLTEXT(''),
                              SELF.cnt := (UNSIGNED)XMLTEXT('@count')));
END;
p := PARSE(x, line, t1, XML('XML/Field'));

extractedRec2 NormIt(extractedRec L,INTEGER C) := TRANSFORM
  SELF.Rule   := L.name + '_' + map(L.values[C].value[1] = '-' =>'Minus'   + trim(L.values[C].value[2..],all),
                 L.values[C].value[1] = '.'                    =>'Decimal' + trim(L.values[C].value[2..],all),
                 trim(L.values[C].value,all));
  SELF.cnt    := L.values[C].cnt;
END;

DistValues := NORMALIZE(p,LEFT.cnt,NormIt(LEFT,COUNTER));

statCnts := SORT(DistValues,Rule);

return statCnts;

END;