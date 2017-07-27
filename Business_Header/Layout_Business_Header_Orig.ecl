// Business Header File Internal Layout
export Layout_Business_Header_Orig :=
record
  unsigned6		rcid											:= 0		;
  unsigned6		bdid											:= 0		; // Seisint Business Identifier
  string2  		source														; // Source file type
  qstring34		source_group							:= ''		; // Source group identifier for merging of records only within source and group
  string3  		pflag 										:= ''		; // Internal processing flags
  unsigned6		group1_id									:= 0		; // Group identifier (temporary) for matching groups of records pre-linked
  qstring34 	vendor_id									:= ''		; // Vendor key
  unsigned4 	dt_first_seen											; // Date record first seen at Seisint
  unsigned4 	dt_last_seen											; // Date record last (most recently seen) at Seisint
  unsigned4 	dt_vendor_first_reported					;
  unsigned4 	dt_vendor_last_reported						;
  qstring120 	company_name											;
  qstring10 	prim_range												;
  string2   	predir														;
  qstring28 	prim_name													;
  qstring4  	addr_suffix												;
  string2   	postdir														;
  qstring5  	unit_desig												;
  qstring8  	sec_range													;
  qstring25 	city															;
  string2   	state															;
  unsigned3 	zip																;
  unsigned2 	zip4															;
  string3   	county														;
  string4   	msa																;
  qstring10 	geo_lat														;
  qstring11 	geo_long													;
  unsigned6 	phone															;
  unsigned2 	phone_score								:= 0		; // Score captioned listings for display ranking
  unsigned4 	fein 											:= 0		; // Federal Tax ID
  boolean   	current														; // Current/Historical indicator
  boolean	  	dppa 											:= false; // DPPA restricted record (Vehicles and Watercraft)
end;