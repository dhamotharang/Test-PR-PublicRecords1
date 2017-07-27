PATTERN Num3 := Text.Digit length(3);
PATTERN Num2 := Text.Digit length(2);
PATTERN Num4 := Text.Digit length(4);

PATTERN seperator := (Text.sws | '-')*;

export PATTERN ssn := Num3 seperator Num2 seperator Num4;