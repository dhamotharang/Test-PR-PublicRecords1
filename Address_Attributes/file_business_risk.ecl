import address_attributes, advo, aml, Business_Header, business_risk, doxie, LN_PropertyV2, Risk_Indicators, ut;

//constants
search_range := address_attributes.Constants.twoYrAgo; //rolling 24 months
string Incorp_svc_includes 	:= '\\b(?:CORP[ ]SERVICES|CORPORATE[ ]SERVICES|INCORPORATION[ ]SERVICE|INCORPORATION[ ]SYSTEMS|INCORPORATION|HARVARD[ ]BUSINESS[ ]SERVICES|EXCELSIOR[ ]LEGAL[ ]INC|LEGALZOOM.COM|ALCO[ ]CORP[ ]SERVICES|HARVARD[ ]BUINESS[ ]SERVICES,[ ]INC.|HARVARD[ ]BUSINESS[ ]SERVICE|HARVARD[ ]BUSINESS[ ]SERVICES|HARVARD[ ]BUSINESS[ ]SERVICES[ ]INC)\\b';
// string Incorp_svc_excludes 	:= '\\b(?:TITLE|BANK)\\b';
string credit_rpr_includes 	:= '\\b(?:CREDIT[ ]REPAIR|SKY[ ]BLUE[ ]SOLUTIONS|LEXINGTON[ ]LAW|OVATION[ ]CREDIT|CREDIT[ ]FIXERS|CREDIT[ ]SOLUTIONS|CREDIT[ ]SERVICES|MY[ ]CREDIT[ ]GROUP)\\b';
// string credit_rpr_excludes 	:= '\\b(?:FARM|BANK)\\b';


//Data Declarations
ds_in := DISTRIBUTE(Business_Header.File_Business_Header_Base_for_keybuild, bdid);
ds := DEDUP(SORT(ds_in(dt_last_seen > search_range and current = true and zip <> 0 and prim_range <> '' and prim_name <> ''), bdid, LOCAL), bdid, LOCAL);

rFinal := record
  qstring5	zip;
  qstring10	prim_range;
  qstring28	prim_name;
  qstring4	addr_suffix;
  string2	predir;
  string2	postdir;
  qstring5	unit_desig;
  qstring8	sec_range;
  qstring25	city;
  string2	state;
  unsigned2	zip4;
	STRING7	 	geo_blk;
	string13	geolink;
	string7	streetlink;
  string3	pflag;//
  unsigned4	dt_first_seen;//
  unsigned4	dt_last_seen;//
  string3	county;
  string4	msa;
  qstring10	geo_lat;
  qstring11	geo_long;
  boolean	current;//
	unsigned	bdid;//
	string2 source; 
  qstring81	match_company_name;//
  qstring20	match_branch_unit;//
  qstring25	match_geo_city;//
	integer4	business_count;
	integer4	legal_srv_cnt;
	integer4	hr_biz_cnt;
	boolean	incorp_srv;
	boolean credit_rpr_srv;
	boolean	hr_drug_trfc_zip := false;
	string1	address_type;
  string1	mixed_address_usage;
	string1	residential_or_business_ind;
  string1	dnd_indicator;
	string1	address_style_flag;
  string1	owgm_indicator;
  string1	drop_indicator;
	boolean	deliverable;
	boolean	occupant_owned;
	unsigned1	property_count;
	unsigned1	property_total;
	string	standardized_land_use_code;
	unsigned8	building_area;
	unsigned8	no_of_buildings;
	unsigned8	no_of_stories;
	unsigned8	no_of_rooms;
	unsigned8	no_of_bedrooms;
	integer4 undel_sec_range;
	integer4	undel_bus_sec_range;
	integer4	num_undel_sec_ranges;
	real	bdid_to_sqft_ratio;
	boolean	prop_sfd := false;
	boolean	potential_shelf_address := false;
	boolean	potential_shell_address := false;
end;
//

