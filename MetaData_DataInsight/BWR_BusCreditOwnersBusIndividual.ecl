// Hello data questions!

// I have a lot of requests today. 

// Can you please tell me - In the SBFE dataset:
// 1.	How many Active SELEIDs have the Owner field(s) populated? 
      // a.	How many Active SELEIDs have the Owner field(s) populated with apparent humans?
      // i.	How many of those apparent humans are LexID’d?
      // b.	How many Active SELEIDs have the Owner field(s) populated with apparent non-humans?
      // i.	How many of those apparent non-humans are BIP ID’d? 
// 2.	How many Active SELEIDs have the Guarantor field(s) populated? 
      // a.	How many Active SELEIDs have the Guarantor field(s) populated with apparent humans?
      // i.	How many of those apparent humans are LexID’d?
      // b.	How many Active SELEIDs have the Guarantor field(s) populated with apparent non-humans?
// 3.	Same Qs above to INACTIVE and DEFUNCT SELEIDS. 
bh := bipv2.CommonBase.ds_base;
bh_active := bh(seleid_status_private = '');
bh_active_d := dedup(sort(distribute(bh_active,hash(seleid)),seleid,local),seleid,local);
bh_inactive := bh(seleid_status_private = 'I');
bh_inactive_d := dedup(sort(distribute(bh_inactive,hash(seleid)),seleid,local),seleid,local);
bh_defunct := bh(seleid_status_private = 'D');
bh_defunct_d := dedup(sort(distribute(bh_defunct,hash(seleid)),seleid,local),seleid,local);

bc_owner := business_credit.Key_BusinessOwnerInformation().key;
output(count(bc_owner),named('allBusOwner'));
output(count(bc_owner(seleid <> 0)),named('BusOwnerWithSeleid'));
output(table(bc_owner,{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('BusOwnerGuarantorInd'));
output(table(bc_owner(seleid <> 0),{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('BusOwnerGuarantorIndWithSeleid'));
bc_owner_d := dedup(sort(distribute(bc_owner(seleid <> 0),hash(seleid)),seleid,local),seleid,local);
output(count(bc_owner_d),named('UniqueBusOwnerSeleid'));

In_owner := business_credit.Key_IndividualOwnerInformation();
output(count(In_Owner),named('allIndvidualOwner'));
output(count(In_Owner(did <> 0)),named('IndvidualOwnerWithDid'));
output(count(In_Owner(seleid <> 0)),named('IndvidualOwnerWithSeleid'));
output(table(In_Owner,{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('IndividualOwnerGuarantorInd'));
output(table(In_Owner(seleid <> 0),{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('IndividualOwnerGuarantorIndWithSeleid'));
output(table(In_Owner(did <> 0),{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('IndividualOwnerGuarantorIndWithDID'));
In_owner_d := dedup(sort(distribute(In_owner(seleid <> 0),hash(seleid)),seleid,local),seleid,local);
output(count(in_owner_d),named('UniqueIndividualOwnerSeleid'));
In_owner_dd := dedup(sort(distribute(In_owner(did <> 0),hash(did)),did,local),did,local);
output(count(in_owner_d),named('UniqueIndividualOwnerDID'));
/////////////////////////////////////////////////////////////////////
BusOwner_active := join(bh_active_d,bc_owner_d,
                  left.seleid = right.seleid);
output(count(BusOwner_active),named('ActiveBusOwner'));
output(table(BusOwner_active,{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('ActiveBusOwnerGuarantorInd'));									

BusOwner_inactive := join(bh_inactive_d,bc_owner_d,
                  left.seleid = right.seleid);
output(count(BusOwner_inactive),named('inactiveBusOwner'));
output(table(BusOwner_inactive,{guarantor_owner_indicator,cnt:=count(group)},guarantor_Owner_indicator,few),all,named('inactiveBusOwnerGuarantorInd'));									

BusOwner_defunct := join(bh_defunct_d,bc_owner_d,
                  left.seleid = right.seleid);
output(count(BusOwner_defunct),named('defunctBusOwner'));
output(table(BusOwner_defunct,{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('defunctBusOwnerGuarantorInd'));									
/////////////////////////////////////////////////////////////

IndividualOwner_active := join(bh_active_d,in_owner_d,
                  left.seleid = right.seleid);
output(count(IndividualOwner_active),named('ActiveIndvOwner'));
output(count(individualOwner_active(did <> 0)),named('ActiveIndvOwnerDID'));
output(table(IndividualOwner_active,{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('ActiveIndvOwnerGuarantorInd'));									

IndividualOwner_inactive := join(bh_inactive_d,in_owner_d,
                  left.seleid = right.seleid);
output(count(IndividualOwner_inactive),named('inactiveIndvOwner'));
output(count(individualOwner_inactive(did <> 0)),named('InActiveIndvOwnerDID'));
output(table(IndividualOwner_inactive,{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('inactiveIndvOwnerGuarantorInd'));									

IndividualOwner_defunct := join(bh_defunct_d,in_owner_d,
                  left.seleid = right.seleid);
output(count(IndividualOwner_defunct),named('defunctIndvOwner'));
output(count(individualOwner_defunct(did <> 0)),named('DefunctIndvOwnerDID'));
output(table(IndividualOwner_defunct,{guarantor_owner_indicator,cnt:=count(group)},guarantor_owner_indicator,few),all,named('defunctIndvOwnerGuarantorInd'));