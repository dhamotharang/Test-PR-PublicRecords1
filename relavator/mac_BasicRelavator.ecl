import Relavator;

EXPORT mac_BasicRelavator(InData, pdidfield, distance_threshold=2, UseIndexThreshold=4000000, firstnrelatives=300) := FUNCTIONMACRO

    RelavatedClustersSM := JOIN(DISTRIBUTE(InData,SKEW(0.1)), Relavator.Key_Person_Cluster_Degree, 
            LEFT.pdidfield=RIGHT.cluster_id and RIGHT.degree_key <= distance_threshold*100,
            TRANSFORM(RECORDOF(RIGHT), 
                SELF := RIGHT, SELF := LEFT
            ),
            KEYED, SKEW(1), KEEP(firstnrelatives));

    RelavatedClustersLG := JOIN(PULL(Relavator.Key_Person_Cluster_Degree), DISTRIBUTE(InData, HASH32(pdidfield)),
            LEFT.cluster_id=RIGHT.pdidfield and LEFT.degree_key <= distance_threshold*100,
            TRANSFORM(RECORDOF(LEFT), 
                SELF := LEFT, SELF := RIGHT
            ),
            SKEW(1), KEEP(firstnrelatives), SMART);
 
    RETURN MAP(COUNT(InData) > UseIndexThreshold => RelavatedClustersLG, RelavatedClustersSM);
    
ENDMACRO;    