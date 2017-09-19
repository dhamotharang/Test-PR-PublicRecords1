import scrubs_bk_search, scrubs,  Scrubs_bk_main, ut;
#OPTION('multiplePersistInstances',FALSE);

export proc_build_base(string filedate) := function
// Get the prod header version from production environment
// boolean_value := ut.IsNewProdHeaderVersion('bk_search') : stored('boolean_value');
// bboolean_value := ut.IsNewProdHeaderVersion('bk_search','bheader_file_version') : stored('bboolean_value');

	dummy_rec := record
		string dummyfield := '';
	end;
	dummyds := dataset([],dummy_rec);


	Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.proc_build_base_main_supp(BankruptcyV2.Mapping_BK_Main(false,false)),
												 Bankruptcyv2.BaseFileNames.dailymainv3,filedate,bld_bk_main_dly, 2,,true);
				 
	Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.BK_DidAndBdid_Daily(false,false),
												 Bankruptcyv2.BaseFileNames.dailysearchv3,filedate,bld_bk_search_dly,2,,true);
	//Adding dailymainv3 to superfile
	Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
												 Bankruptcyv2.BaseFileNames.dailymainv3,filedate,dbld_bk_main_dly, 2,,true,true);
	//Adding dailysearchv3 to superfile				   
	Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
												 Bankruptcyv2.BaseFileNames.dailysearchv3,filedate,dbld_bk_search_dly,2,,true,true);

	// Scrubs for main 
	//Transform to the layout that scrubs is expecting	
	layout_id := {bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp, unsigned8 unique_id} ; 

	layout_id tid(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp L,unsigned8 cnt) :=
     transform			
					self.unique_id		:= cnt	;						
					self := L;
		  end;

  In_bk_mainId       := project(BankruptcyV2.proc_build_base_main_supp(BankruptcyV2.Create_Full_Main_V3(false)),tid(left,counter)) 
	                      : PERSIST('~persist::build_bankruptcy_base_In_bk_mainId');
  // In_bk_mainId       := project(dataset(ut.foreign_prod+'thor_data400::base::bankruptcy::main_v3',
																			  // bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp,
																			  // flat),
														    // tid(left,counter)) : PERSIST('~persist::build_bankruptcy_base_In_bk_mainId');;

	file_to_scrub_main := project( In_bk_mainId , Scrubs_bk_main.Layout_bk_main);
	save_file_to_scrub_main := OUTPUT(file_to_scrub_main,,'~thor_data400::temp::bankruptcyv2::file_to_scrub_main::'+filedate,__COMPRESSED__,OVERWRITE);
 //Apply Scrubs
	scrub_file_step1_main := scrubs_bk_main.Scrubs.FromNone(file_to_scrub_main);
  
 //append bitmap to base
  dbuildbasemain := join( distribute(In_bk_mainId,hash(unique_id)),distribute(scrub_file_step1_main.BitmapInfile,hash(unique_id)), left.unique_id = right.unique_id , 
                          transform(bankruptcyV2.Layout_bankruptcy_main_v3.layout_bankruptcy_main_filing_supp, 
													self.scrubsbits1 := right.scrubsbits1, self := left), left outer, local); 
													
	Bankruptcyv2.MAC_SF_BuildProcess(dbuildbasemain,
										 Bankruptcyv2.BaseFileNames.mainv3,filedate,bld_bk_main, 2,,true);
																				
	// Scrubs for search 
	//Transform to the layout that scrubs is expecting	
	file_to_scrub_t := project( BankruptcyV2.Create_Full_Search_V3(false) , scrubs_bk_search.Layout_bk_search);
	// file_to_scrub_t := project(dataset(ut.foreign_prod+'thor_data400::base::bankruptcy::search_v3',
	                                   // BankruptcyV2.layout_bankruptcy_search_v3_supp_bip ,
																		 // flat),
														 // scrubs_bk_search.Layout_bk_search);
	save_file_to_scrub_t := OUTPUT(file_to_scrub_t,,'~thor_data400::temp::bankruptcyv2::file_to_scrub_t::'+filedate,__COMPRESSED__,OVERWRITE);
														 
	//Apply Scrubs
	scrub_file_step1 := scrubs_bk_search.Scrubs.FromNone(file_to_scrub_t);
	//append bitmap to base
  dbuildbase := project(scrub_file_step1.BitmapInfile,BankruptcyV2.layout_bankruptcy_search_v3_supp_bip);

	Bankruptcyv2.MAC_SF_BuildProcess(dbuildbase,
                       Bankruptcyv2.BaseFileNames.searchv3,filedate,bld_bk_search,2,,true);

	//Adding mainv3 to superfile
	Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
												 Bankruptcyv2.BaseFileNames.mainv3,filedate,dbld_bk_main, 2,,true,true);
	//Adding searchv3 to superfile				   
	Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
												 Bankruptcyv2.BaseFileNames.searchv3,filedate,dbld_bk_search,2,,true,true);

							 
	Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.Map_BK_V3_V2_Main,
												 Bankruptcyv2.BaseFileNames.mainv2,filedate,bld_bk_main_v2, 2,,true);
						 
	Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.Map_BK_V3_V2_Search,
												 Bankruptcyv2.BaseFileNames.searchv2,filedate,bld_bk_search_v2,2,,true);					   

	//Adding mainv2 to superfile
	Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
												 Bankruptcyv2.BaseFileNames.mainv2,filedate,dbld_bk_main_v2, 2,,true,true);
	//Adding searchv2 to superfile					   
	Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
												 Bankruptcyv2.BaseFileNames.searchv2,filedate,dbld_bk_search_v2,2,,true,true);					   


	return					   					 
	sequential(
											parallel(bld_bk_main_dly, 
											bld_bk_search_dly),
											dbld_bk_main_dly, 
											dbld_bk_search_dly,
											parallel(sequential(bld_bk_main, save_file_to_scrub_main),
															 sequential(bld_bk_search, save_file_to_scrub_t)),
											dbld_bk_main, 
											dbld_bk_search,
											parallel(bld_bk_main_v2,					
											bld_bk_search_v2),
											dbld_bk_main_v2,					
											dbld_bk_search_v2,	
											notify('Yogurt:BANKRUPTCY BASE BUILD COMPLETE','*')/*,
											bankruptcyv2.daily_count_stats_for_banko('nonfcra',,true,true,'build')*/
											
											);
											

end;
