// -- BH-449 -- test running iterations on top of the reset of the D&B fein clusters to explode.
// -- this answers "How do they come back together?"
// -- run proxid and lgid3 iters
// -- then run active and gold calculations on results
// -- also run persistent stats

pversion          := '20180402_BH333_test';
num_proxid_iters  := 0;
num_lgid3_iters   := 10;

myfilename  := '~thor_data400::bipv2_dotid::salt_iter::20180302::bh333_post::explode_sbfe_overlinked_clusters';
mylay       := {bipv2.commonbase.layout,string prox_status,string pct_bow_mismatches,unsigned6 old_proxid,unsigned6 old_seleid};
ds_me       := dataset(myfilename,mylay,flat);
ds_prep     := project(ds_me,bipv2.commonbase.layout);
output_prep := output(ds_prep ,,BIPV2_ProxID.Filenames(pversion).out.new  ,compressed,overwrite);
 
prep_proxid := sequential(
   std.file.clearsuperfile(BIPV2_Files.files_dotid().FILE_BASE)
  ,std.file.addsuperfile  (BIPV2_Files.files_dotid().FILE_BASE ,BIPV2_Files.files_dotid().FILE_BASE + pversion)
);

prep_hrchy := sequential(
   output_prep
  ,std.file.clearsuperfile(BIPV2_ProxID.Filenames().out.built)
  ,std.file.addsuperfile  (BIPV2_ProxID.Filenames().out.built ,BIPV2_ProxID.Filenames(pversion).out.new)
);
//BIPV2_Files.files_proxid().DS_PROXID_BUILT = BIPV2_ProxID.Files(pversion).out.built;
//prep_hrchy;

sequential(
#IF(num_proxid_iters > 0)
   sequential(prep_proxid,BIPV2_ProxID._proc_Multiple_Iterations                (1,num_proxid_iters,pversion,'BIPV2_Files.files_dotid().DS_BASE','thor50_dev_eclcc',BIPV2_Files.files_dotid().FILE_BASE)),
#ELSE
  prep_hrchy,
#END
   BIPV2_Build.proc_hrchy                                (pversion,'thor50_dev_eclcc',,true)//BIPV2_Files.files_proxid().DS_PROXID_BUILT
  ,BIPV2_Build.proc_lgid3                ().MultIter_run (1,num_lgid3_iters  ,true  ,true   ,true  ,true ,pversion,'thor50_dev_eclcc')
);

/*
output('<a href="http://10.173.14.204:8010/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=W20180411-102213#/stub/Summary">Parent Workunit</a>' ,named('Parent_Wuid__html'));
#workunit('name','BIPV2_Build.build_hrchy  20180402_BH333_test');
#workunit('priority','high');
#OPTION('multiplePersistInstances',FALSE);
BIPV2_Build.build_hrchy('20180402_BH333_test' ,,,,,false,,true  ).runIter;

*/