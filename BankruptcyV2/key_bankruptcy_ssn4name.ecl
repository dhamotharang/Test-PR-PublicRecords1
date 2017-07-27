import doxie, autokey;

d := DATASET([], autokey.Layout_SSN_redacted);

export key_bankruptcy_ssn4name(STRING t) :=
					INDEX(d, {d}, TRIM(t) + doxie.Version_SuperKey + '::' + 'SSNLast4Name');