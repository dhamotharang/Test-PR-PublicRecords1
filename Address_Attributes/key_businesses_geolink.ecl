Import Data_Services, Business_Header, doxie, risk_indicators, std;

//constants
integer	year_filter := Std.Date.AdjustDate(Std.Date.Today(),-2,0,0);  // DF-23935 Correct Two Year Filter

//layouts
layout_Business_geolink := record
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
	string7			geo_blk;
	string12		geolink;
	string1			geo_match;
end;


//data
ds := Business_Header.File_Business_Header_Base_for_keybuild(prim_name <> '', prim_range <> '', city <> '', state <> '', zip <> 0, current, dt_last_seen > year_filter);

//reclean address to create geolink
layout_Business_geolink AddressClean(ds l) := TRANSFORM
		//cleaned data
	street_address := l.prim_range + ' ' + l.predir + ' ' + l.prim_name + ' ' + l.postdir;
		clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(street_address, l.city, l.state, (string)l.zip);
		self.prim_range := clean_address [1..10];
		self.predir := clean_address [11..12];
		self.prim_name := clean_address [13..40];
		self.addr_suffix := clean_address [41..44];
		self.postdir := clean_address [45..46];
		self.unit_desig := clean_address [47..56];
		self.sec_range := clean_address [57..65];
		self.city := clean_address [90..114];
		self.state := clean_address [115..116];
		self.zip := (integer)clean_address [117..121];
		self.zip4 := (integer)clean_address[122..125];
		self.county := clean_address[143..145];
		self.geo_lat := clean_address[146..155];
		self.geo_long := clean_address[156..166];
		self.msa := clean_address[167..170];
		self.geo_blk := clean_address[171..177];
		self.geo_match := clean_address[178];
		//build geolink for AddrRisk
		self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
		self := l;
		self := [];
end;

Clean_pre := project(ds, AddressClean(Left));

Cleaned := clean_pre(geo_match in ['0','1']);
export key_businesses_geolink := index(Cleaned,{geolink, bdid},{Cleaned},Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::neighborhood::'+doxie.Version_SuperKey+'::businesses_geolink');