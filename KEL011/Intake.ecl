IMPORT KEL011 AS KEL;
IMPORT * FROM KEL011.Null;
EXPORT Intake := MODULE

  EXPORT SingleValue(__recs, __field) := FUNCTIONMACRO
    LOCAL __nonulls := __recs(__NN(__field));
    LOCAL __values := TABLE(__nonulls,{__field,KEL.typ.int __RecordCount := COUNT(GROUP)},__field,FEW);
    LOCAL __bestvalue := __T(TOPN(__values,1,-__RecordCount,-__field)[1].__field);
    LOCAL __flags := CASE(COUNT(__values), 0 => __NullFlag, 1 => __NotNullFlag, __NotNullFlag | KEL.Typ.MultipleValuesDetected);
    LOCAL __best := __BN2(__bestvalue, __flags);
    RETURN IF(COUNT(__nonulls) <= 1, __nonulls[1].__field, __best);
  ENDMACRO;

  EXPORT DetectMultipleValues(__in, __field) := FUNCTIONMACRO
    RETURN __UNWRAP(__in(KEL.Typ.TestFlag(__field, KEL.Typ.MultipleValuesDetected)));
  ENDMACRO;

  EXPORT NullFromDataType(__value) := FUNCTIONMACRO
    LOADXML('<xml/>');
    #DECLARE(vType)
    #DECLARE(nv)
    LOCAL __loc := __value;
    #SET(vType, #GETDATATYPE(__loc))
    #IF(%'vType'%[1..7]='integer' OR %'vType'%[1..4]='real' OR %'vType'%[1..7]='decimal')
      #SET(nv, '0')
    #ELSE
      #SET(nv, '\'\'')
    #END
    RETURN #EXPAND(%'nv'%);
  ENDMACRO;

END;

