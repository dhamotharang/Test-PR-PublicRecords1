EXPORT stripcompany(STRING in_company) :=
FUNCTION
  // IF YOU ADD A WORD ADD IT WITHOUT ANY SPACES OR LETTER S'S... SEE CLEANCOMPANY.
  STRING remtrm := regexreplace('INCORPORATED|' +
                                'CORPORATION|' +
                                'COMPANY|' +
                                'LLC|' +
                                'LP|' +
                                'LIMITED|' +
                                'THE|' +
                                'GROUP|' +
                                'AND|' +
                                'OF',in_company,'');
  RETURN TRIM(remtrm,LEFT,RIGHT);
END;
