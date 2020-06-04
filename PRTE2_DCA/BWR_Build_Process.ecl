IMPORT PRTE, PRTE2_Common, ut, std, PRTE2_DCA;


string pVersion := (STRING8)Std.Date.Today()+''; 

PRTE2_DCA.proc_build_all(pVersion);
