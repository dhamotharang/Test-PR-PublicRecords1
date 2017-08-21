enb_companies := enb.files().base.companies.qa;
enb_contacts	:= enb.files().base.contacts.qa;

enb_unique_bdids	:= table(enb_companies(bdid != 0), {bdid	}, bdid	);
enb_unique_dids		:= table(enb_contacts	, {did	}, did	);

abius_companies := InfoUSA.File_ABIUS_Company_Base;

output(count(abius_companies), named('AbiusCount')); 
output(count(abius_companies(bdid != 0)), named('AbiusBdids'));
output(count(dedup(abius_companies(bdid != 0), bdid, all)), named('AbiusUniqueBdids'));

//get counts of populated sic codes(all zeros is not populated)
siccode1 := enb_companies((unsigned6)rawfields.sic_code_1 != 0);
siccode2 := enb_companies((unsigned6)rawfields.sic_code_2 != 0);
siccode3 := enb_companies((unsigned6)rawfields.sic_code_3 != 0);
siccode4 := enb_companies((unsigned6)rawfields.sic_code_4 != 0);

output(count(siccode1), named('siccode1Count')); 
output(count(siccode2), named('siccode2Count')); 
output(count(siccode3), named('siccode3Count')); 
output(count(siccode4), named('siccode4Count')); 

//do a right only join to abius records in bh file on bdid
//and right only join to abius records in paw file on did and bdid
//get the records that don't match

paw_file := business_header.File_Employment_Out(source = 'IA');
bh_file := business_header.File_Business_Header(source = 'IA');

//this will get me the enb bdids that don't match ia bdids
enb_bdids_not_in_infousa := join(
															 distribute(bh_file									, bdid)
															,distribute(enb_companies(bdid != 0), bdid)
															,left.bdid = right.bdid
															,transform(recordof(enb_companies), self := right)
															,local
															,right only
															);

enb_bdids_not_in_infousa_unique := dedup(enb_bdids_not_in_infousa, bdid, all);

//output(count(enb_bdids_not_in_infousa_unique), named('enb_bdids_not_in_infousa_unique'));

ia_only_bdids := Business_Header.QueryGetSourceOnlyBdids('IA');

output(count(ia_only_bdids), named('ia_only_unique_bdids'));

enb_bdids_in_infousa := join(
															 distribute(ia_only_bdids			, bdid)
															,distribute(enb_unique_bdids	, bdid)
															,left.bdid = right.bdid
															,transform(recordof(enb_unique_bdids), self := right)
															,local
															);
output(count(enb_bdids_in_infousa), named('enb_bdids_in_infousa'));
