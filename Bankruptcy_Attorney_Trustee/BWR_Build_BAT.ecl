import Bankruptcy_Attorney_Trustee, Orbit3;

export BWR_Build_BAT (filedate) := MACRO

#workunit('name','Yogurt:Bankruptcy Attorney Trustee ' + filedate);

DoBuild := Bankruptcy_Attorney_Trustee.Build_All(filedate);

SampleRecs_Attorney := choosen(sort(Bankruptcy_Attorney_Trustee.Files.Attorneys_Base,record),1000);
SampleRecs_Trustee := choosen(sort(Bankruptcy_Attorney_Trustee.Files.Trustees_Base,record),1000);
				
create_orbit_build:= Orbit3.Proc_Orbit3_CreateBuild_npf ('Bankruptcy Attorney Trustee',filedate);

sequential(
			DoBuild
			,output(SampleRecs_Attorney)
			,output(SampleRecs_Trustee)
			,create_orbit_build
			)
			: success(Bankruptcy_Attorney_Trustee.Send_Email(filedate).Build_Success)
			, failure(Bankruptcy_Attorney_Trustee.Send_Email(filedate).Build_Failure)
			;

 endmacro
 ;