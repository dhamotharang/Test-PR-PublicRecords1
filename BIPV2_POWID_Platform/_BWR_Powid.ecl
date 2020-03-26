PowStartIteration   := 1   ;
PowNumIterations    := 2   ;
doPowidInit         := true;
doPowidSpecs        := true;
doPowidIters        := true;
doPowidPost         := true;
Powversion          := '20160202';
Pow_Init_File       := BIPV2_Files.files_powid_down.DS_BASE;  //make sure to put this into the input file parameter below
BIPV2_POWID_Platform._proc_powid().MultIter_run (PowStartIteration,PowNumIterations ,doPowidInit      ,doPowidSpecs     ,doPowidIters     ,doPowidPost      ,Powversion       
,BIPV2_Files.files_powid_down.DS_BASE_PROD  //put your input file to the build here
,BIPV2_build._Constants().Groupname
);
