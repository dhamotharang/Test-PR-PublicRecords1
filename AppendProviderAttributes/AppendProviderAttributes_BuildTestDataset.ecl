Input_Record := RECORD
  UNSIGNED8 LNPID;
END;

ds := DATASET
    (
        [
            {910}, {2537364}
        ],
        Input_Record
    );

OUTPUT(ds,,'~qa::appendproviderattributes::appendproviderattributes::input',OVERWRITE);