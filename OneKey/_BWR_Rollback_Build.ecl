#workunit('name', 'Rollback ' + OneKey._Dataset().name + ' Build');
OneKey.Rollback(pversion            := ''      //version of build you are rolling back
               ,pDeleteInputFiles   := FALSE   //Are the input files bad and need to be deleted?
               ,pDeleteBuildFiles   := FALSE   //Is the build file bad(base file) and need to be deleted?
               ,pIsTesting          := TRUE    //If false, will perform rollback and optional deletion. If true, just output dataset of information gathered.
               ,pFilter             := ''      //regex filter to use if you want to rollback only specific files
               ).fullbuild;
