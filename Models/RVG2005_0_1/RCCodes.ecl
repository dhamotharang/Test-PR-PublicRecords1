EXPORT RCCodes(STRING5 Code) := MODULE
EXPORT Dct := DICTIONARY([{'' => '', ''}
        ],{ STRING5 Code => STRING GroupType, STRING Description });
EXPORT GroupType := Dct[Code].GroupType;
EXPORT Description := Dct[Code].Description;
END;
