has(string src, string str) := stringlib.stringfind(src,str,1) > 0;

export AMLTitleRank(string title) :=
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
	(has(title, 'GENERAL MANAGER') or has(title, 'GENERAL MGR') or has (title, 'GNRL MGR')) and
		~has(title, 'MANAGER FINANCE') and
		~has(title, 'MANAGER/SALES') => 1,
	has(title, 'CHAIRMAN') => 1,
	has(title, 'CHIEF') => 2,
	has(title, 'CFO') => 2,
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