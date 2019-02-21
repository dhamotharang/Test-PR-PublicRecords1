EXPORT macComputeBusinessPersonEntities(dIn, InPersonContextUID, InFirstName, InMiddleName='', InLastName, InEntityFlag = 'EntityFlag1',
  InFlag1 = '', InFlag2 = '', InFlag3 = '', InFlag4 = '', InFlag5 = '', InFlag6 = '', InFlag7 = '', InFlag8 = '', InFlag9 = '', InFlag10 = '') := FUNCTIONMACRO
  IMPORT Relavator;
  
  LOCAL EntityLayout := RECORD
    STRING EntityContextUID;
    UNSIGNED1 EntityType;
    STRING Label;
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
  
  LOCAL EntityLayout tReportedOfficerLayout(dIn L) := TRANSFORM
    SELF.EntityContextUID := L.InPersonContextUID;
    SELF.Label := TRIM(L.InFirstName) + ' ' + #IF(#TEXT(InMiddleName) != '') TRIM(L.InMiddleName)[1] + ' ' + #END TRIM(L.InLastName);
    SELF.EntityType := Relavator.getGraphContextUIDType((STRING)L.InPersonContextUID);
    SELF.InEntityFlag := 1;
    #IF(#TEXT(InFlag1) != '' AND #TEXT(InEntityFlag) != 'EntityFlag1')                           
    SELF.EntityFlag1 := (INTEGER1)L.InFlag1;
    #END
    #IF(#TEXT(InFlag2) != '' AND #TEXT(InEntityFlag) != 'EntityFlag2')                           
    SELF.EntityFlag2 := (INTEGER1)L.InFlag2;
    #END
    #IF(#TEXT(InFlag3) != '' AND #TEXT(InEntityFlag) != 'EntityFlag3')
    SELF.EntityFlag3 := (INTEGER1)L.InFlag3;
    #END
    #IF(#TEXT(InFlag4) != '' AND #TEXT(InEntityFlag) != 'EntityFlag4')
    SELF.EntityFlag4 := (INTEGER1)L.InFlag4;
    #END
    #IF(#TEXT(InFlag5) != '' AND #TEXT(InEntityFlag) != 'EntityFlag5')
    SELF.EntityFlag5 := (INTEGER1)L.InFlag5;
    #END
    #IF(#TEXT(InFlag6) != '' AND #TEXT(InEntityFlag) != 'EntityFlag6')
    SELF.EntityFlag6 := (INTEGER1)L.InFlag6;
    #END
    #IF(#TEXT(InFlag7) != '' AND #TEXT(InEntityFlag) != 'EntityFlag7')
    SELF.EntityFlag7 := (INTEGER1)L.InFlag7;
    #END
    #IF(#TEXT(InFlag8) != '' AND #TEXT(InEntityFlag) != 'EntityFlag8')
    SELF.EntityFlag8 := (INTEGER1)L.InFlag8;
    #END
    #IF(#TEXT(InFlag9) != '' AND #TEXT(InEntityFlag) != 'EntityFlag9')
    SELF.EntityFlag9 := (INTEGER1)L.InFlag9;
    #END
    #IF(#TEXT(InFlag10) != '' AND #TEXT(InEntityFlag) != 'EntityFlag10')
    SELF.EntityFlag10 := (INTEGER1)L.InFlag10;
    #END
    SELF := [];
  END;

  LOCAL PreBusinessPersonEntities := PROJECT(dIn, tReportedOfficerLayout(LEFT));
  LOCAL BusinessPersonEntities := Relavator.Macros.MacGenericEntityProject(PreBusinessPersonEntities,'EntityContextUID','EntityType','Label',,,,,,,'EntityFlag1', 'EntityFlag2', 'EntityFlag3', 'EntityFlag4', 'EntityFlag5', 'EntityFlag6', 'EntityFlag7', 'EntityFlag8', 'EntityFlag9', 'EntityFlag10');

  RETURN BusinessPersonEntities;
ENDMACRO;