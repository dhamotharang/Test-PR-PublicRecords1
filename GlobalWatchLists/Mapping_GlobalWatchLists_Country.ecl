dCountryRecordID 	:=	distribute(Globalwatchlists.Generate_RecordID_Country,hash32(RecordID));

Globalwatchlists.Layout_denorm	tMainCountry(dCountryRecordID	le)	:=
transform
	string	vComments	:=	GlobalWatchLists.Functions.ustrClean(le.comments);
	
	self.pty_key 										:=	le.RecordID;
	self.source 										:=	(string)le.WatchListName;
	self.orig_pty_name							:=	(string)le.CountryName;
	self.country										:=	map(	GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'BALKANS'								=>	'Balkans Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'BELARUS'								=>	'Belarus Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'BPI-PA'								=>	'Blocked Pending Investigation - Palestinian Authority',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'BPI-SDNT'							=>	'Blocked Pending Investigation - Specially Designated Narcotics Traffickers',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'BPI-SDNTK'							=>	'Blocked Pending Investigation - Specially Designated Narcotic Trafficking Kingpins',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'BURMA'									=>	'Burma Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'COTED'									=>	'Cote d\'Ivoire (Ivory Coast) Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'CUBA'									=>	'Cuba Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'DARFUR'								=>	'Darfur Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'DRCONGO'								=>	'Democractic Republic of the Congo Sanction',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'FTO'										=>	'Foreign Terrorists Organization',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'IRAN'									=>	'Iran Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'IRAQ2'									=>	'Iraq Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'IRAQ3'									=>	'Iraq Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'LEBANON'								=>	'Lebanon Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'LIBERIA'								=>	'Liberia Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'NKOREA'								=>	'North Korea Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'NORTH KOREA'						=>	'North Korea Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'NPWMD'									=>	'Non-proliferation Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'NS-PLC'								=>	'NonSpecially Designated Terrorists Palestinian Legislative Council',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'SDGT'									=>	'Specially Designated Global Terrorists',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'SDNT'									=>	'Specially Designated Narcotics Traffickers',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'SDNTK'									=>	'Specially Designated Narcotic Trafficking Kingpins',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'SDT'										=>	'Specially Designated Terrorists',
																						regexfind('SUDAN',GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted),nocase)	=>	'Sudan Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'SYRIA'									=>	'Syria Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)	=	'ZIMB'									=>	'Zimbabwe Sanctions',
																						GlobalWatchLists.Functions.ustrClean2Upper(le.reasonlisted)
																					);
	self.name_type									:=	if(le.nametype	!=	'',(string)le.nametype,'COUNTRY');
	self.date_added_to_list 				:=	(string)le.datelisted;
	self.remarks_1 									:=	vComments[1..75];
	self.remarks_2 									:=	vComments[76..150];
	self.remarks_3 									:=	vComments[151..225];
	self.remarks_4 									:=	vComments[226..300];
	self.remarks_5 									:=	vComments[301..375];
	self.remarks_6 									:=	vComments[376..450];
	
	self.date_first_seen 						:=	globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.ustrClean(le.watchlistdate[1..UnicodeLib.UnicodeFind(le.watchlistdate,' ',1)-1]));
	self.date_last_seen 						:=	globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.ustrClean(le.watchlistdate[1..UnicodeLib.UnicodeFind(le.watchlistdate,' ',1)-1]));
	self.date_vendor_first_reported	:=	globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.ustrClean(le.watchlistdate[1..UnicodeLib.UnicodeFind(le.watchlistdate,' ',1)-1]));
	self.date_vendor_last_reported 	:=	globalwatchlists.convMMDDYYYY(GlobalWatchLists.Functions.ustrClean(le.watchlistdate[1..UnicodeLib.UnicodeFind(le.watchlistdate,' ',1)-1]));
	
	self.address_country 						:=	GlobalWatchLists.Functions.ustrClean(le.CountryName);
	
	self														:=	le;
	self														:=	[];
end;

dMainCountry	:=	project(dCountryRecordID,tMainCountry(left));

dNormCountryNames	:=	distribute(GlobalWatchLists.Normalize_CountryAKAList,hash32(CountryID));

// Denorm Location
dNormLocationList	:=	dNormCountryNames(NameInd	=	'LOCATION');
	
