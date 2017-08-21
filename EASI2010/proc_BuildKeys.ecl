import ut, RoxieKeyBuild;

// Don't forget to update the Version attribute with the new build date
filedate := Version;

current_census := 'current_census';
current_yr := 'current_yr';
five_yr_projection := 'five_yr_projection';
legacy := 'easi_census_2010';

createSuperFiles(string file) := sequential(
		IF (NOT FileServices.SuperFileExists(Cluster + 'base::easi::' + file),
				FileServices.CreateSuperFile(Cluster + 'base::easi::' + file)),
		FileServices.ClearSuperFile(Cluster + 'base::easi::' + file,false),
		IF (NOT FileServices.SuperFileExists(Cluster + 'base::easi_building'),
				FileServices.CreateSuperFile(Cluster + 'base::easi_building')),
		IF (NOT FileServices.SuperFileExists(Cluster + 'key::easi::built::' + file),
				FileServices.CreateSuperFile(Cluster + 'key::easi::built::' + file)),
		IF (NOT FileServices.SuperFileExists(Cluster + 'key::easi::grandfather::' + file),
				FileServices.CreateSuperFile(Cluster + 'key::easi::grandfather::' + file)),
		IF (NOT FileServices.SuperFileExists(Cluster + 'key::easi::father::' + file),
				FileServices.CreateSuperFile(Cluster + 'key::easi::father::' + file)),
		IF (NOT FileServices.SuperFileExists(Cluster + 'key::easi::qa::' + file),
				FileServices.CreateSuperFile(Cluster + 'key::easi::qa::' + file)),
		FileServices.ClearSuperFile(Cluster + 'key::easi::built::' + file,false),
		FileServices.ClearSuperFile(Cluster + 'key::easi::qa::' + file,false)
);

pre0 := sequential(
		createSuperFiles(current_yr),
		createSuperFiles(current_census),
		createSuperFiles(five_yr_projection),
		createSuperFiles(legacy),
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount(Cluster + 'base::easi_building') > 0,
			output('Nothing added to easi_building'),
			fileservices.addsuperfile(Cluster + 'base::easi_building',Cluster + 'base::easi',,true)),
		fileservices.finishsuperfiletransaction()
		);

clust := Cluster;	// if you don't think this is necessary, then try removing it!
//MAC_SK_BuildProcess_Local(theindexprep, keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_Easi_Current_Yr
                                       ,clust + 'key::easi::' + filedate + '::' + current_yr
									   ,Cluster + 'key::easi',bk0,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_Easi_Current_Census
                                       ,clust + 'key::easi::' + filedate + '::' + current_census
									   ,Cluster + 'key::easi',bk8,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_Easi_five_yr_projection
                                       ,clust + 'key::easi::' + filedate + '::' + five_yr_projection
									   ,Cluster + 'key::easi',bk9,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_LegacyFormat_2010
                                       ,clust + 'key::easi::' + filedate + '::' + legacy
									   ,Cluster + 'key::easi',bk10,2);
									   
									  
// Move all the keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Cluster + 'key::easi::@version@::' + current_yr
									,Cluster + 'key::easi::' + filedate + '::' + current_yr
								  ,move1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Cluster + 'key::easi::@version@::' + current_census
									,Cluster + 'key::easi::' + filedate + '::' + current_census
								  ,move8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Cluster + 'key::easi::@version@::' + five_yr_projection
									,Cluster + 'key::easi::' + filedate + '::' + five_yr_projection
								  ,move9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Cluster + 'key::easi::@version@::' + legacy
									,Cluster + 'key::easi::' + filedate + '::' + legacy
								  ,move10);
								  
move_build_keys := parallel(move1,move8,move9,move10);
//move_build_keys := move3;

// Move all the keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Cluster + 'key::easi::@version@::' + current_yr,'Q', moveq1);
RoxieKeyBuild.MAC_SK_Move_V2(Cluster + 'key::easi::@version@::' + current_census,'Q', moveq8);
RoxieKeyBuild.MAC_SK_Move_V2(Cluster + 'key::easi::@version@::' + five_yr_projection,'Q', moveq9);
RoxieKeyBuild.MAC_SK_Move_V2(Cluster + 'key::easi::@version@::' + legacy,'Q', moveq10);
//ut.MAC_SK_Move(Files09.Cluster + 'key::easi_v2','Q', moveq2);
//ut.MAC_SK_Move('~thor200_144::key::easi_v3','Q', moveq3);
// move_qa_keys := parallel(moveq1,moveq2);
move_qa_keys := parallel(moveq1,moveq8,moveq9,moveq10);
//move_qa_keys := moveq3;

pre1 := sequential(
		IF (NOT FileServices.SuperFileExists(Cluster + 'base::easi_built'),
				FileServices.CreateSuperFile(Cluster + 'base::easi_built')),
					fileservices.startsuperfiletransaction(),
					fileservices.clearsuperfile(Cluster + 'base::easi_built'),
					fileservices.addsuperfile(Cluster + 'base::easi_built',Cluster + 'base::easi_building',,true),
					fileservices.clearsuperfile(Cluster + 'base::easi_building'),
					fileservices.finishsuperfiletransaction()
				   );

email_send_list := 'charles.salvo@lexisnexis.com,jose.bello@lexisnexis.com,heather.mccarl@lexisnexis.com';
// email_send_list := 'dqi@seisint.com,jbello@seisint.com,RoxieBuilds@seisint.com';

RoxieKeyBuild.Mac_Daily_Email_Local('EASI CENSUS'
                                   ,'SUCC'
								   ,filedate
								   ,send_succ_msg
								   ,email_send_list);
RoxieKeyBuild.Mac_Daily_Email_Local('EASI CENSUS'
                                   ,'FAIL'
								   ,filedate
								   ,send_fail_msg
								   ,email_send_list);

export proc_BuildKeys := sequential(pre0
									 ,parallel(bk0,bk8,bk9,bk10)
									 ,move_build_keys
									 ,move_qa_keys
									 ,pre1) : success(send_succ_msg)
											 ,failure(send_fail_msg);

