
import strata;

ds := Phonesplus_v2.File_Phonesplus_Base(current_rec);
Strata.mac_Pops		(ds, tStats);
strata.createXMLStats(tStats,'Phonesplus_v2','data',Phonesplus_v2.version,'',resultsOut);
export Strata_Phonesplus := resultsOut;