EXPORT macComputeBusinessPersonAssociations(dIn, InPersonContextUID, InSeleContextUID, InProxContextUID, InSeleId, InProxId, AssociationLabel = 'Business Person') := FUNCTIONMACRO
  IMPORT Relavator;
  
  LOCAL AssociationLayout := RECORD
    STRING FromContextUID;
    STRING ToContextUID;
    STRING Label;
  END;
  
  LOCAL AssociationLayout tEntityReportedOfficerAssociationsLayout(dIn L) := TRANSFORM
    SELF.FromContextUID := MAP(L.InSeleId=L.InProxId OR L.InProxId = 0 => L.InSeleContextUID, L.InProxContextUID);
    SELF.ToContextUID := L.InPersonContextUID;
    SELF.Label := AssociationLabel;
  END;
  
  LOCAL PrePersonAssociations := DEDUP(SORT(PROJECT(dIn,tEntityReportedOfficerAssociationsLayout(LEFT)),FromContextUID, ToContextUID), FromContextUID, ToContextUID);
  LOCAL PersonAssociations := Relavator.Macros.MacGenericAssociationProject(PrePersonAssociations,'FromContextUID','ToContextUID','Label');

  RETURN PersonAssociations;
ENDMACRO;