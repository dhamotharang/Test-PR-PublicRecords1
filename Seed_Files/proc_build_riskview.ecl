EXPORT proc_build_riskview(string filedate) := function

//Spray riskview report files to thor
spray_RiskView := Seed_Files.RiskViewTestSeed_Spray(filedate);

spray_RiskView2 := Seed_Files.RiskView2TestSeed_Spray(filedate);


//build keys
build_keys := Seed_Files.proc_build_riskviewkeys(filedate);

build_all := Sequential(/*spray_RiskView,*/spray_RiskView2,
                        build_keys) :  success(Send_Email(filedate).buildsuccess), failure(Send_Email(filedate).buildfailure);
												
												
return build_all;
end;