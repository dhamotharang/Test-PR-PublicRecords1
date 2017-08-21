STRING14 AllSpaces := '               ';

STRING15 InsertDecimal(STRING14 Amount) := Amount[1..12]+'.'+Amount[13..14];

STRING14 RightJustify(STRING14 Source) := 
  AllSpaces[1..(14-LENGTH(TRIM(Source)))]+Source[1..LENGTH(TRIM(Source))];

EXPORT STRING15 FormatMoney(REAL Value) :=
  IF(Value <> 0, InsertDecimal(RightJustify((STRING14)((DECIMAL14_0)ROUND(VALUE*100)))),
                 AllSpaces[1..11] +'0.00');