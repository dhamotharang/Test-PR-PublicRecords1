export UCC_stats(getretval) := macro
import uccv2,codes,ut,lib_fileservices,_Control;
myds := uccv2.File_UCC_Main_Base(filing_jurisdiction <> '');

Orbit_Report.Run_Stats('ucc',myds,filing_jurisdiction,filing_date,'emailme','st',getretval);

endmacro;
