import doxie;

d := DATASET([], CanadianPhones.layouts.zip);

export key_autokey_zip := INDEX (d, {d}, CanadianPhones.Constants.FILE_NAME_MASK_QA+'zip');
