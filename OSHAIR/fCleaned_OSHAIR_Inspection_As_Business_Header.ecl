import Business_Header,mdr;
import ut;

export fCleaned_OSHAIR_Inspection_As_Business_Header(dataset(OSHAIR.layout_OSHAIR_inspection_clean_bip) pIspBase)
 := function

	Layout_Cleaned_OSHAIR_Inspection_Base := Layout_OSHAIR_Inspection_Base;

	Layout_Cleaned_OSHAIR_Inspection_Local := record
	  unsigned6 record_id := 0;
	  OSHAIR.layout_OSHAIR_inspection_clean_bip;
	end;

	Cleaned_OSHAIR_Inspection_Base := pIspBase;

  Layout_Cleaned_OSHAIR_Inspection_Local AddRecordID(OSHAIR.layout_OSHAIR_inspection_clean_bip L) := 
	transform
	  self := L;
	end;

	Cleaned_OSHAIR_Inspection_Init := project(Cleaned_OSHAIR_Inspection_Base,
								              AddRecordID(left));

 	ut.MAC_Sequence_Records(Cleaned_OSHAIR_Inspection_Init,
							record_id,
						    Cleaned_OSHAIR_Inspection_Seq);
							
	 

	Business_Header.Layout_Business_Header_New  Translate_Cleaned_OSHAIR_Inspection_To_BHF(Layout_Cleaned_OSHAIR_Inspection_Local l, integer c) := transform
	  self.group1_id         := 0;
	  self.vl_id             := (string34)l.activity_number;
		self.vendor_id         := (qstring34)l.activity_number;
	  self.phone             := 0;
	  self.phone_score       := 0;
	  self.source            := MDR.sourceTools.src_OSHAIR;
	  self.source_group      := (qstring34)l.activity_number; //per Business Header definition 
	  self.company_name      := Stringlib.StringToUpperCase(IF(TRIM(l.inspected_site_name) = '',
	                                                           choose(c, l.inspected_site_name, l.cname),
															   l.inspected_site_name)
															 );
	  self.prim_range        := l.prim_range;
	  self.predir            := l.predir;
	  self.prim_name         := l.prim_name;
	  self.addr_suffix       := l.addr_suffix;
	  self.postdir           := l.postdir;
	  self.unit_desig        := l.unit_desig;
	  self.sec_range         := l.sec_range;
	  self.city              := l.v_city_name;
	  self.state             := l.st;
	  self.zip               := (UNSIGNED3)l.zip5;
	  self.zip4              := (UNSIGNED2)l.zip4;
	  self.county            := l.fips_county;
	  self.geo_lat           := l.geo_lat;
	  self.geo_long          := l.geo_long;
	  self.dt_first_seen     := l.last_activity_date;
	  self.dt_last_seen      := self.dt_first_seen;
	  self.dt_vendor_first_reported := l.dt_vendor_first_reported;
	  self.dt_vendor_last_reported := l.dt_vendor_first_reported;
	  self.fein              := 0;
	  self.current           := true; 
	  SELF := [];
	end;


	From_Cleaned_OSHAIR_Inspection_Norm := normalize(Cleaned_OSHAIR_Inspection_Seq,
										 2,
										 Translate_Cleaned_OSHAIR_Inspection_to_BHF(left, counter));
																					 
	From_Cleaned_OSHAIR_Inspection_Norm_Filter := From_Cleaned_OSHAIR_Inspection_Norm(company_name <> '');

	From_Cleaned_OSHAIR_Inspection_Norm_Dist := distribute(From_Cleaned_OSHAIR_Inspection_Norm_Filter,
									 	                   hash(group1_id,
											                    ut.CleanCompany(company_name)));

	From_Cleaned_OSHAIR_Inspection_Norm_Sort := sort(From_Cleaned_OSHAIR_Inspection_Norm_Dist,
						 	                         group1_id,
										             ut.CleanCompany(company_name),
										             -zip,
										             -state,
										             -city,
										             local);

    Business_Header.Layout_Business_Header_New RollupCleanedOSHAIR_InspectionNorm(Business_Header.Layout_Business_Header_New l, Business_Header.Layout_Business_Header_New r) := transform
	  self := l;
	end;

	From_Cleaned_OSHAIR_Inspection_Norm_Rollup := rollup(From_Cleaned_OSHAIR_Inspection_Norm_Sort,
											             left.group1_id = right.group1_id and
										                 ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
											             ((left.zip        = right.zip and
											               left.prim_name  = right.prim_name and
											               left.prim_range = right.prim_range and
											               left.city       = right.city and
											               left.state      = right.state) or
											              (right.zip        = 0 and
											               right.prim_name  = '' and
											               right.prim_range = '' and
											               right.city       = '' and
												           right.state      = '')),
											               RollupCleanedOSHAIR_InspectionNorm(left, right),
											               local);

	Layout_Group_List := record
	  From_Cleaned_OSHAIR_Inspection_Norm_Rollup.group1_id;
	end;

	Cleaned_OSHAIR_Inspection_Group_List := table(From_Cleaned_OSHAIR_Inspection_Norm_Rollup, Layout_Group_List);

	Layout_Group_Stat := record
	  Cleaned_OSHAIR_Inspection_Group_List.group1_id;
	  cnt := count(group);
	end;

	Cleaned_OSHAIR_Inspection_Group_Stat := table(Cleaned_OSHAIR_Inspection_Group_List, Layout_Group_Stat, group1_id);

 
	Business_Header.Layout_Business_Header_New FormatToBHF(Business_Header.Layout_Business_Header_New L, Layout_Group_Stat R) := transform
	  self.group1_id := R.group1_id;
	  self := L;
	end;

	Cleaned_OSHAIR_Inspection_Group_Clean := join(From_Cleaned_OSHAIR_Inspection_Norm_Rollup,
									              Cleaned_OSHAIR_Inspection_Group_Stat(cnt > 1),
									              left.group1_id = right.group1_id,
									              FormatToBHF(left,right),
									              left outer,
									              lookup);

	Cleaned_OSHAIR_Inspection_Clean_Dist := distribute(Cleaned_OSHAIR_INSPECTION_Group_Clean,
									                   hash(zip,
											                trim(prim_name),
												            trim(prim_range),
											                trim(source_group),
												            trim(company_name)));

	Cleaned_OSHAIR_Inspection_Clean_Sort := sort(Cleaned_OSHAIR_INSPECTION_Clean_Dist,
									             zip,
								                 prim_range,
								                 prim_name,
									             source_group,
									             company_name,
									             if(sec_range <> '', 0, 1),
									             sec_range,
									             if(phone <> 0, 0, 1),
									             phone,
									             if(fein <> 0, 0, 1),
									             fein,
									             dt_vendor_last_reported,
									             dt_vendor_first_reported,
									             dt_last_seen,
									             local);
   
    Business_Header.Layout_Business_Header_New RollupCleanedOSHAIR_Inspection(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := transform
	  self.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
												       ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	  self.dt_last_seen             := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
	  self.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
	  self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported);
	  self.company_name             := if(L.company_name = '',               R.company_name,L.company_name);
	  self.group1_id                := if(L.group1_id = 0,                   R.group1_id,   L.group1_id);
		self.vl_id                    := if(L.vl_id = '',                      R.vl_id,   L.vl_id);
	  self.vendor_id                := if((L.group1_id = 0 and R.group1_id <> 0) or L.vendor_id = '',
																			   R.vendor_id,   L.vendor_id);
	  self.source_group             := if((L.group1_id = 0 and R.group1_id <> 0) or L.source_group = '',
																			   R.source_group,L.source_group);
	  self.phone                    := if(L.phone = 0,                       R.phone,       L.phone);
	  self.phone_score              := if(L.phone = 0,                       R.phone_score, L.phone_score);
	  self.fein                     := if(L.fein = 0,                        R.fein,        L.fein);
	  self.prim_range               := if(l.prim_range = ''  and l.zip4 = 0, r.prim_range,  l.prim_range);
	  self.predir                   := if(l.predir = ''      and l.zip4 = 0, r.predir,      l.predir);
	  self.prim_name                := if(l.prim_name = ''   and l.zip4 = 0, r.prim_name,   l.prim_name);
	  self.addr_suffix              := if(l.addr_suffix = '' and l.zip4 = 0, r.addr_suffix, l.addr_suffix);
	  self.postdir                  := if(l.postdir = ''     and l.zip4 = 0, r.postdir,     l.postdir);
	  self.unit_desig               := if(l.unit_desig = ''  and l.zip4 = 0, r.unit_desig,  l.unit_desig);
	  self.sec_range                := if(l.sec_range = ''   and l.zip4 = 0, r.sec_range,   l.sec_range);
	  self.city                     := if(l.city = ''        and l.zip4 = 0, r.city,        l.city);
	  self.state                    := if(l.state = ''       and l.zip4 = 0, r.state,       l.state);
	  self.zip                      := if(l.zip = 0          and l.zip4 = 0, r.zip,         l.zip);
	  self.zip4                     := if(l.zip4 = 0,                        r.zip4,        l.zip4);
	  self.county                   := if(l.county = ''      and l.zip4 = 0, r.county,      l.county);
	  self.msa                      := if(l.msa = ''         and l.zip4 = 0, r.msa,         l.msa);
	  self.geo_lat                  := if(l.geo_lat = ''     and l.zip4 = 0, r.geo_lat,     l.geo_lat);
	  self.geo_long                 := if(l.geo_long = ''    and l.zip4 = 0, r.geo_long,    l.geo_long);
	  self := L;
	end;

	Cleaned_OSHAIR_Inspection_Clean_Rollup := rollup(Cleaned_OSHAIR_Inspection_Clean_Sort,
										 left.zip          = right.zip          and
										 left.prim_name    = right.prim_name    and
										 left.prim_range   = right.prim_range   and
									     left.source_group = right.source_group and
										 left.company_name = right.company_name and
									     (right.sec_range = '' or left.sec_range = right.sec_range) and
									     (right.phone     = 0  or left.phone     = right.phone)     and
										 (right.fein      = 0  or left.fein      = right.fein),
									     RollupCleanedOSHAIR_Inspection(left, right),
									     local);

	return Cleaned_OSHAIR_Inspection_Clean_Rollup;  


 end;