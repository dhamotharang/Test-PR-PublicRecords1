EXPORT macComputeIntraPopulationAssociation(dIn, inId1, inId2, inEntityContextUID, inLabel) := FUNCTIONMACRO
  LOCAL tInput := TABLE(dIn, 
    {EntityContextUID := inEntityContextUID, inId1, inId2, AssociateEntityContextUID := Relavator.MacGraphContextUID(1,inId2), Label := (STRING)inLabel, recs := count(group)},  
    inEntityContextUID, inId2, MERGE);

  //These associations are deliberately directional from the lower id to the higher id to avoid drawing 
  //double edges in the graph visualization
  LOCAL dIntraPopulation := JOIN(tInput((INTEGER)inId1<(INTEGER)inId2), tInput, 
    (STRING)LEFT.AssociateEntityContextUID=(STRING)RIGHT.EntityContextUID, 
    KEEP(1), HASH);

  LOCAL dAssociations := Relavator.Macros.MacGenericAssociationProject(dIntraPopulation,'EntityContextUID','AssociateEntityContextUID','Label');
  
  RETURN dAssociations;
ENDMACRO;