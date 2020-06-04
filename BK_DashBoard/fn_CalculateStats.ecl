
import 		BankruptcyV3,header,overrides,personcontext,std,PromoteSupers;						
/*	All the items should be broken down by FCRA and non-FCRA
Overall figures
1.       Number of BK records
2.       Number of BK cases (unique TMSIDs)
3.       Number of BK case with at least one debtor with linking (lexid or business linking)  - number and % of the number of cases
4.       Number of debtors
o   Consumers – number and % of the debtor
  With lexid – number and % of the consumers
  Without lexid – number and % of the consumers
o   Businesses – number and % – number and % of the debtor
  With business linking – number and % of the businesses
  Without business linking – number and % of the businesses
5.       Number of unique Lexids */

export fn_CalculateStats(boolean isFCRA):= module 

bkSearchKey := pull(BankruptcyV3.key_bankruptcyv3_search_full_bip(isFCRA));

stats_rec := record
bkSearchKey;
string datatype;
string nametype;
string linkingtype;
string buildversion;
string processdate;

end;

shared bksearch := project(bkSearchKey,
transform(stats_rec, self.datatype := 
if(isFCRA = true, 'FCRA','nonFCRA'), 
self.nametype := map(left.name_type ='D' and left.cname = '' => 'Consumers',
left.name_type ='D' and left.cname != '' => 'Businesses',''),

self.linkingtype := map(self.nametype = 'Consumers' and (unsigned)left.did > 0 => 'WithDID',
self.nametype = 'Consumers' and (unsigned)left.did = 0 => 'WithOutDID',
self.nametype = 'Businesses' and (unsigned)left.bdid > 0 => 'WithBDID',
self.nametype = 'Businesses' and (unsigned)left.bdid = 0 => 'WithOutBDID', ''),
self.buildversion := BK_DashBoard.buildversion,
self.processdate := left.process_date,
self := left));

export linking_stats := table(bksearch(nametype <> ''), {datatype, nametype, linkingtype, buildversion, number := count(group)}, datatype, nametype, linkingtype,buildversion, few);
export linking_stats_in_days := table(bksearch(nametype <> ''), {datatype, nametype, linkingtype, processdate, number := count(group)}, datatype, nametype, linkingtype,processdate, few);

NumRecs := table(bksearch,{datatype, buildversion, number := count(group)}, datatype, buildversion, few);
UniqueCase           := table(dedup(sort(distribute(bksearch, hash(tmsid)), tmsid, local), tmsid, local), {datatype, buildversion, number := count(group)}, datatype, buildversion, few);
UniqueCaseWithLinking := table(dedup(sort(distribute(bksearch((unsigned)DID <> 0 or (unsigned)BDID <> 0), hash(tmsid)), tmsid, local), tmsid, local), {datatype, buildversion, number := count(group)}, datatype, buildversion, few);
UniqueDID            := table(dedup(sort(distribute(bksearch((unsigned)DID <> 0), hash(DID)), DID, local), DID, local), {datatype, buildversion, number := count(group)}, datatype, buildversion, few);

stats_rec := record

string datatype;
string statstype;
string buildversion;
integer number;

end;

export overall_stats :=  project(NumRecs, transform(stats_rec, self.statstype := 'NumRecs', self := left))
+ project(UniqueCase, transform(stats_rec, self.statstype := 'Uniquecase', self := left))
+ project(UniqueCaseWithLinking, transform(stats_rec, self.statstype := 'UniqueCaseWithLinking', self := left))
+ project(UniqueDID, transform(stats_rec, self.statstype := 'UniqueDID', self := left));

stats_rec:= record

string datatype;
string statstype;
string processdate;
integer number;

end;

NumRecs_in_days := table(bksearch,{datatype, processdate, number := count(group)}, datatype, processdate, few);
UniqueCase_in_days  := table(dedup(sort(distribute(bksearch, hash(tmsid)), tmsid, local), tmsid, local), {datatype, processdate, number := count(group)}, datatype, processdate, few);

export overall_stats_in_days :=  project(NumRecs_in_days, transform(stats_rec, self.statstype := 'NumRecs', self := left))
+ project(UniqueCase_in_days, transform(stats_rec, self.statstype := 'Uniquecase', self := left));

stats_rec := record
bksearch;
string DIDtype;
//string AlertsType;
string1 consumer_statement_flag;
string1 dispute_flag;
string1 security_freeze;
string1 security_alert;
string1 negative_alert;
string1 id_theft_flag;

end;

bksearch_proj := project(bksearch,transform(stats_rec, self := left, self := []));

shared UniqueDID     := dedup(sort(distribute(bksearch_proj((unsigned)DID <> 0), hash((unsigned)DID)), DID, local), DID, local);

hADL_ind      := Header.fn_ADLSegmentation(header.file_headers, isFCRA).core_check : persist('persist::adl_segmentation_' + if(isFCRA, 'fcra', 'nonfcra'));

UniqueDID tADL_ind(UniqueDID le, hADL_ind  ri):= transform 
self.DIDtype := ri.ind;
self := le;
end;

BkADL_ind := join(UniqueDID, //distribute(bksearch_proj((unsigned)DID <> 0), hash((unsigned)DID)), 
				     distribute(hADL_ind, hash(did)),
					   (unsigned)left.did = right.did,
					   tADL_ind(left, right),
					   left outer, local);

export segmentation_stats := table(BkADL_ind, {datatype, DIDtype, buildversion, number := count(group)}, datatype, DIDtype, buildversion, few);

//header_quick.key_fraud_flag_eq  
//personcontext.Keys.KEY_LexID
//fraud_recs := header_quick.key_fraud_flag_eq;
	
flag_key      := overrides.keys.flag.did;
pcr_key       := overrides.keys.pcr.did;
bk_override   := Overrides.Keys.bankrupt_search;
personcontext := personcontext.Keys.KEY_LexID;

UniqueDID tAlert_flag(UniqueDID le, pcr_key ri):= transform 
//self.AlertsType := if(le.s_did = (unsigned)ri.did, 'PCR', '');
self.consumer_statement_flag := ri.consumer_statement_flag;
self.dispute_flag := ri.dispute_flag;
self.security_freeze := ri.security_freeze;
self.security_alert := ri.security_alert;
self.negative_alert := ri.negative_alert;
self.id_theft_flag := ri.id_theft_flag; 
self := le;
end;

export Bk_alerts := join(UniqueDID, //distribute(bksearch_proj((unsigned)DID <> 0), hash((unsigned)DID)), 
				     distribute(pcr_key, hash(did)),
					  (unsigned)left.did = right.s_did,
					   tAlert_flag(left, right), local);
						 
end;


