import ut, RoxieKeyBuild;

// Don't forget to update the Version Development attribute with the new build date
filedate := EASI.Version_Development;

current_census := 'current_census';
current_yr := 'current_yr';
five_yr_projection := 'five_yr_projection';

createSuperFiles(string file) := sequential(
		IF (NOT FileServices.SuperFileExists(Files09.Cluster + 'base::easi::' + file),
				FileServices.CreateSuperFile(Files09.Cluster + 'base::easi::' + file)),
		FileServices.ClearSuperFile(Files09.Cluster + 'base::easi::' + file,false),
		IF (NOT FileServices.SuperFileExists(Files09.Cluster + 'base::easi_building'),
				FileServices.CreateSuperFile(Files09.Cluster + 'base::easi_building')),
		IF (NOT FileServices.SuperFileExists(Files09.Cluster + 'key::easi::built::' + file),
				FileServices.CreateSuperFile(Files09.Cluster + 'key::easi::built::' + file)),
		IF (NOT FileServices.SuperFileExists(Files09.Cluster + 'key::easi::grandfather::' + file),
				FileServices.CreateSuperFile(Files09.Cluster + 'key::easi::grandfather::' + file)),
		IF (NOT FileServices.SuperFileExists(Files09.Cluster + 'key::easi::father::' + file),
				FileServices.CreateSuperFile(Files09.Cluster + 'key::easi::father::' + file)),
		IF (NOT FileServices.SuperFileExists(Files09.Cluster + 'key::easi::qa::' + file),
				FileServices.CreateSuperFile(Files09.Cluster + 'key::easi::qa::' + file)),
		FileServices.ClearSuperFile(Files09.Cluster + 'key::easi::built::' + file,false),
		FileServices.ClearSuperFile(Files09.Cluster + 'key::easi::qa::' + file,false)
);

pre0 := sequential(
		createSuperFiles(current_yr),
		createSuperFiles(current_census),
		createSuperFiles(five_yr_projection),
		fileservices.startsuperfiletransaction(),
		if (fileservices.getsuperfilesubcount(Files09.Cluster + 'base::easi_building') > 0,
			output('Nothing added to easi_building'),
			fileservices.addsuperfile(Files09.Cluster + 'base::easi_building',Files09.Cluster + 'base::easi',,true)),
		fileservices.finishsuperfiletransaction()
		);

//MAC_SK_BuildProcess_Local(theindexprep, keyname, superkeyname, seq_name, numgenerations = '3', one_node = 'false') := macro
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EASI.Key_Easi_Current_Yr
                                       ,Files09.Cluster + 'key::easi::' + filedate + '::' + current_yr
									   ,Files09.Cluster + 'key::easi',bk0,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EASI.Key_Easi_Current_Census
                                       ,Files09.Cluster + 'key::easi::' + filedate + '::' + current_census
									   ,Files09.Cluster + 'key::easi',bk8,2);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EASI.Key_Easi_five_yr_projection
                                       ,Files09.Cluster + 'key::easi::' + filedate + '::' + five_yr_projection
									   ,Files09.Cluster + 'key::easi',bk9,2);
									   
									   
									   
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(EASI.Key_Easi_Census_v2
//                                       ,Files09.Cluster + 'key::easi::' + filedate + '::census_v2'
//									   ,Files09.Cluster + 'key::easi_v2',bk1,2);
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(EASI.Key_Easi_Census_v3
//                                       ,Files09.Cluster + 'key::easi::' + filedate + '::census_v3'
//									   ,Files09.Cluster + 'key::easi_v3',bk3,2);

// Move all the keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Files09.Cluster + 'key::easi::@version@::' + current_yr
									,Files09.Cluster + 'key::easi::' + filedate + '::' + current_yr
								  ,move1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Files09.Cluster + 'key::easi::@version@::' + current_census
									,Files09.Cluster + 'key::easi::' + filedate + '::' + current_census
								  ,move8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Files09.Cluster + 'key::easi::@version@::' + five_yr_projection
									,Files09.Cluster + 'key::easi::' + filedate + '::' + five_yr_projection
								  ,move9);
//RoxieKeyBuild.Mac_SK_Move_To_Built(Files09.Cluster + 'key::easi::' + filedate + '::census_v2'
 //                                 ,Files09.Cluster + 'key::easi_v2'
//								  ,move2);
//RoxieKeyBuild.Mac_SK_Move_To_Built(Files09.Cluster + 'key::easi::' + filedate + '::census_v3'
//                                  ,Files09.Cluster + 'key::easi_v3'
//								  ,move3);
// move_build_keys := parallel(move1,move2);
move_build_keys := parallel(move1,move8,move9);
//move_build_keys := move3;

// Move all the keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Files09.Cluster + 'key::easi::@version@::' + current_yr,'Q', moveq1);
RoxieKeyBuild.MAC_SK_Move_V2(Files09.Cluster + 'key::easi::@version@::' + current_census,'Q', moveq8);
RoxieKeyBuild.MAC_SK_Move_V2(Files09.Cluster + 'key::easi::@version@::' + five_yr_projection,'Q', moveq9);
//ut.MAC_SK_Move(Files09.Cluster + 'key::easi_v2','Q', moveq2);
//ut.MAC_SK_Move('~thor200_144::key::easi_v3','Q', moveq3);
// move_qa_keys := parallel(moveq1,moveq2);
move_qa_keys := parallel(moveq1,moveq8,moveq9);
//move_qa_keys := moveq3;

pre1 := sequential(
		IF (NOT FileServices.SuperFileExists(Files09.Cluster + 'base::easi_built'),
				FileServices.CreateSuperFile(Files09.Cluster + 'base::easi_built')),
					fileservices.startsuperfiletransaction(),
					fileservices.clearsuperfile(Files09.Cluster + 'base::easi_built'),
					fileservices.addsuperfile(Files09.Cluster + 'base::easi_built','~thor_data400::base::easi_building',,true),
					fileservices.clearsuperfile(Files09.Cluster + 'base::easi_building'),
					fileservices.finishsuperfiletransaction()
				   );

email_send_list := 'charles.salvo@lexisnexis.com';
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

 /*EASI_BuildKeys := sequential(pre0
									 // ,parallel(bk0,bk1)
									 ,bk0
									 ,move_build_keys
									 ,move_qa_keys
									 ,pre1) : success(send_succ_msg)
											 ,failure(send_fail_msg);
*/

export EASI_BuildKeys_V3 := sequential(pre0
									 ,parallel(bk0,bk8,bk9)
									 //,bk0		//bk3
									 ,move_build_keys
									 ,move_qa_keys
									 ,pre1) : success(send_succ_msg)
											 ,failure(send_fail_msg);
