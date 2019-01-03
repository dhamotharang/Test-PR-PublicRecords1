
import strata;

export Strata_Phonesplus (string pversion):= function
ds := Phonesplus_v2.File_Phonesplus_Base(current_rec);
Strata.mac_Pops		(ds, tStats);
strata.createXMLStats(tStats,'Phonesplus_v2','data',pversion,'',resultsOut);

return resultsOut;
end;