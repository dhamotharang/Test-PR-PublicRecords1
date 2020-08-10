import ut, doxie, business_header;

boolean include_hri := false : stored('IncludeHRI');
unsigned1 maxHriPer_value := 10 : stored('MaxHriPer');

doxie.MAC_Header_Field_Declare();
mod_access := doxie.compliance.GetGlobalDataAccessModule();

headerRecs := doxie.header_records()(ut.stringsimilar(prim_name,pname_val) < 3, 
                                   ut.NNEQ(prim_range, prange_value));

doxie.layout_presentation xt(headerRecs le) := transform
	SELF := le;
end;

presRecs := PROJECT(headerRecs, xt(LEFT));

with_risk := doxie.base_presentation(presRecs);

layout_AddressPresentation xt2(with_risk le) := transform
//	SELF.rids := DATASET([{le.rid}], RidRec);
  SELF.rids := [];
	SELF := le;
end;

//prune data to only addr info
with_risk_slim := PROJECT(with_risk, xt2(LEFT));

// get bus header records 
filtered_res := Business_Header.doxie_get_bdids_plus();
bhkb := Business_Header.Key_BH_Best;

layout_AddressPresentation getBus(filtered_res l,  bhkb r) := transform
	SELF.penalt := 0;
	SELF.zip := INTFORMAT(r.zip,5,1);
	SELF.zip4 := INTFORMAT(r.zip4,5,1);
	SELF.suffix := r.addr_suffix;
	SELF.city_name := r.city;
	SELF.st := r.state;
	SELF.hri_address := [];
  SELF.rids := [];
	SELF := r;
end;
 
busRecs := join(filtered_res(bdid != 0), bhkb,
				keyed(left.bdid = right.bdid) AND 
        doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
				getBus(left, right),
				left outer,
				keep (1), limit (0));

layout_AddressPresentation rol_it(with_risk_slim le,with_risk_slim ri) := transform
  self.prim_range := IF(le.prim_range<>'',le.prim_range,ri.prim_range);
  self.predir := IF(le.predir<>'',le.predir,ri.predir);
  self.prim_name := IF(le.prim_name<>'',le.prim_name,ri.prim_name);
  self.suffix := IF(le.suffix<>'',le.suffix,ri.suffix);
  self.postdir := IF(le.postdir<>'',le.postdir,ri.postdir);
  self.sec_range := IF(length(trim(le.sec_range))>length(trim(ri.sec_range)),le.sec_range,ri.sec_range);
  self.unit_desig := IF(length(trim(le.unit_desig))>length(trim(ri.unit_desig)),le.unit_desig,ri.unit_desig);
  self.city_name := IF(le.city_name<>'',le.city_name,ri.city_name);
  self.st := IF(le.st<>'',le.st,ri.st);
  self.zip := IF(le.zip<>'',le.zip,ri.zip);	
//  self.rids := le.rids + ri.rids;
  self.penalt := IF(le.penalt < ri.penalt, le.penalt, ri.penalt);
	self := le;
end;

srtd1 := sort((with_risk_slim + busRecs)(prim_name <> ''),prim_name,(INTEGER)prim_range,suffix,sec_range,unit_desig,
              predir,postdir,zip,zip4,st,city_name);

// consider # a match with any other value (like blank is)							
unitdes_NNEQ(string l, string r) := l = '' or l='#' or r = '' or r ='#' or l=r; 

ta1 := rollup( srtd1,
  left.prim_range = right.prim_range and
  left.predir = right.predir and
  left.prim_name = right.prim_name and
  left.suffix = right.suffix and
  left.postdir = right.postdir and
	left.sec_range = right.sec_range and
	unitdes_NNEQ(left.unit_desig,right.unit_desig) and 
  left.city_name = right.city_name and
  left.st = right.st and
  left.zip = right.zip, rol_it(left,right));

doxie.mac_AddHRIAddress(ta1,withHRIs);

export Location_presentation := sort(IF(include_hri, withHRIs, ta1),
                                    penalt,ut.StringSimilar100(sec_range_value,sec_range),zip,prim_name,(INTEGER)prim_range, sec_range, record);
