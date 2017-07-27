
d := DATASET([], CanadianPhones.layouts.address);

export key_autokey_address := INDEX(d, {d}, CanadianPhones.Constants.FILE_NAME_MASK_QA+'address');
