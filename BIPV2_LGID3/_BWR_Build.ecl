//start at iteration 8,not 1
// ds_in := dataset('~thor_data400::BIPV2_LGID3::salt_iter::20140314::it7',BIPV2.CommonBase.Layout,flat);//(v_city_name in ['BOCA RATON','DAYTON','SPRINGBORO','MIAMISBURG'],st in ['FL','OH']);
// init := BIPV2_LGID3._proc_lgid3().init(ds_in);
init := sequential(
   BIPV2_Files.files_lgid3.clearBuilding
  ,BIPV2_Files.files_lgid3.updateBuilding('~thor_data400::BIPV2_LGID3::salt_iter::20140314::it7')
);
startIter     := 8    ;
numIters      := 1    ;
doInit        := false;
doSpec        := false;
#workunit('priority','high' );
#workunit('protect' ,true   );
multiname := BIPV2_LGID3._proc_lgid3().MultIter     (startIter,numIters               );
multirun  := BIPV2_LGID3._proc_lgid3().MultIter_run (startIter,numIters,doInit,doSpec );
#workunit('name',multiname);
sequential(init, multirun);
