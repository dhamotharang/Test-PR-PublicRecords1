IMPORT autokey;

EXPORT MFetch := MODULE(autokey.IFetch)
	export Fetch_Custom1(string t, boolean workHard, boolean noFail = true) := Fetch_LatLong(t, workHard, noFail);
END;