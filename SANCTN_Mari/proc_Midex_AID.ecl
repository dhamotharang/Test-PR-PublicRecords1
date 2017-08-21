IMPORT SANCTN_Mari 
			,ut
			,Lib_FileServices
			,lib_stringlib
			,Lib_date
			,Standard
			,Address
			,AID;

export proc_Midex_AID(string filedate) := function

valid_states :=	['AE','AP','CN','GU','ON','PR','AK','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI','IA','ID','IL','IN','KS','KY','LA','MA',
												 'MD','ME','MI','MN','MO','MS','MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC','SD','TN','TX',
												 'UT','VA','VI','VT','WA','WI','WV','WY'];

dsIncidentBase	:= sort(SANCTN_Mari.files_SANCTN_common.incident_common,INCIDENT_NUM);
dsPartyBase	:= sort(SANCTN_Mari.files_SANCTN_common.party_common,INCIDENT_NUM);

//Combine addresses for both incident and party in order to AID
layout_addr_combined	:= RECORD
		STRING8			INCIDENT_NUM;
		INTEGER			KEY;
		STRING7			PARTY_NUM;
		STRING100		NAME;
		STRING50		FIRSTNAME;
		STRING50		LASTNAME;
		STRING50 		MIDDLENAME;
		STRING10		SUFFIXNAME;
		STRING45		ADDRESS;
		STRING45		CITY;
		STRING2			STATE;
		STRING9			ZIP;
END;

layout_addr_combined combine_party(dsPartyBase L)	:= TRANSFORM
	self.INCIDENT_NUM	:= L.INCIDENT_NUM;
	self.KEY					:= L.PARTY_KEY;
	self.PARTY_NUM		:= L.PARTY_NUM;
	// self.NAME					:= L.NAME_PARTY;
	self.NAME					:= L.PARTY_FIRM;
	self.FIRSTNAME		:= L.NAME_FIRST;
	self.LASTNAME			:= L.NAME_LAST;
	self.MIDDLENAME		:= L.NAME_MIDDLE;
	self.SUFFIXNAME		:= L.SUFFIX;
	self.ADDRESS			:= L.ADDRESS;
	self.CITY					:= L.CITY;
	self.STATE				:= L.STATE;
	self.ZIP					:= L.ZIP;
END;

ds_PartyAddr_combined	:= project(dsPartyBase,combine_party(left));

layout_addr_combined combine_incident(dsIncidentBase L)	:= TRANSFORM
	self.INCIDENT_NUM	:= L.INCIDENT_NUM;
	self.KEY					:= L.INT_KEY;
	self.PARTY_NUM		:= 'N/A';
	self.NAME					:= L.AGENCY;
	self.FIRSTNAME		:= '';
	self.LASTNAME			:= '';
	self.MIDDLENAME		:= '';
	self.SUFFIXNAME		:= '';
	self.ADDRESS			:= L.PROP_ADDR;
	self.CITY					:= L.PROP_CITY;
	self.STATE				:= L.PROP_STATE;
	self.ZIP					:= L.PROP_ZIP;
END;

ds_IncidentAddr_combined	:= project(dsIncidentBase, combine_incident(left));

ds_addr_combined		:= ds_IncidentAddr_combined + ds_PartyAddr_combined;

//Parse out bad addresses
NewBaseFileBadAddr	:=	ds_addr_combined(ADDRESS = ''OR 
																				NOT Regexfind('[0-9]',ADDRESS) OR // address does not have numbers.
																				NOT REGEXFIND('^[a-zA-Z]+[.]*', CITY) OR
																				STATE NOT IN valid_states OR 
																				(NOT REGEXFIND('^([0-9]{5}(-[0-9]{4})*)', ZIP) AND
																				ZIP != ' '));
