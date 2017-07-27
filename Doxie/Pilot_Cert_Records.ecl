import Doxie_Raw, fcra;

// this function does nothing other than call Doxie_Raw.Pilot_cert_raw , so I replaced this with Doxie_Raw.Pilot_cert_raw.

export Pilot_Cert_Records (dataset(doxie.layout_references) dids,
                           unsigned3 dateVal = 0,
                           boolean IsFCRA = false,
                           dataset (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile
) := function

	return Doxie_Raw.Pilot_cert_raw (dids, dateVal, IsFCRA, flagfile);
end;