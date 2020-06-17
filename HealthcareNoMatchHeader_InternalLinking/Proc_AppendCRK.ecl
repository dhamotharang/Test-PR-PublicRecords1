#OPTION('multiplePersistInstances', FALSE);
IMPORT HealthcareNoMatchHeader_InternalLinking, HealthcareNoMatchHeader_Ingest, STD;
EXPORT  Proc_AppendCRK( 
          STRING	pSrc  = '' 
          ,DATASET(HealthcareNoMatchHeader_InternalLinking.Layout_Header) pInputFile
        ) :=  FUNCTION

  STRING15 convertBase10(UNSIGNED8 val, UNSIGNED1 base) := BEGINC++
    unsigned __int64 i = val;
    int len = 0;
    char base36str[] =  "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    do{
      __result[14-len] = base36str[i%base];
      i = i/base;
      len++;
    }while(len<15);
  ENDC++;
  
  dInputFileNoMatchGrp  :=  GROUP(SORT(DISTRIBUTE(pInputFile,HASH(nomatch_id)),nomatch_id,LOCAL),nomatch_id,LOCAL);

  rCreateCRK :=  RECORD
    UNSIGNED8 nomatch_id;
    STRING50  crk;  //  Customer Record Key
  END;

  rCreateCRK tCreateCRK(dInputFileNoMatchGrp l, DATASET(RECORDOF(dInputFileNoMatchGrp)) dAllRows) :=  TRANSFORM
    SELF.crk        :=  IF(
                          COUNT(dAllRows(lexid>0))>0,                 //  If this cluster has a LexID then
                          'L'+convertBase10(HASH64(pSrc+MIN(dAllRows(lexid>0),dAllRows.lexid)),36),  //  Use lowest LexID for this cluster
                          'C'+convertBase10(HASH64(pSrc+l.nomatch_id),36)
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

  dOldCRK :=  HealthcareNoMatchHeader_Ingest.Files(pSrc).CRK;
  
  HealthcareNoMatchHeader_InternalLinking.Layout_Header tUpdateChangeFlags(dAppendCRK pNew, dOldCRK pOld)  :=  TRANSFORM
    SELF.lexID_changed  :=  IF(pNew.lexid<>pOld.lexid AND pOld.rid>0,'Y','N');
    SELF.old_lexid      :=  IF(pNew.lexid<>pOld.lexid AND pOld.rid>0,pOld.lexid,pNew.lexid);
    SELF.crk_changed    :=  IF(pNew.crk<>pOld.crk AND pOld.rid>0,'Y','N');
    SELF.old_crk        :=  IF(pNew.crk<>pOld.crk AND pOld.rid>0,pOld.crk,pNew.crk);
    SELF                :=  pNew;
  END;

  dUpdateChangeFlags  :=  JOIN(
                            DISTRIBUTE(dAppendCRK,HASH(rid)),
                            DISTRIBUTE(dOldCRK,HASH(rid)),
                              LEFT.rid  = RIGHT.rid,
                            tUpdateChangeFlags(LEFT,RIGHT),
                            LOCAL,
                            LEFT OUTER
                          );

  RETURN  dUpdateChangeFlags;
END;
