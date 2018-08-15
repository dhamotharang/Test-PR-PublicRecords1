import advo,uspis_hotlist,_Control, Orbit3, dops;

export MAC_Build_Advo (

	 pversion
	 ,pAdvoversion
	,pAdvoSprayDirectory	= '\'/data/hds_180/advo/build\''
	,pUSPISSprayDirectory = '\'/data/hds_180/uspis_hotlist/out\''
	,pSourceIP            = _Control.IPAddress.bctlpedata11
	,pSkipAdvo						= 'false'
	,pSkipUSPIS						= 'true'
	
) := MACRO

	DoBuild := Advo.Build_All(pversion,pAdvoversion,pAdvoSprayDirectory,pUSPISSprayDirectory,pSourceIP,pSkipAdvo,pSkipUSPIS);

	//	SampleRecs := Advo.samples; //(sort(Advo.Files().base.qa,record),1000);
	SampleRecs := sort(Advo.Files().base.qa,record);
  DedupRecs := dedup(sort(SampleRecs,{-SampleRecs.date_last_seen,SampleRecs.cleanaid}));
  NewRecs := distribute(DedupRecs,HASH(SampleRecs.date_last_seen,SampleRecs.prim_range,SampleRecs.cleanaid,SampleRecs.dpbc_digit,SampleRecs.chk_digit));
  FIRST1000 := choosen(NewRecs,1000);
	movetoResearch := Advo.AddtoReseachSF;
	idops := dops.updateversion('CDSKeys',pversion,'michael.gould@lexisnexisrisk.com,Sudhir.Kasavajjala@lexisnexisrisk.com,insdataops@LexisNexisRisk.com',,'N',,,'A');
  ldops :=  sequential(dops.updateversion('CDSKeys',pversion,'michael.gould@lexisnexisrisk.com',,'N'),
                dops.updateversion('FCRA_CDSKeys',pversion,'michael.gould@lexisnexisrisk.com',,'F'));
	buildOrbit := sequential(Orbit3.proc_Orbit3_CreateBuild_AddItem ('CDS',pversion,'N'),
	                         Orbit3.proc_Orbit3_CreateBuild ('FCRA CDS',pversion,'F'),
													 
							  );

	sequential(
				DoBuild
				,output(FIRST1000)
				,idops
				,ldops
				,buildOrbit
				,movetoResearch
				)
				: success(Advo.Send_Email(pversion).Build_Success)
				, failure(Advo.Send_Email(pversion).Build_Failure)
				;

 endmacro
 ;