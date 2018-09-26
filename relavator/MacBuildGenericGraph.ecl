IMPORT Relavator;
EXPORT MacBuildGenericGraph(DATASET(Relavator.Layouts.EntityLayout) FinalEntities, DATASET(Relavator.Layouts.AssociationLayout) FinalAssociations, TreeDegrees='2', AssociationCountThreshold=400) := FUNCTION

  LOCAL GraphRec := RECORD
    STRING TreeUID;
    RECORDOF(Relavator.Layouts.EntityLayout);
    UNSIGNED4 ChildCount;
    DATASET(Relavator.Layouts.AssociationLayout) Links;
  END;

  // Filter out abnormally large clusters.

  LOCAL FromEntityCounts := TABLE(FinalAssociations, {AssociationFromContextUID, recs := COUNT(GROUP)}, AssociationFromContextUID, MERGE);
  LOCAL ToEntityCounts := TABLE(FinalAssociations, {EntityContextUID, recs := COUNT(GROUP)}, EntityContextUID, MERGE);

  // Can we optionally filter out vertexes that only have a combined inbound/outbound edges count of 1
  // For Business Graphs this would be less than optimal. 
  // We could have an option of filtering only singltons of a specific type.
  // If you want to keep singletons, consider using flags.
  
  LOCAL FinalAssociationsTrimedFrom := JOIN(FinalAssociations, FromEntityCounts(recs >= AssociationCountThreshold), LEFT.AssociationFromContextUID=RIGHT.AssociationFromContextUID, LEFT ONLY, LOOKUP);
  LOCAL FinalAssociationsTrimedTo := JOIN(FinalAssociationsTrimedFrom(AssociationFromContextUID[4..] != '0'), ToEntityCounts(recs >= AssociationCountThreshold), LEFT.EntityContextUID=RIGHT.EntityContextUID, LEFT ONLY, LOOKUP);

  LOCAL FinalAssociationsColored := JOIN(FinalAssociationsTrimedTo, Relavator.Data_RelationshipTypes, LEFT.AssociationLabel = RIGHT.AssociationLabel, TRANSFORM(Relavator.Layouts.AssociationLayout,
    SELF.AssociationColor := RIGHT.AssociationColor; SELF := LEFT;  
  ), LEFT OUTER, HASH); 

  LOCAL FinalEntitiesDeduped := TABLE(FinalEntities(TRIM(EntityContextUID[4..]) != '0' AND TRIM(EntityContextUID[4..]) != ''),
    {EntityContextUID, EntityType, EntityLabel, EntityToolTip, EntityColor, EntityIcon, EntityWeight, EntityLatitude, EntityLongitude, 
      INTEGER1 EntityFlag1 := MAX(GROUP, EntityFlag1), INTEGER1 EntityFlag2 := MAX(GROUP, EntityFlag2), INTEGER1 EntityFlag3 := MAX(GROUP, EntityFlag3), INTEGER1 EntityFlag4 := MAX(GROUP, EntityFlag4), INTEGER1 EntityFlag5 := MAX(GROUP, EntityFlag5),
      INTEGER1 EntityFlag6 := MAX(GROUP, EntityFlag6), INTEGER1 EntityFlag7 := MAX(GROUP, EntityFlag7), INTEGER1 EntityFlag8 := MAX(GROUP, EntityFlag8), INTEGER1 EntityFlag9 := MAX(GROUP, EntityFlag9), INTEGER1 EntityFlag10 := MAX(GROUP, EntityFlag10)},
    EntityContextUID, MERGE); 

  LOCAL ParentEntities := PROJECT(FinalEntitiesDeduped, TRANSFORM(GraphRec, SELF := LEFT, SELF := []));

  LOCAL GraphPrep := DENORMALIZE(ParentEntities, FinalAssociationsColored, LEFT.EntityContextUID=RIGHT.AssociationFromContextUID,
                          TRANSFORM(GraphRec,  
                          SELF.ChildCount := COUNTER,
                          SELF.Links := LEFT.Links + ROW({RIGHT.AssociationFromContextUID, RIGHT.EntityContextUID, RIGHT.AssociationLabel, RIGHT.AssociationTooltip, RIGHT.AssociationColor, 0}, Relavator.Layouts.AssociationLayout),
                          SELF := LEFT
                          ), HASH);
                          
  // Include the Root of each tree within itself so it is also loaded.
  LOCAL TreeAssociationsRoot := PROJECT(DEDUP(SORT(DISTRIBUTE(FinalAssociationsTrimedTo, HASH32(AssociationFromContextUID)), AssociationFromContextUID, LOCAL), AssociationFromContextUID, LOCAL), 
                                           TRANSFORM(RECORDOF(LEFT),
                                              SELF.AssociationFromContextUID := LEFT.EntityContextUID,
                                              SELF.EntityContextUID := LEFT.AssociationFromContextUID, 
                                              SELF := LEFT));
  // Combine the root assoications to the final associations.
  LOCAL TreeAssociationsFullDirectional := TreeAssociationsRoot + FinalAssociationsTrimedTo;

  // Reverse the associations to make them bidirectional.
  LOCAL TreeAssociationsFullBiDirectional := TreeAssociationsFullDirectional + 
                                       PROJECT(TreeAssociationsFullDirectional, TRANSFORM(RECORDOF(LEFT), 
                                          SELF.AssociationFromContextUID := LEFT.EntityContextUID,
                                          SELF.EntityContextUID := LEFT.AssociationFromContextUID,
                                          SELF := LEFT));

  LOCAL TreeAssociationsFull := TreeAssociationsFullBiDirectional;
  
  // First Degree of Tree.
  LOCAL TreeAssociationsFirstDegree := JOIN(TreeAssociationsFull, GraphPrep, LEFT.EntityContextUID=RIGHT.EntityContextUID,
                                   TRANSFORM(GraphRec, SELF.TreeUID := LEFT.AssociationFromContextUID, SELF.Links := RIGHT.Links, SELF := RIGHT), HASH);
                                   
  // use tree associations but not the root since it's first degrees are there already.
  LOCAL TreeAssociationsSecondDegree := JOIN(TreeAssociationsFirstDegree(TreeUID != EntityContextUID), TreeAssociationsFirstDegree, 
                                              LEFT.EntityContextUID=RIGHT.TreeUID,
                                   TRANSFORM(GraphRec, SELF.TreeUID := LEFT.TreeUID, SELF.Links := RIGHT.Links, SELF := RIGHT), HASH);
                                 
  LOCAL TreeAssociationsSecondDegreeDeduped := DEDUP(SORT(TreeAssociationsSecondDegree, TreeUID, EntityContextUID), TreeUID, EntityContextUID);
  
  LOCAL TreeAssociationsThirdDegree := JOIN(TreeAssociationsSecondDegreeDeduped(TreeUID != EntityContextUID), TreeAssociationsFirstDegree, 
                                              LEFT.EntityContextUID=RIGHT.TreeUID,
                                   TRANSFORM(GraphRec, SELF.TreeUID := LEFT.TreeUID, SELF.Links := RIGHT.Links, SELF := RIGHT), HASH);
       
  // merge after so entities aren't duplicated but flags are merged
  LOCAL FullTrees := TABLE(TreeAssociationsFirstDegree + IF((INTEGER)TreeDegrees > 1, TreeAssociationsSecondDegree) + IF((INTEGER)TreeDegrees > 2,TreeAssociationsThirdDegree), 
    {TreeUID, EntityContextUID, EntityType, EntityLabel, EntityToolTip, EntityColor, EntityIcon, EntityWeight, EntityLatitude, EntityLongitude, 
      INTEGER1 EntityFlag1 := MAX(GROUP, EntityFlag1), INTEGER1 EntityFlag2 := MAX(GROUP, EntityFlag2), INTEGER1 EntityFlag3 := MAX(GROUP, EntityFlag3), INTEGER1 EntityFlag4 := MAX(GROUP, EntityFlag4), INTEGER1 EntityFlag5 := MAX(GROUP, EntityFlag5),
      INTEGER1 EntityFlag6 := MAX(GROUP, EntityFlag6), INTEGER1 EntityFlag7 := MAX(GROUP, EntityFlag7), INTEGER1 EntityFlag8 := MAX(GROUP, EntityFlag8), INTEGER1 EntityFlag9 := MAX(GROUP, EntityFlag9), INTEGER1 EntityFlag10 := MAX(GROUP, EntityFlag10),
      ChildCount, DATASET(Relavator.Layouts.AssociationLayout)Links := Links},
    TreeUID, EntityContextUID, MERGE);
  RETURN FullTrees;
END;
  
