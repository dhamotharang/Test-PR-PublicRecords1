EXPORT CapOne_Dictionary := MODULE

	export values := DATASET([
		{'PEP_DHDSNG','~thor::dowjones::xg::djpdhdsng', 'PEP-Domestic Heads and Deputies State Nat Govt','d2f8da64-6952-4187-b36c-758bb9cb2036'},
		{'PEP_DNGM','~thor::dowjones::xg::djpdngm', 'PEP-Domestic Nat Govt Ministers','feca3c53-f805-433d-af50-5f6bf1e78261'},
		{'PEP_DMNL','~thor::dowjones::xg::dpdmnl', 'PEP-Domestic Members of the Nat Legislature','c4fe6e16-ea62-49e5-bbd5-54db1103cb15'},
		{'PEP_DSCSNG','~thor::dowjones::xg::djpdscsnl', 'PEP-Domestic Senior Civil Servants-Nat Govt','09d7ae90-1bcf-48fa-97db-ae6852c9d97f'},
		{'PEP_DSCSRG','~thor::dowjones::xg::djpdscsrg', 'PEP-Domestic Senior Civil Servants-Reg Govt','101cd3b3-11ab-4519-900e-33656e9e6d30'},
		
		{'PEP_DECS','~thor::dowjones::xg::djpdecs', 'PEP-Domestic Embassy and Consular Staff','afe2fa10-8708-4e60-9fae-e22772c6c0a7'},
		{'PEP_DSMAF','~thor::dowjones::xg::djpdsmaf', 'PEP-Domestic Senior Members of the Armed Forces','0f99866d-1e0e-443e-8ec1-9cf6740502d7'},
		{'PEP_DSMPS','~thor::dowjones::xg::djpdsmps', 'PEP-Domestic Senior Members of the Police Services','212554c4-6732-4926-af61-f6d48ad4fb0e'},
		{'PEP_DSMSS','~thor::dowjones::xg::djpdsmss', 'PEP-Domestic Senior Members of the Secret Services','4168e283-272c-472e-bab2-cebe026ca550'},
		{'PEP_DSMJ','~thor::dowjones::xg::djpdsmj', 'PEP-Domestic Senior Members of the Judiciary','cff3693b-e4dd-41bd-aba8-9871ffcd0ce5'},

		{'PEP_DSCE','~thor::dowjones::xg::djpdsce', 'PEP-Domestic State Corporation Executives','48e75aa5-80b1-4e68-a444-c1a538b542ac'},
		{'PEP_DSAO','~thor::dowjones::xg::djpdsao', 'PEP-Domestic State Agency Officials','042a0431-4bd2-4674-a3e0-21442d4acf52'},
		{'PEP_DHDHRG','~thor::dowjones::xg::djpdhdhrg', 'PEP-Domestic Heads and Deputy Heads of Reg Govt','00ea605d-c5de-4e2f-beb6-43c7ab04d438'},
		{'PEP_DRGM','~thor::dowjones::xg::djpdrgm', 'PEP-Domestic Reg Govt Ministers','d4a67162-0e32-4885-8a69-84788baae2eb'},
		{'PEP_DRL','~thor::dowjones::xg::djpdrl', 'PEP-Domestic Religious Leaders','925fad06-29f0-4831-a75d-f09bfdf66386'},
		
		{'PEP_DPPO','~thor::dowjones::xg::djpdppo', 'PEP-Domestic Pol Party Officials','efa62aa2-6487-48b6-918e-9d07392b00c1'},
		{'PEP_DIOO','~thor::dowjones::xg::djpdioo', 'PEP-Domestic International Org Officials','07cf90d6-3edf-4dd4-b90d-5f8dcba9c8d8'},
		{'PEP_DCM','~thor::dowjones::xg::djpdcm', 'PEP-Domestic City Mayors','f441cc67-3a2d-41ff-8919-203deb6ab362'},
		{'PEP_DPPLGO','~thor::dowjones::xg::djpdpplgo', 'PEP-Domestic Pol Pressure and Labor Grp Officials','45d547d5-a15b-45b7-88d1-70e800f9b05a'},
		{'PEP_DO','~thor::dowjones::xg::djpdo', 'PEP-Domestic Other','bf1c2add-2def-478b-986c-055e9194178c'},
		
		//{'PEP_DNNO','~thor::dowjones::xg::djpdnno', 'PEP-Domestic National NGO Officials','40103125-415f-4731-977f-81d413ad59ae'},
		{'PEP_DSL','~thor::dowjones::xg::djpdsl', 'PEP-Domestic Special Lists','be1eae95-e194-4329-8997-758412785c9b'},
		
		{'PEP_FHDSNG','~thor::dowjones::xg::djpfhdsng', 'PEP-Foreign Heads and Deputies State Nat Govt','d59f639d-36f3-4c34-b887-eb7e4d6593c9'},
		{'PEP_FNGM','~thor::dowjones::xg::djpfngm', 'PEP-Foreign Nat Govt Ministers','9abe0210-7b99-405a-bcf6-a412fdf996c5'},
		{'PEP_FMNL','~thor::dowjones::xg::dpfmnl', 'PEP-Foreign Members of the Nat Legislature','9a542864-6c3c-4b3d-b92b-85df086cb335'},		
		{'PEP_FSCSNG','~thor::dowjones::xg::djpfscsnl', 'PEP-Foreign Senior Civil Servants-Nat Govt','56c86554-2801-4954-9c15-d2940f610598'},
		{'PEP_FSCSRG','~thor::dowjones::xg::djpfscsrg', 'PEP-Foreign Senior Civil Servants-Reg Govt','c6fb5698-e322-433d-a39b-a30563ce9557'},

		{'PEP_FECS','~thor::dowjones::xg::djpfecs', 'PEP-Foreign Embassy and Consular Staff','4712503d-f56c-415e-862d-80e9028829c2'},
		{'PEP_FSMAF','~thor::dowjones::xg::djpfsmaf', 'PEP-Foreign Senior Members of the Armed Forces','aacac60c-6014-4e3a-8882-885530fa2154'},
		{'PEP_FSMPS','~thor::dowjones::xg::djpfsmps', 'PEP-Foreign Senior Members of the Police Services','c0503e94-2eb1-4063-862d-921eeb1d1767'},
		{'PEP_FSMSS','~thor::dowjones::xg::djpfsmss', 'PEP-Foreign Senior Members of the Secret Services','b74ca106-cc05-4b40-b579-47b472798e74'},
		{'PEP_FSMJ','~thor::dowjones::xg::djpfsmj', 'PEP-Foreign Senior Members of the Judiciary','e6d03241-c03b-43e1-9f54-cf7829263bbc'},

		{'PEP_FSCE','~thor::dowjones::xg::djpfsce', 'PEP-Foreign State Corporation Executives','95765b11-a197-4c77-b67d-607bcfcae21c'},
		{'PEP_FSAO','~thor::dowjones::xg::djpfsao', 'PEP-Foreign State Agency Officials','b869eb61-8e63-42c3-8e3c-939130ee911d'},
		{'PEP_FHDHRG','~thor::dowjones::xg::djpfhdhrg', 'PEP-Foreign Heads and Deputy Heads of Reg Govt','567bbdb1-6828-47c5-8650-e0f8f724571b'},
		{'PEP_FRGM','~thor::dowjones::xg::djpfrgm', 'PEP-Foreign Regional Govt Ministers','e034c0fb-e2a0-49a9-9c61-a7f2f88e3a79'},
		{'PEP_FRL','~thor::dowjones::xg::djpfrl', 'PEP-Foreign Religious Leaders','eff8e4a6-2665-4727-bcc3-d6f01f189b6a'},
	
		{'PEP_FPPO','~thor::dowjones::xg::djpfppo', 'PEP-Foreign Pol Party Officials','5b7e7a59-6b30-4d98-80eb-12250bd8bf50'},
		{'PEP_FIOO','~thor::dowjones::xg::djpfioo', 'PEP-Foreign International Org Officials','61fc63fd-9f6b-42e3-a601-95d7d045eea2'},
		{'PEP_FCM','~thor::dowjones::xg::djpfcm', 'PEP-Foreign City Mayors','f330cd6b-44e4-4d87-b28f-c42922755fe2'},
		{'PEP_FPPLGO','~thor::dowjones::xg::djpfpplgo', 'PEP-Foreign Pol Pressure and Labor Grp Officials','4b214e30-27d4-42a7-a215-fabd3d3e2ab9'},
		{'PEP_FO','~thor::dowjones::xg::djpfo', 'PEP-Foreign Other','b9322195-6585-4831-bcb3-ed6ae2cd582c'},

		//{'PEP_FNNO','~thor::dowjones::xg::djpfnno', 'PEP-Foreign National NGO Officials','e2cd9507-fc7e-46af-ad18-72a42a0d011b'},
		{'PEP_FSL','~thor::dowjones::xg::djpfsl', 'PEP-Foreign Special Lists','5da9077b-53be-449f-b1d4-86680fc796ac'},
		
		{'PEP_GDL','~thor::dowjones::xg::djpgdl', 'PEP-Global Deceased List','a4831037-1643-486b-ad83-3c0228384dd3'},
	
		{'SIP_C','~thor::dowjones::xg::djsipc', 'Special Interest Persons + Corruption','5503e04e-d775-4440-af31-1f9b8727e775'},
		{'SIP_FC','~thor::dowjones::xg::djsipfc', 'Special Interest Persons + Financial Crimes','8e4665fb-82c0-4079-8860-30f1b6eaf50f'},
		{'SIP_OC','~thor::dowjones::xg::djsipoc', 'Special Interest Persons + Organized Crimes','8bdc6557-133c-4110-95f0-cdd65863edfb'},
		{'SIP_TC','~thor::dowjones::xg::djsiptc', 'Special Interest Persons + Trafficking Crimes','7d5814df-24e9-4a94-8800-f364348ddc7a'},
		{'SIP_T','~thor::dowjones::xg::djsipt', 'Special Interest Persons + Terror','8a5c81b1-d636-40a9-88a3-3241fd7dd08f'},
		
		{'SIE_C','~thor::dowjones::xg::djsiec', 'Special Interest Entities + Corruption','7b808aeb-78b7-4670-9429-cbd4796af691'},
		{'SIE_FC','~thor::dowjones::xg::djsiefc', 'Special Interest Entities + Financial Crimes','e4a81423-4809-43f5-a9a3-03f4a308ef71'},
		{'SIE_OC','~thor::dowjones::xg::djsieoc', 'Special Interest Entities + Organized Crimes','97e50ab8-065e-4a3a-94aa-186d7761c2bf'},
		{'SIE_TC','~thor::dowjones::xg::djsietc', 'Special Interest Entities + Trafficking Crimes','c7d0acc1-a00d-4d63-bc5e-6a96aaa03460'},
		{'SIE_T','~thor::dowjones::xg::djsiet', 'Special Interest Entities + Terror','defba593-cbd5-41e4-a8ad-22909265d223'}

	], {string code, string lfn, string filename, string36 guid := '00000000-0000-0000-0000-000000000000'});

	export files := PROJECT(values, {string lfn, string filename});
	
	guids := DICTIONARY(values, {code => guid});
	export CodeToGuid(string code) := IF(code in guids, guids[code].guid, ERROR(code + ' not found in guid'));

	shared filenames := DICTIONARY(values, {code => filename});
	export CodeToFileName(string code) := IF(code in filenames, filenames[code].filename, ERROR(code + ' not found in filename'));

	shared lfns := DICTIONARY(values, {code => lfn});
	export CodeToLfn(string code) := IF(code in lfns, lfns[code].lfn, ERROR(code + ' not found in lfn'));
	
	export IsValidCode(string code) := code in filenames;

END;