NewBaseFileGoodAddr	:=	ds_addr_combined(REGEXFIND('^([0-9]+|P[.]*O[.*]|P[ ]*O )', ADDRESS) AND 
																				REGEXFIND('^[a-zA-Z]+[.]*', CITY) AND 
																				STATE IN valid_states AND 
																				(REGEXFIND('^([0-9]{5}(-[0-9]{4})*)', ZIP) OR ZIP = ' '));

layout_AID_prep := RECORD
		layout_addr_combined;
		string77	Append_Prep_Address_Situs;
		string54	Append_Prep_Address_Last_Situs;
		AID.Common.xAID AID := 0;
		//clean fields
		Standard.L_Address.detailed;
END;
			
layout_AID_prep	tPreAddrClean(ds_addr_combined pInput) := TRANSFORM
		self.Append_Prep_Address_Situs			:=	Address.fn_addr_clean_prep(pInput.ADDRESS, 'first');
		self.Append_Prep_Address_Last_Situs	:=	Address.fn_addr_clean_prep(pInput.CITY
																							+	IF(pInput.CITY <> '',', ','') + pInput.STATE
																							+	' ' + pInput.ZIP, 'last');
		self																:=	pInput;
		self																:=	[];
END;
			
rsRawPreClean := PROJECT(NewBaseFileGoodAddr ,tPreAddrClean(LEFT));
	
	unsigned4 lAIDFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	
AID.MacAppendFromRaw_2Line(rsRawPreClean,
														Append_Prep_Address_Situs, Append_Prep_Address_Last_Situs, AID,
														rsCleanAID, lAIDFlags);
														
//Map clean address fields to combined layout
layout_AID_prep clean_combined(rsCleanAID input)	:= TRANSFORM
	// Set the address values
   self.prim_range 	         := input.aidwork_acecache.prim_range;
   self.predir 			         := input.aidwork_acecache.predir;
   self.prim_name 	         := input.aidwork_acecache.prim_name;
   self.addr_suffix          := input.aidwork_acecache.addr_suffix;
   self.postdir 		         := input.aidwork_acecache.postdir;
   self.unit_desig 	         := input.aidwork_acecache.unit_desig;
   self.sec_range 	         := input.aidwork_acecache.sec_range;
   self.p_city_name          := input.aidwork_acecache.p_city_name;
   self.v_city_name          := input.aidwork_acecache.v_city_name;
   self.st 			             := input.aidwork_acecache.st;
   self.zip5 					       := input.aidwork_acecache.zip5;
   self.zip4 					       := input.aidwork_acecache.zip4;
   self.cart 					       := input.aidwork_acecache.cart;
   self.cr_sort_sz 		       := input.aidwork_acecache.cr_sort_sz;
   self.lot 					       := input.aidwork_acecache.lot;
   self.lot_order 		       := input.aidwork_acecache.lot_order;
   self.dpbc 					       := input.aidwork_acecache.dbpc;
   self.chk_digit 		       := input.aidwork_acecache.chk_digit;
   self.addr_rec_type        := input.aidwork_acecache.rec_type;
	 self.fips_county 				 := input.aidwork_acecache.county;
   self.geo_lat 		         := input.aidwork_acecache.geo_lat;
   self.geo_long 		         := input.aidwork_acecache.geo_long;
   self.cbsa 				         := input.aidwork_acecache.msa;
   self.geo_blk 		         := input.aidwork_acecache.geo_blk;
   self.geo_match 	         := input.aidwork_acecache.geo_match;
   self.err_stat 		         := input.aidwork_acecache.err_stat;
   self.aid                  := input.aidwork_rawaid;
   self  := input;
END;

ds_clean_combined	:= project(rsCleanAID, clean_combined(left));

