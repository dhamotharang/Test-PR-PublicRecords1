import Business_Credit, ut;


ReportLayout := RECORD
string30 Topic;
unsigned total;
end;
	
	ReportForm := RECORD
	STRING12	timestamp;
	STRING		process_date;
	STRING2		record_type;
	UNSIGNED6 UltID;
	UNSIGNED6 OrgID;
	UNSIGNED6 SeleID;
	UNSIGNED6 ProxID;
	UNSIGNED6 PowID;
	UNSIGNED 	AccountTypeReported;
	STRING30	Sbfe_Contributor_Number;
	STRING50	Contract_Account_Number;
	UNSIGNED	Guarantor_Owner_Indicator;
	STRING250	Clean_Business_Name;
	STRING5		Clean_title;
	STRING20	Clean_fname;
	STRING20	Clean_mname;
	STRING20	Clean_lname;
	STRING5		Clean_suffix;
	STRING9		Federal_TaxId_SSN;
	STRING10	Phone_Number;
	string10	prim_range;
	string2		predir;
	string28	prim_name;
	string4		addr_suffix;
	string2		postdir;
	string10	unit_desig;
	string8		sec_range;
	END;
	
EXPORT StatsReport(string8 startdate = '19000101', string8 enddate = ut.GetDate, string name = '') := function

LoadFile := Business_Credit.files().linkids;


ProjectedFile:=Project(LoadFile(active),
TRANSFORM(ReportForm,
self.AccountTypeReported				:=	(unsigned)left.Account_Type_Reported;
self.Guarantor_Owner_Indicator	:=	(unsigned)left.Guarantor_Owner_Indicator;
self := left;)):PERSIST(Business_Credit.PersistNames.fnStatsReport);

BigFile:=ProjectedFile(stringlib.StringFilter(process_date,'0123456789') >= startdate and stringlib.StringFilter(process_date,'0123456789') <= enddate);

UltIDRecs					:=	dedup(sort(distribute(BigFile(UltID>0), hash(UltID)),UltID,local),UltID,local);
OrgIDRecs					:=	dedup(sort(distribute(BigFile(OrgID>0), hash(OrgID)),OrgID,local),OrgID,local);
SeleIDRecs				:=	dedup(sort(distribute(BigFile(SeleID>0), hash(SeleID)),SeleID,local),SeleID,local);
PowIDRecs					:=	dedup(sort(distribute(BigFile(PowID>0), hash(PowID)),PowID,local),PowID,local);
ProxIDSort				:=	SORT(DISTRIBUTE(BigFile(ProxID>0), HASH(ProxID)),ProxID,LOCAL);
ProxIDRecs				:=	dedup(ProxIDSort,ProxID,local);
ProxID_TL_Recs		:=	dedup(ProxIDSort(accounttypereported = 1),ProxID,local);
ProxID_LiC_Recs		:=	dedup(ProxIDSort(accounttypereported = 2),ProxID,local);
ProxID_CC_Recs		:=	dedup(ProxIDSort(accounttypereported = 3),ProxID,local);
ProxID_BL_Recs		:=	dedup(ProxIDSort(accounttypereported = 4),ProxID,local);
ProxID_LeC_Recs		:=	dedup(ProxIDSort(accounttypereported = 5),ProxID,local);
ProxID_OCL_Recs		:=	dedup(ProxIDSort(accounttypereported = 6),ProxID,local);
ProxID_Other_Recs	:=	dedup(ProxIDSort(accounttypereported = 99),ProxID,local);
FirstDedup				:=	DEDUP(SORT(DISTRIBUTE(BigFile,
												HASH(	sbfe_contributor_number,contract_account_number)),
															sbfe_contributor_number,contract_account_number,LOCAL),
															sbfe_contributor_number,contract_account_number,LOCAL);
MemberIDRecs2			:=	dedup(sort(distribute(FirstDedup, hash(Sbfe_Contributor_Number)),Sbfe_Contributor_Number,local),Sbfe_Contributor_Number,local);
// MemberIDRecs2			:=	dedup(sort(distribute(BigFile, hash(sbfe_contributor_num)),sbfe_contributor_num,local),sbfe_contributor_num,local);
GuarantorRecs1		:=	count(dedup(sort(distribute(BigFile(record_type = Constants().BS AND Guarantor_Owner_Indicator IN [ 2, 3] AND clean_business_name<>''), hash(clean_business_name)),clean_business_name,local),clean_business_name,local));
GuarantorRecs2		:=	count(dedup(sort(distribute(BigFile(record_type = Constants().IS AND Guarantor_Owner_Indicator IN [ 2, 3] AND clean_fname<>'' AND clean_lname<>''), hash(clean_title, clean_fname, clean_mname, clean_lname, clean_suffix)),clean_title, clean_fname, clean_mname, clean_lname, clean_suffix,local),clean_title, clean_fname, clean_mname, clean_lname, clean_suffix,local));
GuarantorRecsAll	:=	GuarantorRecs1+GuarantorRecs2;
PhoneRecs					:=	dedup(sort(distribute(BigFile(Phone_Number <> ''), hash(Phone_Number)),Phone_Number,local),Phone_Number,local);
CompanyNameRecs		:=	dedup(sort(distribute(BigFile(clean_business_name <> ''), hash(clean_business_name)),clean_business_name,local),clean_business_name,local);
TINRecs						:=	dedup(sort(distribute(BigFile(federal_taxid_ssn <> ''), hash(federal_taxid_ssn)),federal_taxid_ssn,local),federal_taxid_ssn,local);
AddressRecs				:=	dedup(sort(distribute(BigFile(prim_range<>'' OR predir<>'' OR prim_name<>'' OR addr_suffix<>'' OR postdir<>'' OR unit_desig<>'' OR sec_range<>''), hash(prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range)),prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range,local),prim_range, predir, prim_name, addr_suffix, postdir, unit_desig, sec_range,local);

Calculations := Dataset([
{'Total Records',count(BigFile)},{'UltID',count(UltIDRecs)},{'OrgID',count(OrgIDRecs)},{'SeleID',count(SeleIDRecs)},{'ProxID',count(ProxIDRecs)},
{'PowID',count(PowIDRecs)},{'ProxID-Term Loan',count(ProxID_TL_Recs)},{'ProxID-Line of Credit',count(ProxID_LiC_Recs)},{'ProxID-Comercial Card',count(ProxID_CC_Recs)},
{'ProxID-Business Lease',count(ProxID_BL_Recs)},{'ProxID-Letter of Credit',count(ProxID_LeC_Recs)},{'ProxID-Open Ended Credit Line',count(ProxID_OCL_Recs)},{'ProxID-Other',count(ProxID_Other_Recs)},
{'Number of member IDs',count(MemberIDRecs2)},{'Number of Guarantors',GuarantorRecsAll},{'Number of Phone #',count(PhoneRecs)},{'Number of Company Names',count(CompanyNameRecs)},
{'Number of TINs',count(TINRecs)},{'Number of Addresses',count(AddressRecs)}], 
ReportLayout);

IDTableLayout := RECORD
Calculations.Topic;
Calculations.total;
end;

ListTableLayout := RECORD
MemberIDRecs2.sbfe_contributor_number;
end;

MyFile := '~thor_data400::out::sbfe::report::'+workunit;

INCountTable := TABLE(Calculations, IDTableLayout);
INListTable  := TABLE(MemberIDRecs2, ListTableLayout);

CountTable :=	Output(INCountTable, named('ID_Stats'+name));
ListTable  :=	Output(INListTable,named('MemberIDs'+name),ALL);


return sequential(CountTable,ListTable);
end;