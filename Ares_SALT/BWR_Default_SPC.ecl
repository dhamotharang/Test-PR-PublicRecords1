Import Ares, SALT311;

file_test := Ares.Files.ds_area;

SALT311.MAC_Default_SPC(file_test, example_spc);

output(example_spc);