EXPORT proc_build_consumerprofile(string filedate) := function

//Spray riskview report files to thor
spray_CnsmrProfile := Seed_Files.ConsumerProfile_Spray(filedate);

//build keys
build_keys := Seed_Files.proc_build_ConsumerProfileKeys(filedate);

build_all := Sequential(spray_CnsmrProfile,
                        build_keys) :  success(Send_Email_CP(filedate).buildsuccess), failure(Send_Email_CP(filedate).buildfailure);
												
												
return build_all;
end;