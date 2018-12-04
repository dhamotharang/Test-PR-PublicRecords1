EXPORT macComputeBusinessEntities(dIn, InUltContextUID, InSeleContextUID, InProxContextUID, InUltID, InBestSeleCompanyName, 
  InLegalName = '', InDBAName = '', InLatitude = '', InLongitude = '', InToolTip = '', InIsSeleInput = '', InIsProxInput = '',
  InFlag3 = '', InFlag4 = '', InFlag5 = '', InFlag6 = '', InFlag7 = '', InFlag8 = '', InFlag9 = '', InFlag10 = '',
  InIsUltInput = '', InFlag2 = '', InBestProxCompanyName = '') := FUNCTIONMACRO
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
    SELF.Label := CHOOSE(C, (STRING)L.InUltID, 
      MAP(L.InBestSeleCompanyName != '' => L.InBestSeleCompanyName, 
        #IF(#TEXT(InLegalName) != '')  L.InLegalName != '' => L.InLegalName, #END
        #IF(#TEXT(InDBAName) != '') L.InDBAName #ELSE '' #END)
      #IF(#TEXT(InBestProxCompanyName) != '')
        ,MAP(L.InBestProxCompanyName != '' => L.InBestProxCompanyName,        
          #IF(#TEXT(InLegalName) != '')  L.InLegalName != '' => L.InLegalName, #END
          #IF(#TEXT(InDBAName) != '') L.InDBAName #ELSE '' #END)
      #END);
    SELF.EntityType := Relavator.getGraphContextUIDType(CHOOSE(C, (STRING)L.InUltContextUID, (STRING)L.InSeleContextUID, (STRING)L.InProxContextUID));
    #IF(#TEXT(InIsUltInput) != '' AND #TEXT(InIsSeleInput) != '' AND #TEXT(InIsProxInput) != '')                           
    SELF.Flag1 := (INTEGER1)CHOOSE(C, (INTEGER1)L.InIsUltInput, (INTEGER1)L.InIsSeleInput, (INTEGER1)L.InIsProxInput),
    #END    
    #IF(#TEXT(InLatitude) != '')  
    SELF.Latitude := (REAL) L.InLatitude;
    #END
    #IF(#TEXT(InLongitude) != '')  
    SELF.Longitude := (REAL)L.InLongitude;
    #END
    #IF(#TEXT(InToolTip) != '')  
    SELF.ToolTip := L.InToolTip;
    #END
    #IF(#TEXT(InFlag2) != '')                           
    SELF.Flag2 := (INTEGER1)L.InFlag2;
    #END
    #IF(#TEXT(InFlag3) != '')
    SELF.Flag3 := (INTEGER1)L.InFlag3;
    #END
    #IF(#TEXT(InFlag4) != '')
    SELF.Flag4 := (INTEGER1)L.InFlag4;
    #END
    #IF(#TEXT(InFlag5) != '')
    SELF.Flag5 := (INTEGER1)L.InFlag5;
    #END
    #IF(#TEXT(InFlag6) != '')
    SELF.Flag6 := (INTEGER1)L.InFlag6;
    #END
    #IF(#TEXT(InFlag7) != '')
    SELF.Flag7 := (INTEGER1)L.InFlag7;
    #END
    #IF(#TEXT(InFlag8) != '')
    SELF.Flag8 := (INTEGER1)L.InFlag8;
    #END
    #IF(#TEXT(InFlag9) != '')
    SELF.Flag9 := (INTEGER1)L.InFlag9;
    #END
    #IF(#TEXT(InFlag10) != '')
    SELF.Flag10 := (INTEGER1)L.InFlag10;
    #END
    SELF := [];
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