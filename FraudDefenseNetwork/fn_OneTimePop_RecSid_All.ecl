import tools, FraudDefenseNetwork, data_services, lib_fileservices, _control;
export fn_OneTimePop_RecSid_All(STRING run_date) := function 

Location := IF(_control.ThisEnvironment.Name = 'Prod_Thor', '~', Data_Services.Foreign_Prod);

////Erie//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Erie_old  := DATASET(Location + 'thor_data400::base::fdn::qa::Erie',FraudDefenseNetwork.Layouts.Base.Erie, thor);

Erie_old2New := project(Erie_old, transform(FraudDefenseNetwork.Layouts.Base.Erie,        
                     self.record_SID := Constants().ErieRecIDSeries + left.source_rec_id;
                     self := left;
                    ));
                    
dErie_old2New :=   DISTRIBUTE(Erie_old2New, HASH32(claimnumber, cleaned_name.fname, cleaned_name.lname, typeofloss, dateofloss, dateio, findings, responsibleparty, policynumber, cleaned_name_cp.fname, cleaned_name_cp.lname, clean_business_name));             
                          
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.Erie.New, dErie_old2New, NewErieBase); 
 							 

////ErieWatchList//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Erie_Watchlist_old := DATASET(Location + 'thor_data400::base::fdn::qa::eriewatchlist', FraudDefenseNetwork.Layouts.Base.ErieWatchList, thor);

Erie_Watchlist_old2New := project(Erie_Watchlist_old, transform(FraudDefenseNetwork.Layouts.Base.ErieWatchList,        
                                                                RecordID := if(left.source = 'ERIE_WATCHLIST',  Constants().ErieWatchlistRecIDSeries + left.source_rec_id, 
                                                                Constants().ErieNICBWatchlistRecIDSeries + left.source_rec_id);
                                                                self.record_sid := RecordID;
                                                                self := left;
                                                                                          )); 

dErie_Watchlist_old2New :=   DISTRIBUTE(Erie_Watchlist_old2New, HASH32(alertnumber, cleaned_name.fname, cleaned_name.mname, cleaned_name.lname, 
                             clean_business_name, ssn, dob, validstartDate, entity));                                                                       

tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.ErieWatchlist.New, dErie_Watchlist_old2New, NewErieWatchlistBase);


////Glb5//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Glb5_old := DATASET(Location + 'thor_data400::base::fdn::qa::glb5', FraudDefenseNetwork.Layouts.Base.Glb5, thor);

// GLB5 Append Market information 
  inBaseGLB5_dist       := DISTRIBUTE(Glb5_old, HASH32(orig_company_id));
  MBSmarketAppend_dist  := DISTRIBUTE(Files().Input.MBSmarketAppend.Sprayed, HASH32(company_id));

	Glb5MarketAppend      := join(inBaseGLB5_dist, MBSmarketAppend_dist, left.orig_company_id = right.company_id,
                                              transform(FraudDefenseNetwork.Layouts.base.Glb5,
																							               self.sybase_company_id        := stringlib.stringtouppercase(right.company_id); 
																							               self.sybase_main_country_code := stringlib.stringtouppercase(right.main_country_code); 
																							               self.sybase_bill_country_code := stringlib.stringtouppercase(right.bill_country_code);
																							               self.sybase_app_type          := stringlib.stringtouppercase(right.app_type);
																							               self.sybase_market            := stringlib.stringtouppercase(right.market);
																							               self.sybase_sub_market        := stringlib.stringtouppercase(right.sub_market);
																							               self.sybase_vertical          := stringlib.stringtouppercase(right.vertical) ;
																							               self                          := left; 
																							               self                          := []), left outer, local);