Globalwatchlists.Layout_denorm	tDenormLocations(dMainCountry	le,dNormLocationList	ri,integer	cnt)	:=
transform
	self.NumRows					:=	cnt;
	self.locationid_1			:=	if(cnt	=	1,ri.CountryID,le.locationid_1);
	self.locationid_2			:=	if(cnt	=	2,ri.CountryID,le.locationid_2);
	self.locationid_3			:=	if(cnt	=	3,ri.CountryID,le.locationid_3);
	self.locationid_4			:=	if(cnt	=	4,ri.CountryID,le.locationid_4);
	self.locationid_5			:=	if(cnt	=	5,ri.CountryID,le.locationid_5);
	self.locationid_6			:=	if(cnt	=	6,ri.CountryID,le.locationid_6);
	self.locationid_7			:=	if(cnt	=	7,ri.CountryID,le.locationid_7);
	self.locationid_8			:=	if(cnt	=	8,ri.CountryID,le.locationid_8);
	self.locationid_9			:=	if(cnt	=	9,ri.CountryID,le.locationid_9);
	self.locationid_10		:=	if(cnt	=	10,ri.CountryID,le.locationid_10);
	self.locationtype_1		:=	if(cnt	=	1,(string)ri.NameType,le.locationtype_1);
	self.locationtype_2		:=	if(cnt	=	2,(string)ri.NameType,le.locationtype_2);
	self.locationtype_3		:=	if(cnt	=	3,(string)ri.NameType,le.locationtype_3);
	self.locationtype_4		:=	if(cnt	=	4,(string)ri.NameType,le.locationtype_4);
	self.locationtype_5		:=	if(cnt	=	5,(string)ri.NameType,le.locationtype_5);
	self.locationtype_6		:=	if(cnt	=	6,(string)ri.NameType,le.locationtype_6);
	self.locationtype_7		:=	if(cnt	=	7,(string)ri.NameType,le.locationtype_7);
	self.locationtype_8		:=	if(cnt	=	8,(string)ri.NameType,le.locationtype_8);
	self.locationtype_9		:=	if(cnt	=	9,(string)ri.NameType,le.locationtype_9);
	self.locationtype_10	:=	if(cnt	=	10,(string)ri.NameType,le.locationtype_10);
	self.locationname_1		:=	if(cnt	=	1,(string)ri.Name,le.locationname_1); 
	self.locationname_2		:=	if(cnt	=	2,(string)ri.Name,le.locationname_2); 
	self.locationname_3		:=	if(cnt	=	3,(string)ri.Name,le.locationname_3); 
	self.locationname_4		:=	if(cnt	=	4,(string)ri.Name,le.locationname_4); 
	self.locationname_5		:=	if(cnt	=	5,(string)ri.Name,le.locationname_5); 
	self.locationname_6		:=	if(cnt	=	6,(string)ri.Name,le.locationname_6); 
	self.locationname_7		:=	if(cnt	=	7,(string)ri.Name,le.locationname_7); 
	self.locationname_8		:=	if(cnt	=	8,(string)ri.Name,le.locationname_8); 
	self.locationname_9		:=	if(cnt	=	9,(string)ri.Name,le.locationname_9); 
	self.locationname_10	:=	if(cnt	=	10,(string)ri.Name,le.locationname_10); 
	self									:=	le;
end;

dDenormLocations	:=	denormalize(	dMainCountry,
																		dNormLocationList,
																		left.pty_key	=	right.CountryID,
																		tDenormLocations(left,right,counter),
																		local
																	);

// Append Countries
dNormCountryAkaList	:=	dNormCountryNames(NameInd	=	'COUNTRY');
		
GlobalWatchLists.Layout_denorm	tCountryAkaList(dDenormLocations	le,dNormCountryAkaList	ri)	:=
transform
	self.orig_pty_name		:=	(string)ri.Name;
	self.address_country	:=	(string)ri.Name;
	self.aka_id 					:=	(string)ri.RecordID;
	self.aka_type					:=	(string)ri.NameType;
	self									:=	le;
end;

dCountryAkaList	:=	join(	dDenormLocations,
													dNormCountryAkaList,
													left.pty_key	=	right.CountryID,
													tCountryAkaList(left,right),
													left outer,
													local
												); 

dCountryAkaListDedup	:=	dedup(sort(dCountryAkaList,record),record)	:	persist('~thor_200::persist::globalwatchlists::country');

// export	Mapping_GlobalWatchLists_Country	:=	dCountryAkaListDedup;
export	Mapping_GlobalWatchLists_Country	:=	dataset('~thor_200::persist::globalwatchlists::country',GlobalWatchLists.Layout_denorm,thor);