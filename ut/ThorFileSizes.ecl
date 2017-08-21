

//output(FileServices.SuperFileContents('~thor_data400::in::intrado_exb',true));
//output(nothor(FileServices.LogicalFileList('thor_data400::in::intrado_exb',true,true)));

//output(FileServices.LogicalFileSuperOwners('thor_data400::in::intrado::20061101::ll_i047_0002_20061024.exb'))












my_record :=  record
    string1 superfile := '';
	string100 Name := '';

	unsigned8 m_size;
	string20 m_modified := '';
	string20 m_cluster := '';
	string20 m_owner := '';
	string100 pathname := '';
	string100 filename := '';
	end;

newdataset := nothor(FileServices.LogicalFileList(,true,false)(size < 100000000000000 AND not(regexfind('[^:]:[^:]',name))));

my_record project_my_record(newdataset l) := transform
	self.Name := trim(l.name);
	self.m_size := l.size;
	self.m_cluster := trim(l.cluster);
	self.m_modified := trim(l.modified);
	self.m_owner := trim(l.owner);
	self.superfile := if(FileServices.FileExists('~'+l.Name),
			if(FileServices.LogicalFileSuperOwners('~'+l.Name)[1].name = '' , 'N', 'Y'),'N');
	//self.superfile := if(FileServices.FileExists(l.Name),
		//	if(FileServices.LogicalFileSuperOwners(l.Name)[1].name = '' , 'N', 'Y'),'N');
end;


newproject := project(newdataset,project_my_record(left));

//output(newproject(superfile = 'Y'));



newsort := sort(newproject,-m_size);

//output(newsort,,'~thor_data400::in::logical_file_list_thor_dell400_2',overwrite);


new_record := record
	string100 Name;
	unsigned8 m_size;
	string20 m_modified;
	string20 m_cluster;
	string20 m_owner;
	string1 superfile;
	string100 pathname;
	string100 filename;
	string35 name_token1;
	string35 name_token2;
	string35 name_token3;
	string35 name_token4;
	string35 name_token5;
	string35 name_token6;
	string35 name_token7;
end;

new_record parse_name(newsort l) := transform

self.name_token1 := if(Stringlib.StringFind(l.Name,'::',1) <>0,l.Name[1..Stringlib.StringFind(l.Name,'::',1)-1] , l.Name);

self.name_token2 := if(Stringlib.StringFind(l.Name,'::',2)<>0,
				l.Name[Stringlib.StringFind(l.Name,'::',1)+2..Stringlib.StringFind(l.Name,'::',2)-1] , 
				if(Stringlib.StringFind(l.Name,'::',1) = 0 , '' ,
				trim(l.Name[Stringlib.StringFind(l.Name,'::',1)+2..100])));

self.name_token3 := if(Stringlib.StringFind(l.Name,'::',3)<>0,
				l.Name[Stringlib.StringFind(l.Name,'::',2)+2..Stringlib.StringFind(l.Name,'::',3)-1] , 
				if(Stringlib.StringFind(l.Name,'::',2) = 0 , '' ,
				trim(l.Name[Stringlib.StringFind(l.Name,'::',2)+2..100])));

self.name_token4 := if(Stringlib.StringFind(l.Name,'::',4)<>0,
				l.Name[Stringlib.StringFind(l.Name,'::',3)+2..Stringlib.StringFind(l.Name,'::',4)-1] , 
				if(Stringlib.StringFind(l.Name,'::',3) = 0 , '' ,
				trim(l.Name[Stringlib.StringFind(l.Name,'::',3)+2..100])));

self.name_token5 := if(Stringlib.StringFind(l.Name,'::',5)<>0,
				l.Name[Stringlib.StringFind(l.Name,'::',4)+2..Stringlib.StringFind(l.Name,'::',5)-1] , 
				if(Stringlib.StringFind(l.Name,'::',4) = 0 , '' ,
				trim(l.Name[Stringlib.StringFind(l.Name,'::',4)+2..100])));

self.name_token6 := if(Stringlib.StringFind(l.Name,'::',6)<>0,
				l.Name[Stringlib.StringFind(l.Name,'::',5)+2..Stringlib.StringFind(l.Name,'::',6)-1] , 
				if(Stringlib.StringFind(l.Name,'::',5) = 0 , '' ,
				trim(l.Name[Stringlib.StringFind(l.Name,'::',5)+2..100])));				

