EXPORT macComputeBusinessAssociations(dIn, UltContextUID, SeleContextUID, ProxContextUID, AssociationLabel = 'Business Ownership') := FUNCTIONMACRO
  IMPORT Relavator;
  
  LOCAL AssociationLayout := RECORD
    STRING FromContextUID;
    STRING ToContextUID;
    STRING Label;
  END;
  
  LOCAL AssociationLayout tEntityAssociationsLayout(dIn L, INTEGER C) := TRANSFORM
    SELF.FromContextUID := CHOOSE(C, (STRING)L.UltContextUID, (STRING)L.SeleContextUID);
    SELF.ToContextUID := CHOOSE(C, (STRING)L.SeleContextUID, (STRING)L.ProxContextUID);
    SELF.Label := (STRING)AssociationLabel;
  END;

  LOCAL PreAssociations := DEDUP(SORT(NORMALIZE(dIn, 2, tEntityAssociationsLayout(LEFT, COUNTER)), FromContextUID, ToContextUID), FromContextUID, ToContextUID);
  LOCAL _Associations := Relavator.Macros.MacGenericAssociationProject(PreAssociations,'FromContextUID','ToContextUID','Label');

  RETURN _Associations;
ENDMACRO;