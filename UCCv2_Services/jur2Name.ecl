IMPORT ut;

// Convert UCCv2 jurisdictions to their full names

EXPORT STRING jur2Name(STRING rawJur) := FUNCTION

  jur := TRIM(rawJur);

  jurName := MAP(
    jur = 'NYC' => 'NEW YORK CITY, NEW YORK',
    jur = 'TXD' => 'DALLAS COUNTY, TEXAS',
    jur = 'TXH' => 'HARRIS COUNTY, TEXAS',
    LENGTH(jur) = 2 => ut.St2Name(jur),
    ''
  );

  RETURN IF( jurName<>'', jurName, jur);

END;
