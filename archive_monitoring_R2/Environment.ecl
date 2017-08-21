IMPORT _control;


EXPORT Environment := MODULE

  export boolean DEV := FALSE; // production environment
  export boolean INIT_FILES := TRUE; // production environment

  export string MAIL_LIST := 'vmyullyari@seisint.com,dqi@seisint.com,vikram.dhawan@lexisnexis.com,mluber@seisint.com';
  export string BACKUP_MAIL_LIST := 'vmyullyari@seisint.com,tkirk@seisint.com';

  export string QA_NAME := 'qa';
  export string FATHER_NAME := 'father';
  export string GR_FATHER_NAME := 'grandfather';
  export string GR_GR_FATHER_NAME := 'grandgrandfather';

  // landing zone settings which are common for all clients
  EXPORT LandingZone := MODULE
    export ip := 'thorprodspray01.br.seisint.com';
    export RootPath := '/newnfsbatch/THORMonitoring/';

    export sourcePath := RootPath + 'incoming/';
    export reconPath  := '/newnfsbatch/recon/';
    export resultPath := RootPath + 'outgoing/';
    export reportPath := RootPath + 'reports/';
  END;

  //target platform (where to copy processed file from remote site)
  EXPORT GROUP_NAME := 'production_watch_thor';
  EXPORT THOR_CLUSTER := '~production_watch_thor::';

  // whether to allow overwriting batch_in (spray) or batch_report (despray),
  // "allow" is more convenient in testing
  EXPORT boolean ALLOW_OVERWRITE := TRUE;
END;