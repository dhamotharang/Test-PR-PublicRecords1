rIn :=
  record
    unsigned8 did;
  end;
dIn :=
  dataset([
    {16947993}, {15707345913}, {1438850161}, {40168299198}, {193986795}, 
    {281846088}, {192543601212}, {192543671462}, {192543454676}, {12587552845}, {2230}],
    rIn);
	
OUTPUT(dIn,,'~qa::appendbankruptcyflag::appendbankruptcyflag::input',OVERWRITE);	
