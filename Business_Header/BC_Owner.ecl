// Select Business Owner, Key Officer Titles
boolean has(string src, string str) := stringlib.stringfind(src,str,1) > 0;

unsigned1 TitleRank(string title) :=
map((has(title, 'CEO') or has(title, 'OWNER')) AND 
		~has(title, 'WIFE') => 1,
	has(title, 'PRESIDENT') AND 
		~has(title, 'VICE') and
		~has(title, 'V PRES') and
		~has(title, 'V-PRES') and
		~has(title, 'WIFE') => 1,
	has(title, 'PRINCIPAL') => 1,
	has(title, 'PARTNER') and
		~has(title, 'LTD PARTNER') => 1,
	has(title, 'CHAIRMAN') => 1,
	has(title, 'CHIEF EXECUTIVE') => 1,
	has(title, 'CFO') => 1,
	(has(title, 'GENERAL MANAGER') or has(title, 'GENERAL MGR') or has (title, 'GNRL MGR')) and
		~has(title, 'MANAGER FINANCE') and
		~has(title, 'MANAGER/SALES') => 2,
	has(title, 'COO') => 2,
	has(title, 'CIO') => 2,
	has(title, 'CTO') => 2,
	has(title, 'CMO') => 2,
	has(title, 'CSO') => 2,
	has(title, 'EVP') => 3,
	has(title, 'SVP') => 3,
	(has(title, 'SENIOR') or has(title, 'EXECUTIVE')) and
	(has(title, 'VP') or has(title, 'PRESIDENT')) => 3,
	has(title, 'PRESIDENT') OR has(title, 'VP') => 4,
	has(title, 'DIR') => 5,
	has(title, 'MAN') or has(title,'MGR') => 6,
	title = '' => 30,
	31);

Layout_Business_Owner RankCompanyTitles(Layout_Business_Contact_Full L) := TRANSFORM
SELF.owner_flag := has(Stringlib.StringToUpperCase(L.company_title), 'OWNER') AND 
		~has(Stringlib.StringToUpperCase(L.company_title), 'WIFE');
SELF.company_title_rank := TitleRank(Stringlib.StringToUpperCase(L.company_title));
SELF.officer_flag := ~SELF.owner_flag AND SELF.company_title_rank = 1;
SELF := L;
END;

EXPORT BC_Owner := PROJECT(File_Business_Contacts(From_HDR = 'N', (NOT CheckUCC(source, company_name, fname, mname, lname, name_suffix))), RankCompanyTitles(LEFT));