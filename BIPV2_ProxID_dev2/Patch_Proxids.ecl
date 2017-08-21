//this is for when a new dotid build is run on top of existing proxids.
//this way I can patch the proxids before running the proxid build
//this will patch the following cases
//1. if the dotid that the proxid got its value from does not exist anymore, it will reset the proxid to it's dotid.
//2. in the case where the proxid doesn't contain the dotid where it got its value from.
import salt26,BIPV2_Files,ut;

EXPORT Patch_Proxids(

  dataset(layout_dot_base) pDataset = BIPV2_Files.files_dotid.DS_DOTID_BASE

) :=
function

  ddefaultproxids := project(pDataset,transform(layout_dot_base,self.proxid := if(left.proxid = 0 ,left.dotid,left.proxid),self := left));
  
  ds_thin   := table(ddefaultproxids, {dotid, proxid}, dotid, proxid);
  ds_bad    := join(ds_thin, ds_thin, left.dotid=right.dotid and left.proxid<>right.proxid, transform(left));
  
  ds_bad toPatch(ds_bad L, ds_bad R) := 
  transform
    self.dotid  := L.dotid;
    self.proxid := ut.Min2(L.proxid,R.proxid);
  end;

  patchfile := rollup(sort(ds_bad,dotid,proxid), dotid, toPatch(left,right));
  
  salt26.MAC_Reassign_UID(ddefaultproxids,patchfile,proxid,dotid,ds_patched1);

  ds_out := ds_patched1;

  return ds_out;
  
end;