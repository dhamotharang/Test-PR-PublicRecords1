layout_cin := record
Gong.Layout_OrigSample_AmendedFields;
Gong.Layout_Master_origOnly_CIN;
end;

CIN := dataset('~thor_200::in::gong::master::orig::CIN',layout_cin,thor);
dCIN := distribute(CIN,hash32(areacd,cocd,linenbr));
sCIN := sort(dCIN,areacd,cocd,linenbr,sequence_number,local);

layout_npaLookup := record
string3 npa;
string10 listingID;
end;

layout_npaLookup tnpa(sCIN input) := transform
self.npa := input.areacd;
self.listingID := input.areacd + input.cocd + input.linenbr;
end;

pNPA := project(sCIN,tnpa(LEFT));

sNPA := sort(pNPA,npa);

dNPA := dedup(sNPA,npa);
addlrecs_needed := (100 - count(dNPA));

layout_cin trecs(sCIN L,dNPA R) := transform
self := L;
end;

jCIN	:= join(sCIN,dNPA,
					left.areacd = right.npa and
					left.cocd = right.listingID[4..6] and 
					left.linenbr = right.listingID[7..10],
					trecs(left,right),
					lookup);


/* ******************************************************************************************* */
randomsample :=sample(sCIN,10000,1);
drandomsample := dedup(randomsample,areacd + cocd + linenbr);
slim_sample := choosen(drandomsample,addlrecs_needed);

layout_cin trecs2(sCIN L,slim_sample R) := transform
self := L;
end;

jrandomsample	:= join(sCIN,slim_sample,
					left.areacd + left.cocd +left.linenbr = right.areacd + right.cocd +right.linenbr,  
					trecs2(left,right),
					lookup);


fullsampleCIN := jCIN + jrandomsample;

export stats_SampleOrigCIN := output(choosen(fullsampleCIN,all)); 



