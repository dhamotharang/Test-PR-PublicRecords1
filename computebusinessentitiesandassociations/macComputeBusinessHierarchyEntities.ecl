EXPORT macComputeBusinessHierarchyEntities(dIn, InUltContextUID, InSeleContextUID, InProxContextUID, InUltID, InBestSeleCompanyName, InBestProxCompanyName, InLegalName = '', InDBAName = '',  
  InIsUltInput = '', InUltFlag2 = '', InUltFlag3 = '', InUltFlag4 = '', InUltFlag5 = '', InUltFlag6 = '', InUltFlag7 = '', InUltFlag8 = '', InUltFlag9 = '', InUltFlag10 = '',
  InIsSeleInput = '', InSeleFlag2 = '', InSeleFlag3 = '', InSeleFlag4 = '', InSeleFlag5 = '', InSeleFlag6 = '', InSeleFlag7 = '', InSeleFlag8 = '', InSeleFlag9 = '', InSeleFlag10 = '',
  InIsProxInput = '', InProxFlag2 = '', InProxFlag3 = '', InProxFlag4 = '', InProxFlag5 = '', InProxFlag6 = '', InProxFlag7 = '', InProxFlag8 = '', InProxFlag9 = '', InProxFlag10 = '',
  InUltLatitude = '', InUltLongitude = '', InUltToolTip = '', InSeleLatitude = '', InSeleLongitude = '', InSeleToolTip = '', InProxLatitude = '', InProxLongitude = '', InProxToolTip = '',
  UltEntityLabel = '') := FUNCTIONMACRO
  IMPORT Relavator;
  
  LOCAL EntityLayout := RECORD
    STRING EntityContextUID;
    UNSIGNED1 EntityType;
    STRING Label;
    STRING ToolTip;
    REAL Latitude;
    REAL Longitude;
    INTEGER1 Flag1;
    INTEGER1 Flag2;
    INTEGER1 Flag3;
    INTEGER1 Flag4;
    INTEGER1 Flag5;
    INTEGER1 Flag6;
    INTEGER1 Flag7;
    INTEGER1 Flag8;
    INTEGER1 Flag9;
    INTEGER1 Flag10;
  END;
  
  LOCAL EntityLayout tEntityLayout(dIn L, INTEGER C) := TRANSFORM
    SELF.EntityContextUID := CHOOSE(C, (STRING)L.InUltContextUID, (STRING)L.InSeleContextUID, (STRING)L.InProxContextUID);
    SELF.Label := CHOOSE(C, #IF(#TEXT(UltEntityLabel) != '') (STRING)UltEntityLabel #ELSE (STRING)L.InUltID #END, 
      MAP(L.InBestSeleCompanyName != '' => L.InBestSeleCompanyName, 
        #IF(#TEXT(InLegalName) != '')  L.InLegalName != '' => L.InLegalName, #END
        #IF(#TEXT(InDBAName) != '') L.InDBAName #ELSE '' #END)
      #IF(#TEXT(InBestProxCompanyName) != '')
        ,MAP(L.InBestProxCompanyName != '' => L.InBestProxCompanyName,        
          #IF(#TEXT(InLegalName) != '')  L.InLegalName != '' => L.InLegalName, #END
          #IF(#TEXT(InDBAName) != '') L.InDBAName #ELSE '' #END)
      #END);
    SELF.EntityType := Relavator.getGraphContextUIDType(CHOOSE(C, (STRING)L.InUltContextUID, (STRING)L.InSeleContextUID, (STRING)L.InProxContextUID));
    SELF.Flag1 := (INTEGER1)CHOOSE(C, #IF(#TEXT(InIsUltInput)!='')(INTEGER1)L.InIsUltInput#ELSE 0 #END, #IF(#TEXT(InIsSeleInput)!='')(INTEGER1)L.InIsSeleInput#ELSE 0 #END, #IF(#TEXT(InIsProxInput)!='')(INTEGER1)L.InIsProxInput#ELSE 0 #END),
    SELF.Latitude := CHOOSE(C, #IF(#TEXT(InUltLatitude)!='')(REAL)L.InUltLatitude#ELSE 0 #END, #IF(#TEXT(InSeleLatitude)!='')(REAL)L.InSeleLatitude#ELSE 0 #END, #IF(#TEXT(InProxLatitude)!='')(REAL)L.InProxLatitude#ELSE 0 #END);
    SELF.Longitude := CHOOSE(C, #IF(#TEXT(InUltLongitude)!='')(REAL)L.InUltLongitude#ELSE 0 #END, #IF(#TEXT(InSeleLongitude)!='')(REAL)L.InSeleLongitude#ELSE 0 #END, #IF(#TEXT(InProxLongitude)!='')(REAL)L.InProxLongitude#ELSE 0 #END);
    SELF.ToolTip := CHOOSE(C, #IF(#TEXT(InUltToolTip)!='')L.InUltToolTip#ELSE '' #END, #IF(#TEXT(InSeleToolTip)!='')L.InSeleToolTip#ELSE '' #END, #IF(#TEXT(InProxToolTip)!='')L.InProxToolTip#ELSE '' #END);                     
    SELF.Flag2 := CHOOSE(C, #IF(#TEXT(InUltFlag2)!='')(INTEGER1)L.InUltFlag2#ELSE 0 #END, #IF(#TEXT(InSeleFlag2)!='')(INTEGER1)L.InSeleFlag2#ELSE 0 #END, #IF(#TEXT(InProxFlag2)!='')(INTEGER1)L.InProxFlag2#ELSE 0 #END);
    SELF.Flag3 := CHOOSE(C, #IF(#TEXT(InUltFlag3)!='')(INTEGER1)L.InUltFlag3#ELSE 0 #END, #IF(#TEXT(InSeleFlag3)!='')(INTEGER1)L.InSeleFlag3#ELSE 0 #END, #IF(#TEXT(InProxFlag3)!='')(INTEGER1)L.InProxFlag3#ELSE 0 #END);
    SELF.Flag4 := CHOOSE(C, #IF(#TEXT(InUltFlag4)!='')(INTEGER1)L.InUltFlag4#ELSE 0 #END, #IF(#TEXT(InSeleFlag4)!='')(INTEGER1)L.InSeleFlag4#ELSE 0 #END, #IF(#TEXT(InProxFlag4)!='')(INTEGER1)L.InProxFlag4#ELSE 0 #END);
    SELF.Flag5 := CHOOSE(C, #IF(#TEXT(InUltFlag5)!='')(INTEGER1)L.InUltFlag5#ELSE 0 #END, #IF(#TEXT(InSeleFlag5)!='')(INTEGER1)L.InSeleFlag5#ELSE 0 #END, #IF(#TEXT(InProxFlag5)!='')(INTEGER1)L.InProxFlag5#ELSE 0 #END);
    SELF.Flag6 := CHOOSE(C, #IF(#TEXT(InUltFlag6)!='')(INTEGER1)L.InUltFlag6#ELSE 0 #END, #IF(#TEXT(InSeleFlag6)!='')(INTEGER1)L.InSeleFlag6#ELSE 0 #END, #IF(#TEXT(InProxFlag6)!='')(INTEGER1)L.InProxFlag6#ELSE 0 #END);
    SELF.Flag7 := CHOOSE(C, #IF(#TEXT(InUltFlag7)!='')(INTEGER1)L.InUltFlag7#ELSE 0 #END, #IF(#TEXT(InSeleFlag7)!='')(INTEGER1)L.InSeleFlag7#ELSE 0 #END, #IF(#TEXT(InProxFlag7)!='')(INTEGER1)L.InProxFlag7#ELSE 0 #END);
    SELF.Flag8 := CHOOSE(C, #IF(#TEXT(InUltFlag8)!='')(INTEGER1)L.InUltFlag8#ELSE 0 #END, #IF(#TEXT(InSeleFlag8)!='')(INTEGER1)L.InSeleFlag8#ELSE 0 #END, #IF(#TEXT(InProxFlag8)!='')(INTEGER1)L.InProxFlag8#ELSE 0 #END);
    SELF.Flag9 := CHOOSE(C, #IF(#TEXT(InUltFlag9)!='')(INTEGER1)L.InUltFlag9#ELSE 0 #END, #IF(#TEXT(InSeleFlag9)!='')(INTEGER1)L.InSeleFlag9#ELSE 0 #END, #IF(#TEXT(InProxFlag9)!='')(INTEGER1)L.InProxFlag9#ELSE 0 #END);
    SELF.Flag10 := CHOOSE(C, #IF(#TEXT(InUltFlag10)!='')(INTEGER1)L.InUltFlag10#ELSE 0 #END, #IF(#TEXT(InSeleFlag10)!='')(INTEGER1)L.InSeleFlag10#ELSE 0 #END, #IF(#TEXT(InProxFlag10)!='')(INTEGER1)L.InProxFlag10#ELSE 0 #END);
  END;

  LOCAL NormBusinessEntities := NORMALIZE(dIn, 3, tEntityLayout(LEFT, COUNTER), LOCAL)(EntityContextUID[4..] != '0');
  LOCAL PreBusinessEntities := TABLE(NormBusinessEntities,
    {EntityContextUID, EntityType, Label, ToolTip, Latitude, Longitude, 
      INTEGER1 Flag1 := MAX(GROUP, Flag1), INTEGER1 Flag2 := MAX(GROUP, Flag2), INTEGER1 Flag3 := MAX(GROUP, Flag3), INTEGER1 Flag4 := MAX(GROUP, Flag4), INTEGER1 Flag5 := MAX(GROUP, Flag5),
      INTEGER1 Flag6 := MAX(GROUP, Flag6), INTEGER1 Flag7 := MAX(GROUP, Flag7), INTEGER1 Flag8 := MAX(GROUP, Flag8), INTEGER1 Flag9 := MAX(GROUP, Flag9), INTEGER1 Flag10 := MAX(GROUP, Flag10)},
    EntityContextUID, MERGE);

  LOCAL BusinessEntities := Relavator.Macros.MacGenericEntityProject(PreBusinessEntities,'EntityContextUID','EntityType','Label', 'ToolTip',,,, 'Latitude', 'Longitude', 
    'Flag1', 'Flag2', 'Flag3', 'Flag4', 'Flag5', 'Flag6', 'Flag7', 'Flag8', 'Flag9', 'Flag10');

  RETURN BusinessEntities;
ENDMACRO;