//Append Data
rFinal addBusinessBaseCount(ds l) := TRANSFORM
	self.Business_Count := 1;
	self.hr_drug_trfc_zip := (string)l.zip in AML.AMLConstants.setHIFCA;
	fix_zip := (string)intformat(l.zip,5,1);//adding back zeros
	cat_address := l.prim_range + ' ' + l.predir + ' ' +  l.prim_name + ' ' + l.addr_suffix + ' ' + l.postdir + ' ' + l.sec_range;
	clean_address := Risk_Indicators.MOD_AddressClean.clean_addr(cat_address, l.city, l.state, fix_zip);
	self.prim_range := clean_address [1..10];
	self.predir := clean_address [11..12];
	self.prim_name := clean_address [13..40];
	self.addr_suffix := clean_address [41..44];
	self.postdir := clean_address [45..46];
	self.unit_desig := clean_address [47..56];
	self.sec_range := clean_address [57..65];
	self.city := clean_address [90..114];
	self.state := clean_address [115..116];
	self.zip := clean_address [117..121];
	self.zip4 := (integer)clean_address[122..125];
	self.county := clean_address[143..145];
	self.geo_lat := clean_address[146..155];
	self.geo_long := clean_address[156..166];
	self.msa := clean_address[167..170];
	self.geo_blk := clean_address[171..177];
	self.geolink := clean_address[115..116]+clean_address[143..145]+clean_address[171..177];
	self.streetlink := (string)clean_address [117..121] + (string)clean_address[122..123];
	
	In_Corp_Svc 	:= regexfind(Incorp_svc_includes, l.match_company_name) OR regexfind(Incorp_svc_includes, l.company_name);// and not regexfind(Incorp_svc_excludes, l.match_company_name);
	credit_repair := regexfind(credit_rpr_includes, l.match_company_name) OR regexfind(credit_rpr_includes, l.company_name);// and not regexfind(Incorp_svc_excludes, l.match_company_name);
	self.incorp_srv				:=  if(In_Corp_Svc,true,false);
	self.credit_rpr_srv		:=  if(credit_repair,true,false);
	
	self := l;
	self := [];
end;
count_init := PROJECT(ds, addBusinessBaseCount(left), LOCAL);

//Get SICs for each business
rFinal addSicCodes(count_init l, Business_header.key_sic_code r) := transform
	self.hr_biz_cnt := if(l.bdid = r.bdid and 
													(r.sic_code in AML.AMLConstants.setHRBusFullSicCds or 
													 r.sic_code[1..4] in AML.AMLConstants.setHRBusCatgSicCds or
													 r.sic_code[1..6] in AML.AMLConstants.setHRNAICSCodes), 1, 0);
	self.legal_srv_cnt := if(l.bdid = r.bdid and 
													(r.sic_code[1..5] in ['54111','54119','54199'] or
													 r.sic_code[1..4] in ['8111','7380','8741','8741','8742','8744']), 1, 0);
	self := l;
end;

Sic_Counts := JOIN(count_init, Business_header.key_sic_code, 
								KEYED(left.bdid = right.bdid),
								addSicCodes(left,right),keep(20));

Sic_count_dist := DISTRIBUTE(Sic_Counts, HASH32(bdid));
// Count Business types for each business
rFinal rollSic( rFinal l, rFinal r ) := TRANSFORM
	self.hr_biz_cnt := l.hr_biz_cnt + r.hr_biz_cnt;
	self.legal_srv_cnt := l.legal_srv_cnt + r.legal_srv_cnt;
	self := l;
END;
		
final_sic_count := ROLLUP(SORT(Sic_count_dist, bdid, LOCAL), 
		left.bdid = right.bdid, 
	rollSic(left,right), LOCAL);	

Business_count_dist := DISTRIBUTE(final_sic_count, HASH32(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range));

