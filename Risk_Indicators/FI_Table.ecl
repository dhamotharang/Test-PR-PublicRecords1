import header, risk_indicators, property, doxie,doxie_build;


// get header file
hf := distribute(doxie_build.file_header_building(st<>'' and (unsigned)county<>0 and (unsigned)geo_blk<>0 and ~risk_indicators.iid_constants.filtered_source(src, st)), hash(st,county));
// hf := distribute(header.File_Headers(st<>'' and (unsigned)county<>0 and (unsigned)geo_blk<>0 and ~risk_indicators.iid_constants.filtered_source(src)), hash(st,county));
ds := dedup(sort(hf, prim_name, zip, prim_range, predir, postdir, local), prim_name, zip, prim_range, predir, postdir, local);

geoLayout := RECORD
	string12 geo;
	unsigned total;
end;

// calculate property counts per geo levels
p12 := project(table(ds, {geo := st+county+geo_blk, total := count(group)}, st+county+geo_blk, local), geoLayout, local);
p11 := project(table(ds, {geo := st+county+geo_blk[1..6], total := count(group)}, st+county+geo_blk[1..6], local), geoLayout, local);
pfips := project(table(ds, {geo := st+county, total := count(group)}, st+county, local), geoLayout, local);


// get foreclosure file
ff := distribute(property.file_foreclosure_building(situs1_record_type[1]='S' and situs1_err_stat[1]<>'E'), hash(situs1_st, situs1_fipscounty));
dsff := dedup(sort(ff, situs1_prim_name, situs1_zip, situs1_prim_range, situs1_predir, situs1_postdir,local), situs1_prim_name, situs1_zip, situs1_prim_range, situs1_predir, situs1_postdir,local);

// calculate foreclosure counts per geo levels
f12 := project(table(dsff, {geo := situs1_st + situs1_fipscounty + situs1_geo_blk, total := count(group)}, situs1_st+situs1_fipscounty+situs1_geo_blk, local), geoLayout, local);
f11 := project(table(dsff, {geo := situs1_st+situs1_fipscounty+situs1_geo_blk[1..6], total := count(group)}, situs1_st+situs1_fipscounty+situs1_geo_blk[1..6], local), geoLayout, local);
ffips := project(table(dsff, {geo := situs1_st+situs1_fipscounty, total := count(group)}, situs1_st+situs1_fipscounty, local), geoLayout, local);



filayout := record
	string12 geo12;
	string11 geo11;
	string5 fips;
	decimal5_2 geo12_index;
	decimal5_2 geo11_index;
	decimal5_2 fips_index;
	unsigned5 geo12_prop_count;
	unsigned5 geo12_fc_count;
	unsigned5 geo11_prop_count;
	unsigned5 geo11_fc_count;
	unsigned5 fips_prop_count;
	unsigned5 fips_fc_count;
end;



filayout getIndex(geoLayout le, geoLayout ri, unsigned c) := transform
	self.geo12 := if(c=1, le.geo, '');	
	geo12_i := (le.total/ri.total)*100;
	self.geo12_index := if(c=1, if(ri.total<5, 255, geo12_i), 0);		// multiply by 100 and get 2 rounded decimal places, if prop count < 5 then 255
	self.geo12_prop_count := if(c=1, ri.total, 0);
	self.geo12_fc_count := if(c=1, le.total, 0);
	
	self.geo11 := if(c=2, le.geo, '');
	geo11_i := (le.total/ri.total)*100;
	self.geo11_index := if(c=2, if(ri.total<5, 255, geo11_i), 0);			// multiply by 100 and get 2 rounded decimal places, if prop count < 5 then 255
	self.geo11_prop_count := if(c=2, ri.total, 0);
	self.geo11_fc_count := if(c=2, le.total, 0);
	
	self.fips := if(c=3, le.geo, '');
	fips_i := (le.total/ri.total)*100;
	self.fips_index := if(c=3, if(ri.total<5, 255, fips_i), 0);		// multiply by 100 and get 2 rounded decimal places, if prop count < 5 then 255
	self.fips_prop_count := if(c=3, ri.total, 0);
	self.fips_fc_count := if(c=3, le.total, 0);
end;
geo12 := join(f12, p12, left.geo<>'' and length(trim(left.geo,all))=12 and left.geo=right.geo, getIndex(left,right,1), local);
geo11 := join(f11, p11, left.geo<>'' and length(trim(left.geo,all))=11 and left.geo=right.geo, getIndex(left,right,2), local);
fips := join(ffips, pfips, left.geo<>'' and length(trim(left.geo,all))=5 and left.geo=right.geo, getIndex(left,right,3), local);

fi := geo12 + geo11 + fips;

export FI_Table := fi;