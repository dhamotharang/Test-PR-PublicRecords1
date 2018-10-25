DataRec := RECORD
    STRING      date1;
    STRING date2;
    STRING date3;
END;

ds := DATASET
    (
        [
            {'February 17, 1965','2/17/65','Feb. 17, 1965'}
        ],
        DataRec
    );

OUTPUT(ds,,'~qa::cleandate::cleandate::input',OVERWRITE);
