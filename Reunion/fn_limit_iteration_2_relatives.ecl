IMPORT header,watchdog,infutor;

EXPORT fn_limit_iteration_2_relatives(DATASET(reunion.layouts.lIteration) dInFile, UNSIGNED1 mode):=FUNCTION

  dDIDCounts:=DISTRIBUTE(reunion.counts_per_did(infutor.infutor_header),HASH(did));
	dUniqueDIDCounts:=TABLE(dDIDCounts,{did,did_ct},did,did_ct,LOCAL);

  dCandidates:=DISTRIBUTE(dInFile(came_from<>'1'),HASH(did));
  dNotCandidates:=dInFile(came_from='1');
	
	dWatchdog:=DISTRIBUTE(reunion.infutor_for_reunion(mode),HASH(did));

  lCandidateCounts:=RECORD
    dCandidates;
    INTEGER did_ct;
    record_id:=0;
  END;
	
  dCandidateCounts:=JOIN(dCandidates,dUniqueDIDCounts,LEFT.did=RIGHT.did,TRANSFORM(lCandidateCounts,SELF:=LEFT;SELF:=RIGHT;),LOCAL);
  dWatchdogOnly:=SORT(JOIN(dCandidateCounts,dWatchdog,LEFT.did=RIGHT.did,TRANSFORM(lCandidateCounts,SELF:=LEFT;),LOCAL),-did_ct,LOCAL);
  dUnderThreshold:=PROJECT(dWatchdogOnly,TRANSFORM(lCandidateCounts,SELF.record_id:=LEFT.record_id+COUNTER;SELF:=LEFT;))(record_id<=reunion.constants.threshold_);
  dSlim:=PROJECT(dUnderThreshold,reunion.layouts.lIteration);

  RETURN dNotCandidates+dSlim;
END;