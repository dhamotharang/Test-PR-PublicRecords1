Input_Record := RECORD
  UNSIGNED8 LNPID;
  STRING2 PROVIDER_STATE;
END;

ds := DATASET
    (
        [
            {910, 'GA'}, {2537364,'AL'}
        ],
        Input_Record
    );

OUTPUT(ds,,'~qa::appendproviderattributes::appendproviderattributes::input',OVERWRITE);