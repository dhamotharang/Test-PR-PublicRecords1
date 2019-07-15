//this is for when a new dotid build is run on top of existing proxids.
//this way I can patch the proxids before running the proxid build
//this will patch the following cases
//1. if the dotid that the proxid got its value from does not exist anymore, it will reset the proxid to it's dotid.
//2. in the case where the proxid doesn't contain the dotid where it got its value from.
import bipv2,bipv2_files,BIPV2_ProxID,ut,salt26,tools;
EXPORT Patch_Proxids(
   string                   pIteration
  ,string                   pversion    = BIPV2.KeySuffix
  ,dataset(layout_dot_base) pDataset    = BIPV2_Files.files_dotid.DS_BASE
  ,boolean                  pAdd2Super  = true
) :=
function
  iter      := pIteration;
  combo     := pversion + '_' + iter;
  filename  := BIPV2_ProxID.filenames(combo).base.logical;
  ddefaultproxids := BIPV2_ProxID._Filters.Explode(project(pDataset,transform(BIPV2.CommonBase.Layout,self.proxid := if(left.proxid = 0 ,left.dotid,left.proxid),self := left)));
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
  writefile := tools.macf_WriteFile(filename,ds_out,,,true);
  //output some samples
  set100BadDots := set(choosen(table(ds_bad ,{dotid},dotid),100),dotid);
  ds_in_bad   := sort(ddefaultproxids (dotid in set100BadDots) ,dotid,rcid);
  ds_out_bad  := sort(ds_out          (dotid in set100BadDots) ,dotid,rcid);
  //some stats around this
  dproxidsold := table(ddefaultproxids  ,{proxid},proxid,merge);
  dproxidsnew := table(ds_out           ,{proxid},proxid,merge);
  //stats on changed records
  dchanges := join(distribute(ddefaultproxids,rcid),distribute(ds_out,rcid)  ,left.rcid = right.rcid and left.proxid != right.proxid ,transform(left),local);
  return 
  sequential(
    parallel(
       writefile
      ,output(choosen (ds_in_bad  ,500) ,named('BadDotsBeforePatch'     ),all)
      ,output(choosen (ds_out_bad ,500) ,named('BadDotsAfterPatch'      ),all)
      ,output(count   (dproxidsold    ) ,named('TotalProxidsBeforePatch'))
      ,output(count   (dproxidsnew    ) ,named('TotalProxidsAfterPatch' ))
      ,output(count   (dchanges       ) ,named('TotalRecordsChanged'    ))
    )
    ,iff(pAdd2Super = true  ,BIPV2_ProxID.Promote(combo).new2built)
  )
  ;
  
end;
