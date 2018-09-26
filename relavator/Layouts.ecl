EXPORT Layouts := MODULE
  EXPORT EntityLayout := RECORD
    STRING EntityContextUID;
    UNSIGNED1 EntityType;
    STRING EntityLabel;
    STRING EntityTooltip;
    STRING EntityColor;
    STRING Entityicon;
    UNSIGNED EntityWeight;
    REAL EntityLatitude;
    REAL EntityLongitude;
    INTEGER1 EntityFlag1;
    INTEGER1 EntityFlag2;
    INTEGER1 EntityFlag3;
    INTEGER1 EntityFlag4;
    INTEGER1 EntityFlag5;
    INTEGER1 EntityFlag6;
    INTEGER1 EntityFlag7;
    INTEGER1 EntityFlag8;
    INTEGER1 EntityFlag9;
    INTEGER1 EntityFlag10;
  END;

  EXPORT AssociationLayout := RECORD
    STRING AssociationFromContextUID;
    STRING EntityContextUID;
    STRING AssociationLabel;
    STRING AssociationTooltip;
    STRING AssociationColor;
    UNSIGNED AssociationWeight;
  END;

END;