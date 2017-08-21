layout_amt := record
Gong.Layout_OrigSample_AmendedFields;
Gong.Layout_Master_origOnly_AMTorSPR;
end;

AMT := dataset('~thor_200::in::gong::master::orig::amt',layout_amt,thor);
fAMT := AMT(stringlib.stringfilterout(IRNPA,'019 ')<>'' and stringlib.stringfilterout(IRTELNO,'019 ')<>'');
dAMT := distribute(fAMT,hash32(IRNPA));
sAMT := sort(dAMT,IRNPA,IRTELNO,sequence_number,local);

layout_npaLookup := record
string3 npa;
string7 listingID;
end;

layout_npaLookup tnpa(sAMT input) := transform
self.npa := input.IRNPA;
self.listingID := input.IRTELNO;
end;

pNPA := project(sAMT,tnpa(LEFT));

sNPA := sort(pNPA,npa);

dNPA := dedup(sNPA,npa);
addlrecs_needed := (100 - count(dNPA));

layout_amt trecs(sAMT L,dNPA R) := transform
self := L;
end;

jAMT	:= join(sAMT,dNPA,
					left.IRNPA = right.npa and
					left.IRTELNO = right.listingID,
					trecs(left,right),
					lookup);


/* ******************************************************************************************* */
randomsample :=sample(sAMT,10000,1);
drandomsample := dedup(randomsample,IRNPA+IRTELNO);
slim_sample := choosen(drandomsample,addlrecs_needed);

layout_amt trecs2(sAMT L,slim_sample R) := transform
self := L;
end;

jrandomsample	:= join(sAMT,slim_sample,
					left.IRNPA + left.IRTELNO = right.IRNPA + right.IRTELNO,  
					trecs2(left,right),
					lookup);


fullsampleAMT := jAMT + jrandomsample;


export stats_SampleOrigAMT := output(choosen(fullsampleAMT,all)); 




