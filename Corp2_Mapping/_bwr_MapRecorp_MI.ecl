#workunit('name','CORPS V2 DAILY PREPROCESS STATES - 20170113');
#workunit ('priority','high');
#workunit ('priority',15);
#option ('activitiesPerCpp', 50);
#option ('AllowClusters','thor400_44,thor400_60');
#option ('AllowAutoQueueSwitch',TRUE);
#option ('multiplePersistInstances',FALSE);
//************************************************************
//Start Daily
//
//Note:  Unload was for 20160720; Starting with 20160721.
//************************************************************
//July 2016
Corp2_Mapping.fMapState('mi','20160718',,,,FALSE,TRUE); //unload for MI
Corp2_Mapping.fMapState('mi','20160721',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20160728',,,,FALSE,TRUE);
//August 2016
Corp2_Mapping.fMapState('mi','20160804',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20160811',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20160816',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20160822',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20160824',,,,FALSE,TRUE);
//September 2016
Corp2_Mapping.fMapState('mi','20160901',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20160906',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20160920',,,,FALSE,TRUE); 
Corp2_Mapping.fMapState('mi','20160929',,,,FALSE,TRUE);
//October 2016
Corp2_Mapping.fMapState('mi','20161006',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161013',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161020',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161027',,,,FALSE,TRUE);
//November 2016
Corp2_Mapping.fMapState('mi','20161103',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161110',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161117',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161123',,,,FALSE,TRUE);
//December 2016
Corp2_Mapping.fMapState('mi','20161201',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161208',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161215',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161222',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20161229',,,,FALSE,TRUE);
//January 2017
Corp2_Mapping.fMapState('mi','20170105',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20170112',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20170119',,,,FALSE,TRUE);
Corp2_Mapping.fMapState('mi','20170119',,,,FALSE,TRUE);