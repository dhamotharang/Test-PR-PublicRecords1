IMPORT iesp;

EXPORT SearchParams := INTERFACE
  EXPORT iesp.share.t_NameAndCompany nameQueryInputs;
  EXPORT iesp.share.t_Address addrQueryInputs;
  EXPORT STRING10 phoneQueryInput;
END;
