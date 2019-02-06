EXPORT mac_AlertListFull(AlertInputFile, in_did, OutputAppends, BasicOutGraph) := FUNCTIONMACRO 

IMPORT dx_BestRecords, RAMPS;

OutputAppendsFull := OutputAppends;

BiDirectionalGraph := BasicOutGraph + PROJECT(BasicOutGraph(cluster_id != associated_did), 
                              TRANSFORM(RECORDOF(LEFT), 
															self.cluster_id := LEFT.associated_did, self.associated_did := LEFT.cluster_id, 
															SELF := LEFT));

// This needs to be replaced with the a full permission value that takes GLB, DPPA etc..
LOCAL BestRecsPerm := dx_BestRecords.Constants.perm_type.glb;

// Append best records data to get associated Name fields
LOCAL BiDeduped := DEDUP(SORT(BiDirectionalGraph, associated_did), associated_did);
LOCAL BestAppended := dx_BestRecords.append(BiDeduped, associated_did, BestRecsPerm, left_outer := false);

// Patch in names for all the nodes so they can appear in the child dataset. 
AllDidNames := PROJECT(BestAppended, 
  TRANSFORM(
    {LEFT._best.did, STRING Name}, 
    SELF.Name := TRIM((TRIM(LEFT._best.fname) + TRIM(' ' + TRIM(LEFT._best.mname)) + ' ' + TRIM(LEFT._best.lname))[1..100]),
    SELF.did := LEFT._best.did));

FullGraphWithNames := JOIN(BiDirectionalGraph, AllDidNames, 
                        LEFT.associated_did=RIGHT.did, 
											  TRANSFORM(
											   {RIGHT.Name, RECORDOF(LEFT)}, 
												 SELF := RIGHT, SELF := LEFT), 
												HASH);

rChild := RECORD
		UNSIGNED8 cluster_id;
		STRING Name;
END;

rGraphParent := RECORD
		FullGraphWithNames.cluster_id;
		FullGraphWithNames.degree;
		FullGraphWithNames.Name;
		UNSIGNED childcount := 0;
		DATASET(rChild) Relatives;
END;

GraphPrep := SORT(PROJECT(FullGraphWithNames, TRANSFORM(rGraphParent, 
                              SELF.cluster_id := LEFT.cluster_id, 
															SELF.childcount := 1,
															SELF.Relatives := ROW({LEFT.associated_did, LEFT.Name}, rChild);
                              SELF := LEFT, SELF := [])), cluster_id, degree);

rGraphParent tChildren(GraphPrep L, GraphPrep R) := TRANSFORM
  SELF.childcount := L.childcount + 1;
  SELF.Relatives := L.Relatives + R.Relatives;
	SELF := L;
END;

ParentsWithGraph := ROLLUP(GraphPrep(degree <= 1), cluster_id, tChildren(LEFT, RIGHT));

rParent := RECORD
    RECORDOF(AlertInputFile);
    BOOLEAN IsInputRecord := FALSE;
		UNSIGNED8 TreeId := 0;
		STRING Name := '';
    RAMPS.Layouts.rRelavatorAggregates;
		RECORDOF(ParentsWithGraph);
END;

ParentsWithCountsAndGraph := JOIN(ParentsWithGraph, OutputAppends, left.cluster_id=right.cluster_id, 
                         TRANSFORM(rParent, SELF := RIGHT, SELF := LEFT, SELF := []), HASH);
												 
ParentsWithInput := JOIN(ParentsWithCountsAndGraph, AlertInputFile, left.cluster_id=right.in_did, 
                         TRANSFORM(rParent, 
												          SELF.IsInputRecord := MAP(right.in_did>0=>TRUE, FALSE),
												          SELF := RIGHT, SELF := LEFT), LEFT OUTER, KEEP(1), HASH);

// This needs to be replaced with the Best Macro that takes GLB, DPPA etc..
// Patch in names for all the nodes so they can appear in the child dataset. 

ParentsWithInputWithNames := JOIN(ParentsWithInput, AllDidNames, 
                        LEFT.cluster_id=RIGHT.did, 
											  TRANSFORM(RECORDOF(LEFT), 
												 SELF.Name := RIGHT.Name,
												 SELF := LEFT), HASH);

// Create All the trees.

AllTrees := JOIN(BiDirectionalGraph/*(degree<=1)*/, ParentsWithInputWithNames, left.associated_did=right.cluster_id, 
             TRANSFORM(
               RECORDOF(RIGHT), 
               self.TreeId:=left.cluster_id, 
           //    self.Relatives := MAP(LEFT.Degree <= 1 => RIGHT.Relatives), 
               self := RIGHT));

RETURN DEDUP(SORT(AllTrees, TreeId, Cluster_id), TreeId, Cluster_id);
ENDMACRO;