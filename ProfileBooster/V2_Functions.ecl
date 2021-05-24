IMPORT STD;

EXPORT V2_Functions := MODULE

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

  #DECLARE(projectionCode)
  #SET(projectionCode, '');
  
#FOR(records)
  #FOR(Field)
         #IF(STD.Str.ToUpperCase(%'{@name}'%) IN attributesToProject) // We have a date field we care to keep!
          #APPEND(projectionCode, 'SELF.' + %'{@name}'% + '_count := IF(le.' + %'{@name}'% +' < 0, 0, le.' + %'{@name}'% + ');');
          #APPEND(projectionCode, 'SELF.' + %'{@name}'% + '_99997 := IF(le.' + %'{@name}'% +' = -99997, 1, 0);');
          #APPEND(projectionCode, 'SELF.' + %'{@name}'% + '_99998 := IF(le.' + %'{@name}'% +' = -99998, 1, 0);');
        #END
    #END
  #END

    inputLayout transformToUnscorables(inputLayout le) := TRANSFORM
	#EXPAND(%'projectionCode'%)
    SELF.HHMmbrCollTierHighest_Count := IF(le.HHMmbrCollTierHighest < 0, 0, le.HHMmbrCollTierHighest);
    SELF.HHMmbrCollTierHighest_99997 := IF(le.HHMmbrCollTierHighest = -99997, 1, 0);
    SELF.HHMmbrCollTierHighest_99998 := IF(le.HHMmbrCollTierHighest = -99998, 1, 0);    
    SELF.HHMmbrPropAVMMax_Count := IF(le.HHMmbrPropAVMMax < 0, 0, le.HHMmbrPropAVMMax);
    SELF.HHMmbrPropAVMMax_99997 := IF(le.HHMmbrPropAVMMax = -99997, 1, 0);
    SELF.HHMmbrPropAVMMax_99998 := IF(le.HHMmbrPropAVMMax = -99998, 1, 0);
    SELF.HHMmbrDrgNewMsnc7Y_Count := le.HHMmbrDrgNewMsnc7Y;
    SELF.HHMmbrDrgNewMsnc7Y_99997 := IF(le.HHMmbrDrgNewMsnc7Y = -99997, 1, 0);
    SELF.HHMmbrDrgNewMsnc7Y_99998 := IF(le.HHMmbrDrgNewMsnc7Y = -99998, 1, 0);
    SELF.HHMmbrWCrimFelNewMsnc7Y_Count := le.HHMmbrWCrimFelNewMsnc7Y;
    SELF.HHMmbrWCrimFelNewMsnc7Y_99997 := IF(le.HHMmbrWCrimFelNewMsnc7Y = -99997, 1, 0);
    SELF.HHMmbrWCrimFelNewMsnc7Y_99998 := IF(le.HHMmbrWCrimFelNewMsnc7Y = -99998, 1, 0);
    SELF.HHMmbrWCrimNFelNewMsnc7Y_Count := le.HHMmbrWCrimNFelNewMsnc7Y;
    SELF.HHMmbrWCrimNFelNewMsnc7Y_99997 := IF(le.HHMmbrWCrimNFelNewMsnc7Y = -99997, 1, 0);
    SELF.HHMmbrWCrimNFelNewMsnc7Y_99998 := IF(le.HHMmbrWCrimNFelNewMsnc7Y = -99998, 1, 0);
    SELF.HHMmbrWEvictNewMsnc7Y_Count := le.HHMmbrWEvictNewMsnc7Y;
    SELF.HHMmbrWEvictNewMsnc7Y_99997 := IF(le.HHMmbrWEvictNewMsnc7Y = -99997, 1, 0);
    SELF.HHMmbrWEvictNewMsnc7Y_99998 := IF(le.HHMmbrWEvictNewMsnc7Y = -99998, 1, 0);
    SELF.HHMmbrWLnJNewMsnc7Y_Count := le.HHMmbrWLnJNewMsnc7Y;
    SELF.HHMmbrWLnJNewMsnc7Y_99997 := IF(le.HHMmbrWLnJNewMsnc7Y = -99997, 1, 0);
    SELF.HHMmbrWLnJNewMsnc7Y_99998 := IF(le.HHMmbrWLnJNewMsnc7Y = -99998, 1, 0);
    SELF.HHMmbrWBkNewMsnc10Y_Count := le.HHMmbrWBkNewMsnc10Y;
    SELF.HHMmbrWBkNewMsnc10Y_99997 := IF(le.HHMmbrWBkNewMsnc10Y = -99997, 1, 0);
    SELF.HHMmbrWBkNewMsnc10Y_99998 := IF(le.HHMmbrWBkNewMsnc10Y = -99998, 1, 0);
    SELF := le;
    END;    
     
    projDS := PROJECT(inputDS, transformToUnscorables(LEFT));

RETURN projDS;
// RETURN %'projectionCode'%;

ENDMACRO;

EXPORT rollupUnscorables(inputDS, attributesToProject, inputLayout) := FUNCTIONMACRO

  #EXPORTXML(records, inputDS)

  #DECLARE(rollupCode)
  #SET(rollupCode, '');  
  
