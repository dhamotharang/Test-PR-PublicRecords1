IMPORT KEL16 AS KEL;
IMPORT * FROM KEL16.Null;
EXPORT Intake := MODULE

  EXPORT SingleValue(__recs, __field) := FUNCTIONMACRO
    LOCAL __nonulls := __recs(__NN(__field));
    LOCAL __values := TABLE(__nonulls,{__field,KEL.typ.int __RecordCount := COUNT(GROUP)},__field,FEW);
    LOCAL __bestvalue := __T(TOPN(__values,1,-__RecordCount,-__field)[1].__field);
    LOCAL __flags := CASE(COUNT(__values), 0 => __NullFlag, 1 => __NotNullFlag, __NotNullFlag | KEL.Typ.MultipleValuesDetected);
    LOCAL __best := __BN2(__bestvalue, __flags);
    RETURN IF(COUNT(__nonulls) <= 1, __nonulls[1].__field, __best);
  ENDMACRO;

  /* TODO - DetectMultipleValues is no longer used - may be removed in any version after 1.3 */
  EXPORT DetectMultipleValues(__in, __field) := FUNCTIONMACRO
    RETURN __UNWRAP(__in(KEL.Typ.TestFlag(__field, KEL.Typ.MultipleValuesDetected)));
  ENDMACRO;

  EXPORT DetectMultipleValuesOnResult(__in, __field) := FUNCTIONMACRO
    RETURN __in((#EXPAND('__' + #TEXT(__field) + '_flags') & KEL.Typ.MultipleValuesDetected) != 0);
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

  EXPORT ConstructMissingFieldList(din,uidList,filename) :=FUNCTIONMACRO
    LOADXML('<xml/>');
    #DECLARE(__inChild) #SET(__inChild,-1)
    #DECLARE(__currentRec) #SET(__currentRec,'')
    #DECLARE(__inRecord) #SET(__inRecord,0)
    #DECLARE(__prefix) #SET(__prefix,'')
    #DECLARE(__fieldList) #SET(__fieldList,',')
    #DECLARE(__uidField)
    #DECLARE(__uidFieldList) #SET(__uidFieldList,uidList+',')
		#DECLARE(__missingList) #SET(__missingList, '')

    #EXPORTXML(fields, RECORDOF(din))
    #FOR(fields)
      #FOR(Field)
        #IF(%{@isDataset}%=1)
          #SET(__inChild,%__inChild%+1)
        #ELSEIF(%{@isRecord}%=1)
          #IF(%'__prefix'%='') #APPEND(__prefix,%'{@label}'%) #ELSE #APPEND(__prefix,'.'+%'{@label}'%) #END
          #SET(__currentRec,%'{@name}'%)
          #SET(__inRecord, %__inRecord%+1)
        #ELSEIF(%{@isEnd}%=1)
          #IF(%'{@name}'%=%'__currentRec'%)
            #SET(__inRecord, %__inRecord%-1)
            #IF(%__inRecord%=0) #SET(__prefix,'') #ELSE #SET(__prefix,REGEXREPLACE('^(.*)\\.[^.]+$', %'__prefix'%, '$1')) #END
            #SET(__currentRec,REGEXFIND('([^.]+)$', %'__prefix'%, 0))
          #ELSE
            #SET(__inChild,%__inChild%-1)
          #END
        #ELSE
          #IF (%__inChild%<0)
            #IF(%__inRecord%>0)
              #APPEND(__fieldList,%'__prefix'%+'.' + %'{@label}'% + ',')
            #ELSE
              #APPEND(__fieldList,%'{@label}'% + ',')
            #END
          #END
        #END
      #END
    #END

    #LOOP
      #IF(%'__uidFieldList'% = '')
        #BREAK
      #ELSE
        #SET(__uidField,REGEXFIND('^([^,]+),', %'__uidFieldList'%, 1))
        #IF(NOT REGEXFIND(','+%'__uidField'%+',', %'__fieldList'%, NOCASE))
          #IF(NOT REGEXFIND('\\.',%'__uidField'%))
            #APPEND(__missingList,','+%'__uidField'%)
          #ELSE
            #ERROR(%'__uidField'%+' does not exist in ' + filename + '. Hint: use a non-dotted name for the default mapping and override in the USE statements for nested records mappings.')
          #END
        #END
        #SET(__uidFieldList,REGEXFIND('^([^,]+),(.*)$', %'__uidFieldList'%, 2));
      #END
    #END

    RETURN %'__missingList'%[2..];
  ENDMACRO;

  EXPORT AppendFields(din,uidList) :=FUNCTIONMACRO
    LOADXML('<xml/>');
    #DECLARE(__uidFieldList) #SET(__uidFieldList,uidList)
    #DECLARE(__layout) #SET(__layout,'{RECORDOF('+#TEXT(din)+')')

    #LOOP
      #IF(%'__uidFieldList'% = '')
        #BREAK
      #ELSE
        #APPEND(__layout,',STRING '+ REGEXFIND('([^,]+)$', %'__uidFieldList'%, 0))
        #SET(__uidFieldList,REGEXREPLACE('^(.*)\\,[^,]+$', ','+%'__uidFieldList'%, '$1')[2..]);
      #END
    #END
    #APPEND(__layout,'}')

    LOCAL __outds := PROJECT(din,TRANSFORM(#EXPAND(%'__layout'%),SELF:=LEFT,SELF:=[]));
    RETURN __outds;
  ENDMACRO;

END;

