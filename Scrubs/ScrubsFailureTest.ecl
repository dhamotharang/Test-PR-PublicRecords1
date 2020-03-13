import scrubs,STD;

export ScrubsFailureTest(string RelevantProfileName,string pversion):=function 

ScrubsOld:=dataset('~thor_data400::scrubs::orbitreports::fullFile',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsNew:=dataset('~thor_data400::scrubs::orbitreports',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsFiles:=ScrubsOld+ScrubsNew;

RelevantOrbitProfile:=ScrubsFiles(version=pVersion and STD.Str.ToLowerCase(ProfileName)=STD.STR.ToLowerCase(RelevantProfileName));

TestProfile:=if(Exists(RelevantOrbitProfile(RejectWarning='Y')),false,true);

//output(RelevantOrbitProfile(RejectWarning='Y'),all);

return TestProfile;

end;