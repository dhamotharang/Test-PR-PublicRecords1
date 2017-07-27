
import Ingenix_NatlProf;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderLicense;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

new_rec  tcleaning(ingenix_Natlprof.Layout_in_ProviderLicense L) := Transform

self.effective_Date                     := stringlib.stringfilterout(regexreplace('00:00:00.000', L.effective_date, ''), '-');
self.termination_date                   := stringlib.stringfilterout(regexreplace('00:00:00.000', L.termination_date, ''), '-');
self.dt_first_seen := '';
self.dt_last_seen := '';
self.dt_vendor_first_reported := L.processdate;
self.dt_vendor_last_reported := L.processdate;
self                                    := L;

end;


export File_Clean_in_ProviderLicense := project(ingenix_natlprof.File_ProviderLicense_Update, tcleaning(left));;