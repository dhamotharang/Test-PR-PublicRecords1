import ut, STD, header;

export proc_redid_bk(string filedate,string deletefile = 'no') := function
// Get the prod header version from production environment
pboolean_value := header.IsNewProdHeaderVersion('bk_search') : stored('pboolean_value');
bboolean_value := header.IsNewProdHeaderVersion('bk_search','bip_build_version') : stored('bboolean_value');

boolean_value := if (pboolean_value or bboolean_value, true, false);

dummy_rec := record
	string dummyfield := '';
end;
dummyds := dataset([],dummy_rec);


Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.proc_build_base_main_supp(BankruptcyV2.Mapping_BK_Main_ReDID(boolean_value,false),'yes'),
                       Bankruptcyv2.BaseFileNames.mainv3,filedate,bld_bk_main, 2,,true);
				   
Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.proc_build_base_main_supp(BankruptcyV2.file_bankruptcy_main_v3_supplemented,'yes'),
                       Bankruptcyv2.BaseFileNames.mainv3,filedate,bld_bk_main_only_delete, 2,,true);


Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.mac_patch_dummy(BankruptcyV2.BK_DidAndBdid(boolean_value,,false)),
                       Bankruptcyv2.BaseFileNames.searchv3,filedate,bld_bk_search,2,,true);

Bankruptcyv2.MAC_SF_BuildProcess(BankruptcyV2.mac_patch_dummy(BankruptcyV2.BK_DidAndBdid(boolean_value,'yes',false)),
                       Bankruptcyv2.BaseFileNames.searchv3,filedate,bld_bk_search_only_delete,2,,true);

Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
                       Bankruptcyv2.BaseFileNames.mainv3,filedate,dbld_bk_main, 2,,true,true);
				   
Bankruptcyv2.MAC_SF_BuildProcess(dummyds,
                       Bankruptcyv2.BaseFileNames.searchv3,filedate,dbld_bk_search,2,,true,true);

					   

return	if ( boolean_value and 
					ut.Weekday(Std.Date.Today()) = 'SUNDAY'
					,sequential(
										bld_bk_search, 
										dbld_bk_search,
										bld_bk_main,
										dbld_bk_main, 
										header.PostDID_HeaderVer_Update('bk_search'),
										header.PostDID_HeaderVer_Update('bk_search','bip_build_version'),
										output('Full re-did was successful'),
										fileservices.sendemail('christopher.brodeur@lexisnexis.com;batch.prc@lexisnexis.com;james.stockman@lexisnexis.com',
										'Bankruptcy Full re-did was successful '+ (STRING8)Std.Date.Today(),
										'workunit: ' + workunit);
								),
					if (deletefile = 'yes',sequential(
										bld_bk_search_only_delete,
										dbld_bk_search,
										bld_bk_main_only_delete,
										dbld_bk_main, 
										
									output('No Full re-did'),fileservices.sendemail('christopher.brodeur@lexisnexis.com',
										'No Bankruptcy Full re-did '+ (STRING8)Std.Date.Today(),
										'workunit: ' + workunit)),
									sequential(output('No Full re-did'),
									output('No new delete file'),fileservices.sendemail('christopher.brodeur@lexisnexis.com',
										'No Bankruptcy Full re-did or delete file processed'+ (STRING8)Std.Date.Today(),
										'workunit: ' + workunit)))
					);
										

end;
