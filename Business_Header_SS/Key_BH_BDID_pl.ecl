IMPORT Business_Header,ut;

f_bh := business_header.File_Business_Header;

rec := RECORD
  unsigned6 bdid := 0;      
  string2   source;          
  qstring34 source_group := ''; 
  unsigned4 dt_first_seen;   
  unsigned4 dt_last_seen;   
  unsigned4 dt_vendor_first_reported;
  unsigned4 dt_vendor_last_reported;
  qstring120 company_name;
  qstring10 prim_range;
  string2   predir;
  qstring28 prim_name;
  qstring4  addr_suffix;
  string2   postdir;
  qstring5  unit_desig;
  qstring8  sec_range;
  qstring25 city;
  string2   state;
  unsigned3 zip;
  unsigned2 zip4;
  string3   county;
  string4   msa;
  qstring10 geo_lat;
  qstring11 geo_long;
  unsigned6 phone;
  unsigned2 phone_score := 0; 
  unsigned4 fein := 0;        
  boolean   current;          
  boolean	  dppa := false; 
	string2   vendor_st;
END;

rec  makerec(f_bh l) := transform
	self.vendor_st := l.vendor_id[1..2];
	self := l;
end;

p := project(f_bh, makerec(left));

rec rollem(rec l, rec r) := transform
  ut.mac_roll_DFS(dt_first_seen)  
  ut.mac_roll_DLS(dt_last_seen)    
  ut.mac_roll_DFS(dt_vendor_first_reported)
  ut.mac_roll_DLS(dt_vendor_last_reported)
  ut.mac_roll_DLS(geo_lat)
  ut.mac_roll_DLS(geo_long)
	self := l;
end;

r := rollup(
		sort(p,bdid,source,source_group,company_name,prim_range,predir,prim_name,addr_suffix,postdir,
		       unit_desig,sec_range,city,state,zip,zip4,county,msa,phone,fein,current,dppa,vendor_st, local),
	left.bdid = right.bdid and 
	left.source = right.source and
	left.source_group = right.source_group and
	left.company_name = right.company_name and
	left.prim_range = right.prim_range and 
	left.predir = right.predir and
	left.prim_name = right.prim_name and 
	left.addr_suffix = right.addr_suffix and
	left.postdir = right.postdir and
	left.unit_desig = right.unit_desig and
  left.sec_range = right.sec_range and
  left.city = right.city and
  left.state = right.state and
  left.zip = right.zip and
  left.zip4 = right.zip4 and
  left.county = right.county and
	left.msa = right.msa and
	left.phone = right.phone and
  left.fein = right.fein and       
  left.current = right.current and          
  left.dppa = right.dppa and 
	left.vendor_st = right.vendor_st,
	rollem(left, right), local);

EXPORT Key_BH_BDID_pl := INDEX(
	r, 
	{bdid},
	{r},
	'~thor_data400::key::business_header.BDID_pl_' + business_header_ss.key_version);