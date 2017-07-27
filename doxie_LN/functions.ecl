// to keep utility functions for property processing (mainly, comp report)

export functions := MODULE

  // used for 'land_size' calculations;
  // input looks like "106.95 AC", "11880 SF" or "11880"
  export string GetSquareFootage (string acres, string feet) := function
		integer res := if ((integer) feet > 0,
                       (integer) feet,
                       round (43560 * (real) acres));
    return if (acres = '' and feet = '', '', (string) res);
    // can return "0" in case of invalid non-blank data in both 'feet' and 'acres'
  end;

END;