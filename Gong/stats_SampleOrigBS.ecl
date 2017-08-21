layout_bs := record
Gong.Layout_OrigSample_AmendedFields;
Gong.Layout_Master_origOnly_BS;
end;

BS := dataset('~thor_200::in::gong::master::orig::bs',layout_bs,thor);
dBS := distribute(BS,hash32(listingID));
sBS := sort(dBS,listingID,sequence_number,local);

layout_npaLookup := record
string3 npa;
string13 listingID;
end;

layout_npaLookup tnpa(SBS input) := transform
self.npa := input.listingid[1..3];
self.listingID := input.listingID ;
end;

pNPA := project(sBS,tnpa(LEFT));

sNPA := sort(pNPA,npa);

dNPA := dedup(sNPA,npa);
addlrecs_needed := (100 - count(dNPA));

layout_bs trecs(sBS L,dNPA R) := transform
self := L;
end;

jBS	:= join(sBS,dNPA,
					left.listingID = right.listingID, 
					trecs(left,right),
					lookup);


/* ******************************************************************************************* */
randomsample :=sample(sBS,10000,1);
drandomsample := dedup(randomsample,listingID);
slim_sample := choosen(drandomsample,addlrecs_needed);

layout_bs trecs2(sBS L,slim_sample R) := transform
self := L;
end;

jrandomsample	:= join(sBS,slim_sample,
					left.listingID = right.listingID, 
					trecs2(left,right),
					lookup);


fullsampleBS := jBS + jrandomsample;

export stats_SampleOrigBS := output(choosen(fullsampleBS,all));




