

Import STD,_control,tris_lnssi_build,VersionControl,BuildLogger,Orbit3,Roxiekeybuild;


spray_new   := VersionControl.fSprayInputFiles(
            tris_lnssi_build.fSpray(filedate, pUseprod));
