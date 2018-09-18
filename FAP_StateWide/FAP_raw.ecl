IMPORT VotersV2_Services,doxie,UCCv2_Services,doxie
,prof_LicenseV2_Services,VehicleV2_Services
,bankruptcyv2_Services,LiensV2_Services,marriage_divorce_v2_Services
,DeathV2_Services,FAB_StateWide,LN_PropertyV2_Services,doxie_raw,Statewide_Services
,Business_Header,Driversv2_Services, Targus,AutoStandardI,WatercraftV2_services
,Address,suppress,CriminalRecords_Services,header,FCRA;

//***** SET of FUNCTIONS

EXPORT FAP_raw := MODULE

	SHARED DOC_TYPE := Statewide_Services.Constants;
	
	EXPORT STRING BuildName(String40 fname, String40 mname, String40 lname) := FUNCTION
			 FullName := if(fname<>'',TRIM(fname),'')
										+if(mname<>'',' '+TRIM(mname),'')
										+if(lname<>'',' '+TRIM(lname),'');
			RETURN FullName;
	END;
	
	shared unsigned4 max_limit := 2000;
	shared out_layout  := FAB_StateWide.layout_FAB_Statewide_out;	
  Business_Header.doxie_MAC_Field_Declare()
  mod_access := doxie.functions.GetGlobalDataAccessModule ();

	       
  EXPORT search := MODULE
				//****** VOTERS SEARCH
				
				 EXPORT FAP_SearchVoters() := FUNCTION
							
					voter_recs := VotersV2_Services.VotersSearchService_records;
					out_layout  xfm_voter_recs(voter_recs v) := TRANSFORM
						SELF.source_doc_type := StateWide_Services.constants.constant('VO');
						
						SELF.record_id     := (String)v.vtid;
						SELF.Jurisdiction  := v.source_state;
						SELF.full_name     := BuildName(v.name.fname
																						,v.name.mname
																						,v.name.lname);
            SELF.id            := (unsigned6)v.did;																						
						SELF               := v.res;
						SELF               := v.name;
						SELF               := v;						
						SELF               := [];
					END;
         	recs := SORT(PROJECT(voter_recs,xfm_voter_recs(LEFT))
															,penalt,jurisdiction,-id,record_id);
																		
         	RETURN CHOOSEN(recs,max_limit);
      		
				END;
			
				//****** UCC SEARCH
 				EXPORT FAP_SearchUCC() := FUNCTION
      		ucc_recs := UCCv2_Services.UCCSearchService_records();
   				out_layout  xfm_UCC_recs(ucc_recs.records ucc) := TRANSFORM
      						SELF.source_doc_type := StateWide_Services.constants.constant('UC');
      						SELF.record_id     := (String)ucc.tmsid;
      						SELF.Jurisdiction  := ucc.filing_jurisdiction;
									d := ucc.debtors + ucc.secureds + ucc.assignees + ucc.creditors ;
									parties:= PenaltyI.get_uccparty_info(d);
      					  SELF.full_name     := BuildName( parties[1].fname
      																						, parties[1].mname		
      																						, parties[1].lname
      																						);
                  IsBdid := parties[1].bdid >0 OR TRIM(parties[1].orig_name)<>'' and TRIM(parties[1].lname) ='';
   							  SELF.id            := IF(IsBdid, parties[1].bdid,  parties[1].did);
									SELF.company_name  := parties[1].orig_name;
									SELF.is_bdid       := IsBdid;
									SELF               := parties[1];
      						SELF               := ucc;
      						SELF               := [];
      		END;						
         	recs := SORT(PROJECT(ucc_recs.records,xfm_ucc_recs(LEFT))
															,penalt,jurisdiction,-id,record_id);
																			
         	RETURN CHOOSEN(recs,max_limit);
   						
       END;

		
   				//****** Property SEARCH
 			   EXPORT FAP_SearchProperty() :=  
				    FUNCTION
				 
         					Prop_recs := LN_PropertyV2_Services.SearchService_records().Records;
         					out_layout  xfm_Prop_recs(prop_recs Prop) := TRANSFORM
         						SELF.penalt          := Prop.penalt;
										SELF.source_doc_type := StateWide_Services.constants.constant('PR');
         						SELF.record_id       := Prop.ln_fares_id;
         						SELF.Jurisdiction    := IF(COUNT(Prop.deeds(State<>''))>0,Prop.deeds(State<>'')[1].State
										                           ,IF(COUNT(Prop.assessments(state_code<>''))>0
																						       ,Prop.assessments[1].state_code
																						  		 ,'')
																						 );
										pt1 := SORT(PenaltyI.get_Propparty_info(Prop.parties),penalt);
										SELF.full_name     := BuildName(pt1[1].fname
         																						,pt1[1].mname
         																						,pt1[1].lname
      																							);
                    IsBdid  := (unsigned6)pt1[1].bdid>0 OR TRIM(pt1[1].cname) <>'' and TRIM(pt1[1].lname) =''; 																										
         						SELF.id            := IF(IsBdid, (unsigned6)pt1[1].bdid, (unsigned6)pt1[1].did);
										SELF.company_name  := pt1[1].cname;
										SELF.ssn           := pt1[1].app_ssn;
										SELF.phone         := pt1[1].phone_number;
										SELF.addr_suffix   := pt1[1].suffix;
										SELF.zip5          := pt1[1].zip;
										SELf               := pt1[1];										
										SELF.is_bdid       := IsBdid;
           					// SELF               := Prop;
      							SELF               := [];
         					END;
									recs := SORT(PROJECT(Prop_recs,xfm_Prop_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																			
         					RETURN CHOOSEN(recs,max_limit);
     			END;	
				

   					
   				//*****  Hunting and Fishing Search
					// No FAB
   				EXPORT FAP_SearchHunting() := Function
							dids := doxie.get_dids(,~IsCRS);
							HF_recs := doxie.hunting_records(dids);
							out_layout  xfm_HF_recs(HF_recs hf):= TRANSFORM
								SELF.source_doc_type := StateWide_Services.constants.constant('HF');
								SELF.Jurisdiction    := hf.source_state;
								SELF.record_id       := (String)hf.vendor_id;
								SELF.id              := (unsigned6)hf.did;	
								SELF.fname           := hf.fname_in;
								SELF.lname           := hf.lname_in;
								SELF.mname           := hf.mname_in;
								SELF.full_name       := BuildName(hf.fname_in,hf.mname_in,hf.lname_in);
								self.zip5            := hf.zip;
								self.v_city_name     := hf.city_name;
								self.addr_suffix     := hf.suffix;
								SELF.ssn             := hf.best_ssn;
								SELF.penalt          := PenaltyI.get_Hunting_penalt(hf);
								self.hf_lic_num      := hf.HuntFishPerm;  // HuntFishPerm=license number
								self.hf_lic_date     := hf.DateLicense;
								self.hf_lic_type     := hf.License_type_Mapped;
								self.hf_lic_st       := hf.source_state_name;
	              self.hf_home_st	     := hf.home_state_name;
								self                 := hf;
								self                 := [];
							END;
         			recs := SORT(PROJECT(HF_recs,xfm_HF_recs(LEFT))
																	,penalt,jurisdiction,-id,record_id);
																			
         			RETURN CHOOSEN(recs,max_limit);
		
   	    END;

   
   				//*****  Professional License Search
			    //FAB Exists  			 
						 EXPORT FAP_SearchProfLic() := Function
						      out_set := MODULE(Statewide_Services.layout_FAB_FAP_out.output_set)END;
										input_params := AutoStandardI.GlobalModule();
										params := module(project(input_params,prof_licensev2_services.profLicSearch.params,opt))
											export boolean Include_Prof_Lic := if(~out_set.SelectIndividually OR out_set.IncludeProfessionalLicenses,true,false);
										  export boolean Include_Sanc := if(~out_set.SelectIndividually OR out_set.IncludeSanctions ,true,false);
										  export boolean Include_Prov := if(~out_set.SelectIndividually OR out_set.IncludeProviders,true,false);
	
											export unsigned6 	Sanc_id := 0 						 : stored('SanctionID');
											export set of unsigned6  sanc_id_set := [] : stored('SanctionID');
											export unsigned6  ProviderId := 0      		 : stored('ProviderID');
											export unsigned6  prolic_seq_num := 0  		 : stored('SequenceID');
											shared string20	  L_Number := '' 		 : stored('LicenseNumber');
											export string20   License_Number :=  stringlib.stringtouppercase(l_number);													 												 
									end;
									
         					profLic_recs := prof_LicenseV2_Services.ProfLicSearch.val(params);
         					out_layout  xfm_ProfLic_recs(profLic_recs pl) := TRANSFORM
         						SELF.source_doc_type := StateWide_Services.constants.constant('PL');
         						SELF.record_id       := pl.uniqueid;
         						SELF.Jurisdiction    := pl.source_st;
         						SELF.full_name       := BuildName(pl.fname,pl.mname,pl.lname);		
										SELF.company_name    := pl.company_name;
										IsBdid := TRIM(pl.lname) ='' and TRIM(pl.company_name) <>'' OR (unsigned6)pl.bdid>0 ;
										SELF.is_bdid         := IsBdid;
										SELF.ssn             := pl.best_ssn;
										SELF.addr_suffix     := pl.suffix;
										SELF.zip5            := pl.zip;
										SELF.id              := IF(IsBdid,(unsigned6)pl.bdid,(unsigned6)pl.did);
										SELF                 := pl;
         						SELF                 := [];
         					END;
         					recs := SORT(PROJECT(profLic_recs,xfm_ProfLic_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																												
         					RETURN CHOOSEN(recs,max_limit);
         		 END;				

        
   	
   			  //*****  Bankruptcy Search
					//FAB Exists  	
        			EXPORT FAP_SearchBankruptcy() := Function
 	                //partytype_bk is stored/set above via Business_Header.doxie_MAC_Field_Declare's 
									// use of doxie.MAC_Header_Field_Declare and is based upon the input
									// Soap "PartyTypeBK" field.  
									// However due to RQ bug 103238 and discussions with Rosemary Murphy and
									// Kevin Logemann on 05/10/12, for the Statewide_Services.FAP_SearchService
									// it seems like that input field should have been defaulting to "D" all
									// along so that we don't search for the input name/ssn in the 
									// "A"ttorney or "T"rustee records, but only in the "D"ebtor records.
									// But, since it defaults to '' in AutoStandardI.GlobalModule, it is 
									// safer to just set it here (if it is empty on input) so we don't 
									// negatively impact other services that may use the global value.
								  string1 src_party_type_bk := if(party_type_bk = '', 'D',party_type_bk);
         					bankrup_recs := Bankruptcyv2_Services.bankruptcy_raw().source_view(in_party_type:=src_party_type_bk);
									
        					out_layout  xfm_Bankrup_recs(bankrup_recs brc) := TRANSFORM
         						SELF.source_doc_type := StateWide_Services.constants.constant('BK');
         						SELF.record_id       := (String)brc.tmsid;
         						SELF.Jurisdiction    := brc.filing_jurisdiction;
										Best_party := PenaltyI.get_Bankruptcyparty_info(brc);
      							SELF.full_name       := BuildName(Best_party.fname
         																	        		,Best_party.mname
         																	        		,Best_party.lname
         																			       );
										SELF.company_name    := Best_party.cname;
										IsBdid := TRIM(Best_party.lname) = '' and TRIM(Best_party.cname)<>'' OR (unsigned6)Best_party.bdid >0;
										SELF.is_bdid         := IsBdid;
                    SELF.id              := IF(IsBdid
																							 ,(unsigned6)Best_party.bdid
																							 ,(unsigned6)Best_party.did
																							 );
										SELF.zip5            := best_party.zip;																							 
      							SELF                 := Best_party;
										// SELF.phone           := brc.debtors[1].phones[1].phone;
         						SELF                 := brc;
         						SELF                 := [];
         					END;
         					recs := SORT(PROJECT(bankrup_recs,xfm_bankrup_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																			
         					RETURN CHOOSEN(recs,max_limit);
         			  END;
						
								
   			  	//*****  Judgements and Liens Search
     	  		EXPORT FAP_SearchLiens(Boolean srchLiens = true) := Function
								gm := AutoStandardI.GlobalModule();
		
     						unsigned2 penalt	:= AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(gm,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params));
								liens_params := module(project(gm, LiensV2_Services.IParam.search_params, opt))
									
									//To avoid the "too many subjects found" error when liens isn't even requested to 
									//be seached, blank out the major key fields used during autokey lookup.
									export companyName := IF(srchLiens,gm.companyname,'');
									export state := IF(srchLiens,gm.state,'');
									export lastname := IF(srchLiens,gm.lastname,'');
									export addr := IF(srchLiens,gm.addr,'');
									export firstname := IF(srchLiens,gm.firstname,'');
									export zip := IF(srchLiens,gm.zip,'');
									export city := IF(srchLiens,gm.city,'');
											
									export unsigned2 pt := penalt;
									export string CertificateNumber := '' : stored('CertificateNumber');
									export unsigned8 maxresults := maxresults_val;
									export string1 partyType := party_type;
									export string50 liencasenumber := liencasenumber_value;
									export string50 filingnumber := filingnumber_value;
									export string20 filingjurisdiction := filingjurisdiction_value;
									export string25 irsserialnumber := irsserialnumber_value;
									export string6 ssn_mask := ssn_mask_value;
									export string32 ApplicationType := application_type_value;
									export string101 rmsid := rmsid_value;
									export string50 tmsid := tmsid_value;
								END;
								
								
								
								Liens_recs := LiensV2_Services.LiensSearchService_records(liens_params).records;
		           	out_layout  xfm_Liens_recs(liens_recs l) := TRANSFORM
               		  SELF.source_doc_type := StateWide_Services.constants.constant('LI');
               			SELF.record_id       := (String)l.tmsid;
               			SELF.Jurisdiction    := l.Filing_Jurisdiction;
										d := if (l.isdeepDive and (l.penalt > penalt), l.debtors, 
										                                           l.debtors + l.creditors + l.attorneys + l.thds);
										
										parties2:= PenaltyI.get_lienparty_info(d);
               			SELF.full_name       := BuildName(parties2[1]. fname
               																				,parties2[1]. mname
               																				,parties2[1]. lname
               																				);
										SELF.company_name    := parties2[1]. cname;
										IsBdid := TRIM(parties2[1]. lname) = '' and TRIM(parties2[1].cname) <>'' OR (unsigned6)parties2[1].bdid >0;
										SELF.is_bdid         := IsBdid;																												
										SELF.id              := IF(IsBdid
																							,(unsigned6)parties2[1]. bdid
																							,(unsigned6)parties2[1]. did
																							);							
										SELF.zip5            := parties2[1]. zip;
										SELF.phone           := parties2[1]. phone;
               			SELF                 := parties2[1] ;
										SELF                 := l;
               			SELF                 := [];
   							END;
         					recs := SORT(PROJECT(Liens_recs,xfm_Liens_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
									
         					RETURN CHOOSEN(recs,max_limit);
               END;	


 
       			
           			//*****  Marriage and Divorce Search
								EXPORT FAP_SearchMD() := Function
									
									MD_all := marriage_divorce_v2_Services.MDSearchService_Records();
               		MD_recs := MD_all.Records;
									
                  out_layout  xfm_MD_recs(MD_recs md) := TRANSFORM
                      SELF.source_doc_type := StateWide_Services.constants.constant('MD');
                     	SELF.record_id      := (String)md.record_id;
                     	SELF.Jurisdiction  := md.state_origin;
											bparty := PenaltyI.get_MD_bestparty(md);
                     	SELF.full_name      := BuildName(bparty.fname
                     																	,bparty.mname
                     																	,bparty.lname);
              				SELF.id           := (unsigned6)bparty.did;
											SELF.addr_suffix     := bparty.suffix;
										  SELF.zip5            := bparty.zip;
											SELF.penalt          := bparty.ppenalt;
                     	SELF                 := bparty;
											
                     	SELF               := md;
                     	SELF               := [];
                    END;
         					recs := SORT(PROJECT(MD_recs,xfm_MD_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																			
         					RETURN CHOOSEN(recs,max_limit);
           		    END;	


  
             				
                  				// *****  Deaths Search
				         EXPORT FAP_SearchDeaths() := Function
				    			 death_recs := DeathV2_Services.Search_records;
   				   				       					
                   out_layout  xfm_Death_recs(death_recs d) := TRANSFORM
                    	SELF.source_doc_type := StateWide_Services.constants.constant('DE');
                    	SELF.record_id       := (String)d.state_death_id;
                    	SELF.Jurisdiction    := d.st;
                    	SELF.full_name       := BuildName(d.fname,d.mname,d.lname);
               				SELF.id              := (unsigned6)d.did;		
         							SELF.zip5            := d.zip_lastres;
                    	SELF.dob             := d.dob8;
                    	SELF                 := d;
                    	SELF                 := [];
                   END;
        					 recs := SORT(PROJECT(death_recs,xfm_Death_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																		
         					 RETURN CHOOSEN(recs,max_limit);
                     					
                 END;	


                 // *****  Drivers License Search
				         EXPORT FAP_SearchDL() := Function
				    			 DL_recs := Driversv2_Services.DLSearchService_records(FALSE);
   				   				       					
                   out_layout  xfm_dl_recs(DL_recs dl) := TRANSFORM
                    	SELF.source_doc_type := StateWide_Services.constants.constant('DL');
                    	SELF.record_id       := (String)dl.dl_seq;
                    	SELF.Jurisdiction    := dl.state;
                    	SELF.full_name       := BuildName(dl.fname,dl.mname,dl.lname);
               				SELF.id              := (unsigned6)dl.did;	
        							SELF.zip5            := dl.zip;
                      SELF.addr_suffix     := dl.suffix;											
											SELf.dob             :=(string8) dl.dob;
                    	SELF                 := dl;
                    	SELF                 := [];
                   END;
        					recs := SORT(PROJECT(DL_recs,xfm_DL_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																			
         					RETURN CHOOSEN(recs,max_limit);
                     					
                 END;	
								 
							 
                 // *****  WaterCraft Search
				         EXPORT FAP_SearchWC() := Function
									params := module(project(AutoStandardI.GlobalModule(),WatercraftV2_Services.Interfaces.search_params,opt))
										string2 st_pass :=''         		: stored('state');
										export string2 st := stringlib.stringtouppercase(st_pass);
										export unsigned2 pt := 10 			: stored('PenaltThreshold');
										export string30 	wk := ''  		: stored('WatercraftKey');
										string30 h_num := '' : stored('HullNumber');
										export string30 hull_num := stringlib.stringtouppercase (h_num);
										string50 v_name	 := '' 	: stored('VesselName');
										export string50 vesl_nam := stringlib.stringtouppercase(v_name);		
									end;
				    			WC_recs := WatercraftV2_services.WatercraftSearch(params).records;
				    			
  				   				       		
									out_layout  xfm_wc_recs(WC_recs wc) := TRANSFORM
										SELF.source_doc_type := StateWide_Services.constants.constant('WC');
										SELF.record_id       := (String)wc.watercraft_key+';'+(string)wc.sequence_key;
										SELF.Jurisdiction    := wc.state_origin;
										best_party := wc.owners[1];
										SELF.full_name       := BuildName(best_party.fname,best_party.mname,best_party.lname);
										IsBdid := TRIM(best_party.lname)= '' and TRIM(best_party.company_name) <>'' OR (unsigned6)best_party.bdid > 0;
										SELF.company_name    := best_party.company_name;
										SELF.is_bdid         := IsBdid;													
										SELF.id              := IF(IsBdid
																						,(unsigned6)best_party.bdid
																						,(unsigned6)best_party.did
																						);	
										SELF.addr_suffix     := best_party.suffix;																									
										SELf                 := best_party;																							
										SELF                 := wc;
										SELF                 := [];
									END;
        					recs := SORT(PROJECT(WC_recs,xfm_WC_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																			
         					RETURN CHOOSEN(recs,max_limit);
                     					
                 END;
							 
          // *****  Vehicle Search
				  EXPORT FAP_SearchVeh() := Function
										in_mod_E1 := VehicleV2_Services.IParam.getSearchModule();
										in_mod_E2 := VehicleV2_Services.IParam.getSearchModule_entity2();

										E1 := MODULE(PROJECT(in_mod_E1,VehicleV2_Services.IParam.searchParams,OPT))
											EXPORT BOOLEAN noFail := TRUE;
										END;
										E2 := MODULE(PROJECT(in_mod_E2,VehicleV2_Services.IParam.searchParams,OPT))
											EXPORT BOOLEAN noFail := TRUE;
										END;

										Veh_recs_E1 := VehicleV2_Services.SearchRecords.getVehicleRecords(E1);
										Veh_recs_E2 := VehicleV2_Services.SearchRecords.getVehicleRecords(E2);
									 
									 Veh_recs_0 := join(Veh_recs_E1, Veh_recs_E2,
																 (left.vehicle_key = right.vehicle_key and 
																 left.iteration_key = right.iteration_key and 
																 left.sequence_key = right.sequence_key),
																 transform(left),
																 keep(1),
																 limit(0));
									Veh_recs := project(if(AutoStandardI.GlobalModule().TwoPartySearch,Veh_recs_0, Veh_recs_E1), VehicleV2_Services.Layout_Report);
									 
                   out_layout  xfm_Veh_recs(Veh_recs vh) := TRANSFORM
                    	SELF.source_doc_type := StateWide_Services.constants.constant('VH');
                    	SELF.record_id       := (String)vh.vehicle_key+';'+(String)vh.iteration_key+';'+(String)vh.sequence_key;
	                    SELF.Jurisdiction    := vh.state_origin;
											veh_party := PenaltyI.get_Vehparty_info(vh);
										 	SELF.full_name       := BuildName(veh_party.fname,veh_party.mname,veh_party.lname);
											IsBdid := TRIM(veh_party.lname) ='' and TRIM(veh_party.orig_name) <>'' OR veh_party.append_bdid >0;
										  SELF.company_name    := veh_party.orig_name;
										  SELF.is_bdid         := IsBdid;													
									  	SELF.id              := IF(IsBdid
																							,veh_party.append_bdid
																							,veh_party.append_did
																							);	
										  SELF.ssn             := veh_party.append_ssn;
											SELf.penalt          := veh_party.party_penalty;
											SELF                 := veh_party;
                      SELf                 := vh;																							
                    	SELF                 := [];
                   END;
									recs := SORT(PROJECT(veh_recs,xfm_Veh_recs(LEFT))
																			,penalt,jurisdiction,-id,record_id);
																			
         					RETURN CHOOSEN(recs,max_limit);
                  
                     					
        END;
				
				
				//********* EQ Search
				EXPORT FAP_SearchHeaderEQ() := FUNCTION
						d := doxie.Get_Dids();//(not Exclude_Sources_val);
						dids := project(d,Doxie.layout_references);
						set of string2 eq_src_set := ['EQ','QH','WH'];
						header_recs := JOIN(dids,doxie.Key_Header,LEFT.did = RIGHT.s_did
														and RIGHT.src in eq_src_set);
						header.MAC_GlbClean_Header(header_recs,headerCleaned, , , mod_access);
						doxie.MAC_PruneOldSSNs (headerCleaned, ds_prunned, ssn, did);
						Suppress.MAC_Mask(ds_prunned, ds_masked, ssn, null, true, false);
            EQ_recs := PROJECT(ds_masked,recordof(doxie.Key_Header));
						out_layout  xfm_EQ_recs(EQ_recs EQ) := TRANSFORM
                    	SELF.source_doc_type := StateWide_Services.constants.constant('EQ');
                    	SELF.record_id       := (String)eq.rid;
	                    SELF.Jurisdiction    := eq.st;
                    	SELF.full_name       := BuildName(eq.fname,eq.mname,eq.lname);
       							  SELF.company_name    := '';
          				  	SELF.id              := (unsigned6)eq.did;
                      SELF.addr_suffix     := eq.suffix;		
											SELF.dob             := (string8)eq.dob;	
         							SELF.zip5            := eq.zip;											
											SELF.v_city_name     := eq.city_name;
											SELF.p_city_name     := eq.city_name;
											SELF.penalt          := PenaltyI.get_Bureaus_penalt(eq);
                      SELF                 := eq;											
                    	SELF                 := [];
            END;

        		recs := SORT(PROJECT(EQ_recs,xfm_EQ_recs(LEFT))
															,penalt,jurisdiction,-id,record_id);
        		RETURN CHOOSEN(recs,max_limit);
				END;
				
				//********* EN Search
				EXPORT FAP_SearchHeaderEN() := FUNCTION
						d := doxie.Get_Dids();//(not Exclude_Sources_val);
						dids := project(d,Doxie.layout_references);
						set of string2 en_src_set := ['EN'];
						header_recs := JOIN(dids,doxie.Key_Header,LEFT.did = RIGHT.s_did
														and RIGHT.src in en_src_set);
						header.MAC_GlbClean_Header(header_recs,headerCleaned, , , mod_access);	
						doxie.MAC_PruneOldSSNs (headerCleaned, ds_prunned, ssn, did);
						Suppress.MAC_Mask(ds_prunned, ds_masked, ssn, null, true, false);
            EN_recs := PROJECT(ds_masked,recordof(doxie.Key_Header));
						out_layout  xfm_EN_recs(EN_recs EN) := TRANSFORM
                    	SELF.source_doc_type := StateWide_Services.constants.constant('EN');
                    	SELF.record_id       := (String)en.rid;
	                    SELF.Jurisdiction    := en.st;
                    	SELF.full_name       := BuildName(en.fname,en.mname,en.lname);
       							  SELF.company_name    := '';
          				  	SELF.id              := (unsigned6)en.did;
                      SELF.addr_suffix     := en.suffix;		
											SELF.dob             := (string8)en.dob;	
         							SELF.zip5            := en.zip;											
											SELF.v_city_name     := en.city_name;
											SELF.p_city_name     := en.city_name;
											SELF.penalt          := PenaltyI.get_Bureaus_penalt(en);
                      SELF                 := en;											
                    	SELF                 := [];
            END;

        		recs := SORT(PROJECT(EN_recs,xfm_EN_recs(LEFT))
															,penalt,jurisdiction,-id,record_id);
        		RETURN CHOOSEN(recs,max_limit);
				END;

	//********* TN Search
				EXPORT FAP_SearchHeaderTN() := FUNCTION
						d := doxie.Get_Dids();//(not Exclude_Sources_val);
						dids := project(d,Doxie.layout_references);
						set of string2 tn_src_set := ['TN'];
						header_recs := JOIN(dids,doxie.Key_Header,LEFT.did = RIGHT.s_did
														and RIGHT.src in tn_src_set);
						header.MAC_GlbClean_Header(header_recs,headerCleaned, , , mod_access);	
						doxie.MAC_PruneOldSSNs (headerCleaned, ds_prunned, ssn, did);
						Suppress.MAC_Mask(ds_prunned, ds_masked, ssn, null, true, false);
            TN_recs := PROJECT(ds_masked,recordof(doxie.Key_Header));
						out_layout  xfm_TN_recs(TN_recs TN) := TRANSFORM
                    	SELF.source_doc_type := StateWide_Services.constants.constant('TN');
                    	SELF.record_id       := (String)tn.rid;
	                    SELF.Jurisdiction    := tn.st;
                    	SELF.full_name       := BuildName(tn.fname,tn.mname,tn.lname);
       							  SELF.company_name    := '';
          				  	SELF.id              := (unsigned6)tn.did;
                      SELF.addr_suffix     := tn.suffix;		
											SELF.dob             := (string8)tn.dob;	
         							SELF.zip5            := tn.zip;											
											SELF.v_city_name     := tn.city_name;
											SELF.p_city_name     := tn.city_name;
											SELF.penalt          := PenaltyI.get_Bureaus_penalt(tn);
                      SELF                 := tn;											
                    	SELF                 := [];
            END;

        		recs := SORT(PROJECT(TN_recs,xfm_TN_recs(LEFT))
															,penalt,jurisdiction,-id,record_id);
        		RETURN CHOOSEN(recs,max_limit);
				END;                     	
				
        // *****  Criminal Search
				EXPORT FAP_SearchCrim() := Function
					 input_params := AutoStandardI.GlobalModule();
					 tempmod := module(project(input_params,CriminalRecords_Services.IParam.search,opt))
							export string25		doc_number		:= '' : STORED('DOCNumber');
							export string60		offender_key		:= '' : STORED('OffenderKey');
							export string30		county_in			:= '' : STORED('County');
							export string30 		County 			:='';
						end;

						Crim_recs := CriminalRecords_Services.SearchService_Records.val(tempmod);
						out_layout  xfm_Crim_recs(Crim_recs cr) := TRANSFORM
                    	SELF.source_doc_type := StateWide_Services.constants.constant('CR');
                    	SELF.record_id       := (String)cr.offenderid;
											SELf.penalt          := PenaltyI.get_Crim_penalt(cr);
	                    SELF.Jurisdiction    := Address.Map_State_Name_To_Abbrev(StringLib.StringToUpperCase(cr.stateoforigin));
                    	SELF.full_name       := BuildName(cr.name.first,cr.name.middle,cr.name.last);
                    	SELF.fname           := cr.name.first;
                    	SELF.lname           := cr.name.last;
                    	SELF.mname           := cr.name.middle;
										  SELF.company_name    := '';
											SELF.prim_range      := cr.address.streetnumber;
											SELF.predir          := cr.address.streetpredirection;
											SELF.prim_name       := cr.address.streetname;
											SELF.addr_suffix     := cr.address.streetsuffix;
											SELF.postdir         := cr.address.streetpostdirection;
											SELF.unit_desig      := cr.address.unitdesignation;
											SELF.sec_range       := cr.address.unitnumber;
											SELF.v_city_name     := cr.address.city;
											SELF.p_city_name     := cr.address.city;
											SELF.st              := cr.address.state;
											SELF                 := cr.address;
										 	SELF.id              := (unsigned6)cr.uniqueid;
                      SELf.ssn             := cr.ssn;
                      SELf.dob             := IF(cr.dob.year>0 OR cr.dob.month >0 OR cr.dob.day >0
											                           ,INTFORMAT(cr.dob.year,4,1)
																								 +INTFORMAT(cr.dob.month,2,1)
																								 +INTFORMAT(cr.dob.day,2,1),'');
         							SELF                 := cr;
                    	SELF                 := [];
            END;
						recs := SORT(PROJECT(Crim_recs,xfm_Crim_recs(LEFT))
															,penalt,jurisdiction,-id,record_id);
        		RETURN CHOOSEN(recs,max_limit);
        END;

				//*****  Targus White Pages Search
				
				EXPORT FAP_SearchTargusWhitePages() := FUNCTION
						
					dids := doxie.Get_Dids(TRUE,TRUE);
				
				  // Perform Targus White Pages search. 
					targus_recs_1 := JOIN(dids, Targus.Key_Targus_DID, LEFT.did = RIGHT.did, LIMIT(2000));
					
					targus_recs := PROJECT(targus_recs_1,targus.layout_consumer_out);
					
													
					// Slim down the recordset to only what we need.
					out_layout  xfm_Targus_recs(targus_recs t) := TRANSFORM
						SELF.source_doc_type := StateWide_Services.constants.constant('WP');
						SELF.id              := t.did;
						SELF.jurisdiction    := t.st;            // l.state contains the same data.
						SELF.mname           := t.minit;		
						SELF.full_name       := BuildName(t.fname,t.minit,t.lname);
						SELF.addr_suffix     := t.suffix;
						SELF.v_city_name     := t.city_name;
						SELF.zip5            := t.zip;
						SELF.Phone           := t.phone_number;
						SELF.penalt          := PenaltyI.get_Targus_penalt(t);
						SELF                 := t;
						SELF                 := [];
					END; 
					
					recs := SORT(PROJECT(targus_recs,xfm_Targus_recs(LEFT))
											,penalt,jurisdiction,-id,record_id);
				  RETURN CHOOSEN(recs,max_limit);
					
		    END;							
	END;
	
END;