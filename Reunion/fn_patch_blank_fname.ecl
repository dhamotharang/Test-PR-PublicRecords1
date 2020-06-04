EXPORT fn_patch_blank_fname(DATASET(reunion.layouts.lMainRaw) in_main):=FUNCTION

  dCandidates:=DISTRIBUTE(in_main(TRIM(fname)=''),HASH(did));
  dNotCandidates:=in_main(fname<>'');

  lPatch:=RECORD
   UNSIGNED6 did;
   STRING20 fname;
   UNSIGNED count_:=1;
  END;

  dHeaderFormatted:=SORT(DISTRIBUTE(PROJECT(reunion.files(1).infutor_header(fname<>''),lPatch),HASH(did)),did,fname,LOCAL);
  dRolled:=DEDUP(SORT(ROLLUP(dHeaderFormatted,LEFT.did=RIGHT.did AND LEFT.fname=RIGHT.fname,TRANSFORM(lPatch,SELF.count_:=LEFT.count_+1;SELF:=LEFT;),LOCAL),did,-count_,LOCAL),did,LOCAL);
  dJoined:=JOIN(dCandidates,dRolled,LEFT.did=RIGHT.did,TRANSFORM(RECORDOF(dCandidates),SELF.fname:=RIGHT.fname;SELF:=LEFT;),LEFT OUTER,KEEP(1),LOCAL);
  dPatched:=dNotCandidates+dJoined;

  RETURN dPatched;

END;