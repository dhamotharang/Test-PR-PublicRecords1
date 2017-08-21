
import Ingenix_NatlProf;


file_in := dataset(Ingenix_NatlProf.File_In_Cluster + 'in::Ingenix_NatlProf_ProviderLicense', Ingenix_Natlprof.Layout_in_ProviderLicense.raw_srctype,CSV(quote(''),separator('|')));


reformatDate(STRING inDate) := FUNCTION
	string clean_inDate := if (StringLib.StringFind(inDate,'/',1)=0,
									trim(stringlib.stringfilterout(regexreplace('00:00:00.000', inDate, ''), '-'),left,right),
									inDate[7..10] + inDate[1..2] + indate[4..5]
								);
	return clean_inDate;	
END;
		
new_rec := record

Ingenix_Natlprof.Layout_in_ProviderLicense.raw_srctype;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
end;

new_rec  tcleaning(ingenix_Natlprof.Layout_in_ProviderLicense.raw_srctype L) := Transform

self.effective_Date                     := reformatDate(L.effective_date);
self.termination_date                   := reformatDate(L.termination_date);
self.dt_first_seen := '';
self.dt_last_seen := '';
self.dt_vendor_first_reported := L.processdate;
self.dt_vendor_last_reported := L.processdate;
self                                    := L;

end;


export File_Clean_in_ProviderLicense := project(file_in, tcleaning(left));;