import gong;
EXPORT Layout_history := record
	gong.layout_bscurrent_raw;
	unsigned6 did;
	unsigned6 hhid;
	unsigned6	bdid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string1 current_record_flag;  
	string8 deletion_date;
	unsigned2 disc_cnt6 := 0;
	unsigned2 disc_cnt12 := 0;
	unsigned2 disc_cnt18 := 0;
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
// *** New fields
  string80 preppedname := '';
  string1	nametype := '';
  unsigned8 nid := 0;
  unsigned2 name_ind := 0;
  unsigned6 bid := 0;
	end;