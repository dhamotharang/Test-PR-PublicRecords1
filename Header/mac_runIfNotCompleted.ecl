EXPORT mac_runIfNotCompleted(buildName, versionDate, daction, step) := FUNCTIONMACRO
    IMPORT header;
    sf_name:='~thor_data400::base::build_status::'+buildName+'_';
    ver    := Header.LogBuildStatus(sf_name).GetLatest.versionName;
    status:=Header.LogBuildStatus(sf_name).GetLatest.versionStatus;
    update_status:=Header.LogBuildStatus(sf_name, versionDate, step).Write;
    skipStep := (step<=status AND ver=versionDate);
    takeAction :=  if(skipStep,  output(dataset([{'Skipping step:'+#TEXT(daction)}],{string100 message}),NAMED('SKIP_REPORT'),EXTEND),
                                    sequential(daction,update_status ));

    RETURN takeAction;

ENDMACRO;