#FOR(records)
  #FOR(Field)
         #IF(STD.Str.ToUpperCase(%'{@name}'%) IN attributesToProject) // We have a date field we care to keep!
          #APPEND(rollupCode, 'SELF.' + %'{@name}'% + '_count := le.' + %'{@name}'% + '_count + ri.' + %'{@name}'% + '_count;');
          #APPEND(rollupCode, 'SELF.' + %'{@name}'% + '_99997 := le.' + %'{@name}'% + '_99997 + ri.' + %'{@name}'% + '_99997;');
          #APPEND(rollupCode, 'SELF.' + %'{@name}'% + '_99998 := le.' + %'{@name}'% + '_99998 + ri.' + %'{@name}'% + '_99998;');
        #END
    #END
  #END
    
    inputLayout unscorables(inputLayout le, inputLayout ri) := TRANSFORM
		#EXPAND(%'rollupCode'%)
        SELF.HHMmbrCollTierHighest_Count := MAX(le.HHMmbrCollTierHighest_Count, ri.HHMmbrCollTierHighest_Count);
        SELF.HHMmbrCollTierHighest_99997 := le.HHMmbrCollTierHighest_99997 + ri.HHMmbrCollTierHighest_99997;
        SELF.HHMmbrCollTierHighest_99998 := le.HHMmbrCollTierHighest_99998 + ri.HHMmbrCollTierHighest_99998;        
        SELF.HHMmbrPropAVMMax_Count := MAX(le.HHMmbrPropAVMMax_Count, ri.HHMmbrPropAVMMax_Count);
        SELF.HHMmbrPropAVMMax_99997 := le.HHMmbrPropAVMMax_99997 + ri.HHMmbrPropAVMMax_99997;
        SELF.HHMmbrPropAVMMax_99998 := le.HHMmbrPropAVMMax_99998 + ri.HHMmbrPropAVMMax_99998;
       
        SELF.HHMmbrDrgNewMsnc7Y_Count := MIN(ABS(le.HHMmbrDrgNewMsnc7Y_Count),ABS(ri.HHMmbrDrgNewMsnc7Y_Count));
        SELF.HHMmbrDrgNewMsnc7Y_99997 := le.HHMmbrDrgNewMsnc7Y_99997 + ri.HHMmbrDrgNewMsnc7Y_99997;
        SELF.HHMmbrDrgNewMsnc7Y_99998 := le.HHMmbrDrgNewMsnc7Y_99998 + ri.HHMmbrDrgNewMsnc7Y_99998;
        SELF.HHMmbrWCrimFelNewMsnc7Y_Count := MIN(ABS(le.HHMmbrWCrimFelNewMsnc7Y_Count),ABS(ri.HHMmbrWCrimFelNewMsnc7Y_Count));
        SELF.HHMmbrWCrimFelNewMsnc7Y_99997 := le.HHMmbrWCrimFelNewMsnc7Y_99997 + ri.HHMmbrWCrimFelNewMsnc7Y_99997;
        SELF.HHMmbrWCrimFelNewMsnc7Y_99998 := le.HHMmbrWCrimFelNewMsnc7Y_99998 + ri.HHMmbrWCrimFelNewMsnc7Y_99998;
        SELF.HHMmbrWCrimNFelNewMsnc7Y_Count := MIN(ABS(le.HHMmbrWCrimNFelNewMsnc7Y_Count),ABS(ri.HHMmbrWCrimNFelNewMsnc7Y_Count));
        SELF.HHMmbrWCrimNFelNewMsnc7Y_99997 := le.HHMmbrWCrimNFelNewMsnc7Y_99997 + ri.HHMmbrWCrimNFelNewMsnc7Y_99997;
        SELF.HHMmbrWCrimNFelNewMsnc7Y_99998 := le.HHMmbrWCrimNFelNewMsnc7Y_99998 + ri.HHMmbrWCrimNFelNewMsnc7Y_99998;
        SELF.HHMmbrWEvictNewMsnc7Y_Count := MIN(ABS(le.HHMmbrWEvictNewMsnc7Y_Count),ABS(ri.HHMmbrWEvictNewMsnc7Y_Count));
        SELF.HHMmbrWEvictNewMsnc7Y_99997 := le.HHMmbrWEvictNewMsnc7Y_99997 + ri.HHMmbrWEvictNewMsnc7Y_99997;
        SELF.HHMmbrWEvictNewMsnc7Y_99998 := le.HHMmbrWEvictNewMsnc7Y_99998 + ri.HHMmbrWEvictNewMsnc7Y_99998;
        SELF.HHMmbrWLnJNewMsnc7Y_Count := MIN(ABS(le.HHMmbrWLnJNewMsnc7Y_Count),ABS(ri.HHMmbrWLnJNewMsnc7Y_Count));
        SELF.HHMmbrWLnJNewMsnc7Y_99997 := le.HHMmbrWLnJNewMsnc7Y_99997 + ri.HHMmbrWLnJNewMsnc7Y_99997;
        SELF.HHMmbrWLnJNewMsnc7Y_99998 := le.HHMmbrWLnJNewMsnc7Y_99998 + ri.HHMmbrWLnJNewMsnc7Y_99998;
        SELF.HHMmbrWBkNewMsnc10Y_Count := MIN(ABS(le.HHMmbrWBkNewMsnc10Y_Count),ABS(ri.HHMmbrWBkNewMsnc10Y_Count));
        SELF.HHMmbrWBkNewMsnc10Y_99997 := le.HHMmbrWBkNewMsnc10Y_99997 + ri.HHMmbrWBkNewMsnc10Y_99997;
        SELF.HHMmbrWBkNewMsnc10Y_99998 := le.HHMmbrWBkNewMsnc10Y_99998 + ri.HHMmbrWBkNewMsnc10Y_99998;
        
		SELF := le;
		SELF := [];
END;

rollupUnscorables := ROLLUP(inputDS, unscorables(LEFT, RIGHT), seq);

RETURN rollupUnscorables;
// RETURN %'rollupCode'%;

ENDMACRO;

END;