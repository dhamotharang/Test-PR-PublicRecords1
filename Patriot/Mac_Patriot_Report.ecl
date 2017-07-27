export Mac_Patriot_Report(infile) := macro
  output(count(infile(known)),NAMED('Known'));
  output(count(infile(name_match,known)),NAMED('Known_Weak_Hit'));
  output(count(infile(name_match,known,number_with_same_name<100)),NAMED('Known_Strong_Hit'));
  output(count(infile(name_match,~known)),NAMED('Unknown_Weak_Hit'));
  output(count(infile(name_match,~known,number_with_same_name<100)),NAMED('Unknown_Strong_Hit'));
endmacro;