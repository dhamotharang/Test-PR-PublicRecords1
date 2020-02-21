//BWR_RunBuild

#WORKUNIT('name','Training - Data Build Process - MW');
#CONSTANT('ExtraPrefix','::MW');                                        // change the second parameter so your files are created with a unique prefix - ex: thor::spray::filename changes to thor::spray::xx::filename
#CONSTANT('LZDirectory','/data/orbittesting/thor_training/process');    // change the second parameter to the right process on the landing zone. THIS SHOULD MATCH THE FOLDER NAME OF THE FILE YOU ARE PROCESSING
#CONSTANT('BuildDate','20160531');                                      // default is today's date but it needs to match the subfolder on the landingzone which should always be a date. this affects the date first and last seen, and file versioning. THIS SHOULD MATCH THE FOLDER NAME OF THE FILE YOU ARE PROCESSING
//#CONSTANT('KeyBuildDate','20160531');               //added in code review                       
zz_mwittekiend_training.ProcBuildVinServices.RunBuild;                  // run the 20160531 date for the base file then 20160601, 20160602 and 20160630 as the update files

//output(zz_mwittekiend_training.Constants().Directory);