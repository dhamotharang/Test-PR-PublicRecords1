import Roxiekeybuild,Orbit3;
export Proc_Update_Dops() := function
	string_rec := record
		string processdate;
	end;
	newfiledate := dedup(dataset('~thor::dops::liensv2',string_rec,thor,opt),record)[1].processdate;
	return sequential(
						if(~fileservices.fileexists('~thor::dops::liensv2'),
								fileservices.createsuperfile('~thor::dops::liensv2')),
						if(fileservices.getsuperfilesubcount('~thor::dops::liensv2') = 3,
					sequential(RoxieKeybuild.updateversion('Liensv2Keys',newfiledate,'skasavajjala@seisint.com,michael.gould@lexisnexis.com',,'N|B'),
					        Orbit3.proc_Orbit3_CreateBuild ( 'Liens & Judgements',newfiledate,'N|B'),
					fileservices.clearsuperfile('~thor::dops::liensv2',true),
					fileservices.sendemail(
												'Sudhir.Kasavajjala@lexisnexisrisk.com; Michael.Gould@lexisnexisrisk.com',
												'ALERT:LiensV2Keys:Completed',
												'Liensv2 job finished, add to package for deployment'
										)),
					output('Liens build still running')));
end;