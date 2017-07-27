import wk_ut,bipv2_build;

pversion := '20131217';
#workunit ('name', 'BIPV2 Business Header Source Ingest -'+pversion);
#option('multiplePersistInstances',FALSE);

//Build_Ingest := output(BIPV2.BL_Init());
Build_Stats	 := BIPV2.BH_Source_Ingest_Field_Pop_stats;

// -- Send Orbit item list--makes it easier to fill this out in Orbit
fileitems         := wk_ut.get_StringFilesRead(workunit,'^(?=.*?[[:digit:]]{8}.*).*?(base|biz|out).*$');  
SendOrbitItemList := BIPV2_Build.Send_Emails(pversion,pBuildName := 'BIPV2 Build Orbit Item List',pBuildMessage := fileitems).BIPV2WeeklyKeys.BuildNote;

sequential( BIPV2.Create_Supers
					 ,BIPV2.Build_Source_Ingest(pversion)
					 ,Build_Stats
           ,SendOrbitItemList
					);
//EXPORT BWR_Build_Source_Ingest := 'todo';