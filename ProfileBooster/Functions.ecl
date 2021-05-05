IMPORT STD;

EXPORT Functions := MODULE

EXPORT buildNewLayout(InLayout) := FUNCTIONMACRO

  #UNIQUENAME(r);

  #EXPORTXML(records, InLayout)

  #DECLARE(generatedLayoutCode)
  #SET(generatedLayoutCode, '');

  #FOR(records)
      #FOR(Field)
          #APPEND(generatedLayoutCode, %'{@type}'% + ' ' + %'{@name}'% + ';');
          #APPEND(generatedLayoutCode, 'INTEGER ' + %'{@name}'% + '_count;');
          #APPEND(generatedLayoutCode, 'INTEGER ' + %'{@name}'% + '_99997;');
          #APPEND(generatedLayoutCode, 'INTEGER ' + %'{@name}'% + '_99998;');
      #END
  #END

  %r% := RECORD
  INTEGER RecNum;
  #EXPAND(%'generatedLayoutCode'%)
  END;

  RETURN %r%;

ENDMACRO;

EXPORT projectUnscorables(inputDS, attributesToProject, inputLayout) := FUNCTIONMACRO

  #EXPORTXML(records, inputDS)

  #DECLARE(rollupCode)
  #SET(rollupCode, '');  
  #DECLARE(projectionCode)
  #SET(projectionCode, '');
  
#FOR(records)
  #FOR(Field)
         #IF(STD.Str.ToUpperCase(%'{@name}'%) IN attributesToProject) // We have a date field we care to keep!
          #APPEND(projectionCode, 'SELF.' + %'{@name}'% + '_count := IF(le.' + %'{@name}'% +' < 0, 0, le.' + %'{@name}'% + ');');
          #APPEND(projectionCode, 'SELF.' + %'{@name}'% + '_99997 := IF(le.' + %'{@name}'% +' = -99997, 1, 0);');
          #APPEND(projectionCode, 'SELF.' + %'{@name}'% + '_99998 := IF(le.' + %'{@name}'% +' = -99998, 1, 0);');
          #APPEND(rollupCode, 'SELF.' + %'{@name}'% + '_count := le.' + %'{@name}'% + '_count + ri.' + %'{@name}'% + '_count;');
          #APPEND(rollupCode, 'SELF.' + %'{@name}'% + '_99997 := le.' + %'{@name}'% + '_99997 + ri.' + %'{@name}'% + '_99997;');
          #APPEND(rollupCode, 'SELF.' + %'{@name}'% + '_99998 := le.' + %'{@name}'% + '_99998 + ri.' + %'{@name}'% + '_99998;');
        #END
    #END
  #END

    inputLayout transformToUnscorables(inputLayout le) := TRANSFORM
	#EXPAND(%'projectionCode'%)
    SELF := le;
    END;    
     
    projDS := PROJECT(inputDS, transformToUnscorables(LEFT));
    
    inputLayout unscorables(inputLayout le, inputLayout ri) := TRANSFORM
		#EXPAND(%'rollupCode'%)
        SELF.HHMmbrCollTierHighest_Count := MAX(le.HHMmbrCollTierHighest_Count, ri.HHMmbrCollTierHighest_Count);
        SELF.HHMmbrCollTierHighest_99997 := le.HHMmbrCollTierHighest_99997 + ri.HHMmbrCollTierHighest_99997;
        SELF.HHMmbrCollTierHighest_99998 := le.HHMmbrCollTierHighest_99998 + ri.HHMmbrCollTierHighest_99998;        
        SELF.HHMmbrPropAVMMax_Count := MAX(le.HHMmbrPropAVMMax_Count, ri.HHMmbrPropAVMMax_Count);
        SELF.HHMmbrPropAVMMax_99997 := le.HHMmbrPropAVMMax_99997 + ri.HHMmbrPropAVMMax_99997;
        SELF.HHMmbrPropAVMMax_99998 := le.HHMmbrPropAVMMax_99998 + ri.HHMmbrPropAVMMax_99998;
		SELF := le;
		SELF := [];
END;

rollupUnscorables := ROLLUP(projDS, unscorables(LEFT, RIGHT), seq);

RETURN rollupUnscorables;
// RETURN %'rollupCode'%;
// RETURN %'projectionCode'%;

ENDMACRO;

END;