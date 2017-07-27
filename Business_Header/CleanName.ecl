EXPORT STRING142 CleanName(STRING fname, STRING mname, STRING lname, STRING suffix = '') :=
      Datalib.NameClean(TRIM(fname)+' '+TRIM(mname)+' '+TRIM(lname)+' '+suffix);