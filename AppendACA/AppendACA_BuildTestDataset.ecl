DataRec := RECORD
    STRING          predir;
    STRING          primRange;
    STRING          primName;
    STRING          secRange;
    STRING          postdir;
    STRING          addressSuffix;
    STRING          city;
    STRING          state;
    STRING          zip5;
END;

ds := DATASET
    (
        [
            {'N', '1009', '10TH', '', '', 'ST', 'LAKELAND', 'GA', '31635'}
        ],
        DataRec
    );

OUTPUT(ds,,'~qa::appendaca::appendaca::input',OVERWRITE, COMPRESSED);
