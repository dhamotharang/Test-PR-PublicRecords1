import wk_ut,bipv2_build,strata;

pversion := '@version@';

#workunit ('name', 'BIPV2.BWR_Build_Source_Ingest ' + pversion);
#option   ('multiplePersistInstances',FALSE);

Build_Stats	        := BIPV2.BH_Source_Ingest_Field_Pop_stats;
Orbit_Items_Strata  := wk_ut.Strata_Orbit_Item_list(workunit,'BIPV2','Full_Build'  ,pversion ,pEmailNotifyList := BIPV2_Build.mod_email.emailList,pIsTesting := false);

sequential( 
   BIPV2.Create_Supers
  ,BIPV2.Build_Source_Ingest(pversion)
  ,Build_Stats
  ,Orbit_Items_Strata
);
