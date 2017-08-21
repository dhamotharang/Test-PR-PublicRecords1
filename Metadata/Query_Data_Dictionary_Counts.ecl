/*
Count of business header base file(business_header.file_business_header)
Count of business contacts base file(business_header.file_business_contacts)
Business_Header.Query_Count_Unique_BDID
filter out zero bdid and dids from business_header.file_business_contacts.  Then unique on bdid and did, and count the result. 
filter out zero feins from business header file, unique on fein, count result
Business_Header.Query_Unique_bdids_with_sic_code
count of paw output file(business_header.file_employment_out)
filter out blank dids from business_header.file_business_contacts.  Then unique on did, and count the result. 
*/
import business_header ,paw,ut;  
bh := business_header.Files().base.Business_Headers.qa;
bc := business_header.Files().base.Business_Contacts.qa;
dsic_codes := business_header.persists().bhbdidsic;
dpaw := paw.Files().base.qa;

duniquebdids						:= table(bh, {bdid}, bdid);
duniquebdidsdids				:= table(bc(did != 0,bdid != 0), {bdid,did}, bdid,did);
duniquefeins						:= table(bh(fein != 0), {fein}, fein);
duniquebdidswithSicCode	:= table(dsic_codes, {bdid}, bdid);
duniquedids							:= table(bc(did != 0), {did}, did);

countBusinessHeaderBaseFile		:= count(bh);
countBusinessContactsBaseFile := count(bc);
countUniqueBdids							:= count(duniquebdids);
countUniqueBdidsDids					:= count(duniquebdidsdids);
countUniqueFeins							:= count(duniquefeins);
countduniquebdidswithSicCode	:= count(duniquebdidswithSicCode);
PercentageBdidsWithSicCodes		:= (real)countduniquebdidswithSicCode / (real)countUniqueBdids * 100;
countPawBaseFile 							:= count(dpaw);
countduniquedids							:= count(duniquedids);

//* **********************************		  
fn_AddStat(real8 value, string name) := 
FUNCTION
	return ut.fn_AddStatDS(dataset([{name, value}], ut.layout_stats_extend));
END;

bhdr_stats := parallel( 

fn_AddStat(countBusinessHeaderBaseFile,    '01) BH Total business records'),
fn_AddStat(countBusinessContactsBaseFile,  '02) BH Total contact records'),
fn_AddStat(countUniqueBdids,               '03) BH UniqueBusinessRecords'),
fn_AddStat(countUniqueBdidsDids,           '04) BH UniqueContactsRecords'),
fn_AddStat(countUniqueFeins,               '05) BH UniqueFeins'),
fn_AddStat(countduniquebdidswithSicCode,   '06) BH countduniquebdidswithSicCode'),
fn_AddStat(PercentageBdidsWithSicCodes,    '07) BH PercentageBdidsWithSicCodes'),
fn_AddStat(countPawBaseFile,               '08) BH TotalPawBaseFileRecords'),
fn_AddStat(countduniquedids,               '09) BH Unique_individuals_linked_to_businesses'));

//output(countBusinessHeaderBaseFile		,named('countBusinessHeaderBaseFile'	));
//output(countBusinessContactsBaseFile 	,named('countBusinessContactsBaseFile'));
//output(countUniqueBdids								,named('TotalUniqueBusinessRecords'							));
//output(countUniqueBdidsDids						,named('TotalUniqueContactsRecords'					));
//output(countUniqueFeins								,named('TotalUniqueFeins'							));
//output(countduniquebdidswithSicCode		,named('countduniquebdidswithSicCode'	));
//output(PercentageBdidsWithSicCodes		,named('PercentageBdidsWithSicCodes'	));
//output(countPawBaseFile 							,named('TotalPawBaseFileRecords' 						));
//output(countduniquedids								,named('Unique_individuals_linked_to_businesses'));

export Query_Data_Dictionary_Counts := bhdr_stats; 
