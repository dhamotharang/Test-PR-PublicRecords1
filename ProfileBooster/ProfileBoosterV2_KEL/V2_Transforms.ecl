IMPORT ProfileBooster;
EXPORT V2_Transforms := MODULE

	EXPORT ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.PB11_Layout xfm_PB11_Final(ProfileBooster.Layouts.Layout_PB_In l, ProfileBooster.ProfileBoosterV2_KEL.ECL_Functions.Layouts.LayoutPersonPB11 r) := TRANSFORM
		SELF := l;
		SELF := r;
		SELF := [];
	END;	
  
END;