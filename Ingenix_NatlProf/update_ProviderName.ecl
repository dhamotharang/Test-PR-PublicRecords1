import Address,Ingenix_NatlProf,ut;  


Provider_Name 		:= 	distribute(File_in_ProviderName.Allsrc ,hash(FILETYP, ProviderID));
Provider_Gender		:=	distribute(File_in_ProviderGender.Allsrc ,hash(FILETYP, ProviderID));

// We are going to only take the latest gender info. for a given person and type.  The input from
// the vendor will, at times, have multiple genders listed for the same person... this will get
// rid of that confusion.
Provider_Gender_sort := SORT(Provider_Gender,
                             FILETYP, ProviderID, -ProcessDate, -GenderCompanyCount,
														 LOCAL);
Provider_Gender_dedup := DEDUP(Provider_Gender_sort, FILETYP, ProviderID, LOCAL);

string name_filter1(string namefield) := if(StringLib.stringfind(namefield, '*', 1) <> 0,StringLib.stringfindreplace(namefield, '*',' '), regexreplace('M D LLC', namefield, '')); 
string name_filter2(string namefield) := StringLib.stringfilter(namefield, ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-');

new_rec := record
	Ingenix_Natlprof.Layout_in_Providername.raw_srctype;
	string  clean_name	:= '';
	string8	dt_first_seen;
	string8	dt_last_seen;
	string8	dt_vendor_first_reported;
	string8	dt_vendor_last_reported;    
end;

new_rec Join_NameGender(Provider_Name l,Provider_Gender R) := Transform
	self.firstname 									:= L.firstname;
	self.middlename 								:= name_filter2(L.middlename);
	self.lastname 									:= L.lastname;	
	self.suffix 										:= name_filter2(L.suffix);
	self.dt_first_seen              := '';
	self.dt_last_seen               := '';
	self.dt_vendor_first_reported   := L.processdate;
	self.dt_vendor_last_reported    := L.processdate;
	self.gender											:= R.gender;
	self 														:= L;
end;

Joined_NameGender := 	join(	Provider_Name,
														Provider_Gender_dedup,
														left.FILETYP = right.FILETYP and 
														left.ProviderId = right.ProviderId,
														Join_NameGender(left,right), 
														left outer,
														local
													);	
									

file_dist := distribute(Joined_NameGender, hash(FILETYP, ProviderID));
file_sort := sort(file_dist,FILETYP, ProviderID, LastName, FirstName, MiddleName, Suffix, Gender,-ProcessDate, local);

string lSingleSpace(string pString1, string pString2, string pString3, string pstring4 = '')
 := trim(pString1) + ' '
  + if(trim(pString2) = '',
	   ' ',
	   trim(pString2) + ' '
	  )
  + if(trim(pString3) = '', ' ', trim(pstring3) + ' ') + trim(pstring4);
  
new_rec  rollupXform(new_rec l, new_rec r) := transform
        
self.Processdate    := if(l.Processdate > r.Processdate, l.Processdate, r.Processdate);
self.dt_First_Seen := if(l.dt_First_Seen > r.dt_First_Seen, r.dt_First_Seen, l.dt_First_Seen);
self.Dt_Last_Seen  := if(l.Dt_Last_Seen  < r.dt_Last_Seen,  r.dt_Last_Seen,  l.dt_Last_Seen);
self.dt_Vendor_First_Reported := if(l.dt_Vendor_First_Reported > r.dt_Vendor_First_Reported, r.dt_Vendor_First_Reported, l.dt_Vendor_First_Reported);
self.dt_Vendor_Last_Reported  := if(l.dt_Vendor_Last_Reported  < r.dt_Vendor_Last_Reported,  r.dt_Vendor_Last_Reported, l.dt_Vendor_Last_Reported);
self := l;
end;


rollup_ProviderName := rollup(file_sort,rollupXform(LEFT,RIGHT),FILETYP,ProviderID,LastName,FirstName,MiddleName,Suffix,Gender, local); 

//clean name 

new_rec tcleaning(new_rec L) := transform

string name_input := lsinglespace(name_filter1(L.firstname), name_filter1(name_filter2(L.middlename)), name_filter1(L.lastname), name_filter1(name_filter2(L.suffix)));
self.clean_name := if(l.clean_name <> '', l.clean_name, if(trim(name_input,left, right) <> '',Address.CleanPersonFML73(name_input), ''));
self := L;

end;

clean_providername := project(rollup_ProviderName, tcleaning(left));

export update_ProviderName := clean_providername;