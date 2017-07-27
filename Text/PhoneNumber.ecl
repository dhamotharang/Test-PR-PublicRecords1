pattern numbers := pattern('[0-9]')+;

pattern wss :=ws*;

pattern sepchar := pattern('[-./ ]');

pattern seperator := wss sepchar wss;

// Area Code
pattern OpenParen := ['[','(','{','<'];
pattern CloseParen := ['[',')','}','>'];
pattern FrontDigit := ['1', '0'] OPT(Seperator);
pattern areacode := OPT(FrontDigit) OPT(OpenParen) numbers length(3) OPT(CloseParen);

// Last Seven digits
pattern exchange := numbers length(3);
pattern lastfour := numbers length(4);
pattern seven := exchange OPT(seperator) lastfour;

export PATTERN PhoneNumber := OPT(areacode) OPT(Seperator) seven;