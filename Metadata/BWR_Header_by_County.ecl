//Header by County by John J. Bulten W20071217-170043

dDev := distribute(dataset('~thor_data400::base::header_prod',header.Layout_Header,flat),hash(st,county));

rDev := record
  dDev.st;
  dDev.county;
  nCount := count(group);
end;

tDev := table(dDev,rDev,st,county,all);

output(tDev,all);