IMPORT KEL07 AS KEL;
IMPORT * FROM KEL07.Null;
EXPORT Era := MODULE
  EXPORT SimpleRoll(__base, __epoch, __op, __nullMin) := FUNCTIONMACRO
    LoadXml('<xml/>');
    #DECLARE(null)
    #IF(__nullMin)
      #SET(null, KEL.Typ.MINEPOCH)
    #ELSE
      #SET(null, KEL.Typ.MAXEPOCH)
    #END
    #IF(#TEXT(__base) = 'GROUP')
      LOCAL __cond := EXISTS(__base, __epoch != 0);
    #ELSE
      LOCAL __cond := EXISTS(__base(__epoch != 0));
    #END
    RETURN IF(__cond, __op(__base, IF(__epoch=0, %null%, __epoch)), 0);
  ENDMACRO;
  EXPORT FlatRoll(__base, __epoch, __layout) := FUNCTIONMACRO
    RETURN PROJECT(__base, __layout)(__epoch!=0);
  ENDMACRO;
  EXPORT FlatRollSingleRow(__base, __epoch, __layout) := FUNCTIONMACRO
    RETURN PROJECT(DATASET(__base), __layout)(__epoch!=0);
  ENDMACRO;
  EXPORT ShapedRoll(__base, __epoch) := FUNCTIONMACRO
    RETURN DEDUP(NORMALIZE(__base, LEFT.__epoch, TRANSFORM(RECORDOF(LEFT.__epoch), SELF:=RIGHT)), WHOLE RECORD, ALL);
  ENDMACRO;
  EXPORT INTEGER FromDate(KEL.typ.kdate pdate) := FUNCTION
    RETURN IF(pdate=0,0,KEL.Routines.ToDaysSince1900(pdate));
  END;
    // these two replace the above function; in time it can be deleted
  EXPORT INTEGER FromField(KEL.typ.kdate pdate) := FUNCTION
    // top bound for EPOCH is actually 2079-06-06 (65535 days after 1900-01-01) but the validation routine runs on years
    RETURN IF(KEL.Routines.IsValidDate3(pdate,1900,2078),KEL.Routines.ToDaysSince1900(pdate),0);
  END;
  
  EXPORT FromField2(pdate, prule) := FUNCTIONMACRO
    KEL.typ.kdate tdate := (KEL.typ.kdate)prule(pdate); 
    RETURN IF(KEL.Routines.IsValidDate3(tdate,1900,2078),KEL.Routines.ToDaysSince1900(tdate),0);
  ENDMACRO;
  EXPORT FromNDate(pdate) := FUNCTIONMACRO
    RETURN IF(__NL(pdate),0,KEL.Routines.ToDaysSince1900(__T(pdate)));
  ENDMACRO;
  EXPORT KEL.typ.nkdate ToDate(KEL.typ.epoch epoch) := FUNCTION
    RETURN __BN3(IF(epoch=0,0,KEL.Routines.FromDaysSince1900(epoch)),epoch=0,KEL.typ.nkdate);
  END;
  EXPORT KEL.typ.nkdate ToDateMinNull(KEL.typ.epoch epoch) := FUNCTION
    RETURN __CN2(IF(epoch=0,KEL.typ.MINEPOCH,KEL.Routines.FromDaysSince1900(epoch)),KEL.typ.nkdate);
  END;
  EXPORT KEL.typ.nkdate ToDateMinMax(KEL.typ.epoch epoch) := FUNCTION
    RETURN __CN2(IF(epoch=0,KEL.typ.MAXEPOCH,KEL.Routines.FromDaysSince1900(epoch)),KEL.typ.nkdate);
  END;
END;
