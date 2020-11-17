//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
IMPORT  ORBIT3,STD;
EXPORT GetProfileDS (dataset(Orbit3.Layouts.RequestGetProfileLayout)  pProfiles) := function

    tokenval              := Orbit3.GetToken() :Independent;

    ProfileStat           := orbit3.GetProfileV2(tokenval,pProfiles);

   Orbit3.Layouts.Layout_Profile_Status reformatresult(RECORDOF(ProfileStat) L) := TRANSFORM
    self.ProfileName      := L.Result.name;
    self.ProfileStatus    := L.Result.StatStatus;
    self.ProfileVersion   := L.Result.StatVersion;
    self := [];
    END;

    DSresult_out := PROJECT(ProfileStat,reformatresult(LEFT));

    RETURN WHEN(DSresult_out,STD.System.Debug.Sleep(30000));

END;