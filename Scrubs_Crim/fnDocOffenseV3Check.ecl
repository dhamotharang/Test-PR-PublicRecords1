

import scrubs;
EXPORT fnDocOffenseV3Check (string off_lev, string vendor) := function

// return if(vendor in [],1,Scrubs.fn_valid_codesv3(trim(off_lev,left,right),trim(vendor,left,right),'ARR_OFF_LEV','COURT_OFFENSES'));
return Scrubs.fn_valid_codesv3(trim(off_lev,left,right),trim(vendor,left,right),'OFF_LEV','DOC_OFFENSE');
end;