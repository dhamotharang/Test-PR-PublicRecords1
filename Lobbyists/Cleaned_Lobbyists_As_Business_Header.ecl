import Business_Header;
import ut;

Layout_Cleaned_Lobbyists_Base := Layout_Lobbyists_Common;

Layout_Cleaned_Lobbyists_Local := record
  unsigned6 record_id := 0;
	Layout_Cleaned_Lobbyists_Base;
end;

Cleaned_Lobbyists_Base := Cleaned_Lobbyists;

Layout_Cleaned_Lobbyists_Local AddRecordID(Layout_Cleaned_Lobbyists_Base L) := transform
  self := L;
end;

Cleaned_Lobbyists_Init := project(Cleaned_Lobbyists_Base,
                                  AddRecordID(left));

ut.MAC_Sequence_Records(Cleaned_Lobbyists_Init,
                        record_id,
						            Cleaned_Lobbyists_Seq);

Business_Header.Layout_Business_Header  Translate_Cleaned_Lobbyists_To_BHF(Layout_Cleaned_Lobbyists_Local l, integer c) := transform
  self.group1_id         := L.record_id;
  self.vendor_id         := l.Key;
  self.phone             := (unsigned6)choose(c, l.Firm_Phone, l.Association_Phone);
  self.phone_score       := if(choose(c, l.Firm_Phone, l.Association_Phone) <> '', 1, 0);
  self.source            := 'LB';
  self.source_group      := l.Key;
  self.company_name      := Stringlib.StringToUpperCase(choose(c, l.Firm_Name_Full, l.Association_Name_Full));
  self.prim_range        := choose(c, l.Firm_Address_Clean_prim_range,      l.Association_Address_Clean_prim_range);
  self.predir            := choose(c, l.Firm_Address_Clean_predir,          l.Association_Address_Clean_predir);
  self.prim_name         := choose(c, l.Firm_Address_Clean_prim_name,       l.Association_Address_Clean_prim_name);
  self.addr_suffix       := choose(c, l.Firm_Address_Clean_addr_suffix,     l.Association_Address_Clean_addr_suffix);
  self.postdir           := choose(c, l.Firm_Address_Clean_postdir,         l.Association_Address_Clean_postdir);
  self.unit_desig        := choose(c, l.Firm_Address_Clean_unit_desig,      l.Association_Address_Clean_unit_desig);
  self.sec_range         := choose(c, l.Firm_Address_Clean_sec_range,       l.Association_Address_Clean_sec_range);
  self.city              := choose(c, l.Firm_Address_Clean_p_city_name,     l.Association_Address_Clean_p_city_name);
  self.state             := choose(c, l.Firm_Address_Clean_st,              l.Association_Address_Clean_st);
  self.zip               := choose(c, (UNSIGNED3)l.Firm_Address_Clean_zip,  (UNSIGNED3)l.Association_Address_Clean_zip);
  self.zip4              := choose(c, (UNSIGNED2)l.Firm_Address_Clean_zip4, (UNSIGNED2)l.Association_Address_Clean_zip4);
  self.county            := choose(c, l.Firm_Address_Clean_fipscounty,      l.Association_Address_Clean_fipscounty);
  self.msa               := choose(c, l.Firm_Address_Clean_msa,             l.Association_Address_Clean_msa);
  self.geo_lat           := choose(c, l.Firm_Address_Clean_geo_lat,         l.Association_Address_Clean_geo_lat);
  self.geo_long          := choose(c, l.Firm_Address_Clean_geo_long,        l.Association_Address_Clean_geo_long);
  self.dt_first_seen     := (unsigned6)if(l.Lobby_Registration_Date = '',
	                          				      if(l.Lobby_Termination_Date = '',
															    				   if(l.Lobby_Legislative_Year_Start = '',
																	   				    if(l.Lobby_Legislative_Year_End = '',
																		    				   l.Process_Date,
																								   l.Lobby_Legislative_Year_End + '1231'),
																		 				    l.Lobby_Legislative_Year_Start + '0101'),
																					   l.Lobby_Termination_Date),
															 				    l.Lobby_Registration_Date);
  self.dt_last_seen      := (unsigned6)if(l.Lobby_Termination_Date = '',
	                             				    if(l.Lobby_Registration_Date = '',
															    				   if(l.Lobby_Legislative_Year_End = '',
																	   				    if(l.Lobby_Legislative_Year_Start = '',
																		    				   l.Process_Date,
																								   l.Lobby_Legislative_Year_Start + '0101'),
																		 				    l.Lobby_Legislative_Year_End + '1231'),
																					   l.Lobby_Registration_Date),
															 				    l.Lobby_Termination_Date);
  self.dt_vendor_first_reported := (unsigned6)l.Process_Date;
  self.dt_vendor_last_reported := (unsigned6)l.Process_Date;
  self.fein              := 0;
  self.current           := true;
