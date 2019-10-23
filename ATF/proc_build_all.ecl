#workunit('name','Yogurt: ATF Federal Firearms Build');

#OPTION('multiplePersistInstances',FALSE);
import fieldstats,PromoteSupers,business_header,roxiekeybuild,STRATA,_control,versioncontrol;

export proc_build_all(string filedate,boolean pUseProd = false) := function
	
	spray_  		 := VersionControl.fSprayInputFiles(atf.mac_atf_spray(filedate,pUseProd));
	
	 build_super :=
                  IF(
									     FileServices.FileExists('~thor_data400::in::explosives_licenses_' + filedate),
					             sequential
	                     (
												fileservices.startsuperfiletransaction(),
												fileservices.clearsuperfile('~thor_Data400::in::atf_firearms_FATHER'),
												fileservices.addsuperfile('~thor_data400::in::atf_firearms_FATHER','~thor_data400::in::atf_firearms_IN',0,true),
												fileservices.clearsuperfile('~thor_data400::in::atf_firearms_IN'),
												fileservices.addsuperfile('~thor_data400::in::atf_firearms_IN','~thor_data400::in::firearms_licenses_' + filedate),
												fileservices.clearsuperfile('~thor_Data400::in::atf_explosives_FATHER'),
												fileservices.addsuperfile('~thor_data400::in::atf_explosives_FATHER','~thor_data400::in::atf_explosives_IN',0,true),
												fileservices.clearsuperfile('~thor_data400::in::atf_explosives_IN'),
												fileservices.addsuperfile('~thor_data400::in::atf_explosives_IN','~thor_data400::in::explosives_licenses_' + filedate),
												fileservices.finishsuperfiletransaction()
					             ),
											 sequential
	                     (
												fileservices.startsuperfiletransaction(),
												fileservices.clearsuperfile('~thor_Data400::in::atf_firearms_FATHER'),
												fileservices.addsuperfile('~thor_data400::in::atf_firearms_FATHER','~thor_data400::in::atf_firearms_IN',0,true),
												fileservices.clearsuperfile('~thor_data400::in::atf_firearms_IN'),
												fileservices.addsuperfile('~thor_data400::in::atf_firearms_IN','~thor_data400::in::firearms_licenses_' + filedate),
												fileservices.finishsuperfiletransaction()
					            )
								
	                  );
										
										

	//prebuild_spray := prespray : success(output('Pre-build Spray completed.'));

	PromoteSupers.MAC_SF_BuildProcess(preprocess(filedate),'~thor_data400::in::atf_firearms_explosives_IN',prepit,3,,true,filedate);

	df := atf.firearms_explosives_did_ssn();

	PromoteSupers.MAC_SF_BuildProcess(df,'~thor_data400::base::atf_firearms_explosives',b,3,,true)

	build_process := b : success(output('Build of Base ATF file complete.'));

	build_keys := atf.proc_build_keys_new(filedate) : success(output('Build of Thor keys complete.'));

	RoxieKeyBuild.Mac_Daily_Email_Local('ATF','SUCC',filedate,send_succ_msg,Spray_Notification_Email_Address);
	RoxieKeyBuild.Mac_Daily_Email_Local('ATF','FAIL',filedate,send_fail_msg,Spray_Notification_Email_Address);

	ds := dataset('~thor_data400::base::atf_firearms_explosives', ATF.layout_firearms_explosives_out_BIP, flat);
	base_rec_count := output(count(ds), NAMED('Record_Count'));
	base_rec_count_with_did := output(count(ds((integer)DID_out > 0)), NAMED('Record_Count_With_DID'));
	base_rec_count_with_bdid := output(count(ds((integer)bdid > 0)), NAMED('Record_Count_With_BDID'));
	base_rec_count_with_both := output(count(ds((integer)bdid > 0 and (integer)DID_out > 0)), NAMED('Record_Count_With_Both'));
	base_rec_count_with_ssn := output(count(ds(best_ssn != '')), NAMED('Record_Count_With_ssn'));
	date_stats := Query_State_Date_Stats;

 	STRATA.CreateAsHeaderStats(ATF.ATF_as_header(ATF.file_firearms_explosives_base_BIP),
														 'Federal Explosives & Firearms',
														 'data',
														 filedate,
														 '',
														 runAsHeaderStats
														);
														
		update_dops := sequential(RoxieKeyBuild.updateversion('ATFKeys',(filedate),'Darren.Knowles@lexisnexis.com',,'N'),
		                          RoxieKeyBuild.updateversion('FCRA_ATFKeys',(filedate),'Darren.Knowles@lexisnexis.com',,'F'));
   
	 
	 return sequential(
	                    spray_
                      ,build_super                      
											,prepit
											,build_process
										  ,build_keys
										 ,base_rec_count
										 ,base_rec_count_with_did
										 ,base_rec_count_with_bdid
										 ,base_rec_count_with_both
										 ,base_rec_count_with_ssn
										 ,date_stats
										 ,atf.Out_Base_Stats_Population(filedate)
										 ,runAsHeaderStats
										 ,fileservices.clearsuperfile('~thor_data400::in::firearms_licenses')
										 ,fileservices.clearsuperfile('~thor_data400::in::explosives_licenses')
										 ,update_dops

                     );
										
end;
