import Ingenix_Natlprof, address;

file_in := Ingenix_NatlProf.File_in_ProviderBirthDate;

reformatDate(STRING inDate) := FUNCTION
	string clean_inDate := if (StringLib.StringFind(inDate,'/',1)=0,
									trim(stringlib.stringfilterout(regexreplace('00:00:00.000', inDate, ''), '-'),left,right),
									inDate[7..10] + inDate[1..2] + indate[4..5]
								);
	return clean_inDate;	
END;

new_rec := record

Ingenix_Natlprof.Layout_in_ProviderBirthDate;
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    
end;

new_rec tcleaning(file_in L) := transform

self.birthdate     				:= reformatDate(L.birthdate);
self.dt_first_seen              := '';
self.dt_last_seen               := '';
self.dt_vendor_first_reported   := L.processdate;
self.dt_vendor_last_reported    := L.processdate;
self := L;

end;


export File_Clean_in_ProviderBirthDate := project(file_in, tcleaning(left));








