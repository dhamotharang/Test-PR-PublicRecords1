EXPORT fn_patch_blank_lname(DATASET(reunion.layouts.lMainRaw) in_main):=FUNCTION

  dCandidates:=DISTRIBUTE(in_main(TRIM(lname)=''),HASH(did));
  dNotCandidates:=in_main(lname<>'');

  lPatch:=RECORD
   UNSIGNED6 did;
   STRING20 lname;
   UNSIGNED count_:=1;
  END;

  dHeaderFormatted:=SORT(DISTRIBUTE(PROJECT(reunion.files(1).infutor_header(lname<>''),lPatch),HASH(did,lname)),did,lname,LOCAL);
  dRolled:=DEDUP(SORT(ROLLUP(dHeaderFormatted,LEFT.did=RIGHT.did AND LEFT.lname=RIGHT.lname,TRANSFORM(lPatch,SELF.count_:=LEFT.count_+1;SELF:=LEFT;),LOCAL),did,-count_,LOCAL),did,LOCAL);
  dJoined:=JOIN(dCandidates,dRolled,LEFT.did=RIGHT.did,TRANSFORM(RECORDOF(dCandidates),SELF.lname:=RIGHT.lname;SELF:=LEFT;),LEFT OUTER,KEEP(1),LOCAL);
  dPatched:=dNotCandidates+dJoined;

  RETURN dPatched;

END;