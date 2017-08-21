//****** Build a DID key for Doxie
a := output(DID_Gong,,'Base::gong_DID',overwrite);

fordox := dataset('Base::Gong_DID', watchdog.Layout_Gong_Doxie, flat);

didkeyrec := record
	fordox.did;
	fordox.__filepos;
end;

didkey := table(fordox, didkeyrec);
b := buildindex(didkey,,'key::gong.did', overwrite);

sequential(a,b);