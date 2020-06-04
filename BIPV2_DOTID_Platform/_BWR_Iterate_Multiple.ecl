DotStartIteration  := 1   ;
DotNumIterations   := 1   ;
doDotidInit        := true;
doDotidSpecs       := true;
doDotidIters       := true;
doDotidPost        := true;
pversion           := '20151019';
// startfile          := project(dataset('~thor_data400::bipv2::internal_linking::20150828_append_did_fix_dotid_overlinking',bipv2.CommonBase.layout,thor),recordof(BIPV2_Files.files_ingest.DS_BASE));
BIPV2_DOTID_PLATFORM._proc_dotid().MultIter_run (DotStartIteration     ,DotNumIterations      ,doDotidInit ,doDotidSpecs  ,doDotidIters  ,doDotidPost ,pversion  
,project(dataset('~thor_data400::bipv2::internal_linking::20150828_append_did_fix_dotid_overlinking',bipv2.CommonBase.layout,thor),recordof(BIPV2_Files.files_ingest.DS_BASE))
);
// -- rollback changes to ds_ingest in BIPV2_Build.proc_dotid
