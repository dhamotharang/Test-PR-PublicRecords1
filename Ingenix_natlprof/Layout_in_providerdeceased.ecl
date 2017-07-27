export Layout_in_providerdeceased:= Module

export raw := record,maxlength(8192)
	String 		ProviderID ;
	string		DeceasedIndicator ; 
	string		DeceasedDate ;
end;

export raw_srctype := 

{
string  FILETYP;
string	ProcessDate;
string	ProviderID;
string		DeceasedIndicator ; 
string		DeceasedDate ;

};
export raw_Allsrc := 

{
raw_srctype;
string8  dt_first_seen;
    string8  dt_last_seen;
    string8  dt_vendor_first_reported;
    string8  dt_vendor_last_reported;
};
end;