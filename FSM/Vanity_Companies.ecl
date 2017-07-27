ac := annotatedcompanies;

al := length(trim(ac._type));

vi := ac(al <=6,length(trim(stringlib.stringfilterout(_type,'CcWw')))>0);

a1f := ac._type[1] IN ['F','f','N'];
a3l := ac._type[3] IN ['l','L','N'];

had_end(unsigned1 base) := ( al = base or al = base+1 and ac._type[base+1] IN ['S','E'] or al = base+2 and ac._type[base+1] = 'S' and ac._type[base+2] = 'E' );

c0 := a1f and ac._type[2] IN [ 'I','f','F' ] and a3l and had_end(3);
c1 := a1f and ac._type[2] IN [ 'L','l' ] and had_end(2);
c2 := ac._type[1]='I' and ac._type[2] IN ['F','f'] and ac._type[3] IN ['l','L'] and had_end(3);
c3 := ac._type[1]='I' and ac._type[2] = 'I' and ac._type[3] IN ['l','L'] and had_end(3);
c4 := a1f and ac._type[2] = 'i' and ac._type[3] IN ['F','f'] and ac._type[4] IN ['l','L'] and had_end(4);

export Vanity_Companies := vi(c0 or c1 or c2 or c3 or c4);