// Source exlusions 

  FilterSet    := ['GOV', 'GOVERNMENT & ACADEMIC', 'GOVERNMENT', 'HEA', 'HEALTHCARE INITIATIVE', 'GOVERNMENT HEALTHCARE', 'INTERNAL', 'HC -   PROVIDER',  'TAX & REVENUE.FEDERAL','HEALTHCARE' , 'PROVIDER', 'PHARMACY' ,'PAYER'];
  SrcExclusion := set(Files().Input.MBSSourceGcExclusion.Sprayed (gc_id <>0  and status = 1), (string)gc_id); 
	SrcExclusionC := set(Files().Input.MBSSourceGcExclusion.Sprayed (gc_id <>0 and status = 1), (string)company_id); 
  Jfiltered    := Glb5MarketAppend(global_company_id   not in SrcExclusion ); 
	Jfiltered1   := Jfiltered(company_id    not in SrcExclusionC );
  JcountryCode := Jfiltered1(sybase_MAIN_COUNTRY_CODE = 'USA'); 
  Japptype     := JcountryCode(sybase_app_type          not in FilterSet ); 
  Jvertical    := Japptype (sybase_vertical             not in FilterSet ); 
  Jsub_market  := Jvertical(sybase_sub_market           not in FilterSet ); 
  Jmarket      := Jsub_market(sybase_market             not in FilterSet ):persist('temp::glb5_1'); 
   
   dInSegment   := project (Jmarket , transform( FraudDefenseNetwork.Layouts.base.Glb5, 

       self.Industry_segment := map( 
                              left.sybase_app_type in ['INS','AUTO','AIG','LIFE']    => 'INSURANCE' , 
			                        left.sybase_app_type in ['LE','LEG','USLM']      => 'LEGAL' , 
			                        left.sybase_app_type in ['TCOL', 'FCOL', 'COL','COLLECTIONS'] => 'COLLECTIONS' ,
															left.sybase_app_type ='IRB' => 'IRB',
			                        left.sybase_app_type = 'XBPS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'LEGAL',
															left.sybase_app_type = ''  and left.sybase_vertical not in [ 'CORE','','AUTO','USLM'] => left.sybase_vertical ,
			                        left.sybase_app_type = ''  and left.sybase_vertical in [ 'CORE',''] 
															and left.sybase_sub_market = 'PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS' , 'OTHERS'); 
				
				self.sybase_app_type  := map ( 	left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'LIFE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'AUTO',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'USLM',
															left.sybase_app_type = ''  and left.sybase_vertical ='COLLECTIONS' => 'COLLECTIONS',
															left.sybase_app_type = ''  and left.sybase_vertical ='EMERGING' => 'EMERGING',
															left.sybase_app_type = ''  and left.sybase_vertical ='FINANCIAL SERVICES' => 'FINANCIAL SERVICES',
															left.sybase_app_type = ''  and self.Industry_segment ='OTHERS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_sub_market ='PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS',
															left.sybase_app_type);
				
				self := left ));
				
				Jdedup := dedup(dInSegment,(unsigned)linkid, trim(company_id,left,right), trim(global_company_id,left,right) , trim(datetime[1..8],left,right),all );

Glb5_old2New := project(Jdedup, transform(FraudDefenseNetwork.Layouts.Base.Glb5,        
                        self.Record_SID := Constants().GLB5RecIDSeries + left.source_rec_id;
                        self := left;
                       ));

dGlb5_old2New :=   DISTRIBUTE(Glb5_old2New, HASH32(orig_company_id));
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.Glb5.New, dGlb5_old2New, NewGlb5Base);							 

               
////OIG//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
OIG_old  := DATASET(Location + 'thor_data400::base::fdn::qa::OIG', FraudDefenseNetwork.Layouts.Base.OIG, thor);

OIG_old2New := project(OIG_old, transform(FraudDefenseNetwork.Layouts.Base.OIG,        
                                                                     RecordID := if(left.addr_type = 'P', Constants().OIGIndividualRecIDSeries + left.source_rec_id, 
                                                                     Constants().OIGBusinessRecIDSeries + left.source_rec_id);
                                                                     self.Record_SID := RecordID;
                                                                     self := left;
                                                                    ));
                                                                    
dOIG_old2New :=   DISTRIBUTE(OIG_old2New, HASH32(did, bdid));                                                                    
                          
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.OIG.New, dOIG_old2New, NewOIGBase); 


////SuspectIP//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
SuspectIP_old  := DATASET(Location + 'thor_data400::base::fdn::qa::suspectip', FraudDefenseNetwork.Layouts.Base.SuspectIP, thor);

