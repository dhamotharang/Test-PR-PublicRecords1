import _control, address, globalwatchlists, mdr, std, ut;

export Proc_Build_BW_Base(string pFileDate) := function

	//Pull FSE Data from Uniqueid File
	new_filter 	:= GlobalWatchLists.File_In_BridgerWatchList;

	//////////////////////////////////////////////////////////////////////////

	//Find Entities
	Layout_Patriot tMain(new_filter pInput)	:= transform

			// Remove unprintable characters
			string	vCleanLname 			:=	regexreplace('[^ -~]+',(string)pInput.last_name,'');
			string	vCleanFname 			:=	regexreplace('[^ -~]+',(string)pInput.first_name,'');
			string	vCleanMname 			:=	regexreplace('[^ -~]+',(string)pInput.middle_name,'');
			string	vCleanFullname		:=	regexreplace('[^ -~]+',(string)pInput.full_name,'');
			
			string73	vCleanName			:=	map(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)	=	'INDIVIDUAL'	and	vCleanLname	<>	''	and	vCleanFname	<>	''	and	vCleanMname			<>	''	=>	address.CleanPersonLFM73(vCleanLname	+	' '	+	vCleanFname	+	' '	+	vCleanMname),
																				GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)	=	'INDIVIDUAL'	and	vCleanLname	<>	''	and	vCleanFname	<>	''	and vCleanMname			=		''	=>	address.CleanPersonLFM73(vCleanLname	+	' '	+	vCleanFname),
																				GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)	=	'INDIVIDUAL'	and	vCleanLname	=		''	and	vCleanFname	=		''	and	vCleanFullname	<>	''	=>	address.CleanPersonFML73(vCleanFullname),
																				''
																				);
			string	vTitle						:=	GlobalWatchLists.Functions.ustrClean(pInput.title);
			string	vComments2Upper		:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.comments);
			string	vCleanComments		:=	GlobalWatchLists.Functions.ustrClean(pInput.comments);
		
		self.pty_key										:= pInput.reference_id;
		self.source											:= GlobalWatchLists.Functions.ustrClean2Upper(pInput.watchListName);
		self.orig_pty_name							:= if(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)<>'VESSEL',
																				(string)pInput.full_name,
																				'');	
		self.orig_vessel_name						:= if(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)='VESSEL',
																				(string)pInput.full_name,
																				'');			
		self.name_type									:= '';
    self.cname											:= if(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type) not in ['INDIVIDUAL','VESSEL'],
																				(string)pInput.full_name,
																				'');
		self.title      								:= vCleanName[1..5];
		self.fname       								:= vCleanName[6..25];
		self.mname       								:= vCleanName[26..45];
		self.lname       								:= vCleanName[46..65];
		self.suffix 										:= vCleanName[66..70];
		self.a_score  									:= vCleanName[71..73];
		self.remarks_1 									:= (string)pInput.comments[1..75];
		self.remarks_2 									:= (string)pInput.comments[76..151];
		self.remarks_3 									:= (string)pInput.comments[152..227];
		self.remarks_4 									:= (string)pInput.comments[228..303];
		self.remarks_5 									:= (string)pInput.comments[304..379];
		self.remarks_6 									:= (string)pInput.comments[380..455];
		self.remarks_7 									:= (string)pInput.comments[456..531];
		self.remarks_8 									:= (string)pInput.comments[532..607];
		self.remarks_9									:= (string)pInput.comments[608..683];
		self.remarks_10 								:= (string)pInput.comments[684..759];
		self.remarks_11 								:= (string)pInput.comments[760..835];
		self.remarks_12 								:= (string)pInput.comments[836..911];
		self.remarks_13 								:= (string)pInput.comments[912..987];
		self.remarks_14 								:= (string)pInput.comments[988..1063];
		self.remarks_15 								:= (string)pInput.comments[1064..1139];
		self.remarks_16 								:= (string)pInput.comments[1140..1215];
		self.remarks_17 								:= (string)pInput.comments[1216..1291];
		self.remarks_18 								:= (string)pInput.comments[1292..1367];
		self.remarks_19 								:= (string)pInput.comments[1368..1443];
		self.remarks_20 								:= (string)pInput.comments[1444..1519];
		self.remarks_21 								:= (string)pInput.comments[1520..1595];
		self.remarks_22 								:= (string)pInput.comments[1596..1671];
		self.remarks_23 								:= (string)pInput.comments[1672..1747];
		self.remarks_24 								:= (string)pInput.comments[1748..1823];
		self.remarks_25 								:= (string)pInput.comments[1824..1899];
		self.remarks_26 								:= (string)pInput.comments[1900..1975];
		self.remarks_27 								:= (string)pInput.comments[1976..2051];
		self.remarks_28 								:= (string)pInput.comments[2052..2127];
		self.remarks_29 								:= (string)pInput.comments[2128..2203];
		self.remarks_30 								:= (string)pInput.comments[2204..2279];
		self.country										:= '';
		self.addr_1											:= '';
		self.addr_2											:= '';
		self.addr_3											:= '';
		self.addr_4											:= '';
		self.addr_5											:= '';
		self.addr_6											:= '';
		self.addr_7											:= '';
		self.addr_8											:= '';
		self.addr_9											:= '';
		self.addr_10										:= '';
		self.prim_range									:= '';
		self.predir											:= '';
		self.prim_name									:= '';
		self.addr_suffix								:= '';
		self.postdir										:= '';
		self.unit_desig									:= '';
		self.sec_range									:= '';
		self.p_city_name								:= '';
		self.v_city_name								:= '';
		self.st													:= '';
		self.zip												:= '';
		self.zip4												:= '';
		self.cart												:= '';
		self.cr_sort_sz									:= '';
		self.lot												:= '';
		self.lot_order									:= '';
		self.dpbc												:= '';
		self.chk_digit									:= '';
		self.record_type								:= '';
		self.ace_fips_st								:= '';
		self.county											:= '';
		self.geo_lat										:= '';
		self.geo_long										:= '';
		self.msa												:= '';
		self.geo_blk										:= '';
		self.geo_match									:= '';
		self.err_stat										:= '';
		//Added for CCPA-393
		self.global_sid                 :=  0;
		self.record_sid                 :=  0;
		self.did                        :=  0;
		//Added for DF-28226
		self.dt_effective_first := 0;
   self.dt_effective_last := 0;
   self.delta_ind := 0; // 0 - main record, 1 - incremental

		self														:=	pInput;
	end;

	ds_entity :=	project(new_filter, tMain(left));
	
	//////////////////////////////////////////////////////////////////////////

	//Normalize Aliases
	aliasTable := table(new_filter, 
								{integer aliasCount := count(aka_list.aka), 
								new_filter});
								
	aliasLayout := RECORD, maxlength(15000)
    string	Reference_id;
		string  id;
    string  type;
    string  category;
    unicode title;
    unicode first_name;
    unicode middle_name;
    unicode last_name;
    unicode generation;
    unicode full_name;
    unicode comments;
   END;

	aliasLayout getaliases(aliasTable l, integer c):= transform
		self.reference_id		:= l.reference_id;
		self 								:= l.aka_list.aka[c];
	end;

	aliasNorm := normalize(aliasTable, 
						left.aliasCount, 
						getaliases(left, counter));									

	//Map Aliases to Common Layout	
	Layout_Patriot tAlias(new_filter l, aliasNorm r):= transform
			
			string	vCleanLname 			:=	regexreplace('[^ -~]+',(string)r.last_name,'');
			string	vCleanFname 			:=	regexreplace('[^ -~]+',(string)r.first_name,'');
			string	vCleanMname 			:=	regexreplace('[^ -~]+',(string)r.middle_name,'');
			string	vCleanFullname		:=	regexreplace('[^ -~]+',(string)r.full_name,'');
			
			string73	vCleanName			:=	map(GlobalWatchLists.Functions.ustrClean2Upper(l.type)	=	'INDIVIDUAL'	and	vCleanLname	<>	''	and	vCleanFname	<>	''	and	vCleanMname			<>	''	=>	address.CleanPersonLFM73(vCleanLname	+	' '	+	vCleanFname	+	' '	+	vCleanMname),
																				GlobalWatchLists.Functions.ustrClean2Upper(l.type)	=	'INDIVIDUAL'	and	vCleanLname	<>	''	and	vCleanFname	<>	''	and vCleanMname			=		''	=>	address.CleanPersonLFM73(vCleanLname	+	' '	+	vCleanFname),
																				GlobalWatchLists.Functions.ustrClean2Upper(l.type)	=	'INDIVIDUAL'	and	vCleanLname	=		''	and	vCleanFname	=		''	and	vCleanFullname	<>	''	=>	address.CleanPersonFML73(vCleanFullname),
																				''
																				);
			string	vTitle						:=	GlobalWatchLists.Functions.ustrClean(r.title);
	
		self.pty_key										:= r.reference_id;
		self.source											:= GlobalWatchLists.Functions.ustrClean2Upper(l.watchListName);
		self.orig_pty_name							:= if(GlobalWatchLists.Functions.ustrClean2Upper(l.type)<>'VESSEL',
																				(string)r.full_name,
																				'');	
		self.orig_vessel_name						:= if(GlobalWatchLists.Functions.ustrClean2Upper(l.type)='VESSEL',
																				(string)r.full_name,
																				'');																				
		self.name_type									:= if(r.category <> '', 
																					StringLib.StringToUpperCase(r.category)+ ' ' + StringLib.StringToUpperCase(r.type), 
																					r.type);
		self.cname											:= if(GlobalWatchLists.Functions.ustrClean2Upper(l.type) not in ['INDIVIDUAL','VESSEL'],
																				(string)r.full_name,
																				'');
		self.title      								:= vCleanName[1..5];
		self.fname       								:= vCleanName[6..25];
		self.mname       								:= vCleanName[26..45];
		self.lname       								:= vCleanName[46..65];
		self.suffix 										:= vCleanName[66..70];
		self.a_score  									:= vCleanName[71..73];
		self.remarks_1 									:= (string)l.comments[1..75];
		self.remarks_2 									:= (string)l.comments[76..151];
		self.remarks_3 									:= (string)l.comments[152..227];
		self.remarks_4 									:= (string)l.comments[228..303];
		self.remarks_5 									:= (string)l.comments[304..379];
		self.remarks_6 									:= (string)l.comments[380..455];
		self.remarks_7 									:= (string)l.comments[456..531];
		self.remarks_8 									:= (string)l.comments[532..607];
		self.remarks_9 									:= (string)l.comments[608..683];
		self.remarks_10 								:= (string)l.comments[684..759];
		self.remarks_11 								:= (string)l.comments[760..835];
		self.remarks_12 								:= (string)l.comments[836..911];
		self.remarks_13 								:= (string)l.comments[912..987];
		self.remarks_14 								:= (string)l.comments[988..1063];
		self.remarks_15 								:= (string)l.comments[1064..1139];
		self.remarks_16 								:= (string)l.comments[1140..1215];
		self.remarks_17 								:= (string)l.comments[1216..1291];
		self.remarks_18 								:= (string)l.comments[1292..1367];
		self.remarks_19 								:= (string)l.comments[1368..1443];
		self.remarks_20 								:= (string)l.comments[1444..1519];
		self.remarks_21 								:= (string)l.comments[1520..1595];
		self.remarks_22 								:= (string)l.comments[1596..1671];
		self.remarks_23 								:= (string)l.comments[1672..1747];
		self.remarks_24 								:= (string)l.comments[1748..1823];
		self.remarks_25 								:= (string)l.comments[1824..1899];
		self.remarks_26 								:= (string)l.comments[1900..1975];
		self.remarks_27 								:= (string)l.comments[1976..2051];
		self.remarks_28 								:= (string)l.comments[2052..2127];
		self.remarks_29 								:= (string)l.comments[2128..2203];
		self.remarks_30 								:= (string)l.comments[2204..2279];
		self.country										:= '';
		self.addr_1											:= '';
		self.addr_2											:= '';
		self.addr_3											:= '';
		self.addr_4											:= '';
		self.addr_5											:= '';
		self.addr_6											:= '';
		self.addr_7											:= '';
		self.addr_8											:= '';
		self.addr_9											:= '';
		self.addr_10										:= '';
		self.prim_range									:= '';
		self.predir											:= '';
		self.prim_name									:= '';
		self.addr_suffix								:= '';
		self.postdir										:= '';
		self.unit_desig									:= '';
		self.sec_range									:= '';
		self.p_city_name								:= '';
		self.v_city_name								:= '';
		self.st													:= '';
		self.zip												:= '';
		self.zip4												:= '';
		self.cart												:= '';
		self.cr_sort_sz									:= '';
		self.lot												:= '';
		self.lot_order									:= '';
		self.dpbc												:= '';
		self.chk_digit									:= '';
		self.record_type								:= '';
		self.ace_fips_st								:= '';
		self.county											:= '';
		self.geo_lat										:= '';
		self.geo_long										:= '';
		self.msa												:= '';
		self.geo_blk										:= '';
		self.geo_match									:= '';
		self.err_stat										:= '';
		//Added for CCPA-393
		self.global_sid                 :=  0;
		self.record_sid                 :=  0;
		self.did                        :=  0;
		//Added for DF-28226
		self.dt_effective_first := 0;
   self.dt_effective_last := 0;
   self.delta_ind := 0; // 0 - main record, 1 - incremental
		self														:= r;
	end;
	
	ds_alias	:= join(sort(distribute(new_filter(reference_id<>''),hash(reference_id)),record,local),
										sort(distribute(aliasNorm(reference_id<>''),hash(reference_id)),record,local),
												left.reference_id = right.reference_id,
												tAlias(left,right),local);
												
	ds_all_names := DEDUP(SORT(ds_entity + ds_alias,RECORD,LOCAL),RECORD,LOCAL);
	
	//////////////////////////////////////////////////////////////////////////

	//Normalize Addresses
	addrTable := table(new_filter, 
								{integer addrCount := count(address_list.address), 
								new_filter});
								
	addrLayout := RECORD, maxlength(15000)
    string	Reference_id;
		string  id;
    string  type;
    unicode street_1;
    unicode street_2;
    unicode city;
    unicode state;
    unicode postal_code;
    unicode country;
    unicode comments;
   END;

	addrLayout getaddresses(addrTable l, integer c):= transform
		self.reference_id		:= l.reference_id;
		self 								:= l.address_list.address[c];
	end;

	addrNorm := normalize(addrTable, 
						left.addrCount, 
						getaddresses(left, counter));
	
	//Map Addresses to Common Layout
	Layout_Patriot stAddr(ds_all_names l, addrNorm r):= transform
		
			setUSStates							:=	[	'AL','AK','AZ','AR','CA','CO','CT','DE','DC','FL',
																		'GA','HI','ID','IL','IN','IA','KS','KY','LA','ME',
																		'MD','MA','MI','MN','MS','MO','MT','NE','NV','NH',
																		'NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI',
																		'SC','SD','TN','TX','UT','VT','VA','WA','WV','WI',
																		'WY'];
			
			string30	vAddress1			:=	if(	length(r.street_1)	>	0,
																			(string)r.street_1,
																			'');
																			
			string30	vAddress2			:=	if(	length(r.street_2)	>	0,
																			(string)r.street_2,
																			'');
																			
			string100	vCity					:=	GlobalWatchLists.Functions.ustrClean2Upper(r.city);
			string100	vState				:=	GlobalWatchLists.Functions.ustrClean2Upper(r.state);
			string10	vZip					:=	GlobalWatchLists.Functions.ustrClean2Upper(r.postal_code);
			string100	vCountry			:=  (string)r.country;

			string182	vCleanAddr182	:=	if(GlobalWatchLists.Functions.ustrClean2Upper(r.country)	=	'US'	or	regexfind(u'UNITED STATES',vCountry,nocase)	or GlobalWatchLists.Functions.ustrClean2Upper(vState)	in setUSStates,
																			Address.CleanAddress182(vAddress1	+	' '	+	vAddress2,vCity	+	' '	+	vState	+	' '	+	vZip),
																			'');
																
		self.country								:= if ( regexfind('OSFI',l.source,0) <> '','Iran',(string)r.country);
		self.addr_1									:= (string)r.street_1;
		self.addr_2									:= (string)r.street_2;
		self.addr_3									:= '';
		self.addr_4									:= '';
		self.addr_5									:= '';
		self.addr_6									:= '';
		self.addr_7									:= '';
		self.addr_8									:= '';
		self.addr_9									:= '';
		self.addr_10								:= '';
		self.prim_range							:= vCleanAddr182[1..10];
		self.predir									:= vCleanAddr182[11..12];
		self.prim_name							:= vCleanAddr182[13..40];
		self.addr_suffix						:= vCleanAddr182[41..44];
		self.postdir								:= vCleanAddr182[45..46];
		self.unit_desig							:= vCleanAddr182[47..56];
		self.sec_range							:= vCleanAddr182[57..64];
		self.p_city_name						:= vCleanAddr182[65..89];
		self.v_city_name						:= vCleanAddr182[90..114];
		self.st											:= vCleanAddr182[115..116];
		self.zip										:= vCleanAddr182[117..121];
		self.zip4										:= vCleanAddr182[122..125];
		self.cart										:= vCleanAddr182[126..129];
		self.cr_sort_sz							:= vCleanAddr182[130];
		self.lot										:= vCleanAddr182[131..134];
		self.lot_order							:= vCleanAddr182[135];
		self.dpbc										:= vCleanAddr182[136..137];
		self.chk_digit							:= vCleanAddr182[138];
		self.record_type						:= vCleanAddr182[139..140];
		self.ace_fips_st						:= vCleanAddr182[141..142];
		self.county									:= vCleanAddr182[143..145];
		self.geo_lat								:= vCleanAddr182[146..155];
		self.geo_long								:= vCleanAddr182[156..166];
		self.msa										:= vCleanAddr182[167..170];
		self.geo_blk								:= vCleanAddr182[171..177];
		self.geo_match							:= vCleanAddr182[178];
		self.err_stat								:= vCleanAddr182[179..182];
		self := l;
		self := r;
	end;
	
	ds_name_add	:= join(sort(distribute(ds_all_names,hash(pty_key)),record,local),
											sort(distribute(addrNorm(reference_id<>''),hash(reference_id)),record,local),
												left.pty_key = right.reference_id,
												stAddr(left,right),
												left outer,local);
												
	Layout_Patriot addKey(ds_name_add l):= transform
		self.pty_key := map ( l.source = 'OFAC NON-SDN ENTITIES' =>  'OFAC'+l.pty_key ,
		                      l.source = 'OSFI CONSOLIDATED LIST' and l.cname <> '' => 'OCE'+l.pty_key ,
													l.source = 'OSFI CONSOLIDATED LIST' and l.cname = ''  => 'OCI'+l.pty_key ,'' );
		self := l;
	end;
	
	ds_final := project(ds_name_add, addKey(left));
	
	addGlobalSID := mdr.macGetGlobalSID(ds_final, 'Patriot', 'source', 'global_sid'); //DF-26190: Populate Global_SID
												
	ds_out := output(addGlobalSID,,'~thor_data400::in::patriot_file_fse_raw_'+pFileDate);
	
	return ds_out;

end;