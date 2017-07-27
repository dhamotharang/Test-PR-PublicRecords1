import AutoStandardI, liensv2_services
, uccv2_services, FAB_Statewide, corp2_services
,CALBUS_Services,LN_PropertyV2_Services,WatercraftV2_Services
,VehicleV2_Services, doxie,VehicleV2, targus,BankruptcyV2_Services
,marriage_divorce_v2_Services,FBNV2_services,TXBUSV2_Services
,bankruptcyv3,doxie,iesp, doxie_crs;


	export PenaltyI := MODULE

			shared gm := AutoStandardI.GlobalModule();
			
			shared temp_mod_one := module(project(gm,AutoStandardI.LIBIN.PenaltyI.base,opt))
			end;
			shared temp_mod_two := module(project(temp_mod_one,AutoStandardI.LIBIN.PenaltyI.base,opt))
				export firstname := gm.entity2_firstname;
				export middlename := gm.entity2_middlename;
				export lastname := gm.entity2_lastname;
				export unparsedfullname := gm.entity2_unparsedfullname;
				export allownicknames := gm.entity2_allownicknames;
				export phoneticmatch := gm.entity2_phoneticmatch;
				export companyname := gm.entity2_companyname;
				export addr := gm.entity2_addr;
				export city := gm.entity2_city;
				export state := gm.entity2_state;
				export zip := gm.entity2_zip;
				export zipradius := gm.entity2_zipradius;
				export phone := gm.entity2_phone;
				export fein := gm.entity2_fein;
				export bdid := gm.entity2_bdid;
				export did := gm.entity2_did;
				export ssn := gm.entity2_ssn;
			end;
			shared boolean TwoPartySearch := FALSE : stored('TwoPartySearch');

			shared string120 cname_val := '' : stored('CompanyName');
			shared string30 lname_val := '' : STORED('LastName');
			shared boolean XNOR_CNAME_LNAME := IF((cname_val='' AND LNAME_val='')OR(cname_val <>'' AND LNAME_val<>''),TRUE,FALSE);
			shared boolean IsCName := IF(cname_val <>'',TRUE,FALSE);

	    //**** LIENS Penatly
			export Lien_PP_rec := RECORD
					 string120 orig_name;
					 liensv2_services.layout_lien_party_parsed;
					 DATASET(liensv2_services.layout_lien_party_address) addresses;
			END;								
			export Lien_PP1_rec := RECORD
					 liensv2_services.layout_lien_party_parsed;
					 liensv2_services.layout_lien_party_address;
			END;
			shared phone_rec := RECORD
					 dataset(liensv2_services.layout_lien_party_phone) phones;
			END;
			export Lien_PP2_rec := RECORD
					 unsigned2 penalt;
					 liensv2_services.layout_lien_party_parsed;
					 liensv2_services.layout_lien_party_address - phone_rec;
					 liensv2_services.layout_lien_party_phone;
			END;


			Export get_lienparty_info(DATASET(liensv2_services.layout_lien_party) l) := FUNCTION
										Lien_PP_rec xfm_parties(liensv2_services.layout_lien_party L ,integer c) := TRANSFORM
												pp := PROJECT(L.parsed_parties,liensv2_services.layout_lien_party_parsed);
												SELF.orig_name := L.orig_name;
												SELF := pp[c];
												SELF := L;
												SELF := [];
										END;
										
							parties1:= NORMALIZE(l,count(LEFT.parsed_parties),xfm_parties(LEFT,counter));
							Lien_PP1_rec xfm_parties1(recordof(lien_PP_rec) pp, integer c) := TRANSFORM
							        R := PROJECT(pp.addresses,liensv2_services.layout_lien_party_address);
												SELF :=R[c];
												SELF := pp;
												SELF := [];
										END;
							//FORCE thru normalize at least 1 time if count=0			
							parties2:= NORMALIZE(parties1,MAX(count(LEFT.addresses),1),xfm_parties1(LEFT,counter));
							
							Lien_PP2_rec xfm_parties2(recordof(lien_PP1_rec) pp, integer c) := TRANSFORM
							        R := PROJECT(pp.phones,liensv2_services.layout_lien_party_phone);
									temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := FUNCTION
											tempmodbizname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
													export string cname_field := pp.cname;
											end;
											tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
													export boolean allow_wildcard := false;
													export string fname_field := pp.fname;
													export string lname_field := pp.lname;
													export string mname_field := pp.mname;
											end;
											tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
													export boolean allow_wildcard := false;
													export string city_field := pp.v_city_name;
													export string city2_field := '';
													export string pname_field := pp.prim_name;
													export string postdir_field := pp.postdir;
													export string prange_field := pp.prim_range;
													export string predir_field := pp.predir;
													export string state_field := pp.st;
													export string suffix_field := pp.addr_suffix;
													export string zip_field := pp.zip;
												end;	
											tempmodssn := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
													export string ssn_field := pp.ssn;
											end;	
											tempmodphone := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
													export string phone_field := R[c].phone;
											end;
											return AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
													 + AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
													 + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
													 + AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn)
													 + AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
									end;
												penalty1 := temppenalty(temp_mod_one);
												penalty2 := temppenalty(temp_mod_two);
												
												SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
												SELF :=R[c];
												SELF := pp;
												SELF := [];
							END;
							//FORCE thru normalize at least 1 time if count=0			
							parties3:= NORMALIZE(parties2,MAX(count(LEFT.phones),1),xfm_parties2(LEFT,counter));
							parties4 := parties3(cname<>''or lname<>'' or st <>'');
							parties_s := SORT(parties4,penalt,-did,-bdid,-lname,-cname,record);
							out := CHOOSEN(parties_s,1);
							RETURN out;
			END;

      //**** UCC Penatly
			export UCC_PP_rec := RECORD
					 unsigned2 penalt;
					 uccv2_services.layout_ucc_party_raw.orig_name;
					 uccv2_services.layout_ucc_party_parsed_src;
					 DATASET(uccv2_services.layout_ucc_party_address_src) addresses;
			END;								
			export UCC_PP1_rec := RECORD
					 unsigned2 penalt;
					 uccv2_services.layout_ucc_party_raw.orig_name;
					 uccv2_services.layout_ucc_party_parsed_src;
					 uccv2_services.layout_ucc_party_address_src;
			END;	
			
			
			Export get_uccparty_info(DATASET(uccv2_services.layout_ucc_party) l) := FUNCTION
							UCC_PP_rec xfm_parties(uccv2_services.layout_ucc_party L, integer c) := TRANSFORM
												pp := PROJECT(L.parsed_parties,uccv2_services.layout_ucc_party_parsed_src);
												SELF.orig_name := L.orig_name;
												SELF := pp[c];
												SELF.addresses := PROJECT(L.addresses,TRANSFORM(uccv2_services.layout_ucc_party_address_src
												                                                ,SELF := LEFT,SELF := []));
												SELF := [];
							END;
										
							parties1:= NORMALIZE(l,count(LEFT.parsed_parties),xfm_parties(LEFT,counter));
			
										UCC_PP1_rec xfm_parties1(UCC_PP_rec L,integer c) := TRANSFORM
												// pp := PROJECT(L.parsed_parties,uccv2_services.layout_ucc_party_parsed);
												R := PROJECT(L.addresses,uccv2_services.layout_ucc_party_address);
										temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := FUNCTION
												tempmodbizname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
													export string cname_field := L.orig_name;
												end;
												tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
													export boolean allow_wildcard := false;
													export string fname_field := L.fname;
													export string lname_field := L.lname;
													export string mname_field := L.mname;
												end;
												tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
													export boolean allow_wildcard := false;
													export string city_field := R[c].v_city_name;
													export string city2_field := '';
													export string pname_field := R[c].prim_name;
													export string postdir_field := R[c].postdir;
													export string prange_field := R[c].prim_range;
													export string predir_field := R[c].predir;
													export string state_field := R[c].st;
													export string suffix_field := R[c].addr_suffix;
													export string zip_field := R[c].zip5;
												end;
											tempmodssn := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
													export string ssn_field := L.ssn;
											end;												 	
											tempmodfein := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
													export string fein_field := L.fein;
											end;
											return AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
													 + AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
													 + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
													 + AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn)
													 + AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodfein);
									end;
												penalty1 := temppenalty(temp_mod_one);
												penalty2 := temppenalty(temp_mod_two);
												
												SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
												SELF :=R[c];
												SELF.orig_name := L.orig_name;
												SELF := L;
												SELF := []
										END;
							parties2:= NORMALIZE(parties1,count(LEFT.addresses),xfm_parties1(LEFT,counter));
							parties3 := parties2(orig_name<>''or lname<>'' or st <>'');							
							parties_s := SORT(parties2,penalt,-did,-bdid,-lname,-orig_name,record);
							out := CHOOSEN(parties_s,1);
							RETURN out;
			END;
			
			//**** CORP Penatly
		  export Corp_PP_rec := RECORD
					 unsigned2 penalt;
           FAB_Statewide.layout_FAB_Statewide_out - penalt ;
			END;	
			
			Export get_CorpCont_info(DATASET(corp2_services.layout_contact_search) l) := FUNCTION
									Corp_PP_rec xfm_parties(corp2_services.layout_contact_search  L, integer c) := TRANSFORM
        								pp:= PROJECT(L.names,Corp2_services.layout_search_names);
												R := PROJECT(L.addresses,Corp2_services.layout_search_addresses);
												temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := function
													tempmodbizname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
														export string cname_field := pp[1].cont_cname;
													end;
													tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
														export boolean allow_wildcard := false;
														export string fname_field := pp[1].cont_fname;
														export string lname_field := pp[1].cont_lname;
														export string mname_field := pp[1].cont_mname;
													end;
													tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
														export boolean allow_wildcard := false;
														export string city_field := R[c].cont_v_city_name;
														export string city2_field := '';
														export string pname_field := R[c].cont_prim_name;
														export string postdir_field := R[c].cont_postdir;
														export string prange_field := R[c].cont_prim_range;
														export string predir_field := R[c].cont_predir;
														export string state_field := R[c].cont_state;
														export string suffix_field := R[c].cont_addr_suffix;
														export string zip_field := R[c].cont_zip5;
													end;
													tempmodphone := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
														export string phone_field := R[c].cont_phone10;
													end;												
													return
														AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
														+	AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
														+	AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr) 
														+ AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
												end;
												
												penalty1 := temppenalty(temp_mod_one);
												penalty2 := temppenalty(temp_mod_two);
												
												SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);

												// SELF.id              := (UNSIGNED6)l.did;
												SELF.id              := (integer)l.did;
												SELF.company_name    := pp[1].cont_cname;
											  SELF.fname           := pp[1].cont_fname;
												SELF.lname           := pp[1].cont_lname;
												SELF.mname           := pp[1].cont_mname;
          							SELF.prim_range      := R[c].cont_prim_range;
												SELF.predir          := R[c].cont_predir;
												SELF.prim_name       := R[c].cont_prim_name;
												SELF.addr_suffix     := R[c].cont_addr_suffix;
												SELF.postdir         := R[c].cont_postdir;
												SELF.unit_desig      := R[c].cont_unit_desig; 
												SELF.sec_range       := R[c].cont_sec_range;
												SELF.v_city_name     := R[c].cont_v_city_name;
												SELF.st              := R[c].cont_state;
												SELF.zip5            := R[c].cont_zip5;
												SELF.zip4            := R[c].cont_zip4;	
												SELF :=R[c];
												SELF := pp[1];
												SELF := []
										END;
							parties1:= NORMALIZE(l,count(LEFT.addresses),xfm_parties(LEFT,counter));
							parties_s := SORT(parties1,penalt,-id,-lname,-company_name,record);
							out := CHOOSEN(parties_s,1);
							RETURN out;
			END;
			Export get_CorpHist_info(DATASET(corp2_services.layout_corp_search) l) := FUNCTION
			            String2 R1 := 'R1';
									String2 R2 := 'R2';
									String2 C  := 'C';
									Corp_PP_rec xfm_parties(corp2_services.layout_corp_search  L, string2 s_type) := TRANSFORM
										temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := module
											export tempmodbizname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
													export string cname_field := MAP( S_type=R1=>l.corp_ra_name
																													 ,S_type=R2=>l.corp_ra_name
													                                 ,S_type=C=>l.corp_legal_name
																													 ,'');
												end;
												export tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
													export boolean allow_wildcard := false;
													export string fname_field := MAP(S_type=R1=>l.corp_ra_fname1
													                                 ,S_type=R2=>l.corp_ra_fname2
																													 ,'');
													export string lname_field := MAP(S_type=R1=>l.corp_ra_lname1
													                                 ,S_type=R2=>l.corp_ra_lname2
																													 ,'');
													export string mname_field := MAP(S_type=R1=>l.corp_ra_mname1
													                                 ,S_type=R2=>l.corp_ra_mname2
																													 ,'');													
												end;
												export tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
													export boolean allow_wildcard := false;
													export string city_field := MAP(s_type=C=>l.corp_addr1_v_city_name
													                                ,l.corp_ra_v_city_name);
													export string city2_field := '';
													export string prange_field := MAP(s_type=C=>l.corp_addr1_prim_range
													                                  ,l.corp_ra_prim_range);
													export string postdir_field := MAP(s_type=C=>l.corp_addr1_postdir
																														 ,l.corp_ra_postdir);			
													export string pname_field := MAP(s_type=C=>l.corp_addr1_prim_name
													                                 ,l.corp_ra_prim_name);
													export string predir_field := MAP(s_type=C=>l.corp_addr1_predir
													                                  ,l.corp_ra_predir);
													export string state_field := MAP(s_type=C=>l.corp_addr1_state
																													 ,l.corp_ra_state);
													export string suffix_field := MAP(s_type=C=>l.corp_addr1_addr_suffix
													                                  ,l.corp_ra_addr_suffix);
													export string zip_field := MAP(s_type=C=>l.corp_addr1_zip5
													                               ,l.corp_ra_zip5);
												end;

												export penalt :=
												AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
												+ AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
												+ AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr) ;
											end;
												
												penalty1 := temppenalty(temp_mod_one);
												penalty2 := temppenalty(temp_mod_two);
												
												SELF.penalt := if(TwoPartySearch,min(penalty1.penalt,penalty2.penalt),penalty1.penalt);
												SELF.id              := (integer)l.bdid;
												SELF.company_name    := penalty1.tempmodbizname.cname_field;
											  SELF.fname           := penalty1.tempmodindvname.fname_field;
												SELF.lname           := penalty1.tempmodindvname.lname_field;
												SELF.mname           := penalty1.tempmodindvname.mname_field;
          							SELF.prim_range      := penalty1.tempmodaddr.prange_field;
												SELF.predir          := penalty1.tempmodaddr.predir_field;
												SELF.prim_name       := penalty1.tempmodaddr.pname_field;
												SELF.addr_suffix     := penalty1.tempmodaddr.suffix_field;
												SELF.postdir         := penalty1.tempmodaddr.postdir_field;
												SELF.unit_desig      := MAP(s_type=C=>l.corp_addr1_unit_desig
													                          ,l.corp_ra_unit_desig); 
												SELF.sec_range       := MAP(s_type=C=>l.corp_addr1_sec_range
													                          ,l.corp_ra_sec_range);
												SELF.v_city_name     := penalty1.tempmodaddr.city_field;
												SELF.st              := penalty1.tempmodaddr.state_field;
												SELF.zip5            := penalty1.tempmodaddr.zip_field;
												SELF.zip4            := MAP(s_type=C=>l.corp_ra_zip4
													                          ,l.corp_ra_zip4);	
												SELF := []
										END;
							parties1:= PROJECT(l,xfm_parties(LEFT,'C'));
							parties2:= PROJECT(l,xfm_parties(LEFT,'R1'));
							parties3:= PROJECT(l,xfm_parties(LEFT,'R2'));
							parties_all := parties1+parties2+parties3;
							parties_f := parties_all((company_name<>''or lname<>'' or st <>''));
							parties_s := SORT(parties_f,penalt,-id,-company_name,-lname,record);
							out := CHOOSEN(parties_s,1);
							RETURN out;
			END;
     
		 
		  export CALBUS_PP_rec := RECORD
					 unsigned2 penalt;
           FAB_Statewide.layout_FAB_Statewide_out - penalt ;
			END;	
			
			//**** CALBUS Penatly
			Export get_Calbus_info(CALBUS_Services.layouts.SearchOutput l) := FUNCTION
									CALBUS_PP_rec xfm_parties(CALBUS_Services.layouts.SearchOutput  L) := TRANSFORM
        							
												tempmodbizname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
													export string cname_field := L.firm_name;
												end;
												tempmodbizname1 := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
													export string cname_field := L.owner_name;
												end;												
												tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
													export boolean allow_wildcard := false;
													export string city_field := L.business.v_city_name;
													export string city2_field := '';
													export string pname_field := L.business.prim_name;
													export string postdir_field := L.business.postdir;
													export string prange_field := L.business.prim_range;
													export string predir_field := L.business.predir;
													export string state_field := L.business.st;
													export string suffix_field := L.business.addr_suffix;
													export string zip_field := L.business.zip5;
												end;
												tempmodaddr1 := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
													export boolean allow_wildcard := false;
													export string city_field := L.mailing.v_city_name;
													export string city2_field := '';
													export string pname_field := L.mailing.prim_name;
													export string postdir_field := L.mailing.postdir;
													export string prange_field := L.mailing.prim_range;
													export string predir_field := L.mailing.predir;
													export string state_field := L.mailing.st;
													export string suffix_field := L.mailing.addr_suffix;
													export string zip_field := L.mailing.zip5;
												end;
												SELF.penalt :=
												min(AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname),AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname1)) +
												min(AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr),AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr1)) ;
                        
												boolean IsBaddr := If(AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
												                   < AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr1)
																					 ,true,false);
                        Boolean IsFname := IF(AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
												                   <AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname1)
																					 ,true,false);

												SELF.record_id       := (string)l.Account_Number;
												SELF.id              := (integer)L.bdid;
												SELF.company_name    := if(IsFname,tempmodbizname.cname_field,tempmodbizname1.cname_field);
											  SELF.fname           := '';
												SELF.lname           := '';
												SELF.mname           := '';
          							SELF.prim_range      := if(IsBaddr,tempmodaddr.prange_field,tempmodaddr1.prange_field);
												SELF.predir          := if(IsBaddr,tempmodaddr.predir_field,tempmodaddr1.predir_field);
												SELF.prim_name       := if(IsBaddr,tempmodaddr.pname_field,tempmodaddr1.pname_field);
												SELF.addr_suffix     := if(IsBaddr,tempmodaddr.suffix_field,tempmodaddr1.suffix_field);
												SELF.postdir         := if(IsBaddr,tempmodaddr.postdir_field,tempmodaddr1.postdir_field);
												SELF.unit_desig      := if(IsBaddr,L.business.unit_desig,L.Mailing.unit_desig);
												SELF.sec_range       := if(IsBaddr,L.business.sec_range,L.Mailing.sec_range);
												SELF.v_city_name     := if(IsBaddr,tempmodaddr.city_field,tempmodaddr1.city_field);
												SELF.st              := if(IsBaddr,tempmodaddr.state_field,tempmodaddr1.state_field);
												SELF.zip5            := if(IsBaddr,tempmodaddr.zip_field,tempmodaddr1.zip_field);
												SELF.zip4            := if(IsBaddr,L.business.zip4,L.Mailing.zip4);
												SELF := L;
												SELF := [];
										END;
							parties1:=PROJECT(l,xfm_parties(LEFT));
							RETURN parties1;
			END;
			export Prop_rec := RECORD
			
					// string1 priorty;
					unsigned2 penalt;
					string120 orig_name;
					string1 party_type;
					LN_PropertyV2_Services.keys.search().title;
					LN_PropertyV2_Services.keys.search().fname;
					LN_PropertyV2_Services.keys.search().mname;
					LN_PropertyV2_Services.keys.search().lname;
					LN_PropertyV2_Services.keys.search().name_suffix;
					LN_PropertyV2_Services.keys.search().cname;
					string12 did;
					string12 bdid;
					LN_PropertyV2_Services.keys.search().app_ssn;
					LN_PropertyV2_Services.keys.search().prim_range;
					LN_PropertyV2_Services.keys.search().predir;
					LN_PropertyV2_Services.keys.search().prim_name;
					LN_PropertyV2_Services.keys.search().suffix;
					LN_PropertyV2_Services.keys.search().postdir;
					LN_PropertyV2_Services.keys.search().unit_desig;
					LN_PropertyV2_Services.keys.search().sec_range;
					LN_PropertyV2_Services.keys.search().p_city_name;
					LN_PropertyV2_Services.keys.search().v_city_name;
					LN_PropertyV2_Services.keys.search().st;
					LN_PropertyV2_Services.keys.search().zip;
  				LN_PropertyV2_Services.keys.search().zip4;					
  				LN_PropertyV2_Services.keys.search().phone_number;					
			END;	
			
			
			//**** Property Party Penatly
			Export get_Propparty_info(DATASET(LN_PropertyV2_Services.layouts.parties.pparty) l) := FUNCTION
										Prop_rec xfm_parties(Prop_rec pn) := TRANSFORM
                        										
											temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := FUNCTION
												tempmodbizname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
													export string cname_field := pn.cname;
												end;
												tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
													export boolean allow_wildcard := false;
													export string fname_field := pn.fname;
													export string lname_field := pn.lname;
													export string mname_field := pn.mname;
												end;
											tempmodssn := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
													export string ssn_field := pn.app_ssn;
											end;					
			                tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
													export boolean allow_wildcard := false;
													export string city_field := pn.p_city_name;
													export string city2_field := '';
													export string pname_field := pn.prim_name;
													export string postdir_field := pn.postdir;
													export string prange_field := pn.prim_range;
													export string predir_field := pn.predir;
													export string state_field := pn.st;
													export string suffix_field := pn.suffix;
													export string zip_field := pn.zip;
											end;
											tempmodphone := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
												 	export string phone_field := pn.phone_number;
											end;												
											return AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
														+ AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
														+ AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn)
														+ AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
														+ AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
										end;
										
												penalty1 := temppenalty(temp_mod_one);
												penalty2 := temppenalty(temp_mod_two);
												
												SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
												SELF.orig_name := L.orig_names[1].orig_name;
												SELF := pn;
												SELF := [];
										END;	
							
							Prop_rec xfm_norm(LN_PropertyV2_Services.layouts.parties.pparty Npp, integer c) := TRANSFORM
								SELF := Npp;
								SELf := Npp.entity[c];
								SELf := [];
							END;
							
							//cross product (other entities with Prop addr)
							Prop_pp := L(party_type ='P');
							owner_pp := PROJECT(L(party_type in['B','O']).entity,LN_PropertyV2_Services.layouts.parties.entity);
							seller_pp := PROJECT(L(party_type in['S','C']).entity,LN_PropertyV2_Services.layouts.parties.entity);
							LN_PropertyV2_Services.layouts.parties.pparty xfm_add_Prop_entity(LN_PropertyV2_Services.layouts.parties.pparty Prop_addr,DATASET(LN_PropertyV2_Services.layouts.parties.entity) ent, String1 p_type) := TRANSFORM
                SELF.party_type := p_type;
								SELF.entity := ent;
								SELF := Prop_addr;
							END;
							
							owner_cross_pp := PROJECT(Prop_pp,xfm_add_Prop_entity(LEFT,owner_pp,'1'));
							seller_cross_pp := PROJECT(Prop_pp,xfm_add_Prop_entity(LEFT,seller_pp,'2'));
							other_pp := PROJECT(L,TRANSFORM(recordof(L),SELF.party_type :='3',SELF := LEFT));
							all_pp := other_pp + owner_Cross_pp + seller_Cross_pp;
							
							norm_pp := NORMALIZE(all_pp,count(L.entity),xfm_norm(LEFT,counter));
							pp_entity := norm_pp(cname<>'' or lname<>'');
							parties1:= PROJECT(pp_entity,xfm_parties(LEFT));
							parties_s := SORT(parties1,penalt,party_type,-lname,-cname,record);
							out := CHOOSEN(parties_s,1);
							RETURN out;
			END;
			
			//**** Vehicle Penalty
  		EXPORT get_Vehparty_info(VehicleV2_Services.Layout_report veh_recs) := FUNCTION
					 Final_rec := RECORD
								unsigned2 party_penalty;                    
							VehicleV2.Layout_Base_Party.Sequence_Key;
							VehicleV2.Layout_Base_Party.Latest_Vehicle_Flag; 
							string30 history_desc;
								Vehiclev2_services.layout_vehicle_party_out.layout_standard_name;
							Vehiclev2_services.layout_vehicle_party_out.layout_standard_address;
								 string18  county_name;                           
							VehicleV2.Layout_Base_Party.orig_name;
								 VehicleV2.Layout_Base_Party.Orig_DL_Number;      
								 VehicleV2.Layout_Base_Party.Orig_DOB;            
								 VehicleV2.Layout_Base_Party.Orig_Sex; 
							string10 orig_sex_desc;
							VehicleV2.Layout_Base_Party.Orig_SSN;            
								 VehicleV2.Layout_Base_Party.Append_Clean_CName;  
								 VehicleV2.Layout_Base_Party.Append_DID;
								 VehicleV2.Layout_Base_Party.Append_BDID;
							VehicleV2.Layout_Base_Party.Append_SSN;

					 ENd;
   						reg := PROJECT(veh_recs.registrants(Sequence_key <>''),TRANSFORM(Final_rec,
										 SELF.append_did := (integer)LEFT.append_did;
										 SELF.append_bdid := (integer)LEFT.append_bdid;
										 SELf := LEFT));							
							owner := PROJECT(veh_recs.Owners(Sequence_key <>''),TRANSFORM(Final_rec,
										 SELF.append_did := (integer)LEFT.append_did;
										 SELF.append_bdid := (integer)LEFT.append_bdid;
										 SELf := LEFT));
              LH    := PROJECT(veh_recs.lienholders(Sequence_key <>''),TRANSFORM(Final_rec,
										 SELF.append_did := (integer)LEFT.append_did;
										 SELF.append_bdid := (integer)LEFT.append_bdid;
										 SELf := LEFT));
              LE    := PROJECT(veh_recs.lessees(Sequence_key <>''),TRANSFORM(Final_rec,
										 SELF.append_did := (integer)LEFT.append_did;
										 SELF.append_bdid := (integer)LEFT.append_bdid;
										 SELf := LEFT));
              LO    := PROJECT(veh_recs.lessors(Sequence_key <>''),TRANSFORM(Final_rec,
										 SELF.append_did := (integer)LEFT.append_did;
										 SELF.append_bdid := (integer)LEFT.append_bdid;
										 SELf := LEFT));
							vh_pp := (REG+OWNER+LH+LE+LO)(Lname<>'' OR St<>'' OR append_clean_cname <>'')	;		 
							out := TOPN(vh_pp,1,party_penalty,-lname,-append_clean_cname,-st,record)[1]	;		 
							return out;
			END;
		
		//**** Targus Penalty
		EXPORT get_Targus_penalt(targus.layout_consumer_out L) := FUNCTION
							tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
								export boolean allow_wildcard := false;
								export string fname_field := L.fname;
								export string lname_field := L.lname;
								export string mname_field := L.middle_name;
							end;
							tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
								export boolean allow_wildcard := false;
								export string city_field := L.city_name;
								export string city2_field := '';
								export string pname_field := L.prim_name;
								export string postdir_field := L.postdir;
								export string prange_field := L.prim_range;
								export string predir_field := L.predir;
								export string state_field := L.st;
								export string suffix_field := L.suffix;
								export string zip_field := L.zip;
							end;
							tempmodphone := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
								export string phone_field := L.phone_number;
							end;											
            	p:= AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
							    + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
									+ AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);									
									
				      RETURN p;
			END;
			
		//**** Criminal Penalty
		EXPORT get_Crim_penalt(iesp.criminal.t_CrimSearchRecord L) := FUNCTION
							tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
								export boolean allow_wildcard := false;
								export string fname_field := L.name.first;
								export string lname_field := L.name.last;
								export string mname_field := L.name.middle;
							end;
							tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
								export boolean allow_wildcard := false;
								export string city_field := L.address.city;
								export string city2_field := '';
								export string pname_field := L.address.streetname;
								export string postdir_field := L.address.streetpostdirection;
								export string prange_field := L.address.streetnumber;
								export string predir_field := L.address.streetpredirection;
								export string state_field := L.address.state;
								export string suffix_field := L.address.streetsuffix;
								export string zip_field := L.address.zip5;
							end;
  						tempmodssn := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
								export string ssn_field := L.ssn;
							end;							
							
            	p:= AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
							    + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
								  + AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn);									
									
				      RETURN p;
			END;
			
		//**** Credit Bureaus Penalty
		EXPORT get_Bureaus_penalt(doxie.Key_Header L) := FUNCTION
							tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
								export boolean allow_wildcard := false;
								export string fname_field := L.fname;
								export string lname_field := L.lname;
								export string mname_field := L.mname;
							end;
							tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
								export boolean allow_wildcard := false;
								export string city_field := L.city_name;
								export string city2_field := '';
								export string pname_field := L.prim_name;
								export string postdir_field := L.postdir;
								export string prange_field := L.prim_range;
								export string predir_field := L.predir;
								export string state_field := L.st;
								export string suffix_field := L.suffix;
								export string zip_field := L.zip;
							end;
							tempmodphone := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
								export string phone_field := L.phone;
							end;												
 							p:= AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
							    + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
									+ AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);									
									
				      RETURN p;
			END;	
			
		//**** Hunting Penalty	
		 EXPORT get_Hunting_penalt(doxie_crs.layout_hunting_records L) := FUNCTION
							tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
								export boolean allow_wildcard := false;
								export string fname_field := L.fname;
								export string lname_field := L.lname;
								export string mname_field := L.mname;
							end;
							tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
								export boolean allow_wildcard := false;
								export string city_field := L.city_name;
								export string city2_field := '';
								export string pname_field := L.prim_name;
								export string postdir_field := L.postdir;
								export string prange_field := L.prim_range;
								export string predir_field := L.predir;
								export string state_field := L.st;
								export string suffix_field := L.suffix;
								export string zip_field := L.zip;
							end;
							tempmodphone := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
								export string phone_field := L.phone;
							end;							
										 	
 							p:= AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
							    + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
									+ AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);										
									
				      RETURN p;
			END;	
			
			//**** BankruptcyV2 Penalty
				shared	names_rec := RECORD
								 String1 ptype;
								 unsigned6 penalt;
								 BankruptcyV2_Services.layouts.layout_name;
				END;			
    	  shared	names_rec xfm_BKName(BankruptcyV2_Services.layouts.layout_Name N,String1 Ntype) := TRANSFORM
										temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := FUNCTION
											tempmodbizname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
													export string cname_field := N.cname;
											end;
											tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
													export boolean allow_wildcard := false;
													export string fname_field := N.fname;
													export string lname_field := N.lname;
													export string mname_field := N.mname;
												end;				
											tempmodssn := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
													export string ssn_field := N.app_ssn;
											end;			
											tempmodfein := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
													export string fein_field := N.tax_id;
											end;
											
											return AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
													 + AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
													 + AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn)
													 + AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodfein);
										end;
											penalty1 := temppenalty(temp_mod_one);
											penalty2 := temppenalty(temp_mod_two);
											
											SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
                      SELF.PType := NType;	
											SELf := N;
											SELF := [];
												
					END;

					shared add_rec := RECORD
							 String1 ptype;
							 unsigned6 penalt;
							 BankruptcyV2_Services.layouts.layout_address;
					END;
					shared add_rec xfm_BKaddress(BankruptcyV2_Services.layouts.layout_address A,String1 Atype) := TRANSFORM
										temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := FUNCTION
											tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
													export boolean allow_wildcard := false;
													export string city_field := A.v_city_name;
													export string city2_field := '';
													export string pname_field := A.prim_name;
													export string postdir_field := A.postdir;
													export string prange_field := A.prim_range;
													export string predir_field := A.predir;
													export string state_field := A.st;
													export string suffix_field := A.addr_suffix;
													export string zip_field := A.zip;
											end;			
											return AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr);
										end;
											penalty1 := temppenalty(temp_mod_one);
											penalty2 := temppenalty(temp_mod_two);
											
											SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
                      SELF.PType  := AType;			
                 			SELf := A;
											SELF := [];
					
					END;
					
					shared phn_rec := RECORD
							 String1 ptype;
							 unsigned6 penalt;
							 BankruptcyV2_Services.layouts.layout_phone;
					END;
					shared phn_rec xfm_BKPhone(BankruptcyV2_Services.layouts.layout_phone P,String1 Atype) := TRANSFORM
			          temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := FUNCTION
									tempmodphone := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
										export string phone_field := P.phone;
									end;	
									return AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
								end;
									penalty1 := temppenalty(temp_mod_one);
									penalty2 := temppenalty(temp_mod_two);
									
									SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
                  SELF.PType  := AType;											
					
									SELf := P;
									SELF := [];
					
					END;											
			
			Export get_Bankruptcyparty_info(BankruptcyV2_Services.layouts.layout_rollup l) := FUNCTION
              name_L := BankruptcyV2_Services.layouts.layout_name;
						  debtors_PName := SORT(PROJECT(L.debtors(debtor_type_1='P').names ,xfm_BKname(LEFT,'P')),penalt)(CName<>'' OR LName<>'')[1];
						  debtors_SName := SORT(PROJECT(L.debtors(debtor_type_1='S').names ,xfm_BKname(LEFT,'S')),penalt)(CName<>'' OR LName<>'')[1];
						  Attroney_Name := SORT(PROJECT(L.attorneys.names ,xfm_BKname(LEFT,'A')),penalt)(CName<>'' OR LName<>'')[1];
						  Trustee_Name := SORT(PROJECT(L.trustees.names ,xfm_BKname(LEFT,'T')),penalt)(CName<>'' OR LName<>'')[1];							
							PNames := (debtors_PName + debtors_SName + Attroney_Name + Trustee_Name)(CName<>'' OR LName<>'');
							
							add_L := BankruptcyV2_Services.layouts.layout_address;
						  debtors_PAdd :=  SORT(PROJECT(L.debtors(debtor_type_1='P').addresses,xfm_BKAddress(LEFT,'P')),penalt)(st<>'')[1];
						  debtors_SAdd :=  SORT(PROJECT(L.debtors(debtor_type_1='S').addresses,xfm_BKAddress(LEFT,'S')),penalt)(st<>'')[1];
						  Attroney_Add :=  SORT(PROJECT(L.attorneys.addresses,xfm_BKAddress(LEFT,'A')),penalt)(st<>'')[1];
						  Trustee_Add :=  SORT(PROJECT(L.trustees.addresses,xfm_BKAddress(LEFT,'T')),penalt)(st<>'')[1];
							PAddress := (debtors_PAdd + debtors_SAdd + Attroney_Add + Trustee_Add)(st<>'');

							phone_L := BankruptcyV2_Services.layouts.layout_phone;
						  debtors_Pphn :=  SORT(PROJECT(L.debtors(debtor_type_1='P').phones,xfm_BKPhone(LEFT,'P')),penalt)(phone<>'')[1];
						  debtors_Sphn :=  SORT(PROJECT(L.debtors(debtor_type_1='S').phones,xfm_BKphone(LEFT,'S')),penalt)(phone<>'')[1];
						  Attroney_phn :=  SORT(PROJECT(L.attorneys.phones,xfm_BKPhone(LEFT,'A')),penalt)(phone<>'')[1];
						  Trustee_phn :=  SORT(PROJECT(L.trustees.phones,xfm_BKPhone(LEFT,'T')),penalt)(phone<>'')[1];
							PPhone := (debtors_Pphn + debtors_Sphn + Attroney_phn + Trustee_phn)(phone<>'');
		
							BKParty_rec := RECORD
							 String1 ptype;
							 unsigned6 penalt;
							 BankruptcyV2_Services.layouts.layout_Name;
							 BankruptcyV2_Services.layouts.layout_address;
							 bankruptcyv3.key_bankruptcyv3_search_full_bip().phone;
					    END;
					
							BKParty_rec xfm_BKParty(names_rec NR, add_rec AR) := TRANSFORM
							  SELf.penalt := NR.penalt + AR.penalt + PPhone(PType = NR.PType)[1].penalt;
								SELF.Phone := PPhone(PType = NR.PType)[1].phone;
								SELF := NR;
								SELF := AR;
								SELf := [];
							END;
							
							BK_Party := SORT(JOIN(PNames,PAddress
																		, LEFT.ptype = RIGHT.ptype
							                      ,Xfm_BKParty(LEFT,RIGHT),LEFT OUTER)
															 ,penalt,-LName,-CName,-St,record)[1];
						
							RETURN BK_Party;
			END;	
			
		 //**** Marriage and Divorce Penalty	
		 EXPORT get_MD_bestParty(marriage_divorce_v2_Services.layouts.result.wide L) := FUNCTION
		 					md_rec := record
							   unsigned6 ppenalt :=0 ;
							   marriage_divorce_v2_Services.layouts.pparty; 
							end;
							
							md_rec xfm_Bparty_MD(md_rec pp) := TRANSFORM
								temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := FUNCTION
									tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
										export boolean allow_wildcard := false;
										export string fname_field := pp.fname;
										export string lname_field := pp.lname;
										export string mname_field := pp.mname;
									end;
									tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
										export boolean allow_wildcard := false;
										export string city_field := pp.p_city_name;
										export string city2_field := '';
										export string pname_field := pp.prim_name;
										export string postdir_field := pp.postdir;
										export string prange_field := pp.prim_range;
										export string predir_field := pp.predir;
										export string state_field := pp.st;
										export string suffix_field := pp.suffix;
										export string zip_field := pp.zip;
									end;
		
									return AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
												+	AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr);			
								end;
									penalty1 := temppenalty(temp_mod_one);
									penalty2 := temppenalty(temp_mod_two);
									
									p := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
									SELf.ppenalt := p;
									SELF := pp;
							END;
							in_ds := PROJECT(L.Party1 + L.party2 ,md_rec);
							best_party := SORT(PROJECT(in_ds,xfm_BParty_MD(LEFT)),ppenalt,record)[1];
				      RETURN best_party;
			END;
      
			//**** FBN PENALTY
			EXPORT get_FBNParty_info(FBNV2_services.Layout_FBN_Report F) := FUNCTION

			      out_layout_final := FAB_StateWide.layout_FAB_Statewide_out;
						out_layout := record
						  out_layout_final;
						  unsigned2	sort_seq  := 0;
						end;
						
						out_layout xfm_bus(FBNV2_services.Layout_FBN_Report Bus_in) := TRANSFORM
								temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := function
									tempmodbizname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
										export string cname_field := bus_in.bus_name;
								  end;
									tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
										export boolean allow_wildcard := false;
										export string city_field := bus_in.v_city_name;
										export string city2_field := '';
										export string pname_field := bus_in.prim_name;
										export string postdir_field := bus_in.postdir;
										export string prange_field := bus_in.prim_range;
										export string predir_field := bus_in.predir;
										export string state_field := bus_in.st;
										export string suffix_field := bus_in.addr_suffix;
										export string zip_field := bus_in.zip5;
									end;						
									tempmodfein := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_FEIN.full,opt))
										export string fein_field := bus_in.orig_fein;
									end;								
								tempmodphone := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
									export string phone_field := bus_in.bus_phone_num;
								end;							
								return AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
										 + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
										 + AutoStandardI.LIBCALL_PenaltyI_FEIN.val(tempmodfein)
										 + AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
							end;
								penalty1 := temppenalty(temp_mod_one);
								penalty2 := temppenalty(temp_mod_two);
								
                SELF.sort_seq := 0; // prefer bus info before contact when penalty same
								SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
								SELF.record_id       := bus_in.tmsid;
								SELF.id              := bus_in.bdid;
								SELF.company_name    := bus_in.bus_name;
								SELF.phone           := bus_in.bus_phone_num;
								SELF.fein            := bus_in.orig_fein;
								SELF.is_bdid         := TRUE;	
								SELF := bus_in;
								SELF := [];
						END;

						out_layout xfm_cont(FBNV2_services.Layout_Contact cont_in) := TRANSFORM
							temppenalty(AutoStandardI.LIBIN.PenaltyI.base in_mod) := function
								tempmodindvname := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
										export boolean allow_wildcard := false;
										export string fname_field := cont_in.fname;
										export string lname_field := cont_in.lname;
										export string mname_field := cont_in.mname;
									end;
									tempmodaddr := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
										export boolean allow_wildcard := false;
										export string city_field := cont_in.v_city_name;
										export string city2_field := '';
										export string pname_field := cont_in.prim_name;
										export string postdir_field := cont_in.postdir;
										export string prange_field := cont_in.prim_range;
										export string predir_field := cont_in.predir;
										export string state_field := cont_in.st;
										export string suffix_field := cont_in.addr_suffix;
										export string zip_field := cont_in.zip5;
									end;						
									tempmodssn := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_SSN.full,opt))
										export string ssn_field := cont_in.ssn;
									end;				
								tempmodphone := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
									export string phone_field := cont_in.contact_phone;
								end;										
								return AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
											+ AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
											+ AutoStandardI.LIBCALL_PenaltyI_SSN.val(tempmodssn)
											+ AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
							end;
								penalty1 := temppenalty(temp_mod_one);
								penalty2 := temppenalty(temp_mod_two);

                SELF.sort_seq := 1; // prefer cont info after bus info when penalty same
								SELF.penalt := if(TwoPartySearch,min(penalty1,penalty2),penalty1);
                SELF.record_id       := cont_in.tmsid;								
								SELF.id              := cont_in.did;
								SELF.phone           := cont_in.contact_phone;
								SELF.is_bdid         := FALSE;	
								SELf := cont_in;
								SELF := [];
						END;						
						bus_info := PROJECT(F,xfm_bus(LEFT));
						cont_1 :=PROJECT(F.contacts,FBNV2_services.Layout_Contact);
						cont_info := PROJECT(cont_1,xfm_cont(LEFT));
						parties :=  if(XNOR_CNAME_LNAME OR IsCNAME, bus_info) + if(XNOR_CNAME_LNAME OR NOT IsCNAME,cont_info);
						best_party1 := SORT(parties(lname<>'' or company_name<>'' or st <>''),penalt,sort_seq,record)[1];
            best_party  := PROJECT(best_party1,transform(out_layout_final,self := left)); 
						return best_party;
			END;
			
			//**** TxBUS PENALTY
			EXPORT get_TxBusParty_info(TXBUSV2_Services.Layout_Search F) := FUNCTION
			      out_layout := FAB_StateWide.layout_FAB_Statewide_out;
						
						out_layout xfm_bus(TxBusV2_Services.Layout_outlet Bus_in) := TRANSFORM
									tempmodbizname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
										export string cname_field := bus_in.outlet_name;
								  end;
									tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
										export boolean allow_wildcard := false;
										export string city_field := bus_in.outlet_v_city_name;
										export string city2_field := '';
										export string pname_field := bus_in.outlet_prim_name;
										export string postdir_field := bus_in.outlet_postdir;
										export string prange_field := bus_in.outlet_prim_range;
										export string predir_field := bus_in.outlet_predir;
										export string state_field := bus_in.outlet_st;
										export string suffix_field := bus_in.outlet_addr_suffix;
										export string zip_field := bus_in.outlet_zip5;
									end;						
								tempmodphone := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
									export string phone_field := bus_in.outlet_phone;
								end;
								SELF.id              := bus_in.bdid;
								SELF.company_name    := bus_in.outlet_name;
								SELF.phone           := bus_in.outlet_phone;
			         	SELF.prim_range      := bus_in.outlet_prim_range;
								SELF.predir          := bus_in.outlet_predir;
								SELF.prim_name       := bus_in.outlet_prim_name;
								SELF.addr_suffix     := bus_in.outlet_addr_suffix;
								SELF.postdir         := bus_in.outlet_postdir;
								SELF.unit_desig      := bus_in.outlet_unit_desig;
								SELF.sec_range       := bus_in.outlet_sec_range;
								SELF.v_city_name     := bus_in.outlet_v_city_name;
								SELF.st              := bus_in.outlet_st;
								SELF.zip5            := bus_in.outlet_zip5;
								SELF.zip4            := bus_in.outlet_zip4;
								SELF.is_bdid         := TRUE;	
								SELF.penalt          := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
																		    + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
																		    + AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
								SELf := bus_in;
								SELf := [];
						END;
						out_layout xfm_cont(TXBUSV2_Services.Layout_Search cont_in) := TRANSFORM
								tempmodbizname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Biz_Name.full,opt))
										export string cname_field := cont_in.taxpayer_name;
								 end;						
								tempmodindvname := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Indv_Name.full,opt))
										export boolean allow_wildcard := false;
										export string fname_field := cont_in.taxpayer_fname;
										export string lname_field := cont_in.taxpayer_lname;
										export string mname_field := cont_in.taxpayer_mname;
									end;
									tempmodaddr := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Addr.full,opt))
										export boolean allow_wildcard := false;
										export string city_field := cont_in.taxpayer_v_city_name;
										export string city2_field := '';
										export string pname_field := cont_in.taxpayer_prim_name;
										export string postdir_field := cont_in.taxpayer_postdir;
										export string prange_field := cont_in.taxpayer_prim_range;
										export string predir_field := cont_in.taxpayer_predir;
										export string state_field := cont_in.taxpayer_st;
										export string suffix_field := cont_in.taxpayer_addr_suffix;
										export string zip_field := cont_in.taxpayer_zip5;
									end;		
								tempmodphone := module(project(AutoStandardI.GlobalModule(),AutoStandardI.LIBIN.PenaltyI_Phone.full,opt))
									export string phone_field := cont_in.taxpayer_phone;
								end;									
								SELF.id              := cont_in.did;
								SELF.company_name    := cont_in.taxpayer_name;
								SELF.fname           := cont_in.taxpayer_fname;
								SELF.lname           := cont_in.taxpayer_lname;
								SELF.mname           := cont_in.taxpayer_mname;
								SELF.phone           := cont_in.taxpayer_phone;
			         	SELF.prim_range      := cont_in.taxpayer_prim_range;
								SELF.predir          := cont_in.taxpayer_predir;
								SELF.prim_name       := cont_in.taxpayer_prim_name;
								SELF.addr_suffix     := cont_in.taxpayer_addr_suffix;
								SELF.postdir         := cont_in.taxpayer_postdir;
								SELF.unit_desig      := cont_in.taxpayer_unit_desig;
								SELF.sec_range       := cont_in.taxpayer_sec_range;
								SELF.v_city_name     := cont_in.taxpayer_v_city_name;
								SELF.st              := cont_in.taxpayer_st;
								SELF.zip5            := cont_in.taxpayer_zip5;
								SELF.zip4            := cont_in.taxpayer_zip4;
								SELF.is_bdid         := FALSE;	
								SELF.penalt          := AutoStandardI.LIBCALL_PenaltyI_Biz_Name.val(tempmodbizname)
								                       + AutoStandardI.LIBCALL_PenaltyI_Addr.val(tempmodaddr)
																			 + AutoStandardI.LIBCALL_PenaltyI_Indv_Name.val(tempmodindvname)
																			 + AutoStandardI.LIBCALL_PenaltyI_Phone.val(tempmodphone);
								SELf := cont_in;
								SELF := [];
						END;						
						bus_1 :=PROJECT(F.outlet,TxBusV2_Services.Layout_outlet);						
						bus_info := PROJECT(bus_1,xfm_bus(LEFT));
						cont_info := PROJECT(F,xfm_cont(LEFT));
				    parties :=  if(XNOR_CNAME_LNAME OR IsCNAME, bus_info) + if(XNOR_CNAME_LNAME OR NOT IsCNAME,cont_info);
						best_party := SORT(parties(Lname<>'' OR company_name<>'' OR st<>''),penalt,record)[1];
						return best_party;
			END;
	END;