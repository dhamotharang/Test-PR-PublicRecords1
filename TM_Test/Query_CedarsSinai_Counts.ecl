f := TM_Test.cedarssinai_out;

count(f);
count(f(Address_Block <> ''));
count(f(DOD_Year <> ''));
count(f(Phone <> ''));
output(f(Address_Block <> ''),all);
output(f(DOD_Year <> ''),all);



