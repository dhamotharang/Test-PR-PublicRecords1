IMPORT Business_Header, ut;

Layout_Cleaned_Lobbyists_Base := Layout_Lobbyists_Common;

Cleaned_Lobbyists_Base := Cleaned_Lobbyists;

Business_Header.Layout_Business_Contact_Full Translate_RA_To_BCF(Layout_Cleaned_Lobbyists_Base l, unsigned1 c) := transform
  self.source           := 'LB';
  self.vendor_id        := l.Key;
  self.dt_first_seen    := (unsigned6)if(l.Lobby_Registration_Date = '',
	                          				     if(l.Lobby_Termination_Date = '',
															    				  if(l.Lobby_Legislative_Year_Start = '',
																	   				   if(l.Lobby_Legislative_Year_End = '',
																		    				  l.Process_Date,
																								  l.Lobby_Legislative_Year_End + '1231'),
																		 				   l.Lobby_Legislative_Year_Start + '0101'),
																					  l.Lobby_Termination_Date),
															 				   l.Lobby_Registration_Date);
  self.dt_last_seen     := (unsigned6)if(l.Lobby_Termination_Date = '',
	                             				   if(l.Lobby_Registration_Date = '',
															    				  if(l.Lobby_Legislative_Year_End = '',
																	   				   if(l.Lobby_Legislative_Year_Start = '',
																		    				  l.Process_Date,
																								  l.Lobby_Legislative_Year_Start + '0101'),
																		 				   l.Lobby_Legislative_Year_End + '1231'),
																					  l.Lobby_Registration_Date),
															 				   l.Lobby_Termination_Date);
  self.title            := choose(c,
	                                l.Lobbyist_Name_Clean_title,
	                                l.Lobbyist_Name_Clean_title,
																	l.Association_Contact_Name_Clean_title);
  self.fname            := choose(c,
	                                l.Lobbyist_Name_Clean_fname,
	                                l.Lobbyist_Name_Clean_fname,
																	l.Association_Contact_Name_Clean_fname);
  self.mname            := choose(c,
	                                l.Lobbyist_Name_Clean_mname,
																	l.Lobbyist_Name_Clean_mname,
																	l.Association_Contact_Name_Clean_mname);
  self.lname            := choose(c,
	                                l.Lobbyist_Name_Clean_lname,
																	l.Lobbyist_Name_Clean_lname,
																	l.Association_Contact_Name_Clean_lname);
  self.name_suffix      := choose(c,
	                                l.Lobbyist_Name_Clean_name_suffix,
																	l.Lobbyist_Name_Clean_name_suffix,
																	l.Association_Contact_Name_Clean_name_suffix);
  self.name_score       := choose(c,
	                                Business_Header.CleanName(l.Lobbyist_Name_Clean_fname,
																	                          l.Lobbyist_Name_Clean_mname,
																														l.Lobbyist_Name_Clean_lname,
																														l.Lobbyist_Name_Clean_name_suffix)[142],
	                                Business_Header.CleanName(l.Lobbyist_Name_Clean_fname,
																	                          l.Lobbyist_Name_Clean_mname,
																														l.Lobbyist_Name_Clean_lname,
																														l.Lobbyist_Name_Clean_name_suffix)[142],
                                  Business_Header.CleanName(l.Association_Contact_Name_Clean_fname,
																	                          l.Association_Contact_Name_Clean_mname,
																														l.Association_Contact_Name_Clean_lname,
																														l.Association_Contact_Name_Clean_name_suffix)[142]);
  self.email_address    := choose(c,
	                                l.Lobbyist_Email,
																	l.Lobbyist_Email,
																	'');
  self.prim_range       := choose(c,
	                                l.Lobbyist_Address_Clean_prim_range,
																	l.Lobbyist_Address_Clean_prim_range,
																	l.Association_Address_Clean_prim_range);
  self.predir           := choose(c,
	                                l.Lobbyist_Address_Clean_predir,
																	l.Lobbyist_Address_Clean_predir,
																	l.Association_Address_Clean_predir);
  self.prim_name        := choose(c,
	                                l.Lobbyist_Address_Clean_prim_name,
																	l.Lobbyist_Address_Clean_prim_name,
																	l.Association_Address_Clean_prim_name);
  self.addr_suffix      := choose(c,
	                                l.Lobbyist_Address_Clean_addr_suffix,
																	l.Lobbyist_Address_Clean_addr_suffix,
																	l.Association_Address_Clean_addr_suffix);
  self.postdir          := choose(c,
	                                l.Lobbyist_Address_Clean_postdir,
																	l.Lobbyist_Address_Clean_postdir,
																	l.Association_Address_Clean_postdir);
  self.unit_desig       := choose(c,
	                                l.Lobbyist_Address_Clean_unit_desig,
																	l.Lobbyist_Address_Clean_unit_desig,
																	l.Association_Address_Clean_unit_desig);
  self.sec_range        := choose(c,
	                                l.Lobbyist_Address_Clean_sec_range,
																	l.Lobbyist_Address_Clean_sec_range,
																	l.Association_Address_Clean_sec_range);
  self.city             := choose(c,
	                                l.Lobbyist_Address_Clean_p_city_name,
																	l.Lobbyist_Address_Clean_p_city_name,
																	l.Association_Address_Clean_p_city_name);
  self.state            := choose(c,
	                                l.Lobbyist_Address_Clean_st,
																	l.Lobbyist_Address_Clean_st,
																	l.Association_Address_Clean_st);
  self.zip              := (unsigned3)choose(c,
	                                           l.Lobbyist_Address_Clean_zip,
																						 l.Lobbyist_Address_Clean_zip,
																						 l.Association_Address_Clean_zip);
  self.zip4             := (unsigned3)choose(c,
	                                           l.Lobbyist_Address_Clean_zip4,
																						 l.Lobbyist_Address_Clean_zip4,
																						 l.Association_Address_Clean_zip4);
  self.county           := choose(c,
	                                l.Lobbyist_Address_Clean_fipscounty,
																	l.Lobbyist_Address_Clean_fipscounty,
																	l.Association_Address_Clean_fipscounty);
  self.msa              := choose(c,
	                                l.Lobbyist_Address_Clean_msa,
																	l.Lobbyist_Address_Clean_msa,
																	l.Association_Address_Clean_msa);
  self.geo_lat          := choose(c,
	                                l.Lobbyist_Address_Clean_geo_lat,
																	l.Lobbyist_Address_Clean_geo_lat,
																	l.Association_Address_Clean_geo_lat);
  self.geo_long         := choose(c,
	                                l.Lobbyist_Address_Clean_geo_long,
																	l.Lobbyist_Address_Clean_geo_long,
																	l.Association_Address_Clean_geo_long);
  self.phone            := (unsigned6)choose(c,
	                                           l.Lobbyist_Phone,
																	           l.Lobbyist_Phone,
																	           l.Association_Phone);
  self.ssn              := 0;
  self.company_title        := choose(c,
	                                    'LOBBYIST',
																	    'FIRM MEMBER',
																	    'CONTACT');
  self.company_name         := choose(c,
	                                    l.Association_Name_Full,
																			l.Firm_Name_Full,
																			l.Association_Name_Full);
  self.company_source_group := l.Key;
  self.company_prim_range   := choose(c,
	                                    l.Association_Address_Clean_prim_range,
	                                    l.Firm_Address_Clean_prim_range,
	                                    l.Association_Address_Clean_prim_range);
  self.company_predir       := choose(c,
	                                    l.Association_Address_Clean_predir,
	                                    l.Firm_Address_Clean_predir,
	                                    l.Association_Address_Clean_predir);
  self.company_prim_name    := choose(c,
	                                    l.Association_Address_Clean_prim_name,
	                                    l.Firm_Address_Clean_prim_name,
	                                    l.Association_Address_Clean_prim_name);
  self.company_addr_suffix  := choose(c,
	                                    l.Association_Address_Clean_addr_suffix,
	                                    l.Firm_Address_Clean_addr_suffix,
	                                    l.Association_Address_Clean_addr_suffix);
  self.company_postdir      := choose(c,
	                                    l.Association_Address_Clean_postdir,
	                                    l.Firm_Address_Clean_postdir,
	                                    l.Association_Address_Clean_postdir);
  self.company_unit_desig   := choose(c,
	                                    l.Association_Address_Clean_unit_desig,
	                                    l.Firm_Address_Clean_unit_desig,
	                                    l.Association_Address_Clean_unit_desig);
  self.company_sec_range    := choose(c,
	                                    l.Association_Address_Clean_sec_range,
	                                    l.Firm_Address_Clean_sec_range,
	                                    l.Association_Address_Clean_sec_range);
  self.company_city         := choose(c,
	                                    l.Association_Address_Clean_p_city_name,
	                                    l.Firm_Address_Clean_p_city_name,
	                                    l.Association_Address_Clean_p_city_name);
  self.company_state        := choose(c,
	                                    l.Association_Address_Clean_st,
	                                    l.Firm_Address_Clean_st,
	                                    l.Association_Address_Clean_st);
  self.company_zip          := (unsigned3)choose(c,
	                                               l.Association_Address_Clean_zip,
	                                               l.Firm_Address_Clean_zip,
	                                               l.Association_Address_Clean_zip);
  self.company_zip4         := (unsigned2)choose(c,
	                                               l.Association_Address_Clean_zip4,
	                                               l.Firm_Address_Clean_zip4,
	                                               l.Association_Address_Clean_zip4);
  self.company_phone        := (unsigned6)choose(c,
	                                               l.Association_Phone,
	                                               l.Firm_Phone,
	                                               l.Association_Phone);
  self.company_fein         := 0;
  self.record_type          := 'C';
  self                      := l;
end;

Cleaned_Lobbyists_Contact_Ra_Norm := normalize(Cleaned_Lobbyists_Base,
                                               3,
																							 Translate_RA_To_BCF(left, counter));

Cleaned_Lobbyists_Contact_Ra_Init := Cleaned_Lobbyists_Contact_Ra_Norm(lname <> '', company_name <> '');

export Cleaned_Lobbyists_As_Business_Contact := Cleaned_Lobbyists_Contact_Ra_Init((integer)name_score < 3,
                                                                                  Business_Header.CheckPersonName(fname,
																																									                                mname,
																																																									lname,
																																																									name_suffix)) : persist('TEMP::Cleaned_Lobbyists_Contacts_As_BC');