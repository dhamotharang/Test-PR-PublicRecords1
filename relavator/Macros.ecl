IMPORT Relavator;
EXPORT Macros := MODULE
    EXPORT MacGenericEntityProject(InputFile, InEntityContextUID, InEntityType='',InEntityLabel,InEntityTooltip='',InEntityColor='',InEntityicon='',InEntityWeight='',
                                   InEntityLatitude='',InEntityLongitude='',InEntityFlag1='',InEntityFlag2='',InEntityFlag3='',InEntityFlag4='',InEntityFlag5='',
                                   InEntityFlag6='',InEntityFlag7='',InEntityFlag8='',InEntityFlag9='',InEntityFlag10='') := FUNCTIONMACRO
                                   
       LOCAL Entities := PROJECT(InputFile, 
                             TRANSFORM(Relavator.Layouts.EntityLayout, 
                               #IF(#TEXT(InEntityContextUID) != '')                           
                                SELF.EntityContextUID := (STRING)#EXPAND('LEFT.' + InEntityContextUID),
                               #END
                               #IF(#TEXT(InEntityType) != '')                           
                                SELF.EntityType := (UNSIGNED1)#EXPAND('LEFT.' + InEntityType),
                               #END
                               #IF(#TEXT(InEntityLabel) != '')                           
                                SELF.EntityLabel := (STRING)#EXPAND('LEFT.' + InEntityLabel),
                               #END
                               #IF(#TEXT(InEntityTooltip) != '')                           
                                SELF.EntityTooltip := (STRING)#EXPAND('LEFT.' + InEntityTooltip),
                               #END
                               #IF(#TEXT(InEntityColor) != '')                           
                                SELF.EntityColor := (STRING)#EXPAND('LEFT.' + InEntityColor),
                               #END
                               #IF(#TEXT(InEntityicon) != '')                           
                                SELF.Entityicon := (STRING)#EXPAND('LEFT.' + InEntityicon),
                               #END
                               #IF(#TEXT(InEntityWeight) != '')                           
                                SELF.EntityWeight := (UNSIGNED)#EXPAND('LEFT.' + InEntityWeight),
                               #END
                               #IF(#TEXT(InEntityLatitude) != '')                           
                                SELF.EntityLatitude := (REAL)#EXPAND('LEFT.' + InEntityLatitude),
                               #END
                               #IF(#TEXT(InEntityLongitude) != '')                           
                                SELF.EntityLongitude := (REAL)#EXPAND('LEFT.' + InEntityLongitude),
                               #END
                               #IF(#TEXT(InEntityFlag1) != '')                           
                                SELF.EntityFlag1 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag1),
                               #END
                               #IF(#TEXT(InEntityFlag2) != '')                           
                                SELF.EntityFlag2 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag2),
                               #END
                               #IF(#TEXT(InEntityFlag3) != '')                           
                                SELF.EntityFlag3 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag3),
                               #END
                               #IF(#TEXT(InEntityFlag4) != '')                           
                                SELF.EntityFlag4 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag4),
                               #END
                               #IF(#TEXT(InEntityFlag5) != '')                           
                                SELF.EntityFlag5 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag5),
                               #END
                               #IF(#TEXT(InEntityFlag6) != '')                           
                                SELF.EntityFlag6 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag6),
                               #END
                               #IF(#TEXT(InEntityFlag7) != '')                           
                                SELF.EntityFlag7 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag7),
                               #END
                               #IF(#TEXT(InEntityFlag8) != '')                           
                                SELF.EntityFlag8 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag8),
                               #END
                               #IF(#TEXT(InEntityFlag9) != '')                           
                                SELF.EntityFlag9 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag9),
                               #END
                               #IF(#TEXT(InEntityFlag10) != '')                           
                                SELF.EntityFlag10 := (INTEGER1)#EXPAND('LEFT.' + InEntityFlag10),
                               #END
                             SELF := []));
       RETURN Entities;   
    ENDMACRO;       
    EXPORT MacGenericAssociationProject(InputFile,InAssociationFromContextUID,InAssociationEntityContextUID,InAssociationLabel='',InAssociationTooltip='',InAssociationColor='',InAssociationWeight='') := FUNCTIONMACRO
       LOCAL Associations := PROJECT(InputFile, TRANSFORM(Relavator.Layouts.AssociationLayout,
                                SELF.AssociationFromContextUID := (STRING)#EXPAND('LEFT.' + InAssociationFromContextUID),
                                SELF.EntityContextUID := (STRING)#EXPAND('LEFT.' + InAssociationEntityContextUID),
                               #IF(#TEXT(InAssociationLabel) != '')                           
                                SELF.AssociationLabel := (STRING)#EXPAND('LEFT.' + InAssociationLabel),
                               #END
                               #IF(#TEXT(InAssociationTooltip) != '')                           
                                SELF.AssociationTooltip := (STRING)#EXPAND('LEFT.' + InAssociationTooltip),
                               #END
                               #IF(#TEXT(InAssociationColor) != '')                           
                                SELF.AssociationColor := (STRING)#EXPAND('LEFT.' + InAssociationColor),
                               #END
                               #IF(#TEXT(InAssociationWeight) != '')                           
                                SELF.AssociationWeight := (UNSIGNED)#EXPAND('LEFT.' + InAssociationWeight),
                               #END
                             SELF := []));
       RETURN Associations;
    ENDMACRO; 
    EXPORT macComputeEntities(dIn, InEntityContextUID, InEntityLabel, 
      InFlag1 = '', InFlag2 = '', InFlag3 = '', InFlag4 = '', InFlag5 = '', 
      InFlag6 = '', InFlag7 = '', InFlag8 = '', InFlag9 = '', InFlag10 = '',
      InEntityColor = '', InEntityWeight = '', InEntityTooltip = '', InEntityIcon = '', InEntityLatitude = '', InEntityLongitude = '')  := FUNCTIONMACRO
      IMPORT Relavator;
      
      LOCAL dsEntities := TABLE(dIn, 
        {EntityContextUID := InEntityContextUID, EntityType := Relavator.getGraphContextUIDType(InEntityContextUID),
        EntityLabel := InEntityLabel, 
        Flag1 := #IF(#TEXT(InFlag1) != '') MAX(GROUP, (INTEGER)InFlag1) #ELSE 0 #END,
        Flag2 := #IF(#TEXT(InFlag2) != '') MAX(GROUP, (INTEGER)InFlag2) #ELSE 0 #END,
        Flag3 := #IF(#TEXT(InFlag3) != '') MAX(GROUP, (INTEGER)InFlag3) #ELSE 0 #END,
        Flag4 := #IF(#TEXT(InFlag4) != '') MAX(GROUP, (INTEGER)InFlag4) #ELSE 0 #END,
        Flag5 := #IF(#TEXT(InFlag5) != '') MAX(GROUP, (INTEGER)InFlag5) #ELSE 0 #END,
        Flag6 := #IF(#TEXT(InFlag6) != '') MAX(GROUP, (INTEGER)InFlag6) #ELSE 0 #END,
        Flag7 := #IF(#TEXT(InFlag7) != '') MAX(GROUP, (INTEGER)InFlag7) #ELSE 0 #END,
        Flag8 := #IF(#TEXT(InFlag8) != '') MAX(GROUP, (INTEGER)InFlag8) #ELSE 0 #END,
        Flag9 := #IF(#TEXT(InFlag9) != '') MAX(GROUP, (INTEGER)InFlag9) #ELSE 0 #END,
        Flag10 := #IF(#TEXT(InFlag10) != '') MAX(GROUP, (INTEGER)InFlag10) #ELSE 0 #END,
        EntityColor := #IF(#TEXT(InEntityColor) != '') (STRING)InEntityColor #ELSE '' #END,
        EntityIcon := #IF(#TEXT(InEntityIcon) != '') (STRING)InEntityIcon #ELSE '' #END,
        EntityTooltip := #IF(#TEXT(InEntityTooltip) != '') (STRING)InEntityTooltip #ELSE '' #END,
        EntityWeight := #IF(#TEXT(InEntityWeight)!= '') (INTEGER)InEntityWeight #ELSE COUNT(GROUP) #END,
        EntityLatitude := #IF(#TEXT(InEntityLatitude) != '') (REAL)InEntityLatitude #ELSE 0 #END,
        EntityLongitude := #IF(#TEXT(InEntityLongitude) != '') (REAL)InEntityLongitude #ELSE 0 #END},
        InEntityContextUID, MERGE);
                       
      LOCAL Entities := Relavator.Macros.MacGenericEntityProject(dsEntities, 'EntityContextUID', 'EntityType','EntityLabel','EntityTooltip','EntityColor','EntityIcon','EntityWeight',
                             'EntityLatitude', 'EntityLongitude','Flag1','Flag2','Flag3','Flag4','Flag5','Flag6','Flag7','Flag8','Flag9','Flag10');
                             
      RETURN Entities;
    ENDMACRO;
END;