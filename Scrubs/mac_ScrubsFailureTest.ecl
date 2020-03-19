import scrubs,STD;

export mac_ScrubsFailureTest(RelevantProfileNames,pversion):=functionmacro 

ScrubsOld:=dataset('~thor_data400::scrubs::orbitreports::fullFile',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsNew:=dataset('~thor_data400::scrubs::orbitreports',Scrubs.Layouts.OrbitLogLayout,thor);
ScrubsFiles:=ScrubsOld+ScrubsNew;

lowercaselist:=STD.STR.ToLowerCase(RelevantProfileNames);

addSingleQuotes:='\''+STD.STR.FindReplace(lowercaselist,',','\',\'')+'\'';

RelevantOrbitProfiles:=ScrubsFiles(version=pVersion and STD.Str.ToLowerCase(ProfileName)in[#EXPAND(addSingleQuotes)]);

MessageStringRec:=RECORD
    Scrubs.Layouts.OrbitLogLayout;
    String MessageString:='';
END;

PrepDataForMessage:=project(RelevantOrbitProfiles,transform(MessageStringRec,self:=left;));

MessageStringRec tGenerateMessage(MessageStringRec L, MessageStringRec R):=TRANSFORM
    Self.MessageString:=if(L.MessageString='',
    L.ProfileName+'\t'+L.ruledesc+'\t'+L.Rulecnt+'\t'+L.rulepcnt+'\n'+R.ProfileName+'\t'+R.ruledesc+'\t'+R.Rulecnt+'\t'+R.rulepcnt,
    L.MessageString+'\n'+R.ProfileName+'\t'+R.ruledesc+'\t'+R.Rulecnt+'\t'+R.rulepcnt);
END;

TestProfile:=if(Exists(RelevantOrbitProfiles(RejectWarning='Y')),false,true);

BodyMessage:=if(Exists(RelevantOrbitProfiles(RejectWarning='Y')),
)

return TestProfile;

endmacro;