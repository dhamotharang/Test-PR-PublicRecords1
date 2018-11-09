EXPORT Proc_ClearSuperKeys := PARALLEL( // parallel should be ok - all using different superkey
     Process_LocationID_Layouts.ClearKeySuperFile // main datafile
    ,Process_LocationID_Layouts.ClearKeyIDHistorySuperFile // ID History
    ,Key_LocationId_.ClearKeySuperFile // uberkey
    ,Key_LocationId_.ClearValueKeySuperFile // values for uberkey
    ,Key_LocationId_STATECITY.ClearKeySuperFile // linkpath
    ,Key_LocationId_ZIP.ClearKeySuperFile // linkpath
);
