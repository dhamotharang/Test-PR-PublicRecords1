IMPORT doxie;

EXPORT iParam := MODULE

  EXPORT PropHistHRI := INTERFACE(doxie.IDataAccess)
    EXPORT boolean IgnoreFares     := FALSE;
    EXPORT boolean IgnoreFidelity  := FALSE;
  END;

  EXPORT RelDetails := INTERFACE
    EXPORT BOOLEAN   IncludeRelatives     := FALSE;//  : STORED('IncludeRelatives');
    EXPORT UNSIGNED1 RelativeDepth        := 0;//      : STORED('RelativeDepth');
    EXPORT UNSIGNED3 MaxRelatives         := 0;//      : STORED('MaxRelatives');
    EXPORT BOOLEAN   IncludeAssociates    := FALSE;//  : STORED('IncludeAssociates');
  END;

END;
