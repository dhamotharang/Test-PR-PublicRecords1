import ut, Business_Header,mdr; 

Layout_outf := AMIDIR.Layout_AMIDIR_Base_BIP;

export fAMIDIR_As_Business_Header(dataset(Layout_outf) pAMIDIR)
 :=
  function

	Cleaned_AMIDIR_Base := pAMIDIR;

	Layout_Cleaned_AMIDIR_Local := record
	  unsigned6 record_id := 0;
		recordof(File_AMIDIR_DID_SSN_BDID);
	end;

	Layout_Cleaned_AMIDIR_Local AddRecordID(Cleaned_AMIDIR_Base L) := transform
	  self := L;
	end;

	Cleaned_AMIDIR_Init := project(Cleaned_AMIDIR_Base, AddRecordID(left));

	ut.MAC_Sequence_Records(Cleaned_AMIDIR_Init,
							record_id,
										Cleaned_AMIDIR_Seq);
													

	Business_Header.Layout_Business_Header_New  Translate_Cleaned_AMIDIR_To_BHF(Layout_Cleaned_AMIDIR_Local l) := transform
	  self.vl_id             := l.Key;
		self.group1_id         := l.record_id;
	  self.vendor_id         := l.Key;
		self.bdid							 := (unsigned6)l.bdid;
	  self.phone             := (unsigned6)l.Business_Phone;
	  self.phone_score       := if((l.Business_Phone) <> '', 1, 0);
	  self.source            := MDR.sourceTools.src_AMIDIR;
	  self.source_group      := l.Key;
	  self.company_name      := l.Business_Name;
	  self.prim_range        := l.Business_Address_Clean_prim_range;
	  self.predir            := l.Business_Address_Clean_predir;
	  self.prim_name         := l.Business_Address_Clean_prim_name;
	  self.addr_suffix       := l.Business_Address_Clean_addr_suffix;
	  self.postdir           := l.Business_Address_Clean_postdir;
	  self.unit_desig        := l.Business_Address_Clean_unit_desig;
	  self.sec_range         := l.Business_Address_Clean_sec_range;
	  self.city              := l.Business_Address_Clean_v_city_name;
	  self.state             := l.Business_Address_Clean_st;
	  self.zip               := (UNSIGNED3)l.Business_Address_Clean_zip;
	  self.zip4              := (UNSIGNED2)l.Business_Address_Clean_zip4;
	  self.county            := l.Business_Address_Clean_fipscounty;
	  self.msa               := l.Business_Address_Clean_msa;
	  self.geo_lat           := l.Business_Address_Clean_geo_lat;
	  self.geo_long          := l.Business_Address_Clean_geo_long;  
		self.dt_first_seen     := (unsigned4)l.Date_First_Seen;																								   
	  self.dt_last_seen      := (unsigned4)l.Date_Last_Seen;																								  
	  self.dt_vendor_first_reported := (unsigned4)l.Date_Vendor_First_Reported;
	  self.dt_vendor_last_reported  := (unsigned4)l.Date_Vendor_Last_Reported;
	  self.fein              := 0;
	  self.current           := true;
	end;

	File_Cleaned_AMIDIR := project(Cleaned_AMIDIR_Seq,Translate_Cleaned_AMIDIR_to_BHF(left));
																					 
	File_Cleaned_AMIDIR_Filter := File_Cleaned_AMIDIR(company_name <> '');


	File_Cleaned_AMIDIR_Dist := distribute(File_Cleaned_AMIDIR_Filter,
										   hash(group1_id, ut.CleanCompany(company_name)));

	File_Cleaned_AMIDIR_Sort := sort(File_Cleaned_AMIDIR_Dist,
																	 group1_id,
																 ut.CleanCompany(company_name),
																	 -zip,
																	 -state,
																	 -city,
																	 local);

	Business_Header.Layout_Business_Header_New RollupCleanedAMIDIRNorm(Business_Header.Layout_Business_Header_New l, Business_Header.Layout_Business_Header_New r) := transform
	  self := l;
	end;

	File_Cleaned_AMIDIR_Rollup := rollup(File_Cleaned_AMIDIR_Sort,
																			 left.group1_id = right.group1_id and
																			 ut.CleanCompany(left.company_name) = ut.CleanCompany(right.company_name) and
																			 ((left.zip       = right.zip and
																			 left.prim_name   = right.prim_name and
																			 left.prim_range  = right.prim_range and
																			 left.city        = right.city and
																			 left.state       = right.state) 
																			 or
																			 (right.zip       = 0 and
																			 right.prim_name  = '' and
																			 right.prim_range = '' and
																			 right.city       = '' and
																			 right.state      = '')),
																			 RollupCleanedAMIDIRNorm(left, right),
																			 local);

	/*
	Layout_Group_List := record
	  File_Cleaned_AMIDIR_Rollup.group1_id;
	end;

	Cleaned_AMIDIR_Group_List := table(File_Cleaned_AMIDIR_Rollup, Layout_Group_List);

	Layout_Group_Stat := record
	  Cleaned_AMIDIR_Group_List.group1_id;
	  cnt := count(group);
	end;

	Cleaned_AMIDIR_Group_Stat := table(Cleaned_AMIDIR_Group_List, Layout_Group_Stat, group1_id);

	Business_Header.Layout_Business_Header FormatToBHF(Business_Header.Layout_Business_Header L, Layout_Group_Stat R) := transform
	  self.group1_id := R.group1_id;
	  self := L;
	end;

	Cleaned_AMIDIR_Group_Clean := join(File_Cleaned_AMIDIR_Rollup,
									   Cleaned_AMIDIR_Group_Stat(cnt > 1),
														 left.group1_id = right.group1_id,
														 FormatToBHF(left,right),
														 left outer,
														 lookup);
	Cleaned_AMIDIR_Clean_Dist := distribute(Cleaned_AMIDIR_Group_Clean,
	*/

	Cleaned_AMIDIR_Clean_Dist := distribute(File_Cleaned_AMIDIR_Rollup,
											hash(zip,
																	 trim(prim_name),
																		 trim(prim_range),
																		 trim(source_group),
																		 trim(company_name)));

	Cleaned_AMIDIR_Clean_Sort := sort(Cleaned_AMIDIR_Clean_Dist,
									  zip,
														prim_range,
														prim_name,
														source_group,
														company_name,
									  if(sec_range <> '', 0, 1),sec_range,
									  if(phone <> 0, 0, 1),phone,
									  if(fein <> 0, 0, 1),fein,
									  dt_vendor_last_reported,
														dt_vendor_first_reported,
														dt_last_seen,
														local);

	//Final Rollup
	Business_Header.Layout_Business_Header_New RollupCleanedAMIDIR(Business_Header.Layout_Business_Header_New L, Business_Header.Layout_Business_Header_New R) := transform
	  self.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
														 ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
		self.dt_last_seen             := max(L.dt_last_seen,R.dt_last_seen);
	  self.dt_vendor_last_reported  := max(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
	  self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported);
	  self.company_name             := if(L.company_name = '',               R.company_name,L.company_name);
	  self.group1_id                := if(L.group1_id = 0,                   R.group1_id,   L.group1_id);
		self.vl_id                    := if(L.vl_id = '',  R.vl_id,   L.vl_id);
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

	Cleaned_AMIDIR_Clean_Rollup := rollup(Cleaned_AMIDIR_Clean_Sort,
											 left.zip          = right.zip          and
											 left.prim_name    = right.prim_name    and
											 left.prim_range   = right.prim_range   and
									   left.source_group = right.source_group and
											 left.company_name = right.company_name and
											 (right.sec_range = '' or left.sec_range = right.sec_range) and
									   (right.phone     = 0  or left.phone     = right.phone)     and
											 (right.fein      = 0  or left.fein      = right.fein),
									   RollupCleanedAMIDIR(left, right),
									   local);

	return Cleaned_AMIDIR_Clean_Rollup;
  end
 ;
