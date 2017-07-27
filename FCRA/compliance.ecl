// To keep fcra-relevant restrictions/permissions in one place
import ut,fcra;

export compliance := MODULE

  // defines how many corrections can exist for a given user (identified by SSN and DID)
  export unsigned4 MAX_OVERRIDE_LIMIT := 100;
  // blank flag file, to use as a default in functions' signatures
  export blank_flagfile := dataset([], fcra.Layout_override_flag);


  export watercrafts := module
    // state origin
    export set of string2 restricted_states := ['CA','FL','IN','KY','MD','MI','MO','MT','NE','NH','NJ','NM','OK','PA','UT','WA','WV'];
		export set of string2 restricted_sources := ['W1'];
  end;

  export proflicenses := module
    // this is temporarily, until legal can verify whether these can be used as well
    // (presence of these source constitutes the difference between V1 and V2)
    export set of string restricted_sources := ['AMDIR'];
  end;

  export ucc := module
    export boolean is_ok (string8 today, string8 filing_date) :=
      (filing_date != '') and (ut.DaysApart (today, filing_date) < ut.DaysInNYears (7));
  end;
END;
