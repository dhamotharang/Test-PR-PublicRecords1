layout_QST := record
Gong.Layout_OrigSample_AmendedFields;
Gong.Layout_Master_origOnly_QST;
end;

QST := dataset('~thor_200::in::gong::master::orig::qst',layout_QST,thor);
dQST := distribute(QST,hash32(atnNbr));
sQST := sort(dQST,atnNbr,local);

layout_npaLookup := record
string3 npa;
string8 listingID;
end;

layout_npaLookup tnpa(SQST input) := transform
self.npa := input.atnNbr[1..3];
self.listingID := input.atnNbr[4..10];
end;

pNPA := project(sQST,tnpa(LEFT));

sNPA := sort(pNPA,npa);

dNPA := dedup(sNPA,npa);
addlrecs_needed := (100 - count(dNPA));

layout_QST trecs(sQST L,dNPA R) := transform
self := L;
end;

jQST	:= join(sQST,dNPA,
					left.atnNbr[1..3] = right.npa and
					left.atnNbr[4..10] = right.listingID, 
					trecs(left,right),
					lookup);
 

/* ******************************************************************************************* */
randomsample :=sample(sQST,10000,1);
drandomsample := dedup(randomsample,atnNbr);
slim_sample := choosen(drandomsample,addlrecs_needed);

layout_QST trecs2(sQST L,slim_sample R) := transform
self := L;
end;

jrandomsample	:= join(sQST,slim_sample,
					left.atnNbr = right.atnNbr, 
					trecs2(left,right),
					lookup);


fullsampleQST := jQST + jrandomsample;

export stats_SampleOrigQST :=output(choosen(fullsampleQST,all)); 