import scrubs,STD;

export mac_ScrubsFailureTest(RelevantProfileNames,pversion):=functionmacro 

ScrubsOld:=dataset('~thor_data400::scrubs::orbitreports::fullFile',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsNew:=dataset('~thor_data400::scrubs::orbitreports',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsFiles:=ScrubsOld+ScrubsNew;

lowercaselist:=STD.STR.ToLowerCase(RelevantProfileNames);

addSingleQuotes:='\''+STD.STR.FindReplace(lowercaselist,',','\',\'')+'\'';

RelevantOrbitProfiles:=ScrubsFiles(version=pVersion and STD.Str.ToLowerCase(ProfileName)in[#EXPAND(addSingleQuotes)]);

output(RelevantOrbitProfiles,all);

TestProfile:=if(Exists(RelevantOrbitProfiles(RejectWarning='Y')),false,true);

return TestProfile;

endmacro;