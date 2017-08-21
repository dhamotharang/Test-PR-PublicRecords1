import Gong_v2;
EXPORT Layout_gongMaster := record,maxlength(30000)
 Gong_v2.Layout_Raw_LSS;
 Layout_GongHistory;
 string2 pfrd_address_ind:='';
	unsigned8 rawAid := 0;
// ((( NEW FIELDS from LSSI
//  string1	dwelling;	// S=Single family, M=Multifamily
  string1	govlevel := '';	// L=Local, C=County/School, S=State, F=Federal
  string1	line_type := '';	// C=Compiled I=Web Submitted, O=Other
 						// T=Landline Telco, V=VoIP, W=Wireless
//  string	locnm;		// Locality name
  string	pr_urban_name := '';
  string8	sic1 := '';		// Business category 1
  string8	sic2 := '';
  string8	sic3 := '';
  string8	sic4 := '';
  string8	sic5 := '';
  string8	supplier_date := '';	// MMDDYYYY// ***
// )))
end;