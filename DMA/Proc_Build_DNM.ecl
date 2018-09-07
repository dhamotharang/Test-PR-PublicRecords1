#workunit('name','DNM Monthly Build')
import ut, DMA, _control, RoxieKeyBuild, Orbit3,Scrubs_DoNotMail;

export proc_build_DNM(string sourceIP,string SourceFile,string fileDate,string groupName='thor400_44',string emailTarget=' ') :=
function
	sprayIP := map(
								sourceIP = 'bctlpedata11' => _control.IPAddress.bctlpedata11,
								sourceIP = 'edata10' => _control.IPAddress.edata10,
								sourceIP = 'edata11' => _control.IPAddress.edata11,
								sourceIP = 'edata11b' => _control.IPAddress.edata11b,
								sourceIP = 'edata14' => _control.IPAddress.edata14,
								sourceIP = 'edata14a' => _control.IPAddress.edata14a,
								sourceIP = 'edata12' => _control.IPAddress.edata12,
								sourceIP
								);
	
	RoxieKeyBuild.Mac_Daily_Email_Local('DO NOT MAIL','SUCC',fileDate,sendSuccMsg,if(emailTarget<>' ',emailTarget,Email_Notification_List));
	RoxieKeyBuild.Mac_Daily_Email_Local('DO NOT MAIL','FAIL',fileDate,sendFailMsg,if(emailTarget<>' ',emailTarget,'kgummadi@seisint.com'));
	
	sprayFile := fileservices.sprayVariable(sprayIP,sourceFile,,'\\t',,'"',groupName,'~thor_data400::in::suppression::MPS_'+fileDate,,,,,true,true);
	
	addSuper := sequential(fileservices.startsuperfiletransaction(),
												 fileservices.addsuperfile('~thor_data400::in::suppression::MPS_delete','~thor_data400::in::suppression::MPS_father',,true),
												 fileservices.clearsuperfile('~thor_data400::in::suppression::MPS_father'),
												 fileservices.addsuperfile('~thor_data400::in::suppression::MPS_father','~thor_data400::in::suppression::MPS',,true),
												 fileservices.clearsuperfile('~thor_data400::in::suppression::MPS'),
												 fileservices.addsuperfile('~thor_data400::in::suppression::MPS','~thor_data400::in::suppression::MPS_'+filedate),
												 fileservices.finishsuperfiletransaction(),
												 fileservices.clearsuperfile('~thor_data400::in::suppression::MPS_delete',true)
												);
	
	ut.MAC_SF_BuildProcess(dma.proc_build_mps_all(fileDate).proc_build_base,'~thor_data400::base::suppression::mps',buildBase,2,,true)
	buildKey := dma.proc_build_mps_all(fileDate).proc_build_key : success(sendSuccMsg), failure(sendFailMsg);
	
	// updateVersion := RoxieKeyBuild.updateversion('DoNotMailKeys',fileDate,'kgummadi@seisint.com;christopher.brodeur@lexisnexis.com;randy.reyes@lexisnexis.com',,'N');
	
	//buildClickdataFile := DMA.proc_clickdata_DNM(fileDate);
	
	mpsBase := distribute(DMA.file_suppressionMPS,hash(fname,lname,prim_range,prim_name,sec_range,zip));
	mpsFather := distribute(DMA.file_suppressionMPS_father,hash(fname,lname,prim_range,prim_name,sec_range,zip));

	typeof(mpsBase) getNewRecs(mpsBase l, mpsFather r) := transform
		self := l;
	end;

	sampleRecs := join(mpsBase,mpsFather,
											left.fname = right.fname and
											left.lname = right.lname and
											left.prim_range = right.prim_range and
											left.prim_name = right.prim_name and
											left.sec_range = right.sec_range and
											left.zip = right.zip,
											getNewRecs(left,right),
											left only,
											local
											);
										
	qaRecs 	:= output(choosen(sampleRecs,1000),named('DNM_Sample_Records'));
	Strata_Stats := DMA.Out_Base_Stats_Population(fileDate);
	qaEmail	:= fileservices.sendemail('cbrodeur@seisint.com;qualityassurance@seisint.com;camaral@seisint.com;randy.reyes@lexisnexisrisk.com',
																		'DNM sample data for build version ' + fileDate,
																		'http://prod_esp:8010/WsWorkunits/WUInfo?Wuid=' + workunit);
	
	orbit_update := Orbit3.proc_Orbit3_CreateBuild ('Do Not Mail',fileDate,'N');
	
	return sequential(sprayFile,addSuper,buildBase,buildKey,//updateVersion,buildClickdataFile, 
	                                                                        qaRecs,Strata_Stats,qaEmail,Scrubs_DoNotMail.fnRunScrubs(fileDate,''), orbit_update);
	
end;