end;

From_Cleaned_Lobbyists_Norm := normalize(Cleaned_Lobbyists_Seq,
                                         2,
										                     Translate_Cleaned_Lobbyists_to_BHF(left, counter));
																				 
From_Cleaned_Lobbyists_Norm_Filter := From_Cleaned_Lobbyists_Norm(company_name <> '');

From_Cleaned_Lobbyists_Norm_Dist := distribute(From_Cleaned_Lobbyists_Norm_Filter,
                                               hash(group1_id,
											                         ut.CleanCompany(company_name)));

From_Cleaned_Lobbyists_Norm_Sort := sort(From_Cleaned_Lobbyists_Norm_Dist,
                                         group1_id,
										                     ut.CleanCompany(company_name),
										                     -zip,
										                     -state,
										                     -city,
										                     local);

Business_Header.Layout_Business_Header RollupCleanedLobbyistsNorm(Business_Header.Layout_Business_Header l, Business_Header.Layout_Business_Header r) := transform
  self := l;
end;

From_Cleaned_Lobbyists_Norm_Rollup := rollup(From_Cleaned_Lobbyists_Norm_Sort,
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
							                               RollupCleanedLobbyistsNorm(left, right),
							                               local);

Layout_Group_List := record
  From_Cleaned_Lobbyists_Norm_Rollup.group1_id;
end;

Cleaned_Lobbyists_Group_List := table(From_Cleaned_Lobbyists_Norm_Rollup, Layout_Group_List);

Layout_Group_Stat := record
  Cleaned_Lobbyists_Group_List.group1_id;
  cnt := count(group);
end;

Cleaned_Lobbyists_Group_Stat := table(Cleaned_Lobbyists_Group_List, Layout_Group_Stat, group1_id);

Business_Header.Layout_Business_Header FormatToBHF(Business_Header.Layout_Business_Header L, Layout_Group_Stat R) := transform
  self.group1_id := R.group1_id;
  self := L;
end;

Cleaned_Lobbyists_Group_Clean := join(From_Cleaned_Lobbyists_Norm_Rollup,
                                      Cleaned_Lobbyists_Group_Stat(cnt > 1),
									                    left.group1_id = right.group1_id,
									                    FormatToBHF(left,right),
									                    left outer,
									                    lookup);

Cleaned_Lobbyists_Clean_Dist := distribute(Cleaned_Lobbyists_Group_Clean,
                                           hash(zip,
										                            trim(prim_name),
												                        trim(prim_range),
												                        trim(source_group),
												                        trim(company_name)));

Cleaned_Lobbyists_Clean_Sort := sort(Cleaned_Lobbyists_Clean_Dist,
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

Business_Header.Layout_Business_Header RollupCleanedLobbyists(Business_Header.Layout_Business_Header L, Business_Header.Layout_Business_Header R) := transform
  self.dt_first_seen            := ut.EarliestDate(ut.EarliestDate(L.dt_first_seen,R.dt_first_seen),
	                                                 ut.EarliestDate(L.dt_last_seen,R.dt_last_seen));
	self.dt_last_seen             := ut.LatestDate(L.dt_last_seen,R.dt_last_seen);
  self.dt_vendor_last_reported  := ut.LatestDate(L.dt_vendor_last_reported,R.dt_vendor_last_reported);
  self.dt_vendor_first_reported := ut.EarliestDate(L.dt_vendor_first_reported,R.dt_vendor_first_reported);
  self.company_name             := if(L.company_name = '',               R.company_name,L.company_name);
  self.group1_id                := if(L.group1_id = 0,                   R.group1_id,   L.group1_id);
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

Cleaned_Lobbyists_Clean_Rollup := rollup(Cleaned_Lobbyists_Clean_Sort,
			                             left.zip          = right.zip          and
			                             left.prim_name    = right.prim_name    and
			                             left.prim_range   = right.prim_range   and
                                   left.source_group = right.source_group and
			                             left.company_name = right.company_name and
			                             (right.sec_range = '' or left.sec_range = right.sec_range) and
                                   (right.phone     = 0  or left.phone     = right.phone)     and
			                             (right.fein      = 0  or left.fein      = right.fein),
                                   RollupCleanedLobbyists(left, right),
                                   local);

export Cleaned_Lobbyists_As_Business_Header := Cleaned_Lobbyists_Clean_Rollup : persist('TEMP::Cleaned_Lobbyists_As_Business_Header');