self.name_token7 := if(Stringlib.StringFind(l.Name,'::',7)<>0,
				l.Name[Stringlib.StringFind(l.Name,'::',6)+2..Stringlib.StringFind(l.Name,'::',7)-1] , 
				if(Stringlib.StringFind(l.Name,'::',6) = 0 , '' ,
				trim(l.Name[Stringlib.StringFind(l.Name,'::',6)+2..100])));	

self := l

end;
test_records := project(newsort,parse_name(left));

//test_sorted := sort(distribute(test_records,hash(Name)),Name,local);




string4 map_tokens(string st) := function
return
	map( // the top half does directories ... we want more stuff here
	st = '' => '9999',
	st = 'header' => '8351' ,
	st = 'property' => '8377' ,
	st = 'ln_property' => '8377', 
	st = 'vehicle' => '8367', 
	st = 'business_header' => '8367',
	st = 'corp' => '8314',
	st = 'corp2' => '8314',
	st = 'corp2_services' => '8314',
	st = 'corpv1' => '8314',
	st = 'infousa' => '8500',
	st = 'criminal_offenses' => '8336',
	st = 'liens' => '8361',
	st = 'zoom' => '8409',
	st = 'targus' => '8409',
	st = 'daybatch_pcnsr' => '8373',
	st = 'daybatchpcnsr' => '8373',
	st = 'yellowpages' => '8403',
	st = 'qsent' => '8375',
	st = 'criminal_offenses' => '8336',
	st = 'criminal_offenders' => '8336',
	st = 'liensv2' => '8361',
	st = 'dl' => '8327',
	st = 'patriot' => '8371',
	st = 'ficititious_business_names' => '8371',
	st = 'bbb' => '8305',
	// the bottom half does file name matching... we want to get rid of all of these in the long run
	Stringlib.StringFind(st,'header',1)<>0 => '8351',
	Stringlib.StringFind(st,'fares',1)<>0 => '8377',
	Stringlib.StringFind(st,'asses',1)<>0 => '8377',
	Stringlib.StringFind(st,'deed',1)<>0 => '8377',
	Stringlib.StringFind(st,'property',1)<>0 => '8377',
	Stringlib.StringFind(st,'vehicle',1)<>0 => '8367',
	Stringlib.StringFind(st,'vehreg',1)<>0 => '8367',
	Stringlib.StringFind(st,'vehout',1)<>0 => '8367',
	Stringlib.StringFind(st,'veh_',1)<>0 => '8367',
	Stringlib.StringFind(st,'vote',1)<>0 => '8399',
	Stringlib.StringFind(st,'gong',1)<>0 => '8325',
	Stringlib.StringFind(st,'amt.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'amt_master',1)<>0 => '8325',
	Stringlib.StringFind(st,'ban.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'bas.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'bs.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'cin.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'gte.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'lsi.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'lsi_master',1)<>0 => '8325',
	Stringlib.StringFind(st,'lsp.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'lss.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'nev.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'pac.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'pr.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'pr_master',1)<>0 => '8325',
	Stringlib.StringFind(st,'qst.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'qst_master',1)<>0 => '8325',
	Stringlib.StringFind(st,'spr.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'swb.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'snt.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'usw.master',1)<>0 => '8325',
	Stringlib.StringFind(st,'lsp',1)<>0 => '8325',
	Stringlib.StringFind(st,'lss',1)<>0 => '8325',
	Stringlib.StringFind(st,'lsi.',1)<>0 => '8325',
	Stringlib.StringFind(st,'watchdog',1)<>0 => '8401',
	Stringlib.StringFind(st,'people_at_work',1)<>0 => '8372',
	Stringlib.StringFind(st,'amt_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'amt.history',1)<>0 => '8324',
	Stringlib.StringFind(st,'bs_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'ban_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'bas_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'cin_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'gte_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'lssi_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'lsi_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'qst_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'nev_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'pac_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'swb_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'snt_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'spr_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'usw_history',1)<>0 => '8324',
	Stringlib.StringFind(st,'flcrash',1)<>0 => '8301',
	Stringlib.StringFind(st,'bankrupt',1)<>0 => '8304',
	Stringlib.StringFind(st,'bkrupt',1)<>0 => '8304',
	Stringlib.StringFind(st,'bk_',1)<>0 => '8304',
	Stringlib.StringFind(st,'eq_',1)<>0 => '8307',
	Stringlib.StringFind(st,'bh_',1)<>0 => '8307',
	Stringlib.StringFind(st,'busreg',1)<>0 => '8308',
	Stringlib.StringFind(st,'court',1)<>0 => '8311',
	Stringlib.StringFind(st,'civil',1)<>0 => '8311',
	Stringlib.StringFind(st,'emerge',1)<>0 => '8313',
	Stringlib.StringFind(st,'corp_',1)<>0 => '8314',
	Stringlib.StringFind(st,'corporate',1)<>0 => '8314',
	Stringlib.StringFind(st,'corp4_',1)<>0 => '8314',
	Stringlib.StringFind(st,'ln_tu',1)<>0 => '8314',
	Stringlib.StringFind(st,'ucc',1)<>0 => '8395',
	Stringlib.StringFind(st,'phonesplus',1)<>0 => '8375',
	Stringlib.StringFind(st,'official_rec',1)<>0 => '8370',
	
	Stringlib.StringFind(st,'dnb',1)<>0 => '8395',
	Stringlib.StringFind(st,'hss',1)<>0 => '8390',
	Stringlib.StringFind(st,'criminal_offense',1)<>0 => '8336',
	Stringlib.StringFind(st,'crim_offen',1)<>0 => '8316',
	Stringlib.StringFind(st,'prof_license',1)<>0 => '8376',
	Stringlib.StringFind(st,'prolic',1)<>0 => '8376',
	Stringlib.StringFind(st,'business_rel',1)<>0 => '8307',
	Stringlib.StringFind(st,'employment',1)<>0 => '8307',
	Stringlib.StringFind(st,'watercraft',1)<>0 => '8307',
	Stringlib.StringFind(st,'infousa_',1)<>0 => '8500',
	Stringlib.StringFind(st,'info_usa_',1)<>0 => '8500',
	Stringlib.StringFind(st,'relative',1)<>0 => '8382',
	Stringlib.StringFind(st,'fcra_crim',1)<>0 => '8336',
	Stringlib.StringFind(st,'lien',1)<>0 => '8361',
	Stringlib.StringFind(st,'sex',1)<>0 => '8387',
	Stringlib.StringFind(st,'hdr',1)<>0 => '8351',
	Stringlib.StringFind(st,'qsent',1)<>0 => '8375',
	Stringlib.StringFind(st,'util',1)<>0 => '8398',
	Stringlib.StringFind(st,'correction',1)<>0 => '8316',
	Stringlib.StringFind(st,'marriage',1)<>0 => '8365',
	Stringlib.StringFind(st,'white_page',1)<>0 => '8403',
	Stringlib.StringFind(st,'fldl',1)<>0 => '8327',
	Stringlib.StringFind(st,'drvlic',1)<>0 => '8327',
	Stringlib.StringFind(st,'death_',1)<>0 => '8322',
	Stringlib.StringFind(st,'fictitious',1)<>0 => '8307',
	Stringlib.StringFind(st,'cellphones_',1)<>0 => '8375',
	Stringlib.StringFind(st,'gov_phone',1)<>0 => '8307',
	Stringlib.StringFind(st,'crim',1)<>0 => '8316',
	Stringlib.StringFind(st,'irs_non',1)<>0 => '8359',
	
	Stringlib.StringFind(st,'arrest',1)<>0 => '8316',
	Stringlib.StringFind(st,'ebr_',1)<>0 => '8328',
	Stringlib.StringFind(st,'faa_air',1)<>0 => '8330',
	Stringlib.StringFind(st,'airmen_data',1)<>0 => '8331',
	Stringlib.StringFind(st,'dlsearch',1)<>0 => '8327',
	Stringlib.StringFind(st,'lntu',1)<>0 => '8388',
	Stringlib.StringFind(st,'ingenix',1)<>0 => '8355',
	Stringlib.StringFind(st,'best_address',1)<>0 => '8400',
	Stringlib.StringFind(st,'accutrend',1)<>0 => '8307',
	Stringlib.StringFind(st,'abius',1)<>0 => '8307',
	Stringlib.StringFind(st,'flmv',1)<>0 => '8327',
	Stringlib.StringFind(st,'txmv',1)<>0 => '8327',
	Stringlib.StringFind(st,'nvmv',1)<>0 => '8327',
	Stringlib.StringFind(st,'ndmv',1)<>0 => '8327',
	Stringlib.StringFind(st,'dl_',1)<>0 => '8327',
	Stringlib.StringFind(st,'address_cache',1)<>0 => '9998',
	Stringlib.StringFind(st,'moxie.mv',1)<>0 => '8367',
	Stringlib.StringFind(st,'moxie.bh',1)<>0 => '8307',
	Stringlib.StringFind(st,'moxie.dl',1)<>0 => '8327',
	Stringlib.StringFind(st,'student',1)<>0 => '8329',
	Stringlib.StringFind(st,'yellowpages',1)<>0 => '8407',
	Stringlib.StringFind(st,'risk_ind',1)<>0 => '8352',
	Stringlib.StringFind(st,'targus_con',1)<>0 => '8403',
	Stringlib.StringFind(st,'death',1)<>0 => '8322',
	Stringlib.StringFind(st,'forclos',1)<>0 => '8377',
	Stringlib.StringFind(st,'eviction',1)<>0 => '8340',
	Stringlib.StringFind(st,'bbb_',1)<>0 => '8305',
	Stringlib.StringFind(st,'prof_src_',1)<>0 => '8376',
	Stringlib.StringFind(st,'irs5500',1)<>0 => '8358',
	Stringlib.StringFind(st,'irs_5500',1)<>0 => '8358',
	Stringlib.StringFind(st,'wildcard',1)<>0 => '8367',
	Stringlib.StringFind(st,'fein',1)<>0 => '8307',
	Stringlib.StringFind(st,'cellphone',1)<>0 => '8375',
	Stringlib.StringFind(st,'daybatch',1)<>0 => '8373',
	Stringlib.StringFind(st,'rel_name',1)<>0 => '8382',
	Stringlib.StringFind(st,'vina',1)<>0 => '8367',
	Stringlib.StringFind(st,'em_src',1)<>0 => '8388',
	Stringlib.StringFind(st,'eqcontac',1)<>0 => '8307',
	
	Stringlib.StringFind(st,'infutor',1)<>0 => 'X001',
	
	'9999');
end;

// giant map here
mapped_record := record
	string100 Name;
	string20 m_size;
	string20 m_modified;
	string20 m_cluster;
	string20 m_owner;
	string1 superfile;
	string100 pathname;
	string100 filename;
	string35 name_token1;
	string4  token1_value;
	string35 name_token2;
	string4  token2_value;	
	string35 name_token3;
	string4  token3_value;
	string35 name_token4;
	string4  token4_value;
	string35 name_token5;
	string4  token5_value;
	string35 name_token6;
	string4  token6_value;
	string35 name_token7;
	string4  token7_value;
	string4 best_value;
end;

mapped_record map_record(test_records l) := transform

self.m_size :=  (string20) l.m_size;
self.token1_value := map_tokens(l.name_token1);
self.token2_value := map_tokens(l.name_token2);
self.token3_value := map_tokens(l.name_token3);
self.token4_value := map_tokens(l.name_token4);
self.token5_value := map_tokens(l.name_token5);
self.token6_value := map_tokens(l.name_token6);
self.token7_value := map_tokens(l.name_token7);
self.best_value := '';
self := l;
end;

final_records := project(test_records,map_record(left));

mapped_record set_best_value(mapped_record l) := transform

self.pathname := '/c$/thordata/' + Stringlib.StringFindReplace(l.Name,'::','/');
self.filename := 
			if(l.name_token7 <> '',l.name_token7,
			if(l.name_token6 <> '',l.name_token6,
			if(l.name_token5 <> '',l.name_token5,
			if(l.name_token4 <> '',l.name_token4,
			if(l.name_token3 <> '',l.name_token3,
			if(l.name_token2 <> '',l.name_token2,
			if(l.name_token1 <> '',l.name_token1,''
			)))))));
self.best_value := 
			if(l.token1_value <> '9999',l.token1_value,
			if(l.token2_value <> '9999',l.token2_value,
			if(l.token3_value <> '9999',l.token3_value,
			if(l.token4_value <> '9999',l.token4_value,
			if(l.token5_value <> '9999',l.token5_value,
			if(l.token6_value <> '9999',l.token6_value,
			if(l.token7_value <> '9999',l.token7_value,'9999'
			)))))));
self := l;
end;
best_records := project(final_records,set_best_value(left));

//output(best_records(superfile = 'Y'));



export ThorFileSizes := 


sequential
(
output(best_records,,'~thor_data400::in::logical_file_list',overwrite),
Fileservices.Despray('~thor_data400::in::logical_file_list','192.168.0.39',
 									'/export/home/hozed/thor_file_sizes/data_files.d00',,,,TRUE)
//output(choosen(best_records(best_value = '9999'),10000))

);




