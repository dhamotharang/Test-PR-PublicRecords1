#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthcareNoMatchHeader_InternalLinking, STD;
EXPORT  Proc_AppendCRK( 
          DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInputFile
        ) :=  FUNCTION

  dInputFileNoMatchGrp  :=  GROUP(SORT(DISTRIBUTE(pInputFile,HASH(nomatch_id)),nomatch_id,LOCAL),nomatch_id,LOCAL);

  rCreateCRK :=  RECORD
    UNSIGNED8 nomatch_id;
    STRING50  crk;  //  Customer Record Key
  END;

  rCreateCRK tCreateCRK(dInputFileNoMatchGrp l, DATASET(RECORDOF(dInputFileNoMatchGrp)) dAllRows) :=  TRANSFORM
    SELF.crk        :=  IF(
                          COUNT(dAllRows(lexid>0))>0,                 //  If this cluster has a LexID then
                          'L'+MIN(dAllRows(lexid>0),dAllRows.lexid),  //  Use lowest LexID for this cluster
                          'C'+l.nomatch_id
                        );
    SELF.nomatch_id :=  l.nomatch_id;
  END;

  dCreateCRK  :=  ROLLUP(dInputFileNoMatchGrp, GROUP, tCreateCRK(LEFT,ROWS(LEFT)));
  
  dAppendCRK  :=  JOIN(
                    DISTRIBUTE(pInputFile,HASH(nomatch_id)),
                    DISTRIBUTE(dCreateCRK,HASH(nomatch_id)),
                      LEFT.nomatch_id = RIGHT.nomatch_id,
                    TRANSFORM(
                      RECORDOF(LEFT),
                      SELF.crk  :=  RIGHT.crk;
                      SELF      :=  LEFT;
                    ),
                    LOCAL
                  );
                
  RETURN  dAppendCRK;
END;