layout_AID_prep Notcln_combined(NewBaseFileBadAddr input)	:= TRANSFORM
	 self.Append_Prep_Address_Situs	:= ' ';
	 self.Append_Prep_Address_Last_Situs	:= ' ';
   CleanAddress  := Address.CleanAddress182(trim(input.ADDRESS),trim(input.CITY) + ' ' + trim(input.STATE) + ' ' + trim(input.ZIP));
   // Set the address values
   self.prim_range 	:= CleanAddress[1..10]; 
   self.predir 			:= CleanAddress[11..12];					   
   self.prim_name 	:= CleanAddress[13..40];
   self.addr_suffix	:= CleanAddress[41..44];
   self.postdir 		:= CleanAddress[45..46];
   self.unit_desig 	:= CleanAddress[47..56];
   self.sec_range 	:= CleanAddress[57..64];
   self.p_city_name := CleanAddress[65..89];
   self.v_city_name := CleanAddress[90..114];
   self.st 			   	:= if(CleanAddress[115..116]=''
                          ,ziplib.ZipToState2(CleanAddress[117..121])
													,CleanAddress[115..116]);
   self.zip5 			:= CleanAddress[117..121];
   self.zip4 			:= CleanAddress[122..125];
   self.cart 			:= CleanAddress[126..129];
   self.cr_sort_sz := CleanAddress[130];
   self.lot 			:= CleanAddress[131..134];
   self.lot_order := CleanAddress[135];
   self.dpbc 			:= CleanAddress[136..137];
   self.chk_digit := CleanAddress[138];
   self.addr_rec_type := CleanAddress[139..140];
   self.fips_state		:= CleanAddress[141..142];
   self.fips_county   := CleanAddress[143..145];
   self.geo_lat 	:= CleanAddress[146..155];
   self.geo_long 	:= CleanAddress[156..166];
   self.cbsa 			:= CleanAddress[167..170];
   self.geo_blk 	:= CleanAddress[171..177];
   self.geo_match := CleanAddress[178];
   self.err_stat 	:= CleanAddress[179..182];
	 self := input;
END;

ds_CleanParsedBad	:= project(NewBaseFileBadAddr,Notcln_combined(left));

//split incident and party 
ds_goodAddr_incident	:= ds_clean_combined(trim(PARTY_NUM)	= 'N/A');
ds_badAddr_incident		:= ds_CleanParsedBad(trim(PARTY_NUM)	= 'N/A');
ds_goodAddr_party			:= ds_clean_combined(trim(PARTY_NUM)	!= 'N/A');
ds_badAddr_party			:= ds_CleanParsedBad(trim(PARTY_NUM)	!= 'N/A');

ds_clean_incident		:= sort(ds_goodAddr_incident + ds_badAddr_incident,INCIDENT_NUM);
ds_clean_party			:= sort(ds_goodAddr_party + ds_badAddr_party,INCIDENT_NUM);

//Join back to original incident and party file and include clean and AID fields
SANCTN_Mari.layouts_SANCTN_common.SANCTN_incident_did	add_cln_incident_addr(dsIncidentBase L, ds_clean_incident R )	:= TRANSFORM
	self.prim_range   :=	R.prim_range;
  self.predir 	    :=	R.predir;
  self.prim_name    :=	R.prim_name;
  self.addr_suffix  :=	R.addr_suffix;
  self.postdir 		  :=	R.postdir;
  self.unit_desig   :=	R.unit_desig;
  self.sec_range 	  :=	R.sec_range;
  self.p_city_name  :=	R.p_city_name;
  self.v_city_name  :=	R.v_city_name;
  self.st 			    :=	R.st;
  self.zip5 			  :=	R.zip5;
  self.zip4 			  :=	R.zip4;
  self.cart 			  :=	R.cart;
  self.cr_sort_sz 	:=	R.cr_sort_sz;
  self.lot 				  :=	R.lot;
  self.lot_order 	  :=	R.lot_order;
  self.dpbc 			  :=	R.dpbc;
  self.chk_digit 	  :=	R.chk_digit;
  self.addr_rec_type:=	R.addr_rec_type;
  self.fips_county  :=	R.fips_county;
	self.fips_state		:=  R.fips_state;
  self.geo_lat 		  :=	R.geo_lat;
  self.geo_long 	  :=	R.geo_long;
  self.cbsa 			  :=	R.cbsa;
  self.geo_blk 		  :=	R.geo_blk;
  self.geo_match 	  :=	R.geo_match;
  self.err_stat 	  :=	R.err_stat;
  self.aid          :=	R.aid;
	self := L;
	self := [];
