import civil_court, civ_court;

export fDoInputStats(DATASET(civil_court.Layout_In_Party) party,  DATASET(civil_court.Layout_In_Matter) matter) := function

//FIND DUPLICATES

dpsPtyCNE1 := table(distribute(party, hash(case_number)), {case_number, entity_1, counted := count(group)}, case_number, entity_1, local);
dpsPtyCKey := table(distribute(party, hash(case_key)), {case_key,counted := count(group)}, case_key, local);
dpsMat := table(distribute(matter, hash(case_key)), {case_key,counted := count(group)}, case_key, local);

civil_court.Layout_In_Party jpartydupes(civil_court.Layout_In_Party l) := transform
	self := l;
end;

partydupes := join(distribute(party, hash(case_key)), dpsPtyCKey(counted > 1), left.case_key = right.case_key, jpartydupes(left), local);
partydupes2 := join(distribute(party, hash(case_number)), dpsPtyCNE1(counted > 1), left.entity_1 = right.entity_1 and left.case_number = right.case_number, jpartydupes(left), local);

civil_court.Layout_In_Matter jmatterdupes(civil_court.Layout_In_Matter l) := transform
	self := l;
end;

matterdupes := join(distribute(matter, hash(case_key)), dpsMat(counted > 1), left.case_key = right.case_key, jmatterdupes(left), local);

//CREATE TABLES
tblNM := group(table(distribute(party, hash(entity_1)), {entity_1, entity_nm_format_1},entity_1, entity_nm_format_1, local), record, all);
tblTYPE := 	group(table(distribute(party, hash(entity_type_description_1_orig)), {entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master},entity_type_code_1_orig, entity_type_description_1_orig, entity_type_code_1_master, few, local), record, all);
tblADDR1 := group(table(distribute(party, hash(entity_1_address_1)), {entity_1_address_1},entity_1_address_1, local), record, all);
tblADDR2 := group(table(distribute(party, hash(entity_1_address_2)), {entity_1_address_2},entity_1_address_2, local), record, all);
tblADDR3 := group(table(distribute(party, hash(entity_1_address_3)), {entity_1_address_3},entity_1_address_3, local), record, all);
tblADDR4 := group(table(distribute(party, hash(entity_1_address_4)), {entity_1_address_4},entity_1_address_4, local), record, all);

tblCType := group(table(distribute(matter, hash(case_type)), {case_type, case_type_code},case_type, case_type_code, local), record, all);
tblDispDt := table(distribute(matter, hash(disposition_date)), {disposition_date, counted := count(group)},disposition_date, local);
tblDisp := group(table(distribute(matter, hash(disposition_description)), {disposition_code, disposition_description},disposition_code, disposition_description, local), record, all);
tblSuit := group(table(distribute(matter, hash(suit_amount)), {suit_amount},suit_amount, local), record, all);
tblFilDt := table(distribute(matter, hash(filing_date)), {filing_date, counted := count(group)},filing_date, local);

//OUTPUT

output(choosen(party, 10), named('Party_Top_10'));
output(count(party), named('Party_Total_Records'));
output(sum(dpsPtyCNE1(counted > 1), counted), named('Party_Duplicates_Case_Number_and_Name'));
output(sum(dpsPtyCKey(counted > 1), counted), named('Party_Duplicates_Case_key'));
output(partydupes, named('Party_Duplicate_Sample_Case_Key'));
output(choosen(tblNM, 5000), named('Names_and_Format'));
output(choosen(tblTYPE, 5000), named('Entity_TYpe'));
output(choosen(tblADDR1, 5000), named('Address1'));
output(choosen(tblADDR2, 5000), named('Address2'));
output(choosen(tblADDR3, 5000), named('Address3'));
output(choosen(tblADDR4, 5000), named('Address4'));
output(choosen(matter, 10), named('Matter_Top_10'));
output(count(matter), named('Matter_Total_Records'));
output(sum(dpsMat(counted > 1), counted), named('Matter_Duplicates_Case_key'));
output(matterdupes, named('Matter_Duplicate_Sample'));
output(choosen(tblCType, 5000), named('Case_Type'));
output(choosen(tblDispDt, 5000), named('Disposition_Date'));
output(choosen(tblDisp, 5000), named('Dispositions'));
output(choosen(tblSuit, 5000), named('Suit_Amounts'));
output(choosen(tblFilDt, 5000), named('Filing_Dates'));

completed := 'completed';

return completed;
end;