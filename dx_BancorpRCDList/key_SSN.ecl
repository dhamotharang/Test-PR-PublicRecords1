IMPORT $;

keyed_fields := RECORD
  $.layouts.i_ssn.ssn;
END;

payload := RECORD
  $.layouts.i_ssn.ssn;
END;

EXPORT key_SSN() := INDEX({keyed_fields}, {payload}, $.names().i_ssn, OPT);