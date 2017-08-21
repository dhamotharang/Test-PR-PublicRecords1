layout_LSS := record
Gong.Layout_OrigSample_AmendedFields;
Gong.Layout_Master_origOnly_LSS;
end;

LSS := dataset('~thor_200::in::gong::master::orig::LSS',layout_LSS,thor);
dLSS := distribute(LSS,hash32(npa,telno));
sLSS := sort(dLSS,npa,telno,sequence_number,local);

layout_npaLookup := record
string3 npa;
string8 listingID;
end;

layout_npaLookup tnpa(SLSS input) := transform
self.npa := input.npa;
self.listingID := input.telno;
end;

pNPA := project(sLSS,tnpa(LEFT));

sNPA := sort(pNPA,npa);

dNPA := dedup(sNPA,npa);
addlrecs_needed := (100 - count(dNPA));

layout_LSS trecs(sLSS L,dNPA R) := transform
self := L;
end;

jLSS	:= join(sLSS,dNPA,
					left.npa = right.npa and
					left.telno = right.listingID, 
					trecs(left,right),
					lookup);
 

/* ******************************************************************************************* 
randomsample :=sample(sLSS,10000,1);
drandomsample := dedup(randomsample,npa+telno);
slim_sample := choosen(drandomsample,addlrecs_needed);

layout_LSS trecs2(sLSS L,slim_sample R) := transform
self := L;
end;

jrandomsample	:= join(sLSS,slim_sample,
					left.npa+left.telno = right.npa+right.telno, 
					trecs2(left,right),
					lookup);


fullsampleLSS := jLSS + jrandomsample;

output(choosen(fullsampleLSS,all)); 

*/

export stats_SampleOrigLSS := output(choosen(jLSS,100));
