IMPORT KEL06 AS KEL;
IMPORT * FROM KEL06.Null;
EXPORT Intake := MODULE
  EXPORT SingleValue(__recs, __field) := FUNCTIONMACRO
    LOCAL __nonulls := __recs(__NN(__field));
    LOCAL __values := TABLE(__nonulls,{__field,KEL.typ.int __RecordCount := COUNT(GROUP)},__field,FEW);
    LOCAL __bestvalue := __T(TOPN(__values,1,-__field)[1].__field);
    LOCAL __flags := CASE(COUNT(__values), 0 => __NullFlag, 1 => __NotNullFlag, __NotNullFlag | KEL.Typ.MultipleValuesDetected);
    RETURN __BN2(__bestvalue, __flags);
  ENDMACRO;
  EXPORT DetectMultipleValues(__in, __field) := FUNCTIONMACRO
    RETURN __UNWRAP(__in(KEL.Typ.TestFlag(__field, KEL.Typ.MultipleValuesDetected)));
  ENDMACRO;
END;
