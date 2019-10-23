import bipv2,bipv2_files,BIPV2_ProxID,ut,salt26,tools;
iter      := '29';
pversion  := BIPV2.KeySuffix + 'a';
pdataset  := BIPV2_Files.files_dotid.DS_DOTID_BASE;
filename  := BIPV2_ProxID.filenames(pversion + '_' + iter).base.logical;
#workunit('name','BIPV2_ProxID Proxid patch ' + pversion + ', ' + iter);
#workunit('protect','true');
#workunit('priority','high');
ddefaultproxids := project(pDataset,transform(BIPV2_Files.layout_dotid,self.proxid := if(left.proxid = 0 ,left.dotid,left.proxid),self := left));
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
tools.macf_WriteFile(filename,ds_out);
//output some samples
set100BadDots := set(choosen(table(ds_bad ,{dotid},dotid),100),dotid);
ds_in_bad   := sort(pDataset (dotid in set100BadDots) ,dotid,rcid);
ds_out_bad  := sort(ds_out   (dotid in set100BadDots) ,dotid,rcid);
output(choosen(ds_in_bad  ,500) ,named('BadDotsBeforePatch' ),all);
output(choosen(ds_out_bad ,500) ,named('BadDotsAfterPatch'  ),all);
//some stats around this
dproxidsold := table(pdataset ,{proxid},proxid);
dproxidsnew := table(ds_out   ,{proxid},proxid);
output(count(dproxidsold)  ,named('TotalProxidsBeforePatch'));
output(count(dproxidsnew)  ,named('TotalProxidsAfterPatch'));
//stats on changed records
dchanges := join(distribute(pdataset,rcid),distribute(ds_out,rcid)  ,left.rcid = right.rcid and left.proxid != right.proxid ,transform(left),local);
output(count(dchanges)  ,named('TotalRecordsChanged'));
