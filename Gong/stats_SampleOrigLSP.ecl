layout_lsp := record
Gong.Layout_OrigSample_AmendedFields;
Gong.Layout_Master_origOnly_LSP;
end;

LSP := dataset('~thor_200::in::gong::master::orig::lsp',layout_lsp,thor);
dLSP := distribute(LSP,hash32(npa,telno));
sLSP := sort(dLSP,npa,telno,sequence_number,local);

layout_npaLookup := record
string3 npa;
string8 listingID;
end;

layout_npaLookup tnpa(SLSP input) := transform
self.npa := input.npa;
self.listingID := input.telno;
end;

pNPA := project(sLSP,tnpa(LEFT));

sNPA := sort(pNPA,npa);

dNPA := dedup(sNPA,npa);
addlrecs_needed := (100 - count(dNPA));

layout_lsp trecs(sLSP L,dNPA R) := transform
self := L;
end;

jLSP	:= join(sLSP,dNPA,
					left.npa = right.npa and
					left.telno = right.listingID, 
					trecs(left,right),
					lookup);
 

/* ******************************************************************************************* 
randomsample :=sample(sLSP,10000,1);
drandomsample := dedup(randomsample,npa+telno);
slim_sample := choosen(drandomsample,addlrecs_needed);

layout_lsp trecs2(sLSP L,slim_sample R) := transform
self := L;
end;

jrandomsample	:= join(sLSP,slim_sample,
					left.npa+left.telno = right.npa+right.telno, 
					trecs2(left,right),
					lookup);


fullsampleLSP := jLSP + jrandomsample;

output(choosen(fullsampleLSP,all)); 

*/

export stats_SampleOrigLSP := output(choosen(jLSP,100));
