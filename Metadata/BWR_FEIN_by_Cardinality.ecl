//FEIN by Cardinality W20080507-142453
//Lists how many FEINs appear once, twice, etc.
//Sum all counts for total unique FEINs; take sum of (frequency times count) for total FEINs

d1:=distribute(table(Business_Header.File_Business_Header(fein>0),{fein,f2:=count(group)},fein),hash32(fein));
output(choosen(table(distributed(d1,hash32(fein)),{f2,count(group)},f2),all));