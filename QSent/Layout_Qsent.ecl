export Layout_Qsent := module

export common := record, maxlength(4096)
  string FILE;
	string RECID;
	string XCODE;
	string LSTTYP;
	string NPA;
	string TELNO;
	string LSTSTY;
	string INDENT;
	string SPLIT;
	string FSN;
	string FTD;
	string LSTNM;
	string LSTGN;
	string HSENO;
	string HSESX;
	string STRT;
	string LOCNM;
	string STATE;
	string DIRTX;
	string ZIP;
	string SPLTX;
	string NSTEL;
	string COUNTY;
	string DWELLING;
	string GEO_ACC;
	string GEO_LAT;
	string GEO_LONG;
	string MAILABLE;
	string ORIG_LOC;
	string ORIG_STATE;
  string ORIG_HSENO;
  string ORIG_HSESX;
	string ORIG_STRT;
	string ORIG_NPA;
	string ORIG_TELNO;
	string ORIG_ZIP;
	string POSTAL_TYPE;
	string PRIVACY;
	string VENDOR;
	string LAST_UDT_DATE;
	string VEN_REG;
	string SICCODE;
end;

export lsi := record, maxlength(4096)
 string field;
end;

export lsp := record, maxlength(4096)
 	string RECID;
	string XCODE;
	string LSTTYP;
	string NPA;
	string TELNO;
	string LSTSTY;
	string INDENT;
	string SPLIT;
	string FSN;
	string FTD;
	string LSTNM;
	string LSTGN;
	string HSENO;
	string HSESX;
	string STRT;
	string LOCNM;
	string STATE;
	string DIRTX;
	string ZIP;
	string SPLTX;
	string NSTEL;
	string VEN_REG;
end;

export lss_old := record, maxlength(4096)
	string RECID;
	string XCODE;
	string LSTTYP;
	string NPA;
	string TELNO;
	string LSTSTY;
	string INDENT;
	string SPLIT;
	string FSN;
	string FTD;
	string LSTNM;
	string LSTGN;
	string HSENO;
	string HSESX;
	string STRT;
	string LOCNM;
	string STATE;
	string DIRTX;
	string ZIP;
	string SPLTX;
	string NSTEL;
	string COUNTY;
	string DWELLING;
	string GEO_ACC;
	string GEO_LAT;
	string GEO_LONG;
	string MAILABLE;
	string ORIG_LOC;
	string ORIG_STATE;
	string ORIG_STRT;
	string ORIG_NPA;
	string ORIG_TELNO;
	string ORIG_ZIP;
	string POSTAL_TYPE;
	string PRIVACY;
	string VENDOR;
	string LAST_UDT_DATE;
	string VEN_REG;
end;

export lss_new := record, maxlength(4096)
	string RECID;
	string XCODE;
	string LSTTYP;
	string NPA;
	string TELNO;
	string LSTSTY;
	string INDENT;
	string SPLIT;
	string FSN;
	string FTD;
	string LSTNM;
	string LSTGN;
	string HSENO;
	string HSESX;
	string STRT;
	string LOCNM;
	string STATE;
	string DIRTX;
	string ZIP;
	string SPLTX;
	string NSTEL;
	string COUNTY;
	string DWELLING;
	string GEO_ACC;
	string GEO_LAT;
	string GEO_LONG;
	string MAILABLE;
	string ORIG_LOC;
	string ORIG_STATE;
	string ORIG_HSENO;
	string ORIG_HSESX;
	string ORIG_STRT;
	string ORIG_NPA;
	string ORIG_TELNO;
	string ORIG_ZIP;
	string POSTAL_TYPE;
	string PRIVACY;
	string VENDOR;
	string LAST_UDT_DATE;
	string VEN_REG;
end;

end;


















// record
 // string hash_key;
 // string listing_name;
 // string addr1;
 // string city;
 // string st;
 // string zip9;
 // string phone; //Might have 0000 for non-pubs
 // string listing_type; //RS (residence), BG (Business / Government), BR (Business / Residential) 
 // string listing_class; //NP (non-published), SL (Standard Listing), NL (Non-Listed) 
 // string action_code; // I (in), O (out), B (Baseline)
 // string action_date; 
 // string line_type; //LL (Land Line) 
 // string prev_hash_key; //MASTER ONLY
 // string prev_action_code; //MASTER ONLY
 // string prev_action_date; //MASTER ONLY
 // string match_code; //MASTER ONLY
// end;