EXPORT Proc_CurrentToSuperKeys := PARALLEL( // parallel should be ok - all using different superkey
     Process_LocationID_Layouts.AssignCurrentKeyToSuperFile // Assign main datafile
    ,Process_LocationID_Layouts.AssignCurrentKeyIDHistoryToSuperFile // Assign ID History Key
    ,Key_LocationId_.AssignCurrentKeyToSuperFile // Assign uberkey
    ,Key_LocationId_.AssignCurrentValueKeyToSuperFile // Assign values for uberkey
    ,Key_LocationId_STATECITY.AssignCurrentKeyToSuperFile // Assign linkpath
    ,Key_LocationId_ZIP.AssignCurrentKeyToSuperFile // Assign linkpath
);
