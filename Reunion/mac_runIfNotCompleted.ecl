EXPORT mac_runIfNotCompleted(buildName, versionDate, daction, step) := FUNCTIONMACRO
    IMPORT header;
    sf_name:='~thor_data400::base::build_status::'+buildName+'_';
    ver    := reunion.LogBuildStatus(sf_name).GetLatest.buildversionName;
    status:=reunion.LogBuildStatus(sf_name).GetLatest.versionStatus;
    feedVer := Reunion._config.get_feed_sVersion;
    update_status:=reunion.LogBuildStatus(sf_name, versionDate, feedVer, step).Write;
    skipStep := (step<=status AND ver=versionDate);
    takeAction :=  if(skipStep,  output(dataset([{'Skipping step:'+#TEXT(daction)}],{string100 message}),NAMED('SKIP_REPORT'),EXTEND),
                                    sequential(daction,update_status ));

    RETURN takeAction;

ENDMACRO;