SuspectIP_old2New := project(SuspectIP_old, transform(FraudDefenseNetwork.Layouts.Base.SuspectIP,        
                             self.Record_SID := Constants().SuspectIPRecIDSeries + left.source_rec_id;
                             self := left;
                            ));

dSuspectIP_old2New := DISTRIBUTE(SuspectIP_old2New, HASH32(orig_ip)); 
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.SuspectIP.New, dSuspectIP_old2New, NewSuspectIPBase);							 


////TextMinedCrim//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
TextMinedCrim_old := DATASET(Location + 'thor_data400::base::fdn::qa::textminedcrim', FraudDefenseNetwork.Layouts.Base.TextMinedCrim, thor);

TextMinedCrim_old2New := project(TextMinedCrim_old, transform(FraudDefenseNetwork.Layouts.Base.TextMinedCrim,        
                                 self.Record_SID := Constants().TextMinedCrimRecIDSeries + left.source_rec_id;
                                 self := left;
                                ));
                                
dTextMinedCrim_old2New := DISTRIBUTE(TextMinedCrim_old2New, HASH32(did));                                
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.TextMinedCrim.New, dTextMinedCrim_old2New, NewTextMinedCrimBase);							 


////AInspection//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
AInspection_old := DATASET(Location + 'thor_data400::base::fdn::qa::ainspection', FraudDefenseNetwork.Layouts.Base.AInspection, thor);

AInspection_old2New := project(AInspection_old(length(trim(state,left,right)) <3), transform(FraudDefenseNetwork.Layouts.Base.AInspection,        
                               self.Record_SID := Constants().AInspectionRecIDSeries + left.source_rec_id;
                               self := left; 
                              ));

dAInspection_old2New := DISTRIBUTE(AInspection_old2New, HASH32(clean_address.prim_name)); 
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.AInspection.New, dAInspection_old2New, NewAInspectionBase);								 


////CFNA//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CFNA_old := DATASET(Location + 'thor_data400::base::fdn::qa::cfna', FraudDefenseNetwork.Layouts.Base.CFNA, thor);

CFNA_old2New := PROJECT(CFNA_old, transform(FraudDefenseNetwork.Layouts.Base.CFNA,        
                        self.Record_SID := Constants().CFNARecIDSeries + left.source_rec_id;
                        self := left; 
                       ));

dCFNA_old2New := DISTRIBUTE(CFNA_old2New, HASH32(Application_ID));
							 
tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.CFNA.New, dCFNA_old2New, NewCFNABase);							 


////Tiger//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Tiger_old := DATASET(Location + 'thor_data400::base::fdn::qa::tiger', FraudDefenseNetwork.Layouts.Base.tiger, thor);

Tiger_old2New := PROJECT(Tiger_old, transform(FraudDefenseNetwork.Layouts.Base.tiger,        
                         self.Record_SID := Constants().TigerRecIDSeries + left.source_rec_id;
                         self := left;
                        ));

dTiger_old2New := DISTRIBUTE(Tiger_old2New, HASH32(app_number));

tools.mac_WriteFile(FraudDefenseNetwork.Filenames(run_date).Base.Tiger.New, dTiger_old2New, NewTigerBase);	                           

OneTimePop_RecSid_All := Sequential(
                                    NewErieBase, 
                                    NewErieWatchlistBase,
                                    NewGlb5Base, 
                                    NewOIGBase,
                                    NewSuspectIPBase, 
                                    NewTextMinedCrimBase, 
                                    NewAInspectionBase, 
                                    NewCFNABase, 
                                    NewTigerBase,
                                    FraudDefenseNetwork.Promote(run_date,,true,,,FraudDefenseNetwork.Filenames().base.dAll_filenames).buildfiles.New2Built,
                                    FraudDefenseNetwork.Promote(run_date,,true,,,FraudDefenseNetwork.Filenames().base.dAll_filenames).buildfiles.built2qa,
                                    FraudDefenseNetwork.Promote(run_date,,true,,,FraudDefenseNetwork.Filenames().base.dAll_filenames).buildfiles.cleanup
                                  );                   
return OneTimePop_RecSid_All;

END;