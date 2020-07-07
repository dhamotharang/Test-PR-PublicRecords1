IMPORT doxie, dx_BestRecords;
EXPORT test_get_batch_service := MACRO
  //This is a test service which iterates through all permission types for dx_BestRecords.append
  //The idea is to deploy this service with an alias before and after changes are made.
  //Then run both services with a set of dids and look for differences on the same cluster.
  //This ensures the data will be the same.

  in_layout := RECORD
      integer acctno;
      unsigned6 did;
  END;

  batch_in := DATASET([], in_layout) : STORED('batch_in');

  p_type := dx_BestRecords.Constants.PERM_TYPE;

  //Iterate through permissions:
  glb_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb, FALSE, FALSE), acctno);
  glb_nonexperian_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_nonen, FALSE, FALSE), acctno);
  glb_nonequifax_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_noneq, FALSE, FALSE), acctno);
  glb_nonexperian_nonequifax_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_nonen_noneq, FALSE, FALSE), acctno);
  glb_nonblank_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_nonblank, FALSE, FALSE), acctno);
  glb_nonexperian_nonblank_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_nonen_nonblank, FALSE, FALSE), acctno);
  glb_nonequifax_nonblank_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_noneq_nonblank, FALSE, FALSE), acctno);
  glb_nonexperian_nonequifax_nonblank_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_nonen_noneq_nonblank, FALSE, FALSE), acctno);
  glb_nonutil_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_nonutil, FALSE, FALSE), acctno);
  glb_nonutil_nonblank_res := SORT(dx_BestRecords.append(batch_in, did, p_type.glb_nonutil_nonblank, FALSE, FALSE), acctno);
  nonglb_res := SORT(dx_BestRecords.append(batch_in, did, p_type.nonglb, FALSE, FALSE), acctno);
  nonglb_preglb_res := SORT(dx_BestRecords.append(batch_in, did, p_type.nonglb_noneq, FALSE, FALSE), acctno);
  nonglb_nonblank_res := SORT(dx_BestRecords.append(batch_in, did, p_type.nonglb_nonblank, FALSE, FALSE), acctno);
  nonglb_nonblank_preglb_res := SORT(dx_BestRecords.append(batch_in, did, p_type.nonglb_noneq_nonblank, FALSE, FALSE), acctno);
  marketing_res := SORT(dx_BestRecords.append(batch_in, did, p_type.marketing, FALSE, FALSE), acctno);
  marketing_preglb_res := SORT(dx_BestRecords.append(batch_in, did, p_type.marketing_preglb, FALSE, FALSE), acctno);
  infutor_res := SORT(dx_BestRecords.append(batch_in, did, p_type.infutor, FALSE, FALSE), acctno);

  OUTPUT(glb_res, NAMED('glb'));
  OUTPUT(glb_nonexperian_res, NAMED('glb_nonexperian'));
  OUTPUT(glb_nonequifax_res, NAMED('glb_nonequifax'));
  OUTPUT(glb_nonexperian_nonequifax_res, NAMED('glb_nonexperian_nonequifax'));
  OUTPUT(glb_nonblank_res, NAMED('glb_nonblank'));
  OUTPUT(glb_nonexperian_nonblank_res, NAMED('glb_nonexperian_nonblank'));
  OUTPUT(glb_nonequifax_nonblank_res, NAMED('glb_nonequifax_nonblank'));
  OUTPUT(glb_nonexperian_nonequifax_nonblank_res, NAMED('glb_nonexperian_nonequifax_nonblank'));
  OUTPUT(glb_nonutil_res, NAMED('glb_nonutil'));
  OUTPUT(glb_nonutil_nonblank_res, NAMED('glb_nonutil_nonblank'));
  OUTPUT(nonglb_res, NAMED('nonglb'));
  OUTPUT(nonglb_preglb_res, NAMED('nonglb_preglb'));
  OUTPUT(nonglb_nonblank_res, NAMED('nonglb_nonblank'));
  OUTPUT(nonglb_nonblank_preglb_res, NAMED('nonglb_nonblank_preglb'));
  OUTPUT(marketing_res, NAMED('marketing'));
  OUTPUT(marketing_preglb_res, NAMED('marketing_preglb'));
  OUTPUT(infutor_res, NAMED('infutor'));

ENDMACRO;