//Count Businesses At Each Address - this rolls up all business per each unique address
rFinal rollSicBiz( rFinal l, rFinal r ) := TRANSFORM
	self.Business_Count := if(l.source <> 'GB', l.Business_Count + r.Business_Count, l.Business_Count);//This is to not count individual real estate agents
	self.hr_biz_cnt := l.hr_biz_cnt + r.hr_biz_cnt;
	self.legal_srv_cnt := l.legal_srv_cnt + r.legal_srv_cnt;
	
	//maintain the address shell/credit repair status during the rollup
	self.incorp_srv := map(l.incorp_srv = false and r.incorp_srv => true,
												 l.incorp_srv = true  and r.incorp_srv => true,
												 l.incorp_srv = false and r.incorp_srv = false => false,
												 l.incorp_srv = true  and r.incorp_srv = false => true, false);
												 
	self.credit_rpr_srv := map(l.credit_rpr_srv = false and r.credit_rpr_srv => true,
														 l.credit_rpr_srv = true  and r.credit_rpr_srv => true,
														 l.credit_rpr_srv = false and r.credit_rpr_srv = false => false,
														 l.credit_rpr_srv = true  and r.credit_rpr_srv = false => true, false);
	self := l;
END;
		
final_bizsic_count := ROLLUP(SORT(Business_count_dist, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, LOCAL), 
		left.zip = right.zip and
		left.prim_range = right.prim_range and 
		left.prim_name = right.prim_name and 
		left.addr_suffix = right.addr_suffix and 
		left.predir = right.predir and
		left.postdir = right.postdir and
		left.sec_range = right.sec_range, 
	rollSicBiz(left,right), LOCAL);		

//Pull ADVO Address Characteristics
rFinal addAdvo(final_bizsic_count l, ADVO.Key_Addr1 r) := TRANSFORM			
	self.address_type := r.address_type;
  self.mixed_address_usage := r.mixed_address_usage;
	self.residential_or_business_ind := r.residential_or_business_ind;
  self.dnd_indicator := r.dnd_indicator;
	self.address_style_flag := r.address_style_flag;
  self.owgm_indicator := r.owgm_indicator;
  self.drop_indicator := r.drop_indicator;
	self.deliverable := if(r.address_type <> '', true, false);
	self := l;
end;

with_ADVO := JOIN(final_bizsic_count, ADVO.Key_Addr1,
		keyed((string)left.zip = right.zip) and
		keyed(left.prim_range = right.prim_range) and
		keyed(left.prim_name = right.prim_name) and
		keyed(left.addr_suffix = right.addr_suffix) and
		keyed(left.predir = right.predir) and
		keyed(left.postdir = right.postdir) and
		keyed(left.sec_range = right.sec_range),
	addADVO(left, right),Left Outer,keep(1));

//Append Property V4 Property Characteristics
rFinal addProperty(with_ADVO l, LN_PropertyV2.Key_Prop_Address_V4 r) := transform
	self.occupant_owned := r.occupant_owned;
	self.property_count	:= r.property_count;
	self.property_total	:= r.property_total;
	self.standardized_land_use_code := r.standardized_land_use_code;
	self.building_area := r.building_area;
	self.no_of_buildings := r.no_of_buildings;
	self.no_of_stories := r.no_of_stories;
	self.no_of_rooms := r.no_of_rooms;
	self.no_of_bedrooms := r.no_of_bedrooms;
	self := l;
end;

base_with_Property := JOIN(with_ADVO, LN_PropertyV2.Key_Prop_Address_V4,
	keyed(left.prim_range = right.prim_range) and
	keyed(left.prim_name = right.prim_name) and
	keyed(left.sec_range = right.sec_range) and
	keyed(left.zip = right.zip) and
	keyed(left.addr_suffix = right.suffix) and
	keyed(left.predir = right.predir) and
	keyed(left.postdir = right.postdir),
	addProperty(left, right),Left Outer,keep(1));