END;

ds_map_cln_incident	:= join(dsIncidentBase, ds_clean_incident,
														trim(left.INCIDENT_NUM) = trim(right.INCIDENT_NUM) AND
														left.INT_KEY = right.KEY AND
														trim(left.AGENCY) = trim(right.NAME) AND
														trim(left.PROP_ADDR) = trim(right.ADDRESS) AND
														trim(left.PROP_CITY) = trim(right.CITY) AND
														trim(left.PROP_STATE) = trim(right.STATE) AND
														trim(left.PROP_ZIP) = trim(right.ZIP),
														add_cln_incident_addr(left,right),LEFT OUTER);
														
SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did	add_cln_party_addr(dsPartyBase L, ds_clean_party R )	:= TRANSFORM
	self.prim_range   :=	R.prim_range;
  self.predir 	    :=	R.predir;
  self.prim_name    :=	R.prim_name;
  self.addr_suffix  :=	R.addr_suffix;
  self.postdir 		  :=	R.postdir;
  self.unit_desig   :=	R.unit_desig;
  self.sec_range 	  :=	R.sec_range;
  self.p_city_name  :=	R.p_city_name;
  self.v_city_name  :=	R.v_city_name;
  self.st 			    :=	R.st;
  self.zip5 			  :=	R.zip5;
  self.zip4 			  :=	R.zip4;
  self.cart 			  :=	R.cart;
  self.cr_sort_sz 	:=	R.cr_sort_sz;
  self.lot 				  :=	R.lot;
  self.lot_order 	  :=	R.lot_order;
  self.dpbc 			  :=	R.dpbc;
  self.chk_digit 	  :=	R.chk_digit;
  self.addr_rec_type:=	R.addr_rec_type;
  self.fips_county  :=	R.fips_county;
	self.fips_state		:=  R.fips_state;
  self.geo_lat 		  :=	R.geo_lat;
  self.geo_long 	  :=	R.geo_long;
  self.cbsa 			  :=	R.cbsa;
  self.geo_blk 		  :=	R.geo_blk;
  self.geo_match 	  :=	R.geo_match;
  self.err_stat 	  :=	R.err_stat;
  self.aid          :=	R.aid;
	self := L;
	self := [];
END;

ds_map_cln_party	:= join(dsPartyBase, ds_clean_party,
														trim(left.INCIDENT_NUM) = trim(right.INCIDENT_NUM) AND
														left.PARTY_KEY = right.KEY AND
														trim(left.PARTY_NUM) = trim(right.PARTY_NUM) AND
														trim(left.PARTY_FIRM) = trim(right.NAME) AND
														trim(left.NAME_FIRST) = trim(right.FIRSTNAME) AND
														trim(left.NAME_LAST) = trim(right.LASTNAME) AND
														trim(left.NAME_MIDDLE) = trim(right.MIDDLENAME) AND
														trim(left.ADDRESS) = trim(right.ADDRESS) AND
														trim(left.CITY) = trim(right.CITY) AND
														trim(left.STATE) = trim(right.STATE) AND
														trim(left.ZIP) = trim(right.ZIP),
														add_cln_party_addr(left,right),LEFT OUTER);


out_cln_incident	:= output(ds_map_cln_incident,,SANCTN_Mari.cluster_name +'temp::SANCTN::NP::cln_incident_aid',overwrite);
out_cln_party			:= output(ds_map_cln_party,,SANCTN_Mari.cluster_name +'temp::SANCTN::NP::cln_party_aid',overwrite);

retval	:= parallel(out_cln_incident, out_cln_party);
														
return retval;
END;
