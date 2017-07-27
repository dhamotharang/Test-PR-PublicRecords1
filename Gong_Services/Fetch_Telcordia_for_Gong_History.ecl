// If we didn't find any records and we were given a 10 digit phone number,
// Tell the caller something about the phone number.

import Risk_Indicators,ut,doxie;
doxie.MAC_Header_Field_Declare();

TelcordiaRecs := if(phone_value[8..10] <> '',
  TOPN (CHOOSEN (Risk_Indicators.Key_Telcordia_tpm (
                   keyed(npa = phone_value[1..3]),
                   keyed(nxx = phone_value[4..6]), 
                   keyed(tb = phone_value[7] or tb = 'A')), ut.limits.TELCORDIA_MAX), 1, tb));

Layout_TelcordiaRec := RECORD
	string3 npa;
	string3 nxx;
	string1 tb;
	string50 city;
	string2 st;
	string30 ocn;
	string1 company_type;
	string2 nxx_type;
	string1 dial_ind;
END;
Layout_TelcordiaRec doTelcordiaProject(TelcordiaRecs l) := TRANSFORM
	SELF := l;
END;
export Fetch_Telcordia_for_Gong_History := PROJECT(TelcordiaRecs,doTelcordiaProject(LEFT));


