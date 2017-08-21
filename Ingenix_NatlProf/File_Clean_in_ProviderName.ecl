
import Ingenix_NatlProf,Address;

File_in := ingenix_Natlprof.File_in_ProviderName.Allsrc;

new_rec := record

Ingenix_Natlprof.Layout_in_Providername.raw_srctype;
string73 clean_name := '';
string8  dt_first_seen;
string8  dt_last_seen;
string8  dt_vendor_first_reported;
string8  dt_vendor_last_reported;    
end;

string name_filter1(string namefield) := if(StringLib.stringfind(namefield, '*', 1) <> 0,StringLib.stringfindreplace(namefield, '*',' '), regexreplace('M D LLC', namefield, '')); 
string name_filter2(string namefield) := StringLib.stringfilter(namefield, ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
string lSingleSpace(string pString1, string pString2, string pString3, string pstring4 = '')
 := trim(pString1) + ' '
  + if(trim(pString2) = '',
	   ' ',
	   trim(pString2) + ' '
	  )
  + if(trim(pString3) = '', ' ', trim(pstring3) + ' ') + trim(pstring4);

new_rec   tcleaning(ingenix_Natlprof.Layout_in_ProviderName.raw_srctype L) := Transform

self.firstname := L.firstname;
self.middlename := name_filter2(L.middlename);
self.lastname := L.lastname;
self.suffix := name_filter2(L.suffix);
string name_input := lsinglespace(name_filter1(L.firstname), name_filter1(name_filter2(L.middlename)), name_filter1(L.lastname), name_filter1(name_filter2(L.suffix)));
self.clean_name := if(trim(name_input,all)='','',Address.CleanPersonFML73(name_input));
self.dt_first_seen              := '';
self.dt_last_seen               := '';
self.dt_vendor_first_reported   := L.processdate;
self.dt_vendor_last_reported    := L.processdate;
self := L;

end;

export File_Clean_in_ProviderName := project(file_in, tcleaning(left));