//
base_prop_dist := DISTRIBUTE(base_with_Property, HASH32(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range));
//Count undeliverable secondary ranges from secondary rage rollup in the base file
rFinal addUndelCount(base_prop_dist l) := TRANSFORM
	self.undel_sec_range  := if(l.sec_range  <> '' and l.deliverable = false, 1, 0);  
	self.bdid_to_sqft_ratio := if(l.building_area <> 0, l.building_area / l.business_count, 0);
	self.prop_sfd := if(l.building_area > 0, Address_Attributes.functions.getSFD(l.standardized_land_use_code), false);
	self := l;
	self := [];
end;

count_sec_init := PROJECT(base_prop_dist, addUndelCount(left),LOCAL);

count_sec_init_dist := DISTRIBUTE(count_sec_init, HASH32(zip,prim_range,prim_name,addr_suffix,predir,postdir,sec_range));
rFinal rollBiz( rFinal l, rFinal r ) := TRANSFORM
	self.undel_bus_sec_range := if(~l.deliverable and ~r.deliverable, l.undel_bus_sec_range + r.Business_Count, l.undel_bus_sec_range);
	self := l;
	self := [];
END;
		
final_business_count := ROLLUP(SORT(count_sec_init_dist, zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, LOCAL), 
		left.zip = right.zip and
		left.prim_range = right.prim_range and 
		left.prim_name = right.prim_name and 
		left.addr_suffix = right.addr_suffix and 
		left.predir = right.predir and
		left.postdir = right.postdir and
		left.sec_range = right.sec_range,
	rollBiz(left,right), LOCAL);

suspicious_base_addresses := TABLE(final_business_count, {zip, prim_range, prim_name, addr_suffix, predir,
																													total_undeliverable_sec_ranges := COUNT(GROUP, undel_sec_range = 1)}, 
																													zip, prim_range, prim_name, addr_suffix, predir);

bads := suspicious_base_addresses(total_undeliverable_sec_ranges > 0);
bads_dist := DISTRIBUTE(bads, HASH32(zip,prim_range,prim_name,addr_suffix,predir));
rFinal addDetails(final_business_count l, bads_dist r) := transform
	
	potential_shelf := if(((l.address_type  = '1' or  l.prop_sfd) and l.building_area <> 0 and l.bdid_to_sqft_ratio < 50) OR  		//ADVO <> SFD or LN Prod <> SFD and sqft < 50 per bdid (median is 250 sqft)
											  ((l.address_type  = '1' or  l.prop_sfd) and l.business_count > 20) OR
											  ((l.address_type  = '1' or  l.prop_sfd) and l.num_undel_sec_ranges > 2) or
											    l.num_undel_sec_ranges >= 10, true, false);
												 
	potential_shell := if(((l.legal_srv_cnt > 1 or l.incorp_srv) and (l.address_type in ['', '0'] and not l.prop_sfd)) or 
											 (l.business_count > 1000 and l.bdid_to_sqft_ratio < 50), true, false);	
												
	//Shell requires a legal entity to be present at the non-residential location and the registered businesses over 1000
	self.num_undel_sec_ranges := r.total_undeliverable_sec_ranges;
	self.potential_shelf_address := potential_shelf;
	self.potential_shell_address := potential_shell;
	self := l;
end;

bad_final := JOIN(final_business_count, bads_dist,
		left.zip = right.zip and
		left.prim_range = right.prim_range and
		left.prim_name = right.prim_name and
		left.addr_suffix = right.addr_suffix and
		left.predir = right.predir,
	addDetails(left, right),left outer, keep(1),LOCAL);

//Join back to business header to flag BDIDs by address
dBad_final := DISTRIBUTE(bad_final, bdid);
dBizHeader := DISTRIBUTE(ds, bdid);

rFinal joinFinal(dBad_final l, dBizHeader r) := transform
	self := l;
end;

final := JOIN(dBad_final, dBizHeader,
		left.bdid = right.bdid,
	joinFinal(left, right),left outer, keep(1), LOCAL);
	
export file_business_risk := final;
