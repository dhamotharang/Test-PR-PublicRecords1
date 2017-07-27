dpaw := paw.files().base.built;
dtable1 := table(dpaw(bdid != 0,did != 0),{bdid,did},bdid,did,merge);
dtable2 := table(dtable1,{bdid,unsigned8 cnt := count(group)},bdid,merge);
/*
The Legacy Business Header (and downstream processes) has produced approximately XXX million BDIDs with:
1-10 LexIDs		XXM
11-50 LexIDs		XXM
>50 LexIDs		XXM
*/
total_bdids_with_lexids  := count(dtable2);
bdids_with1_10_lexids    := count(dtable2(cnt <= 10));
bdids_with11_50_lexids   := count(dtable2(cnt > 10,cnt <= 50));
bdids_withGT_50_lexids   := count(dtable2(cnt > 50));

output(total_bdids_with_lexids ,named('total_bdids_with_lexids'));
output(bdids_with1_10_lexids   ,named('bdids_with1_10_lexids'  ));
output(bdids_with11_50_lexids  ,named('bdids_with11_50_lexids' ));
output(bdids_withGT_50_lexids  ,named('bdids_withGT_50_lexids' ));

/*
3.	VERSION 1 OF AN ALGORITHM TO MEASURE DEGREE OF VANITY BETWEEN A LEXID AND BIP ENTITY.
The first version of this algorithm is complete, and pushed into production on  XX MM YYYY.   This algorithm delivers: 
XX M LexID â€“ ProxID 
XX M LexID -  POWID
XXM LexID â€“ SELEID
XXM LexID â€“ OrgID
XXM LexID - UltID
*/

ds_base := distribute(table(bipv2.CommonBase.ds_base(vanity_owner_did != 0),{vanity_owner_did,proxid, seleid, powid, orgid,ultid})) : independent;

output(count(table(ds_base, {vanity_owner_did, proxid},vanity_owner_did, proxid ,merge)) ,named('ProxidsWithVanityDid'));
output(count(table(ds_base, {vanity_owner_did, seleid},vanity_owner_did, seleid ,merge)) ,named('SeleidsWithVanityDid'));
output(count(table(ds_base, {vanity_owner_did, powid },vanity_owner_did, powid  ,merge)) ,named('PowidsWithVanityDid' ));
output(count(table(ds_base, {vanity_owner_did, orgid },vanity_owner_did, orgid  ,merge)) ,named('OrgidsWithVanityDid' ));
output(count(table(ds_base, {vanity_owner_did, ultid },vanity_owner_did, ultid  ,merge)) ,named('UltidsWithVanityDid' ));

///////////////////////////////
#workunit('name','BIPV2 2.2 IDENTIFYING BUSINESSES AT RESIDENTIAL ADDRESSES');
/*
BIP has delivered the following numbers/percentages of business entities at a residential address:
ProxID â€“ Active
ProxID â€“ Inactive
ProxID â€“ Defunct
Total:

POWID â€“ Active
POWID â€“ Inactive
POWID â€“ Defunct
Total:

SELEID â€“ Active
SELEID â€“ Inactive
SELEID â€“ Defunct
Total

OrgID â€“ Active
OrgID â€“ Inactive
OrgID â€“ Defunct
Total: 

UltID â€“ Active
UltID â€“ Inactive
UltID â€“ Defunct
*/

// output(bipv2.CommonBase.ds_base);

BIPV2_PostProcess.proc_segmentation(bipv2.keysuffix,bipv2.CommonBase.ds_base(address_type_derived = 'R'),pTurnOffStrata := true).output_segs_fixed_filtered;

//address_type_derived