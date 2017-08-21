



string12 d1:='001531260479';
string12 d2:='000038024972';
output(hashmd5(d1,d2));


string10 px:='9372648224';
output(hashmd5(px[4..10],px[1..3]));


string12 bd1:='000038024972';
string2 st:='OH';
string5 zip:='45315';
string25 city:='CLAYTON';
string28 prim_name :='UNION';
string10 prim_range:='7189';
string2 predir:='';
string4 suffix:='RD';
string2 postdir:='';
string8 sec_range:='';
output(hashmd5(bd1,st,zip,city,prim_name,prim_range,predir,suffix,postdir,sec_range));
