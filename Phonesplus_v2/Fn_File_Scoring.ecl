import experian_phones,ut, mdr;
EXPORT fn_File_Scoring(dataset(recordof(Layout_Phonesplus_Base)) 
											phplus_in = _keybuild_phonesplus_base):= function
//Phonesplus excluding inquiry tracking data
pplus := phplus_in(Translation_Codes.fGet_all_sources(src_all) != mdr.sourceTools.src_InquiryAcclogs);


//------One year for landlines
//Attribute Phonesplus_v2.Fn_Phone_Verification places above the line
//Last 1 year for landlines only and all cellphones
pplus_t := project(pplus(in_flag),File_Scoring.layout);

//-------Rollup
File_Scoring.layout t_rollup (File_Scoring.layout le, File_Scoring.layout ri) := transform
	glb_priority(string1 flag)			:= map(
											   flag = ''=> 2,
											   flag = 'G'=> 3,
											   flag = 'B'=> 4,
											   flag = 'D'=> 5,
											   1);
self.datefirstseen := ut.EarliestDate(le.datefirstseen, ri.datefirstseen);
self.datelastseen := MAX(le.datelastseen, ri.datelastseen);
self.ListingType := if(stringlib.stringContains(le.ListingType, ri.ListingType, true),le.ListingType, le.ListingType + ri.ListingType);
self.glb_dppa_flag := if(glb_priority(le.glb_dppa_flag) < glb_priority(ri.glb_dppa_flag), le.glb_dppa_flag,ri.glb_dppa_flag);
self := ri;
end;

pplus_s := sort(distribute(pplus_t, hash(cellphone)),
								 cellphone,
								 fname,
								 mname,
								 lname,
								 prim_range,
								 predir,
								 prim_name,
								 addr_suffix,
								 postdir,
								 unit_desig,
								 sec_range,
								 p_city_name,
								 v_city_name,
								 state,
								 zip5,
								 zip4,
								 geo_lat,
								 geo_long,
								 geo_blk,
								 hhid,
								 did,
								 datelastseen,	
								 local);

pplus_r   := ROLLUP(pplus_s , t_rollup(LEFT, RIGHT),
								 cellphone,
								 fname,
								 mname,
								 lname,
								 prim_range,
								 predir,
								 prim_name,
								 addr_suffix,
								 postdir,
								 unit_desig,
								 sec_range,
								 p_city_name,
								 v_city_name,
								 state,
								 zip5,
								 zip4,
								 geo_lat,
								 geo_long,
								 geo_blk,
								 hhid,
								 did,
								 local);
return pplus_r;

end;