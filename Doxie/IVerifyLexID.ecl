// Defines an interface for the input criteria to use in LexID verification.
// Primary usage is to compare input against a header file (or alike), when specific verification rules are needed.

EXPORT IVerifyLexID := INTERFACE
  export unsigned6 did := 0;
  export string9 ssn := '';
  export string fname := '';
  export string lname := '';
end;
