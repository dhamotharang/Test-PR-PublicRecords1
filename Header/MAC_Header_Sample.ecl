export MAC_Header_Sample(infile,outfile) := macro
  #uniquename(initials)
  %initials% := infile( lname='ASHER' and fname IN ['HANK','HENRY'] or
                      lname='SIMMONS' and fname = 'LISA' or
                      lname='WYMAN' and fname = 'MIKE' or
                      ssn IN ['047561169','47561169','158328695','311488606'
,'044540170','020325524','196037941'] );
  #uniquename(rdids)
  %rdids% := record
  %initials%.did;
  end;
  #uniquename(ta)
  %ta% := dedup(table(%initials%,%rdids%),did,all);

  #uniquename(cpy_l)
  typeof(infile) %cpy_l%(infile le) := transform
  self := le;
  end;

  outfile := join(infile,%ta%,left.did=right.did,%cpy_l%(left),lookup);

  endmacro;