EXPORT macComputeDatasetDelta(dOld, dNew, strJoinFields1, strJoinFields2, setFieldsToIgnore = []) := FUNCTIONMACRO
  IMPORT hipie_ecl;
  LOADXML('<xml/>');
  #DECLARE(FieldDiff) #SET(FieldDiff, '')
  #EXPORTXML(Fields, RECORDOF(dOld))
  #FOR(Fields)
    #FOR(Field)
      #IF(%'{@label}'% NOT IN setFieldsToIgnore) // ignore field list.
        #IF(%'FieldDiff'% != '')
          #APPEND(FieldDiff, ' OR ')
        #END
        #APPEND(FieldDiff, ' LEFT.' + %'{@label}'% + ' != RIGHT.' + %'{@label}'%)
      #END
    #END
  #END
  LOCAL strJoinStatement  := hipie_ecl.macComputeJoinStatement(strJoinFields1, strJoinFields2);
  
  LOCAL rDiffValues := RECORD
    STRING Field;
    STRING OldValue;
    STRING NewValue;
    INTEGER IsDifferent;
  END;
  
  LOCAL rDiff := RECORD
    RECORDOF(dOld) Old;
    RECORDOF(dNew) New;
    DATASET(rDiffValues) Differences;
  end;
  
  LOCAL dBasediff  := JOIN(dOld, dNew, 
		#EXPAND(strJoinStatement) AND ( #EXPAND(%'FieldDiff'%)),
			TRANSFORM({#EXPAND(hipie_ecl.macComputeAppendFieldsRecord(strJoinFields1, '')) rDiff}, 
			 SELF.Old := LEFT,
			 SELF.New := RIGHT, 
			 SELF.Differences := DATASET([
					#FOR(Fields)
						#FOR(Field)
							#IF(%'{@label}'% NOT IN setFieldsToIgnore) // ignore field list.
							{%'{@label}'%, #EXPAND('(STRING)LEFT.' + %'{@label}'%), #EXPAND('(STRING)RIGHT.' + %'{@label}'%), #EXPAND('LEFT.' + %'{@label}'% + ' != RIGHT.' + %'{@label}'%)},                           
							#END
						#END
					#END
			 {'fieldname', '1', '2', FALSE}
			 ], rDiffValues)((BOOLEAN)IsDifferent),
       SELF := LEFT,
			 ), HASH);  
  RETURN dBasediff;
ENDMACRO;