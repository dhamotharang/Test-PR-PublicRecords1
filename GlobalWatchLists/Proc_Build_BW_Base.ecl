import _control, address, globalwatchlists, mdr, std, ut;

export Proc_Build_BW_Base(string pFileDate) := function

	//Pull FSE Data from Uniqueid File
	new_filter 	:= File_In_BridgerWatchList;

	//////////////////////////////////////////////////////////////////////////

	//Find Entities
	globalwatchlists.Layout_Watchlist.entityLayout	tMain(new_filter pInput)	:= transform

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
		self.entity_type								:= if(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)='BUSINESS',
																					'Entity',
																					pInput.type);
    self.cname											:= if(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type) not in ['INDIVIDUAL','VESSEL'],
																				(string)pInput.full_name,
																				'');
		self.title      								:= vCleanName[1..5];
		self.fname       								:= vCleanName[6..25];
		self.mname       								:= vCleanName[26..45];
		self.lname       								:= vCleanName[46..65];
		self.suffix 										:= vCleanName[66..70];
		self.a_score  									:= vCleanName[71..73];
		self.date_first_seen						:= '';//ut.GetDate;
		self.date_last_seen							:= '';//ut.GetDate;
		self.date_vendor_first_reported	:= '';//ut.GetDate;
		self.date_vendor_last_reported	:= '';//ut.GetDate;
		self.entity_id									:= '';
		self.first_name									:= if(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)<>'VESSEL',
																					(string)pInput.first_name,
																					'');
		self.last_name									:= if(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)<>'VESSEL',
																					(string)pInput.last_name,
																					'');
		self.title_1										:=	map(regexfind('Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief,Myanmar Defense Services (Tatmadaw); Commander-in-Chief,Myanmar Army',vTitle,nocase)											=>	regexreplace('Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief,Myanmar Defense Services (Tatmadaw); Commander-in-Chief,Myanmar Army',vTitle,'Vice Sr. General;Vice-Chairman of the St. Peace & Dev. Council;Dpty Cmdr-in-Chief,Myanmar Defense Services (Tatmadaw);Cmdr-in-Chief,Myanmar Army',nocase),
																						regexfind('Brigadier General,Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff',vTitle,nocase)	=>	regexreplace('Brigadier General,Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff',vTitle,'Brigadier Gen,Cmdg Officer of Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps;Dpty Cmdr of Ramazan HQ;Chief of Staff of Iraq Crisis',nocase),
																						(string)pInput.title
																						);
		self.title_2										:= '';
		self.title_3										:= '';
		self.title_4										:= '';
		self.title_5										:= '';
		self.title_6										:= '';
		self.title_7										:= '';
		self.title_8										:= '';
		self.title_9										:= '';
		self.title_10										:= '';
		self.aka_id											:= '';		
		self.aka_type										:= '';
		self.aka_category								:= '';
		self.giv_designator							:= map(GlobalWatchLists.Functions.ustrClean2Upper(pInput.type)  = 'BUSINESS' 	=> 'G',
																						GlobalWatchLists.Functions.ustrClean2Upper(pInput.type) = 'INDIVIDUAL' => 'I',
																						GlobalWatchLists.Functions.ustrClean2Upper(pInput.type) = 'VESSEL' 		=> 'V',
																						GlobalWatchLists.Functions.ustrClean2Upper(pInput.type) = 'AIRCRAFT' 	=> 'A',
																						'');
		self.date_added_to_list					:=	Globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.ustrClean2Upper(pInput.listed_date));
		self.gender											:=	GlobalWatchLists.Functions.ustrClean2Upper(pInput.gender);
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
		self.linked_with_1							:= (string)pInput.comments[Stringlib.StringFind((string)pInput.comments,'(Linked To:', 1)+12..Stringlib.StringFind((string)pInput.comments,')', 1)-1];
		self.linked_with_2							:= '';
		self.linked_with_3							:= '';
		self.linked_with_4							:= '';
		self.linked_with_5							:= '';
		self.linked_with_6							:= '';
		self.linked_with_7							:= '';
		self.linked_with_8							:= '';
		self.linked_with_9							:= '';
		self.linked_with_10							:= '';	
		self.linked_with_id_1						:= '';
		self.linked_with_id_2						:= '';
		self.linked_with_id_3						:= '';			
		self.linked_with_id_4						:= '';
		self.linked_with_id_5						:= '';
		self.linked_with_id_6						:= '';
		self.linked_with_id_7						:= '';
		self.linked_with_id_8						:= '';
		self.linked_with_id_9						:= '';
		self.linked_with_id_10					:= '';
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
		self.type						:= l.type;
		self 								:= l.aka_list.aka[c];
	end;

	aliasNorm := normalize(aliasTable, 
						left.aliasCount, 
						getaliases(left, counter));
						

	//Map Aliases to Common Layout	
	globalwatchlists.Layout_Watchlist.entityLayout tAlias(new_filter l, aliasNorm r):= transform
			
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
		self.entity_type								:= if(GlobalWatchLists.Functions.ustrClean2Upper(l.type)='BUSINESS',
																					'Entity',
																					l.type);
		self.cname											:= if(GlobalWatchLists.Functions.ustrClean2Upper(l.type) not in ['INDIVIDUAL','VESSEL'],
																				(string)r.full_name,
																				'');
		self.title      								:= vCleanName[1..5];
		self.fname       								:= vCleanName[6..25];
		self.mname       								:= vCleanName[26..45];
		self.lname       								:= vCleanName[46..65];
		self.suffix 										:= vCleanName[66..70];
		self.a_score  									:= vCleanName[71..73];
		self.date_first_seen						:= '';//ut.GetDate;
		self.date_last_seen							:= '';//ut.GetDate;
		self.date_vendor_first_reported	:= '';//ut.GetDate;
		self.date_vendor_last_reported	:= '';//ut.GetDate;
		self.entity_id									:= '';
		self.first_name									:= if(GlobalWatchLists.Functions.ustrClean2Upper(l.type)<>'VESSEL',
																					(string)r.first_name,
																					'');
		self.last_name									:= if(GlobalWatchLists.Functions.ustrClean2Upper(l.type)<>'VESSEL',
																					(string)r.last_name,
																					'');
		self.title_1										:= map(regexfind('Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief,Myanmar Defense Services (Tatmadaw); Commander-in-Chief,Myanmar Army',vTitle,nocase)											=>	regexreplace('Vice Senior General; Vice-Chairman of the State Peace and Development Council; Deputy Commander-in-Chief,Myanmar Defense Services (Tatmadaw); Commander-in-Chief,Myanmar Army',vTitle,'Vice Sr. General;Vice-Chairman of the St. Peace & Dev. Council;Dpty Cmdr-in-Chief,Myanmar Defense Services (Tatmadaw);Cmdr-in-Chief,Myanmar Army',nocase),
																					regexfind('Brigadier General,Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff',vTitle,nocase)	=>	regexreplace('Brigadier General,Commanding Officer of the Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps; Deputy Commander of the Ramazan Headquarters; Chief of Staff of the Iraq Crisis Staff',vTitle,'Brigadier Gen,Cmdg Officer of Iranian Islamic Revolutionary Guard Corps-Qods Force Ramazan Corps;Dpty Cmdr of Ramazan HQ;Chief of Staff of Iraq Crisis',nocase),
																					(string)r.title
																					);
		self.title_2										:= '';
		self.title_3										:= '';
		self.title_4										:= '';
		self.title_5										:= '';
		self.title_6										:= '';
		self.title_7										:= '';
		self.title_8										:= '';
		self.title_9										:= '';
		self.title_10										:= '';
		self.aka_id											:= r.id;		
		self.aka_type										:= r.type;
		self.aka_category								:= r.category;
		self.giv_designator							:= map(GlobalWatchLists.Functions.ustrClean2Upper(l.type)  = 'BUSINESS' 	=> 'G',
																						GlobalWatchLists.Functions.ustrClean2Upper(l.type) = 'INDIVIDUAL' => 'I',
																						GlobalWatchLists.Functions.ustrClean2Upper(l.type) = 'VESSEL' 		=> 'V',
																						GlobalWatchLists.Functions.ustrClean2Upper(l.type) = 'AIRCRAFT' 	=> 'A',
																						'');
		self.date_added_to_list					:= Globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.ustrClean2Upper(l.listed_date));
		self.gender											:= GlobalWatchLists.Functions.ustrClean2Upper(l.gender);
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
		self.linked_with_1							:= (string)l.comments[Stringlib.StringFind((string)l.comments,'(Linked To:', 1)+12..Stringlib.StringFind((string)l.comments,')', 1)-1];
		self.linked_with_2							:= '';
		self.linked_with_3							:= '';
		self.linked_with_4							:= '';
		self.linked_with_5							:= '';
		self.linked_with_6							:= '';
		self.linked_with_7							:= '';
		self.linked_with_8							:= '';
		self.linked_with_9							:= '';
		self.linked_with_10							:= '';	
		self.linked_with_id_1						:= '';
		self.linked_with_id_2						:= '';
		self.linked_with_id_3						:= '';			
		self.linked_with_id_4						:= '';
		self.linked_with_id_5						:= '';
		self.linked_with_id_6						:= '';
		self.linked_with_id_7						:= '';
		self.linked_with_id_8						:= '';
		self.linked_with_id_9						:= '';
		self.linked_with_id_10					:= '';	
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
	globalwatchlists.Layout_Watchlist.stAddrLayout stAddr(ds_all_names l, addrNorm r):= transform
		
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
		self.address_id 						:= r.id;
		self.address_line_1 				:= (string)r.street_1;
		self.address_line_2 				:= (string)r.street_2;
		self.address_line_3 				:= '';
		self.address_city						:= (string)r.city;
		self.address_state_province	:= (string)r.state;
		self.address_postal_code		:= (string)r.postal_code;
		self.address_country				:= (string)r.country;
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

	globalwatchlists.Layout_Watchlist.addLayout fixL(ds_name_add l):= transform
		self.dob_id_1 						:= '';
		self.dob_id_2							:= '';
		self.dob_id_3							:= '';
		self.dob_id_4							:= '';
		self.dob_id_5							:= '';
		self.dob_id_6							:= '';
		self.dob_id_7							:= '';
		self.dob_id_8							:= '';
		self.dob_id_9							:= '';
		self.dob_id_10						:= '';
		self.dob_1								:= '';
		self.dob_2								:= '';
		self.dob_3								:= '';
		self.dob_4								:= '';
		self.dob_5								:= '';
		self.dob_6								:= '';
		self.dob_7								:= '';
		self.dob_8								:= '';
		self.dob_9								:= '';
		self.dob_10								:= '';
		self.pob_id_1							:= '';
		self.pob_id_2							:= '';
		self.pob_id_3							:= '';
		self.pob_id_4							:= '';
		self.pob_id_5							:= '';
		self.pob_id_6							:= '';
		self.pob_id_7							:= '';
		self.pob_id_8							:= '';
		self.pob_id_9							:= '';
		self.pob_id_10						:= '';
		self.pob_1								:= '';
		self.pob_2								:= '';
		self.pob_3								:= '';
		self.pob_4								:= '';
		self.pob_5								:= '';
		self.pob_6								:= '';
		self.pob_7								:= '';
		self.pob_8								:= '';
		self.pob_9								:= '';
		self.pob_10								:= '';
		self.id_id_1							:= '';
		self.id_id_2							:= '';
		self.id_id_3							:= '';
		self.id_id_4							:= '';
		self.id_id_5							:= '';
		self.id_id_6							:= '';
		self.id_id_7							:= '';
		self.id_id_8							:= '';
		self.id_id_9							:= '';
		self.id_id_10							:= '';
		self.id_type_1						:= '';
		self.id_type_2						:= '';
		self.id_type_3						:= '';
		self.id_type_4						:= '';
		self.id_type_5						:= '';
		self.id_type_6						:= '';
		self.id_type_7						:= '';
		self.id_type_8						:= '';
		self.id_type_9						:= '';
		self.id_type_10						:= '';
		self.id_number_1					:= '';
		self.id_number_2					:= '';
		self.id_number_3					:= '';
		self.id_number_4					:= '';
		self.id_number_5					:= '';
		self.id_number_6					:= '';
		self.id_number_7					:= '';
		self.id_number_8					:= '';
		self.id_number_9					:= '';
		self.id_number_10					:= '';
		self.id_country_1					:= '';
		self.id_country_2					:= '';
		self.id_country_3					:= '';
		self.id_country_4					:= '';
		self.id_country_5					:= '';
		self.id_country_6					:= '';
		self.id_country_7					:= '';
		self.id_country_8					:= '';
		self.id_country_9					:= '';
		self.id_country_10				:= '';
		self.id_issue_date_1			:= '';
		self.id_issue_date_2			:= '';
		self.id_issue_date_3			:= '';
		self.id_issue_date_4			:= '';
		self.id_issue_date_5			:= '';
		self.id_issue_date_6			:= '';
		self.id_issue_date_7			:= '';
		self.id_issue_date_8			:= '';
		self.id_issue_date_9			:= '';
		self.id_issue_date_10			:= '';
		self.id_expiration_date_1	:= '';
		self.id_expiration_date_2	:= '';
		self.id_expiration_date_3	:= '';
		self.id_expiration_date_4	:= '';
		self.id_expiration_date_5	:= '';
		self.id_expiration_date_6	:= '';
		self.id_expiration_date_7	:= '';
		self.id_expiration_date_8	:= '';
		self.id_expiration_date_9	:= '';
		self.id_expiration_date_10:= '';
		self.passport_details			:= '';
		self.sanctions_program_1	:= if ( regexfind('OSFI',l.source,0) <> '','SEMA Iran','');
		self.sanctions_program_2 	:= '';
		self.sanctions_program_3	:= '';
		self.sanctions_program_4	:= '';
		self.sanctions_program_5	:= '';
		self.sanctions_program_6	:= '';
		self.sanctions_program_7	:= '';
		self.sanctions_program_8	:= '';
		self.sanctions_program_9	:= '';
		self.sanctions_program_10	:= '';
		self := l;
	end;
	
	ds_name_addr := project(ds_name_add, fixL(left));
	ded_name_addr	:= DEDUP(SORT(ds_name_addr,RECORD,LOCAL),RECORD,LOCAL);

	//////////////////////////////////////////////////////////////////////////

	//Normalize Additional Info
	aInfoTable := table(new_filter, 
								{integer aInfoCount := count(additional_info_list.additionalinfo), 
								new_filter});
								
	aInfoLayout := RECORD, maxlength(15000)
    string	Reference_id;
		string  id;
    string 	type;
    unicode information;
    unicode parsed;
    unicode comments;
   END;

	aInfoLayout getainfo(aInfoTable l, integer c):= transform
		self.reference_id		:= l.reference_id;
		self 								:= l.additional_info_list.additionalinfo[c];
	end;

	aInfoNorm := normalize(aInfoTable, 
						left.aInfoCount, 
						getainfo(left, counter));
						
	//Map DOB to Common Layout
	ds_aInfo_dob := aInfoNorm(type='DOB');

	globalwatchlists.Layout_Watchlist.addLayout tDenormDOB(ds_name_addr l, ds_aInfo_dob	r, integer cnt):= transform
		self.numrows			:= cnt;
		self.dob_id_1			:= if(cnt =	1, (string)r.id, '');
		self.dob_id_2			:= if(cnt =	2, (string)r.id, '');
		self.dob_id_3			:= if(cnt =	3, (string)r.id, '');
		self.dob_id_4			:= if(cnt =	4, (string)r.id, '');
		self.dob_id_5			:= if(cnt =	5, (string)r.id, '');
		self.dob_id_6			:= if(cnt =	6, (string)r.id, '');
		self.dob_id_7			:= if(cnt =	7, (string)r.id, '');
		self.dob_id_8			:= if(cnt =	8, (string)r.id, '');
		self.dob_id_9			:= if(cnt =	9, (string)r.id, '');
		self.dob_id_10		:= if(cnt =	10, (string)r.id, '');
		self.dob_1				:= Globalwatchlists.convMMDDYYYY(if(cnt =	1, (string)r.parsed, ''));
		self.dob_2				:= Globalwatchlists.convMMDDYYYY(if(cnt =	2, (string)r.parsed, ''));
		self.dob_3				:= Globalwatchlists.convMMDDYYYY(if(cnt =	3, (string)r.parsed, ''));
		self.dob_4				:= Globalwatchlists.convMMDDYYYY(if(cnt =	4, (string)r.parsed, ''));
		self.dob_5				:= Globalwatchlists.convMMDDYYYY(if(cnt =	5, (string)r.parsed, ''));
		self.dob_6				:= Globalwatchlists.convMMDDYYYY(if(cnt =	6, (string)r.parsed, ''));
		self.dob_7				:= Globalwatchlists.convMMDDYYYY(if(cnt =	7, (string)r.parsed, ''));
		self.dob_8				:= Globalwatchlists.convMMDDYYYY(if(cnt =	8, (string)r.parsed, ''));
		self.dob_9				:= Globalwatchlists.convMMDDYYYY(if(cnt =	9, (string)r.parsed, ''));
		self.dob_10				:= Globalwatchlists.convMMDDYYYY(if(cnt =	10, (string)r.parsed, ''));		
		self 							:= l;
	end;
	
	dDenormDOB	:=	denormalize(sort(distribute(ds_name_addr,hash(pty_key)),record,local),
															sort(distribute(ds_aInfo_dob(reference_id<>''),hash(reference_id)),record,local),
															left.pty_key = right.reference_id,
															tDenormDOB(left, right, counter),local
															);

	//Map POB to Common Layout
	ds_aInfo_pob := aInfoNorm(type='PlaceOfBirth');

	globalwatchlists.Layout_Watchlist.addLayout tDenormPOB(dDenormDOB l, ds_aInfo_pob	r, integer cnt):= transform
		self.pob_id_1			:= if(cnt =	1, (string)r.id, '');
		self.pob_id_2			:= if(cnt =	2, (string)r.id, '');
		self.pob_id_3			:= if(cnt =	3, (string)r.id, '');
		self.pob_id_4			:= if(cnt =	4, (string)r.id, '');
		self.pob_id_5			:= if(cnt =	5, (string)r.id, '');
		self.pob_id_6			:= if(cnt =	6, (string)r.id, '');
		self.pob_id_7			:= if(cnt =	7, (string)r.id, '');
		self.pob_id_8			:= if(cnt =	8, (string)r.id, '');
		self.pob_id_9			:= if(cnt =	9, (string)r.id, '');
		self.pob_id_10		:= if(cnt =	10, (string)r.id, '');
		self.pob_1				:= if(cnt =	1, (string)r.information, '');
		self.pob_2				:= if(cnt =	2, (string)r.information, '');
		self.pob_3				:= if(cnt =	3, (string)r.information, '');
		self.pob_4				:= if(cnt =	4, (string)r.information, '');
		self.pob_5				:= if(cnt =	5, (string)r.information, '');
		self.pob_6				:= if(cnt =	6, (string)r.information, '');
		self.pob_7				:= if(cnt =	7, (string)r.information, '');
		self.pob_8				:= if(cnt =	8, (string)r.information, '');
		self.pob_9				:= if(cnt =	9, (string)r.information, '');
		self.pob_10				:= if(cnt =	10, (string)r.information, '');
		self 							:= l;
	end;

		dDenormPOB	:=	denormalize(sort(distribute(dDenormDOB,hash(pty_key)),record,local),
															sort(distribute(ds_aInfo_pob(reference_id<>''),hash(reference_id)),record,local),
															left.pty_key = right.reference_id,
															tDenormPOB(left, right, counter),local
															);

	//////////////////////////////////////////////////////////////////////////
	
	//Normalize Identification
	identTable := table(new_filter, 
								{integer identCount := count(identification_list.identification), 
								new_filter});
								
	idLayout := record, maxlength(8192)
		string	  Reference_id;
	  string 		Id;
		string 	  Type;
		unicode50	Label;
		unicode50	Number;
		unicode50	Issued_By;
		string10	Date_Issued;
		string10	Date_Expires;
		unicode	  Comments;
	end;

	idLayout getidents(identTable l, integer c):= transform
		self.reference_id		:= l.reference_id;
		self 								:= l.identification_list.identification[c];
	end;

	identNor := normalize(identTable, 
						left.identCount, 
						getidents(left, counter));
	
	identNorm := sort(identNor, (integer)reference_id, (integer)id, number); 	

	//Map ID to Common Layout
	ds_ident_pass := sort(identNorm, (integer)reference_id, type, number);
	
	globalwatchlists.Layout_Watchlist.addLayout tDenormPass(dDenormPOB l, ds_ident_pass	r, integer cnt):= transform
		self.NumRows								:=	cnt;
		self.id_id_1								:=	if(cnt =	1, (string)r.id, l.id_id_1);
		self.id_id_2								:=	if(cnt =	2, (string)r.id, l.id_id_2);
		self.id_id_3								:=	if(cnt =	3, (string)r.id, l.id_id_3);
		self.id_id_4								:=	if(cnt =	4, (string)r.id, l.id_id_4);
		self.id_id_5								:=	if(cnt =	5, (string)r.id, l.id_id_5);
		self.id_id_6								:=	if(cnt =	6, (string)r.id, l.id_id_6);
		self.id_id_7								:=	if(cnt =	7, (string)r.id, l.id_id_7);
		self.id_id_8								:=	if(cnt =	8, (string)r.id, l.id_id_8);
		self.id_id_9								:=	if(cnt =	9, (string)r.id, l.id_id_9);
		self.id_id_10								:=	if(cnt =	10, (string)r.id, l.id_id_10);
		self.id_type_1							:=	if(cnt =	1 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	1 and r.type='Other',
																				(string)r.label,
																				l.id_type_1));
		self.id_type_2							:=	if(cnt =	2 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	2 and r.type='Other',
																				(string)r.label,
																				l.id_type_2));	
		self.id_type_3							:=	if(cnt =	3 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	3 and r.type='Other',
																				(string)r.label,
																				l.id_type_3));	
		self.id_type_4							:=	if(cnt =	4 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	4 and r.type='Other',
																				(string)r.label,
																				l.id_type_4));	
		self.id_type_5							:=	if(cnt =	5 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	5 and r.type='Other',
																				(string)r.label,
																				l.id_type_5));	
		self.id_type_6							:=	if(cnt =	6 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	6 and r.type='Other',
																				(string)r.label,
																				l.id_type_6));	
		self.id_type_7							:=	if(cnt =	7 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	7 and r.type='Other',
																				(string)r.label,
																				l.id_type_7));
		self.id_type_8							:=	if(cnt =	8 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	8 and r.type='Other',
																				(string)r.label,
																				l.id_type_8));	
		self.id_type_9							:=	if(cnt =	9 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	9 and r.type='Other',
																				(string)r.label,
																				l.id_type_9));	
		self.id_type_10							:=	if(cnt =	10 and r.type='Passport', 
																				(string)r.type, 
																			if(cnt =	10 and r.type='Other',
																				(string)r.label,
																				l.id_type_10));	
		self.id_number_1						:=	if(cnt =	1, (string)r.number, l.id_number_1); 
		self.id_number_2						:=	if(cnt =	2, (string)r.number, l.id_number_2); 
		self.id_number_3						:=	if(cnt =	3, (string)r.number, l.id_number_3); 
		self.id_number_4						:=	if(cnt =	4, (string)r.number, l.id_number_4); 
		self.id_number_5						:=	if(cnt =	5, (string)r.number, l.id_number_5); 
		self.id_number_6						:=	if(cnt =	6, (string)r.number, l.id_number_6); 
		self.id_number_7						:=	if(cnt =	7, (string)r.number, l.id_number_7); 
		self.id_number_8						:=	if(cnt =	8, (string)r.number, l.id_number_8); 
		self.id_number_9						:=	if(cnt =	9, (string)r.number, l.id_number_9); 
		self.id_number_10						:=	if(cnt =	10, (string)r.number, l.id_number_10); 
		self.id_country_1						:=	if(cnt =	1, (string)r.issued_by, l.id_country_1); 
		self.id_country_2						:=	if(cnt =	2, (string)r.issued_by, l.id_country_2); 
		self.id_country_3						:=	if(cnt =	3, (string)r.issued_by, l.id_country_3); 
		self.id_country_4						:=	if(cnt =	4, (string)r.issued_by, l.id_country_4); 
		self.id_country_5						:=	if(cnt =	5, (string)r.issued_by, l.id_country_5); 
		self.id_country_6						:=	if(cnt =	6, (string)r.issued_by, l.id_country_6); 
		self.id_country_7						:=	if(cnt =	7, (string)r.issued_by, l.id_country_7); 
		self.id_country_8						:=	if(cnt =	8, (string)r.issued_by, l.id_country_8); 
		self.id_country_9						:=	if(cnt =	9, (string)r.issued_by, l.id_country_9); 
		self.id_country_10					:=	if(cnt =	10, (string)r.issued_by, l.id_country_10); 
		self.id_issue_date_1				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	1, r.date_issued, l.id_issue_date_1));
		self.id_issue_date_2				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	2, r.date_issued, l.id_issue_date_2));
		self.id_issue_date_3				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	3, r.date_issued, l.id_issue_date_3));
		self.id_issue_date_4				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	4, r.date_issued, l.id_issue_date_4));
		self.id_issue_date_5				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	5, r.date_issued, l.id_issue_date_5));
		self.id_issue_date_6				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	6, r.date_issued, l.id_issue_date_6));
		self.id_issue_date_7				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	7, r.date_issued, l.id_issue_date_7));
		self.id_issue_date_8				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	8, r.date_issued, l.id_issue_date_8));
		self.id_issue_date_9				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	9, r.date_issued, l.id_issue_date_9));
		self.id_issue_date_10				:=	Globalwatchlists.convMMDDYYYY(if(cnt =	10, r.date_issued, l.id_issue_date_10));
		self.id_expiration_date_1		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	1, r.date_expires, l.id_expiration_date_1));
		self.id_expiration_date_2		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	2, r.date_expires, l.id_expiration_date_2));
		self.id_expiration_date_3		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	3, r.date_expires, l.id_expiration_date_3));
		self.id_expiration_date_4		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	4, r.date_expires, l.id_expiration_date_4));
		self.id_expiration_date_5		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	5, r.date_expires, l.id_expiration_date_5));
		self.id_expiration_date_6		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	6, r.date_expires, l.id_expiration_date_6));
		self.id_expiration_date_7		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	7, r.date_expires, l.id_expiration_date_7));
		self.id_expiration_date_8		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	8, r.date_expires, l.id_expiration_date_8));
		self.id_expiration_date_9		:=	Globalwatchlists.convMMDDYYYY(if(cnt =	9, r.date_expires, l.id_expiration_date_9));
		self.id_expiration_date_10	:=	Globalwatchlists.convMMDDYYYY(if(cnt =	10, r.date_expires, l.id_expiration_date_10));
		self												:=	l;
	end;

	dDenormPass	:=	denormalize(sort(distribute(dDenormPOB,hash(pty_key)),record,local),
															sort(distribute(ds_ident_pass(reference_id<>''),hash(reference_id)),record,local),
															left.pty_key = right.reference_id,
															tDenormPass(left, right, counter),local
															);
	
	//////////////////////////////////////////////////////////////////////////
	
	//Parse Sanctions Program
	ds_sanctions	:= new_filter(regexfind('Program', (string)comments, 0)<>'');
	
	rCommentsSlim_Layout	:= record, maxlength(40960)
		string20	reference_id;
		string60	watchlistname;
		string		comments;
	end;

	rCommentsSlim_Layout tSancs(ds_sanctions pInput)	:= transform
		self.comments	:=	(string)pInput.comments[Stringlib.StringFind((string)pInput.comments,'Program:', 1)+9..length((string)pInput.comments)];
		self					:=	pInput;
	end;

	dComments	:= project(ds_sanctions, tSancs(left));

	pattern	SingleComment	:=	pattern('[^,]+');

	rParseComments_Layout	:= record,maxlength(40960)
		dComments;
		string	CompleteComment	:=	GlobalWatchLists.Functions.strClean(matchtext(SingleComment));
	end;

	dCommentsParsed	:=	parse(dComments,comments,SingleComment,rParseComments_Layout,scan,first);

	rCommentsSlim_Layout	tComments(dCommentsParsed	pInput)	:= transform
		self.comments	:=	if(	GlobalWatchLists.Functions.strClean2Upper(pInput.CompleteComment)	in	GlobalWatchLists.constants.InvalidVals,
													SKIP,
													GlobalWatchLists.Functions.strClean(pInput.CompleteComment)
												);
		self					:=	pInput;
	end;

	dCommentsReform		:= project(dCommentsParsed, tComments(left));
	dCommentsReformat := sort(dCommentsReform, (integer)reference_id, comments); 

	//Map Sanctions to Common Layout
	globalwatchlists.Layout_Watchlist.addLayout tDenormSanc(dDenormPass l, dCommentsReformat r, integer cnt):= transform
		self.NumRows								:=	cnt;
		self.sanctions_program_1		:=	if(cnt =	1, (string)r.comments, l.sanctions_program_1); 
		self.sanctions_program_2 		:=	if(cnt =	2, (string)r.comments, l.sanctions_program_2);
		self.sanctions_program_3		:=	if(cnt =	3, (string)r.comments, l.sanctions_program_3);
		self.sanctions_program_4		:=	if(cnt =	4, (string)r.comments, l.sanctions_program_4);
		self.sanctions_program_5		:=	if(cnt =	5, (string)r.comments, l.sanctions_program_5);
		self.sanctions_program_6		:=	if(cnt =	6, (string)r.comments, l.sanctions_program_6);
		self.sanctions_program_7		:=	if(cnt =	7, (string)r.comments, l.sanctions_program_7);
		self.sanctions_program_8		:=	if(cnt =	8, (string)r.comments, l.sanctions_program_8);
		self.sanctions_program_9		:=	if(cnt =	9, (string)r.comments, l.sanctions_program_9);
		self.sanctions_program_10		:=	if(cnt =	10, (string)r.comments, l.sanctions_program_10);
		self												:=	l;
	end;

	dDenormSanc	:= denormalize(sort(distribute(dDenormPass,hash(pty_key)),record,local),
															sort(distribute(dCommentsReformat(reference_id<>''),hash(reference_id)),record,local),
															left.pty_key = right.reference_id,
															tDenormSanc(left, right, counter),local
															);
	
	//////////////////////////////////////////////////////////////////////////
	
	//Map to Final Layout
	
	Globalwatchlists.Layout_GlobalWatchLists finalTran(dDenormSanc l):= transform
	self.pty_key := map ( l.source = 'OFAC NON-SDN ENTITIES' =>  'OFAC'+l.pty_key ,
		                      l.source = 'OSFI CONSOLIDATED LIST' and l.giv_designator = 'G' => 'OCE'+l.pty_key ,
													l.source = 'OSFI CONSOLIDATED LIST' and l.giv_designator = 'I'  => 'OCI'+l.pty_key ,'' );
		self.nationality_id_1 := '';
		self.nationality_id_2 := '';
		self.nationality_id_3 := '';
		self.nationality_id_4 := '';
		self.nationality_id_5 := '';
		self.nationality_id_6 := '';
		self.nationality_id_7 := '';
		self.nationality_id_8 := '';
		self.nationality_id_9 := '';
		self.nationality_id_10 := '';
		self.nationality_1 := '';
		self.nationality_2 := '';
		self.nationality_3 := '';
		self.nationality_4 := '';
		self.nationality_5 := '';
		self.nationality_6 := '';
		self.nationality_7 := '';
		self.nationality_8 := '';
		self.nationality_9 := '';
		self.nationality_10 := '';
		self.primary_nationality_flag_1 := '';
		self.primary_nationality_flag_2 := '';
		self.primary_nationality_flag_3 := '';
		self.primary_nationality_flag_4 := '';
		self.primary_nationality_flag_5 := '';
		self.primary_nationality_flag_6 := '';
		self.primary_nationality_flag_7 := '';
		self.primary_nationality_flag_8 := '';
		self.primary_nationality_flag_9 := '';
		self.primary_nationality_flag_10 := '';
		self.citizenship_id_1 := '';
		self.citizenship_id_2 := '';
		self.citizenship_id_3 := '';
		self.citizenship_id_4 := '';
		self.citizenship_id_5 := '';
		self.citizenship_id_6 := '';
		self.citizenship_id_7 := '';
		self.citizenship_id_8 := '';
		self.citizenship_id_9 := '';
		self.citizenship_id_10 := '';
		self.citizenship_1 := '';
		self.citizenship_2 := '';
		self.citizenship_3 := '';
		self.citizenship_4 := '';
		self.citizenship_5 := '';
		self.citizenship_6 := '';
		self.citizenship_7 := '';
		self.citizenship_8 := '';
		self.citizenship_9 := '';
		self.citizenship_10 := '';
		self.primary_citizenship_flag_1 := '';
		self.primary_citizenship_flag_2 := '';
		self.primary_citizenship_flag_3 := '';
		self.primary_citizenship_flag_4 := '';
		self.primary_citizenship_flag_5 := '';
		self.primary_citizenship_flag_6 := '';
		self.primary_citizenship_flag_7 := '';
		self.primary_citizenship_flag_8 := '';
		self.primary_citizenship_flag_9 := '';
		self.primary_citizenship_flag_10 := '';
		self.primary_dob_flag_1 := '';
		self.primary_dob_flag_2 := '';
		self.primary_dob_flag_3 := '';
		self.primary_dob_flag_4 := '';
		self.primary_dob_flag_5 := '';
		self.primary_dob_flag_6 := '';
		self.primary_dob_flag_7 := '';
		self.primary_dob_flag_8 := '';
		self.primary_dob_flag_9 := '';
		self.primary_dob_flag_10 := '';
		self.country_of_birth_1 := '';
		self.country_of_birth_2 := '';
		self.country_of_birth_3 := '';
		self.country_of_birth_4 := '';
		self.country_of_birth_5 := '';
		self.country_of_birth_6 := '';
		self.country_of_birth_7 := '';
		self.country_of_birth_8 := '';
		self.country_of_birth_9 := '';
		self.country_of_birth_10 := '';
		self.primary_pob_flag_1 := '';
		self.primary_pob_flag_2 := '';
		self.primary_pob_flag_3 := '';
		self.primary_pob_flag_4 := '';
		self.primary_pob_flag_5 := '';
		self.primary_pob_flag_6 := '';
		self.primary_pob_flag_7 := '';
		self.primary_pob_flag_8 := '';
		self.primary_pob_flag_9 := '';
		self.primary_pob_flag_10 := '';
		self.language_1 := '';
		self.language_2 := '';
		self.language_3 := '';
		self.language_4 := '';
		self.language_5 := '';
		self.language_6 := '';
		self.language_7 := '';
		self.language_8 := '';
		self.language_9 := '';
		self.language_10 := '';
		self.membership_1 := '';
		self.membership_2 := '';
		self.membership_3 := '';
		self.membership_4 := '';
		self.membership_5 := '';
		self.membership_6 := '';
		self.membership_7 := '';
		self.membership_8 := '';
		self.membership_9 := '';
		self.membership_10 := '';
		self.position_1 := '';
		self.position_2 := '';
		self.position_3 := '';
		self.position_4 := '';
		self.position_5 := '';
		self.position_6 := '';
		self.position_7 := '';
		self.position_8 := '';
		self.position_9 := '';
		self.position_10 := '';
		self.occupation_1 := '';
		self.occupation_2 := '';
		self.occupation_3 := '';
		self.occupation_4 := '';
		self.occupation_5 := '';
		self.occupation_6 := '';
		self.occupation_7 := '';
		self.occupation_8 := '';
		self.occupation_9 := '';
		self.occupation_10 := '';
		self.grounds := '';
		self.subj_to_common_pos_2001_931_cfsp_fl := '';
		self.federal_register_citation_1 := '';
		self.federal_register_citation_2 := '';
		self.federal_register_citation_3 := '';
		self.federal_register_citation_4 := '';
		self.federal_register_citation_5 := '';
		self.federal_register_citation_6 := '';
		self.federal_register_citation_7 := '';
		self.federal_register_citation_8 := '';
		self.federal_register_citation_9 := '';
		self.federal_register_citation_10 := '';
		self.federal_register_citation_date_1 := '';
		self.federal_register_citation_date_2 := '';
		self.federal_register_citation_date_3 := '';
		self.federal_register_citation_date_4 := '';
		self.federal_register_citation_date_5 := '';
		self.federal_register_citation_date_6 := '';
		self.federal_register_citation_date_7 := '';
		self.federal_register_citation_date_8 := '';
		self.federal_register_citation_date_9 := '';
		self.federal_register_citation_date_10 := '';
		self.license_requirement := '';
		self.license_review_policy := '';
		self.subordinate_status := '';
		self.height := '';
		self.weight := '';
		self.physique := '';
		self.hair_color := '';
		self.eyes := '';
		self.complexion := '';
		self.race := '';
		self.scars_marks := '';
		self.photo_file := '';
		self.offenses := '';
		self.ncic := '';
		self.warrant_by := '';
		self.caution := '';
		self.reward := '';
		self.type_of_denial := '';
		self.linked_with_2 := '';
		self.linked_with_3 := '';
		self.linked_with_4 := '';
		self.linked_with_5 := '';
		self.linked_with_6 := '';
		self.linked_with_7 := '';
		self.linked_with_8 := '';
		self.linked_with_9 := '';
		self.linked_with_10 := '';
		self.linked_with_id_1 := '';
		self.linked_with_id_2 := '';
		self.linked_with_id_3 := '';
		self.linked_with_id_4 := '';
		self.linked_with_id_5 := '';
		self.linked_with_id_6 := '';
		self.linked_with_id_7 := '';
		self.linked_with_id_8 := '';
		self.linked_with_id_9 := '';
		self.linked_with_id_10 := '';
		self.listing_information := '';
		self.foreign_principal := '';
		self.nature_of_service := '';
		self.activities := '';
		self.finances := '';
		self.registrant_terminated_flag := '';
		self.foreign_principal_terminated_flag := '';
		self.short_form_terminated_flag := '';
		self.remarks := '';
		self.call_sign := '';
		self.vessel_type := '';
		self.tonnage := '';
		self.gross_registered_tonnage := '';
		self.vessel_flag := '';
		self.vessel_owner := '';
		self.ni_number_details := '';
		self.date_last_updated := '';
		self.effective_date := '';
		self.expiration_date := '';
		//Added for CCPA-94
		self.global_sid := 0;
		self.record_sid := 0;
		self.did        := 0;
		self := l;
	end;
	
	final_file 		:= project(dDenormSanc(trim(pty_key) <> ''), finalTran(left));
	ded_final			:= DEDUP(SORT(DISTRIBUTE(final_file),RECORD,LOCAL),RECORD, LOCAL);
	
	//DF-26191: Append Global_SIDs
	addGlobalSID	:= mdr.macGetGlobalSID(ded_final, 'GlobalWatchList', 'source', 'global_sid');	
	
	ds_out := output(addGlobalSID,,'~thor_data400::in::globalwatchlists_ofac_fse_'+pFileDate, overwrite);
	
	return ds_out;

end;