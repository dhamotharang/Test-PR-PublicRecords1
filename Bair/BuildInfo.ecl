EXPORT BuildInfo := module

	EXPORT LastFull					:= dataset(bair.Superfile_List(false).BuiltVers, bair.layouts.rBuiltVers, flat, opt);
	EXPORT LastFullPkgLive  := Bair.IsPkgLiveOnRoxie(LastFull[1].ver);
	EXPORT DeltaToBeFlushed := if(not LastFull[1].deployed and LastFullPkgLive, true, false);
	
END;