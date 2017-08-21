import RoxieKeyBuild;
export Proc_build_ECrashV2(string filedate,string morning = 'no',string issunday = 'N') := function

updatedops := map(morning = 'yes' and issunday = 'N' => RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com',,'N',,'Y'),
                   morning = 'yes' and issunday = 'Y' => RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com','Y','N',,'Y'),
									 RoxieKeyBuild.updateversion('EcrashV2Keys',filedate,'skasavajjala@seisint.com'));

build_v2 :=  Sequential(
                          proc_build_EcrashV2_keys(filedate),
													updatedops): success(send_email(filedate,'V2').buildsuccess), failure(send_email(filedate,'V2').buildfailure);
													
return build_v2;

end;
													
													
													