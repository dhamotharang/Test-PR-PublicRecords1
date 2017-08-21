import AID, SexOffender, address, lib_date, lib_stringlib, DigsSoff;

ds := okc_sexual_offenders.OKC_Sex_Offender_Norm(orig_state ~in ['TX','OR','MI','FL','MS']);

	ds_fix_tx := DigsSoff.OnelineAddr('TX');
	ds_fix_or := DigsSoff.OnelineAddr('OR');
	ds_fix_mi := DigsSoff.OnelineAddr('MI');
	ds_fix_fl := DigsSoff.OnelineAddr('FL');
	ds_fix_ms := DigsSoff.OnelineAddr('MS');

In_Base_file := ds + ds_fix_tx + ds_fix_or + ds_fix_mi + ds_fix_fl + ds_fix_ms;

//Layout_OKC_Cleaned := OKC_Sexual_Offenders.Layout_OKC_Sex_Offender_Common;

	Addr_cleanup_Values 		:= ['0000 ADDRES NOT CURRENT AV'	,'0000 ADDRESS CURRENT RD'
								   ,'0000 ADDRESS NOT CURRENT AV'   ,'0000 ADDRESS NOT CURRENT BD'
								   ,'0000 ADDRESS NOT CURRENT CR'	,'0000 ADDRESS NOT CURRENT CT'
								   ,'0000 ADDRESS NOT CURRENT DR'	,'0000 ADDRESS NOT CURRENT RD'
								   ,'0000 ADDRESS NOT CURRENT LA'	,'0000 ADDRESS NOT CURRENT LN'
								   ,'0000 ADDRESS NOT CURRENT PL'	,'0000 ADDRESS NOT CURRENT PV'
								   ,'0000 ADDRESS NOT CURRENT ST'	,'0000 ADDRESS NOT CURRENT TR'
								   ,'0000 ADDRESS NOT CURRENT WY'	,'0000 NO CURRENT ADDRESS AV'
								   ,'0000 NO CURRENT ADDRESS RD'	,'0000 NO CURRENT ADDRESS ST'
								   ,'0000 ADDRESS UNKNOWN NOT CURRENT ST','0000 DOMICARY BD'
								   ,'0000 HOMELESS AV'				,'0000 HOMELESS DT'
								   ,'0000 HOMELESS HW'				,'0000 HOMELESS RD'
								   ,'0000 HOMELESS ST'				,'0000 N ADDRESS NOT CURRENT AV'
								   ,'0000 N ADDRESS NOT CURRENT ST'	,'0000 NO CURRENT ADDDRESS RD'
								   ,'0000 NO CURRENT ADDRESS RD'	,'0000 NO CURRENT ADDRESS ST'
								   ,'0000 NOT CURRENT AV'			,'0000 W ADDRESS NOT CURRENT RD'	
								   ,'00000 NO CURRENT ADDRESS CR'	,'00000 NO CURRENT ADDRESS RD'
								   ,'ABSCONDED'						,'ABSCONDED FROM PROBATION'
								   ,'ABSCONDED FROM REGISTRATION'	,'ACTIVE'
								   ,'ACTIVE COMMUNITY SUPERVISION'	,'ADDRESS UNKNOWN'
								   ,'ADMINISTRATIVE PROBATION'		,'APPEAL'
								   ,'COMMUNITY CONTROL'				,'COMPLIANT'
								   ,'COUNTY INCARCERATION'			,'CSC'
								   ,'CSCD/DIS'						,'DEAD'
								   ,'DECEASED'						,'DEPORTED'
								   ,'DISCHARGED'					,'ESCAPED'
								   ,'FAIL TO VERIFY ADDRESS'		,'FAILED TO VERIFY ADDRESS'		
								   ,'FAILURE TO REGISTER'
								   ,'FEDERAL INCARCERATION'			,'FEDERAL SUPERVISION'
								   ,'FUGITIVE'						,'HOMELESS'
								   ,'IN COMPLIANCE'					,'IN CUSTODY'
								   ,'IN VIOLATION'					,'INCARCERATED'
								   ,'INS CUSTODY'					,'JIMMY RYCE'
								   ,'JPO'							,'JPO/DIS'
								   ,'MOVED'							,'MOVED OUT OF STATE'
								   ,'NO CURRENT ADDRESS ST'			,'NO CURRENT ADDRESS BD'
								   ,'NO CURRENT ADDRESS RD'			,'NO CURRENT ADDRESS AV'
								   ,'NON COMPLIANT'					,'NON REGISTRATION COMPLIANCE'
								   ,'NON-COMPLIANT'					,'NON-COMPLIANT/INCARCERATED'
								   ,'NOT CURRENT'					,'OUT OF STATE'
								   ,'OUT OF STATE WORK IN CT'		,'PAR/DIS'
								   ,'PAROLE'						,'PAROLED'
								   ,'PENDING'						,'PENDING FROM OUT-OF-STATE'
								   ,'PREDATOR'						,'PREDITOR'
								   ,'PROBATION'						,'REGISTERED'
								   ,'REGISTERED IN AN OUTLYING OFFICE','REGISTRATION PERIOD HAS ENDED'
								   ,'RELEASED'						,'REPORTED DECEASED'
								   ,'REVOKED'						,'SEX OFFENDER'
								   ,'STATE INCARCERATION'			,'SUPERVISION'
								   ,'TDC'							,'TERMINATED'
								   ,'TEXAS YOUTH COMMISSION'		,'TRANSIENT'
								   ,'TYC/DIS'						,'UNAVAILABLE'
								   ,'UNDER DHFS SUPERVISION'		,'UNDER INVESTIGATION'
								   ,'UNDER SUPERVISION'				,'UNKNOWN'
								   ,'UNKNOWN ADDRESS'				,'UNVERIFIED ADDRESS'
								   ,'WANTED'						,'WHEREABOUTS UNCONFIRMED'];

	Invalid_City_List 			:= ['WARRANT ISSUED', 'NONE', 'UNK', 'UNKNOWN'];

	// This function formats the given date in MM/DD/YYYY to YYYYMMDD format.
	DateFinder := '^([0-9]{1,2})/([0-9]{1,2})/([0-9]{4})$';
	formatDate(string intext) 	:= if(regexfind(DateFinder,intext)
									, intformat((integer)regexfind(DateFinder,intext,3),4,1) 
									+ intformat((integer)regexfind(DateFinder,intext,1),2,1) 
									+ intformat((integer)regexfind(DateFinder,intext,2),2,1)
									,intext);
							   
OKC_Sexual_Offenders.Layout_OKC_Sex_Offender_Common.prep Clean_OKC_Sex_Off_Address(In_Base_file InputRecord) := transform
  	string8 tempDate		 	:= formatDate(trim(InputRecord.scrape_date,left,right));
	string2 process_cc       	:= if(tempDate <> '', tempDate[1..2], '');
	string2 process_yy       	:= if(tempDate <> '', tempDate[3..4], '');
	string2 process_mm       	:= if(tempDate <> '', tempDate[5..6], '');
	string2 process_dd       	:= if(tempDate <> '', tempDate[7..8], ''); 
	self.dt_first_reported   	:= tempDate;
	self.dt_last_reported    	:= tempDate;
	self.vendor_code         	:= 'C2';
	self.orig_state          	:= stringlib.StringToUpperCase(trim(InputRecord.orig_state,left,right));
    // Taking advantage of the newly provided SOR Numbers from OKC.  If the individual has one, use that for
	// the Seisint Primary Key, rather than the derived value as used previously.
	self.seisint_primary_key 	:= if(InputRecord.orig_state in ['VA', 'IN', 'CO'] and trim(InputRecord.sor_number,left,right) != ''
									,self.vendor_code + InputRecord.orig_state + trim(InputRecord.sor_number,left,right),
									if(trim(InputRecord.sor_number,left,right) != ''
									,self.vendor_code /*+ self.orig_state*/ + trim(InputRecord.sor_number,left,right)
									,self.vendor_code /*+ self.orig_state*/ + process_yy 
									+ (string)lib_date.DayOfYear((integer)(process_cc + process_yy),(integer)process_mm,(integer)process_dd) 
									+ (string)InputRecord.key));
	self.key                 	:= InputRecord.key;
	//self.source_file       	:= self.orig_state + ' STATE WIDE';
	self.name_type           	:= InputRecord.name_type;

	//////////ADDRESS CLEANER///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Restrict the zips to length 5 for the addressid cache
	string filterRegAddress2	:= if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-4],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-3],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-2],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										InputRecord.registration_address_2[1..length(trim(InputRecord.registration_address_2,left,right))-1],
										if(regexfind('[0-9][0-9][0-9][0-9][0-9]', InputRecord.registration_address_2[length(trim(InputRecord.registration_address_2,left,right))-9..length(trim(InputRecord.registration_address_2,left,right))], 0)<>'',
										trim(InputRecord.registration_address_2,left,right),
										trim(InputRecord.registration_address_2,left,right))))));
										
	// Remove address as of dates for the addressid cache
	string filterRegAddress3 	:= if(regexfind('ADDRESS AS OF', StringLib.StringToUpperCase(InputRecord.registration_address_3), 0)<>'',
									'',
									InputRecord.registration_address_3);
	
	// Fix Virginia's address abbreviations
	string tempRegistrationAddress1 := lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(InputRecord.registration_address_1,
												'NRADC','Northwestern Regional Adult Detention Center')
												,'SWVRJA','SOUTHWEST VIRGINIA REGIONAL JAIL AUTHORITY')
												,'SWVRJ','SOUTHWEST VIRGINIA REGIONAL JAIL')	
												,'VCBR','VIRGINIA CENTER FOR BEHAVIORAL REHABILITATION');
												
	string tempRegistrationAddress2 := lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(
										 lib_stringlib.StringLib.StringFindReplace(filterRegAddress2,
												'NRADC','Northwestern Regional Adult Detention Center')
												,'SWVRJA','SOUTHWEST VIRGINIA REGIONAL JAIL AUTHORITY')
												,'SWVRJ','SOUTHWEST VIRGINIA REGIONAL JAIL')
												,'VCBR','VIRGINIA CENTER FOR BEHAVIORAL REHABILITATION');
	
	// Fix Vermont's address data so that it will parse properly - check: cguyton
	string tempRegAddress1 := if(trim(tempRegistrationAddress1) <> ''
							AND trim(tempRegistrationAddress2) = ''
							AND trim(filterRegAddress3) = ''
							AND trim(InputRecord.registration_address_4) = ''
							AND trim(InputRecord.registration_address_5) = ''
							AND (InputRecord.orig_state = 'VT' OR InputRecord.orig_state = 'ME')
							,'',
							//Added an additional sub-if clause to parse the address_1 field
							if(trim(tempRegistrationAddress1) <> ''
							AND trim(tempRegistrationAddress2) = ''
							AND trim(InputRecord.registration_address_3) = ''
							AND trim(InputRecord.registration_address_4) = ''
							AND trim(InputRecord.registration_address_5) = ''
							AND InputRecord.orig_state = 'UT', 
							stringlib.stringtouppercase(tempRegistrationAddress1[1..25][1.. 25-stringlib.stringfind(StringLib.StringReverse(tempRegistrationAddress1[1..25]), ' ', 1)]),
							tempRegistrationAddress1));
							
	string tempRegAddress2 := if(trim(tempRegistrationAddress1) <> ''
							AND trim(tempRegistrationAddress2) = ''
							AND trim(InputRecord.registration_address_3) = ''
							AND trim(InputRecord.registration_address_4) = ''
							AND trim(InputRecord.registration_address_5) = ''
							AND (InputRecord.orig_state = 'VT' OR InputRecord.orig_state = 'ME')
							// Checking to make sure they reside in a Vermont county
							// before appending the state
							AND trim(InputRecord.registration_county) <> ''
							, InputRecord.registration_address_1 +', '+ InputRecord.orig_state
								// Added a sub-if clause to check and see if the county is null, 
								// in which case the state has already been provided because they
								// aren't residing in Vermont.
							, if(trim(tempRegistrationAddress1) <> ''
								AND trim(tempRegistrationAddress2) = ''
								AND trim(InputRecord.registration_address_3) = ''
								AND trim(InputRecord.registration_address_4) = ''
								AND trim(InputRecord.registration_address_5) = ''
								AND (InputRecord.orig_state = 'VT' OR InputRecord.orig_state = 'ME')
								AND trim(InputRecord.registration_county) = ''
								, InputRecord.registration_address_1
								//Added an additional sub-if clause to parse the address_1 field	   
							, if(trim(tempRegistrationAddress1) <> ''
								AND trim(tempRegistrationAddress2) = ''
								AND trim(InputRecord.registration_address_3) = ''
								AND trim(InputRecord.registration_address_4) = ''
								AND trim(InputRecord.registration_address_5) = ''
								AND InputRecord.orig_state = 'UT'
								, stringlib.stringtouppercase(tempRegistrationAddress1[26-stringlib.stringfind(StringLib.StringReverse(tempRegistrationAddress1[1..25]), ' ', 1)..length(trim(tempRegistrationAddress1, left, right))])
 								, tempRegistrationAddress2)));

	string prep_Address1 := stringlib.StringToUpperCase(if(tempRegAddress1 <> '' 
								OR tempRegAddress2 <> '' 
								OR InputRecord.registration_address_3 <> '' 
								OR InputRecord.registration_address_4 <> '' 
								OR InputRecord.registration_address_5 <> '', 					
										//tempRegAddress1
										if(trim(tempRegAddress1,left,right) in Addr_cleanup_Values
											,''
										// Added checks for those incarcerated with the New York DOC addresses 
										// that don't parse, and filter out the first address line for them
										// and use the second address line in its place.
										,if(tempRegAddress1[1..7] = 'NYSDOCS' AND InputRecord.orig_state = 'NY'
											OR tempRegAddress1[1..7] = 'NYCDOCS' AND InputRecord.orig_state = 'NY'
											,trim(tempRegAddress2,left,right)
											,trim(tempRegAddress1,left,right)))
										,''));
							             
	string prep_Address2 := stringlib.StringToUpperCase(if(tempRegAddress1 <> '' 
								OR tempRegAddress2 <> '' 
								OR InputRecord.registration_address_3 <> '' 
								OR InputRecord.registration_address_4 <> '' 
								OR InputRecord.registration_address_5 <> '',
										//tempRegAddress2
										 trim(if(trim(tempRegAddress2,left,right) in ['UNKNOWN']
										,''
										,if(tempRegAddress1[1..7] = 'NYSDOCS' AND InputRecord.orig_state = 'NY'
											OR tempRegAddress1[1..7] = 'NYCDOCS' AND InputRecord.orig_state = 'NY'
											,''
											, trim(tempRegAddress2,left,right) + ' '))
											+ trim(InputRecord.registration_address_3,left,right) + ' ' 
											+ trim(InputRecord.registration_address_4,left,right) 
											+ trim(InputRecord.registration_address_5,left,right),left,right)
										,''));

	self.append_Prep_Address1 		:= prep_Address1;
	self.append_Prep_Address2 		:= prep_Address2;
	self.append_Rawaid 				:= 0;
	self.registration_address_1     := stringlib.StringToUpperCase(trim(tempRegAddress1, left, right));
	self.registration_address_2     := stringlib.StringToUpperCase(trim(tempRegAddress2, left, right));
	self 							:= inputRecord;
	end;

	prepAddress := project(In_Base_file, Clean_OKC_Sex_Off_Address(left));

	unsigned4 lAIDAppendFlags		:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
			
	AID.MacAppendFromRaw_2Line(prepAddress, Append_Prep_Address1, Append_Prep_Address2, Append_RawAID, addressCleaned, lAIDAppendFlags);

OKC_Sexual_Offenders.Layout_OKC_Sex_Offender_Common.interim addressAppended(addressCleaned pInput) := transform
	self.Append_RawAID				:= pInput.AIDWork_RawAID;
	self.prim_range 				:= pInput.AIDWork_ACECache.prim_range;
	self.predir 					:= pInput.AIDWork_ACECache.predir;
	self.prim_name 					:= pInput.AIDWork_ACECache.prim_name;
	self.addr_suffix 				:= pInput.AIDWork_ACECache.addr_suffix;
	self.postdir 					:= pInput.AIDWork_ACECache.postdir;
	self.unit_desig 				:= pInput.AIDWork_ACECache.unit_desig;
	self.sec_range 					:= pInput.AIDWork_ACECache.sec_range;
	self.p_city_name 				:= pInput.AIDWork_ACECache.p_city_name;
	self.v_city_name 				:= pInput.AIDWork_ACECache.v_city_name;
	self.st 						:= pInput.AIDWork_ACECache.st;
	self.zip 						:= pInput.AIDWork_ACECache.zip5;
	self.zip4 						:= pInput.AIDWork_ACECache.zip4;
	self.cart 						:= pInput.AIDWork_ACECache.cart;
	self.cr_sort_sz 				:= pInput.AIDWork_ACECache.cr_sort_sz;
	self.lot 						:= pInput.AIDWork_ACECache.lot;
	self.lot_order 					:= pInput.AIDWork_ACECache.lot_order;
	self.dbpc 						:= pInput.AIDWork_ACECache.dbpc;
	self.chk_digit 					:= pInput.AIDWork_ACECache.chk_digit;
	self.rec_type 					:= pInput.AIDWork_ACECache.rec_type;
	self.county 					:= pInput.AIDWork_ACECache.county;
	self.geo_lat 					:= pInput.AIDWork_ACECache.geo_lat;
	self.geo_long 					:= pInput.AIDWork_ACECache.geo_long;
	self.msa 						:= pInput.AIDWork_ACECache.msa;
	self.geo_blk 					:= pInput.AIDWork_ACECache.geo_blk;
	self.geo_match 					:= pInput.AIDWork_ACECache.geo_match;
	self.err_stat 					:= pInput.AIDWork_ACECache.err_stat;
	self							:= pInput;
	end;
		
cleanAddress := project(addressCleaned,addressAppended(left));

//Temporary Name Fix///////////////////////////////////////
	remove_rec := cleanAddress(orig_state ~in ['AR','VA']);
	filter_rec := cleanAddress(orig_state in ['AR','VA']);

	dsadd_layout := record
		string temp_name;
		cleanAddress;
	end;

	dsadd_layout remTran(filter_rec l) := transform
		self.temp_name 	:= l.name_orig;
		self.name_orig 	:= if(regexfind(',',l.name_orig,0)<>'' and regexfind(',',l.name_orig[DataLib.StringFind(l.name_orig,',',1)+1..length(stringlib.StringToUpperCase(l.name_orig))], 0)='',
								l.name_orig,
							if(regexfind(', [A-Z]', l.name_orig[DataLib.StringFind(l.name_orig,',',1)+1..length(stringlib.StringToUpperCase(l.name_orig))], 0)<>'',
								l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)] + ' ' + trim(regexreplace(', ', regexreplace(', ', regexreplace(', ', l.name_orig[DataLib.StringFind(l.name_orig,',',1)+1..length(stringlib.StringToUpperCase(l.name_orig))], ' '), ' '), ' '),left,right),			
							if(regexfind(',[A-Z]', l.name_orig[DataLib.StringFind(l.name_orig,',',1)+1..length(stringlib.StringToUpperCase(l.name_orig))], 0)<>'',
								l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)] + ' ' + trim(regexreplace(',', regexreplace(',', regexreplace(',', l.name_orig[DataLib.StringFind(l.name_orig,',',1)+1..length(stringlib.StringToUpperCase(l.name_orig))], '  '), '  '), '  '),left,right),
							if(regexfind(',$', l.name_orig[DataLib.StringFind(l.name_orig,',',1)+1..length(stringlib.StringToUpperCase(l.name_orig))], 0)<>'',
								l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)] + ' ' + trim(regexreplace(',', l.name_orig[DataLib.StringFind(l.name_orig,',',1)+1..length(stringlib.StringToUpperCase(l.name_orig))], ''),left,right),
							l.name_orig))));
		self := l;
	end;

	clean_rec 	:= project(filter_rec, remTran(left));

	dsadd_layout normTran(remove_rec l) := transform
		self.temp_name := '';
		self := l;
	end;

	fltr_rec 	:= project(remove_rec, normTran(left)); 

concat_rec 	:= fltr_rec + clean_rec;
//output(concat_rec,named('concat_rec'));

///////////////////////////////////////////////////////////////////////////
	ds_slim := record
		string test_first_name;
		string test_middle_name;
		string test_last_name;
		string test_suffix_name;
		concat_rec;
	end;

	ds_slim reformName(concat_rec l) := transform

	name_pattern 		:= '[A-Z], [A-Z]$';
	name_pattern3 		:= '[A-Z]+[ ]+[A-Z]+[ ]+[A-Z]';
	name_pattern3a 		:= '[A-Z]+[, ]+[A-Z]+[ ]+[A-Z]$';
	name_pattern3b 		:= '[A-Z]+[ ]+[A-Z]+[, ]+[A-Z]$';
	name_pattern4 		:= '[A-Z]+[ ]+[A-Z]+[ ]+[A-Z]+[ ]+[A-Z]$';
	name_pattern4a 		:= '[A-Z]+[ ]+[A-Z]+[ ]+[A-Z]+[-]+[A-Z]+[ ]+[A-Z]$';
	name_pattern4b 		:= '[A-Z]+[ ]+[A-Z]+[, ]+[A-Z]+[ ]+[A-Z]';

	remove_space		:= regexreplace('  ', regexreplace('  ', regexreplace('  ', regexreplace('  ', l.name_orig, ' '), ' '), ' '), ' ');
	
	remove_punct2		:= if(regexfind(',JR|,SR|,III|,II|,IV', remove_space, 0)<>'',// and regexfind(name_pattern, remove_punct1, 0)<>'',
								regexreplace(',', remove_space, ' '),
							if(regexfind(', JR|, SR|, III|, II|, IV', remove_space, 0)<>'',
								regexreplace(',', remove_space, ''),
								remove_space));

	insert_space 		:= if(regexfind(',[A-Z]',stringlib.StringToUpperCase(remove_punct2),0)<>'',
								regexreplace(',',stringlib.StringToUpperCase(remove_punct2),', '),
								stringlib.StringToUpperCase(remove_punct2));
								
	remove_suffix		:= regexreplace('\\.JR| JR | JR$| JR\\.|\\.SR| SR | SR$| SR\\.| III| II| IV | IV$', insert_space, ' ');

	remove_punct1		:= regexreplace('\\.',stringlib.StringToUpperCase(remove_suffix),'');

	remove_mname		:= regexreplace(' NMN| NMI| A.K.A.| AKA ', remove_punct1, '');

	remove_punct		:= if(regexfind(' ,', remove_mname, 0)<>'',
								regexreplace(' ,', remove_mname, ','),
								remove_mname);	
							
	self.name_orig		:= if(l.orig_state in ['AR','VA'],
								l.temp_name,
								l.name_orig);

	self.test_first_name:= if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and stringlib.StringToUpperCase(remove_punct)<>'',
								stringlib.StringToUpperCase(remove_punct)[1..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)],
						   
							if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind('[A-Z]+[ ]+[A-Z]', remove_punct[DataLib.StringFind(remove_punct,',',1)+1..length(remove_punct)], 0)='',
								remove_punct[DataLib.StringFind(remove_punct,',',1)+1..length(remove_punct)],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',remove_punct[1..DataLib.StringFind(remove_punct,',',1)], 0)='' and regexfind(name_pattern3a, remove_punct, 0)<>'',
								remove_punct[DataLib.StringFind(remove_punct,',',1)+1..DataLib.StringFind(remove_punct,' ',2)],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',remove_punct[1..DataLib.StringFind(remove_punct,',',1)], 0)<>'' and regexfind(name_pattern3b, remove_punct, 0)<>'',
								remove_punct[DataLib.StringFind(remove_punct,',',1)+1..DataLib.StringFind(remove_punct,' ',3)],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(name_pattern4b, remove_punct, 0)<>'',
								remove_punct[DataLib.StringFind(remove_punct,',',1)+1..DataLib.StringFind(remove_punct,' ',3)],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',remove_punct[DataLib.StringFind(remove_punct,',',1)+1..DataLib.StringFind(remove_punct,' ',2)], 0)<>'',
								regexreplace(' JR.| JR| SR.| SR| III| II| IV$',remove_punct[DataLib.StringFind(remove_punct,',',1)+1..DataLib.StringFind(remove_punct,' ',3)],''),
								remove_punct[DataLib.StringFind(remove_punct,',',1)+1..DataLib.StringFind(remove_punct,' ',2)]))))));							

	self.test_middle_name:= if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind('[A-Z]+[ ]+[A-Z]', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))], 0)='',
								'',
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern4, stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$', stringlib.StringToUpperCase(remove_punct), 0)='',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',3)],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern4, stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR$| SR.| SR| III| II| IV$', stringlib.StringToUpperCase(remove_punct), 0)<>'',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',2)],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern3, stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| II| III| IV$', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))], 0)='',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',2)],	
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern3, stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| II| III| IV$', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))], 0)<>'',
								'',
														
							if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind('[A-Z]+[ ]+[A-Z]', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),',',1)+1..length(stringlib.StringToUpperCase(remove_punct))], 0)='' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',stringlib.StringToUpperCase(remove_punct)[1..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),',',1)], 0)='',
								'',
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' /*and regexfind(' JR.| JR| SR.| SR| III| II| IV$',stringlib.StringToUpperCase(remove_punct)[1..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),',',1)], 0)<>'' */and regexfind(name_pattern4b, stringlib.StringToUpperCase(remove_punct), 0)<>'',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',3)+1..length(stringlib.StringToUpperCase(remove_punct))],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',remove_punct[1..DataLib.StringFind(remove_punct,',',1)], 0)='' and regexfind(name_pattern3a, remove_punct, 0)<>'',
								remove_punct[DataLib.StringFind(remove_punct,' ',2)..length(remove_punct)],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',stringlib.StringToUpperCase(remove_punct)[1..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),',',1)], 0)<>'' and regexfind(name_pattern3b, stringlib.StringToUpperCase(remove_punct), 0)<>'',
								'',
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(name_pattern, stringlib.StringToUpperCase(remove_punct)[1..length(stringlib.StringToUpperCase(remove_punct))], 0)<>'',//For format: 'lname, fname'
								'',
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),',',1)+1..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',2)], 0)<>'',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',3)..length(stringlib.StringToUpperCase(remove_punct))],
								regexreplace(' JR.| JR| SR.| SR| III| II| IV$',stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',2)..length(stringlib.StringToUpperCase(remove_punct))],''))))))))))));
			
	self.test_last_name	:= if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind('[A-Z]+[ ]+[A-Z]', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))], 0)='',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern4, stringlib.StringToUpperCase(remove_punct), 0)<>'' or regexfind(name_pattern4a, stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))], 0)<>'',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',2)..length(stringlib.StringToUpperCase(remove_punct))],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern4, stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(' JR.| JR| SR.| SR| II| III', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))], 0)='',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',2)..length(stringlib.StringToUpperCase(remove_punct))],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern3, stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| II| III', stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))], 0)<>'',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',1)..length(stringlib.StringToUpperCase(remove_punct))],
								if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)='' and regexfind(name_pattern4, stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$', stringlib.StringToUpperCase(remove_punct), 0)='',
								stringlib.StringToUpperCase(remove_punct)[DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),' ',3)..length(stringlib.StringToUpperCase(remove_punct))],
											
							if(regexfind(',', stringlib.StringToUpperCase(remove_punct), 0)<>'' and regexfind(' JR.| JR| SR.| SR| III| II| IV$',remove_punct[1..DataLib.StringFind(remove_punct,',',1)-1], 0)<>'',
								regexreplace(' JR.| JR| SR.| SR| III| II| IV$',remove_punct[1..DataLib.StringFind(remove_punct,',',1)-1],''),
								stringlib.StringToUpperCase(remove_punct)[1..DataLib.StringFind(stringlib.StringToUpperCase(remove_punct),',',1)-1]))))));

	self.test_suffix_name	:= if(regexfind(',JR|JR\\.| JR\\.| JR | JR,| JR$', stringlib.StringToUpperCase(l.name_orig), 0)<>'' and l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)-1]<>'JR',
								'JR',
								if(regexfind(',SR|SR\\.| SR\\.| SR | SR,| SR$', stringlib.StringToUpperCase(l.name_orig), 0)<>'' and l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)-1]<>'SR',
								'SR',
								if(regexfind(',III$| III | III$| III,', stringlib.StringToUpperCase(l.name_orig), 0)<>'' and l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)-1]<>'III',
								'III',
								if(regexfind(',II$| II | II$| II,', stringlib.StringToUpperCase(l.name_orig), 0)<>'' and l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)-1]<>'II',
								'II',
								if(regexfind(',IV$| IV | IV$', stringlib.StringToUpperCase(l.name_orig), 0)<>'' and l.name_orig[1..DataLib.StringFind(l.name_orig,',',1)-1]<>'IV',
								'IV',
								'')))));
		
	self := l;
	end;

name_fix := project(concat_rec, reformName(left));
//output(name_fix,named('name_fix'));

/////////////////////////////////////////////////////////////////////////////
OKC_Sexual_Offenders.Layout_OKC_Sex_Offender_Common.final restAppended(name_fix InputRecord) := transform
	
	// function to explode race/ethnicity value
	expRaceEthnicity(string strValue):= map(stringlib.StringToUpperCase(trim(strValue,left,right)) = 'A' => 'ASIAN'
	                                    ,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'B' => 'BLACK'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'H' => 'HISPANIC'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'I' => 'INDIAN'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'U' => 'UNKNOWN'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'W' => 'WHITE'
										,stringlib.StringToUpperCase(trim(strValue,left,right)) = 'O' => 'OTHER'
										,stringlib.StringToUpperCase(trim(strValue,left,right)));
	
	unsigned3 tempIntHeight  		:= (unsigned3)lib_stringlib.stringlib.stringfilter(InputRecord.height,'0123456789');
	
	string73 tempName 				:= if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name <> '' and InputRecord.test_middle_name <> 'NMN' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name <> '' ,
										address.CleanPersonFML73(InputRecord.test_first_name + ' ' + InputRecord.test_middle_name + ' ' + InputRecord.test_last_name + ' ' + InputRecord.test_suffix_name),
										if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name <> '' and InputRecord.test_middle_name <> 'NMN' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonFML73(InputRecord.test_first_name + ' ' + InputRecord.test_middle_name + ' ' + InputRecord.test_last_name),
										if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name <> '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name + ' ' + InputRecord.test_first_name + ' ' + InputRecord.test_suffix_name),
										if(InputRecord.test_first_name <> '' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name + ' ' + InputRecord.test_first_name ),
										if(InputRecord.test_first_name = '' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name <> '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name + ' ' + InputRecord.test_suffix_name ),
										if(InputRecord.test_first_name ='' and InputRecord.test_middle_name = '' and InputRecord.test_last_name <> '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonLFM73(InputRecord.test_last_name),
										if(InputRecord.test_first_name <>'' and InputRecord.test_middle_name = '' and InputRecord.test_last_name = '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonFML73(InputRecord.test_first_name),
										if(InputRecord.test_first_name ='' and InputRecord.test_middle_name <> '' and InputRecord.test_middle_name <> 'NMN' and InputRecord.test_last_name = '' and InputRecord.test_suffix_name = '' ,
										address.CleanPersonFML73(InputRecord.test_middle_name),
										''))))))));
							
	self.title               		:= tempName[1..5];
	self.fname			     		:= tempName[6..25];
	self.mname			     		:= tempName[26..45];
	self.lname						:= if(tempName[46..48] in ['JR ','SR '],
										tempName[49..65],
										tempName[46..65]);
	self.name_suffix        		:= if(tempName[46..48] in ['JR ','SR '],
										tempName[46..48],
										tempName[66..70]);
	self.name_score	         		:= tempName[71..73];
	self.name_orig           		:= stringlib.StringToUpperCase(trim(InputRecord.name_orig,left,right));
	self.name_aka            		:= stringlib.StringToUpperCase(trim(InputRecord.name_aka,left,right));
	// If the state is Indiana and the registration date value is 19000101, then set it to null.
	self.reg_date_1          		:= if(InputRecord.orig_state = 'IN' 
										AND InputRecord.reg_date_1 = '19000101', '',
										if(regexfind('LIFE',StringLib.StringToUpperCase(InputRecord.reg_date_1),0)<>'', '99991231'
										,lib_stringlib.stringlib.stringfilter(InputRecord.reg_date_1,'0123456789')));
	self.reg_date_2          		:= if(InputRecord.orig_state = 'IN' 
										AND InputRecord.reg_date_2 = '19000101', '',
										if(regexfind('LIFE',StringLib.StringToUpperCase(InputRecord.reg_date_2),0)<>'', '99991231'
										,lib_stringlib.stringlib.stringfilter(InputRecord.reg_date_2,'0123456789')));
	self.reg_date_3          		:= if(InputRecord.orig_state = 'IN' 
										AND InputRecord.reg_date_3 = '19000101', '',
										if(regexfind('LIFE',StringLib.StringToUpperCase(InputRecord.reg_date_3),0)<>'', '99991231'
										,lib_stringlib.stringlib.stringfilter(InputRecord.reg_date_3,'0123456789')));
	self.date_of_birth       		:= lib_stringlib.stringlib.stringfilter(InputRecord.date_of_birth,'0123456789');
	self.date_of_birth_aka   		:= lib_stringlib.stringlib.stringfilter(InputRecord.date_of_birth_aka,'0123456789');
	self.conviction_date_1   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_1,'0123456789');
	self.conviction_date_2   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_2,'0123456789');
	self.conviction_date_3   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_3,'0123456789');
	self.conviction_date_4   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_4,'0123456789');
	self.conviction_date_5   		:= lib_stringlib.stringlib.stringfilter(InputRecord.conviction_date_5,'0123456789');
	self.offense_date_1      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_1,'0123456789');
	self.offense_date_2      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_2,'0123456789');
	self.offense_date_3      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_3,'0123456789');
	self.offense_date_4      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_4,'0123456789');
	self.offense_date_5      		:= lib_stringlib.stringlib.stringfilter(InputRecord.offense_date_5,'0123456789');
	self.image_date          		:= lib_stringlib.stringlib.stringfilter(InputRecord.image_date,'0123456789');
	self.height         			:=  if(tempIntHeight != 0, intformat((integer)((tempIntHeight/100) * 12 + (tempIntHeight%100)),3,1),'');
	self.sex            			:= 	map(stringlib.StringToUpperCase(trim(InputRecord.sex,left,right)) = 'M' => 'MALE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.sex,left,right)) = 'F' => 'FEMALE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.sex,left,right)) = 'U' => 'UNKNOWN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.sex,left,right)));
	// Trim the prefixed data from the front of the Kentucky records
	self.race           			:= 	if(trim(InputRecord.race,left,right) = ''
										   ,expRaceEthnicity(InputRecord.ethnicity)
										,if(trim(InputRecord.orig_state,left,right) = 'KY' 
											AND InputRecord.race[2..4]             = ' - '
										   ,trim(InputRecord.race[5..],left,right)
										   ,expRaceEthnicity(InputRecord.race)));
	self.ethnicity      			:=  if(trim(InputRecord.ethnicity,left,right) <> ''
										   ,expRaceEthnicity(InputRecord.ethnicity)
										   ,'');
	self.hair_color     			:= 	map(stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'BRO' => 'BROWN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'BLK' => 'BLACK'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'BLN' => 'BLOND'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'GRY' => 'GRAY'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'GRN' => 'GREEN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)) = 'WHI' => 'WHITE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.hair_color,left,right)));
	self.eye_color    				:= 	map(stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'BRO' => 'BROWN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'BLK' => 'BLACK'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'BLU' => 'BLUE'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'GRY' => 'GRAY'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'GRN' => 'GREEN'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)) = 'HAZ' => 'HAZEL'
										   ,stringlib.StringToUpperCase(trim(InputRecord.eye_color,left,right)));
	//self.image_link     			:= if (trim(InputRecord.image_link,left,right) <> '', 'OKC_'+ InputRecord.image_link, '');
	self.image_link       			:= InputRecord.image_link;
	self.source_file                := stringlib.StringToUpperCase(trim(InputRecord.source_file, left, right));
	self.offender_status            := if(trim(InputRecord.offender_status,left,right)<>'' and InputRecord.orig_state='OK',
										'',
										stringlib.StringToUpperCase(trim(InputRecord.offender_status,left,right)));
	self.offender_category          := stringlib.StringToUpperCase(trim(InputRecord.offender_category, left, right));
	self.risk_level_code            := stringlib.StringToUpperCase(trim(InputRecord.risk_level_code, left, right));
	self.risk_description           := stringlib.StringToUpperCase(trim(InputRecord.risk_description, left, right));
	self.police_agency              := stringlib.StringToUpperCase(trim(InputRecord.police_agency, left, right));
	self.police_agency_contact_name := stringlib.StringToUpperCase(trim(InputRecord.police_agency_contact_name, left, right));
	self.police_agency_address_1    := stringlib.StringToUpperCase(trim(InputRecord.police_agency_address_1, left, right));
	self.police_agency_address_2    := stringlib.StringToUpperCase(trim(InputRecord.police_agency_address_2, left, right));
	//self.police_agency_phone      := stringlib.StringToUpperCase(InputRecord.police_agency_phone);
	self.registration_type          := stringlib.StringToUpperCase(trim(InputRecord.registration_type, left, right));
	self.reg_date_1_type            := stringlib.StringToUpperCase(trim(InputRecord.reg_date_1_type, left, right));
	self.reg_date_2_type            := stringlib.StringToUpperCase(trim(InputRecord.reg_date_2_type, left, right));
	self.reg_date_3_type            := stringlib.StringToUpperCase(trim(InputRecord.reg_date_3_type, left, right));
	self.registration_address_3     := stringlib.StringToUpperCase(trim(InputRecord.registration_address_3, left, right));
	self.registration_address_4     := stringlib.StringToUpperCase(trim(InputRecord.registration_address_4, left, right));
	self.registration_address_5     := stringlib.StringToUpperCase(trim(InputRecord.registration_address_5, left, right));
	self.registration_county        := stringlib.StringToUpperCase(trim(InputRecord.registration_county, left, right));
	self.employer                   := stringlib.StringToUpperCase(trim(InputRecord.employer, left, right));
	self.employer_address_1         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_1, left, right));
	self.employer_address_2         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_2, left, right));
	self.employer_address_3         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_3, left, right));
	self.employer_address_4         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_4, left, right));
	self.employer_address_5         := stringlib.StringToUpperCase(trim(InputRecord.employer_address_5, left, right));
	self.employer_county            := stringlib.StringToUpperCase(trim(InputRecord.employer_county, left, right));
	self.school                     := stringlib.StringToUpperCase(trim(InputRecord.school, left, right));
	self.school_address_1           := stringlib.StringToUpperCase(trim(InputRecord.school_address_1, left, right));
	self.school_address_2           := stringlib.StringToUpperCase(trim(InputRecord.school_address_2, left, right));
	self.school_address_3           := stringlib.StringToUpperCase(trim(InputRecord.school_address_3, left, right));
	self.school_address_4           := stringlib.StringToUpperCase(trim(InputRecord.school_address_4, left, right));
	self.school_address_5           := stringlib.StringToUpperCase(trim(InputRecord.school_address_5, left, right));
	self.school_county              := stringlib.StringToUpperCase(trim(InputRecord.school_county, left, right));
	self.offender_id                := stringlib.StringToUpperCase(trim(InputRecord.offender_id, left, right));
	self.doc_number                 := stringlib.StringToUpperCase(trim(InputRecord.doc_number, left, right));
	self.sor_number                 := stringlib.StringToUpperCase(trim(InputRecord.sor_number, left, right));
	self.st_id_number               := stringlib.StringToUpperCase(trim(InputRecord.st_id_number, left, right));
	self.fbi_number                 := stringlib.StringToUpperCase(trim(InputRecord.fbi_number, left, right));
	self.ncic_number                := stringlib.StringToUpperCase(trim(InputRecord.ncic_number, left, right));
	//self.orig_ssn                 := lib_stringlib.stringlib.stringfilter(InputRecord.orig_ssn,'0123456789');
	//self.age                      := lib_stringlib.stringlib.stringfilter(InputRecord.age,'0123456789');
	self.weight                     := lib_stringlib.stringlib.stringfilter(InputRecord.weight,'0123456789');
	self.skin_tone                  := stringlib.StringToUpperCase(trim(InputRecord.skin_tone, left, right));
	self.build_type                 := stringlib.StringToUpperCase(trim(InputRecord.build_type, left, right));
	self.scars_marks_tattoos        := stringlib.StringToUpperCase(trim(InputRecord.scars_marks_tattoos, left, right));
	//self.shoe_size                := stringlib.StringToUpperCase(InputRecord.shoe_size);
	self.corrective_lense_flag      := stringlib.StringToUpperCase(trim(InputRecord.corrective_lense_flag, left, right));
	self.conviction_jurisdiction_1  := if(regexfind('AK AK|AL AL|AR AR|AZ AZ|CA CA|CO CO|CT CT|DC DC|DE DE|FL FL|'+
											'GA GA|HI HI|IA IA|ID ID|IL IL|IN IN|KS KS|KY KY|LA LA|MA MA|MD MD|ME ME|MI MI|MN MN|MO MO|'+
											'MS MS|MT MT|NC NC|ND ND|NE NE|NH NH|NJ NJ|NM NM|NV NV|NY NY|OH OH|OK OK|OR OR|PA PA|RI RI|'+
											'SC SC|SD SD|TN TN|TX TX|UT UT|VA VA|VT VT|WA WA|WI WI|WV WV|WY WY',
											stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right)), 0)<>'' and InputRecord.orig_state = 'NV',
											stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right))[1..length(stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right)))-2],
											stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_1, left, right)));
	self.court_1                    := stringlib.StringToUpperCase(trim(InputRecord.court_1, left, right));
	self.court_case_number_1        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_1, left, right));
	self.offense_code_or_statute_1  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_1, left, right));
	self.offense_description_1      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_1, left, right));
	self.offense_description_1_2    := if(inputrecord.orig_state='ND',
											'',
											stringlib.StringToUpperCase(trim(InputRecord.offense_description_1_2, left, right)));
	self.victim_minor_1             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_1, left, right));
	//self.victim_age_1             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_1            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_1, left, right));
	self.victim_relationship_1      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_1, left, right));
	self.sentence_description_1     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_1, left, right));
	self.sentence_description_1_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_1_2, left, right));
	self.conviction_jurisdiction_2  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_2, left, right));
	self.court_2                    := stringlib.StringToUpperCase(trim(InputRecord.court_2, left, right));
	self.court_case_number_2        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_2, left, right));
	self.offense_code_or_statute_2  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_2, left, right));
	self.offense_description_2      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_2, left, right));
	self.offense_description_2_2    := if(inputrecord.orig_state='ND',
											'',
											stringlib.StringToUpperCase(trim(InputRecord.offense_description_2_2, left, right)));
	self.victim_minor_2             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_2, left, right));
	//self.victim_age_2             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_2            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_2, left, right));
	self.victim_relationship_2      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_2, left, right));
	self.sentence_description_2     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_2, left, right));
	self.sentence_description_2_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_2_2, left, right));
	self.conviction_jurisdiction_3  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_3, left, right));
	self.court_3                    := stringlib.StringToUpperCase(trim(InputRecord.court_3, left, right));
	self.court_case_number_3        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_3, left, right));
	self.offense_code_or_statute_3  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_3, left, right));
	self.offense_description_3      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_3, left, right));
	self.offense_description_3_2    := if(inputrecord.orig_state='ND',
											'',
											stringlib.StringToUpperCase(trim(InputRecord.offense_description_3_2, left, right)));
	self.victim_minor_3             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_3, left, right));
	//self.victim_age_3             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_3            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_3, left, right));
	self.victim_relationship_3      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_3, left, right));
	self.sentence_description_3     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_3, left, right));
	self.sentence_description_3_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_3_2, left, right));
	self.conviction_jurisdiction_4  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_4, left, right));
	self.court_4                    := stringlib.StringToUpperCase(trim(InputRecord.court_4, left, right));
	self.court_case_number_4        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_4, left, right));
	self.offense_code_or_statute_4  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_4, left, right));
	self.offense_description_4      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_4, left, right));
	self.offense_description_4_2    := if(inputrecord.orig_state='ND',
											'',
											stringlib.StringToUpperCase(trim(InputRecord.offense_description_4_2, left, right)));
	self.victim_minor_4             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_4, left, right));
	//self.victim_age_4             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_4            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_4, left, right));
	self.victim_relationship_4      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_4, left, right));
	self.sentence_description_4     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_4, left, right));
	self.sentence_description_4_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_4_2, left, right));
	self.conviction_jurisdiction_5  := stringlib.StringToUpperCase(trim(InputRecord.conviction_jurisdiction_5, left, right));
	self.court_5                    := stringlib.StringToUpperCase(trim(InputRecord.court_5, left, right));
	self.court_case_number_5        := stringlib.StringToUpperCase(trim(InputRecord.court_case_number_5, left, right));
	self.offense_code_or_statute_5  := stringlib.StringToUpperCase(trim(InputRecord.offense_code_or_statute_5, left, right));
	self.offense_description_5      := stringlib.StringToUpperCase(trim(InputRecord.offense_description_5, left, right));
	self.offense_description_5_2    := if(inputrecord.orig_state='ND',
											'',
											stringlib.StringToUpperCase(trim(InputRecord.offense_description_5_2, left, right)));
	self.victim_minor_5             := stringlib.StringToUpperCase(trim(InputRecord.victim_minor_5, left, right));
	//self.victim_age_5             := stringlib.StringToUpperCase(InputRecord.;
	self.victim_gender_5            := stringlib.StringToUpperCase(trim(InputRecord.victim_gender_5, left, right));
	self.victim_relationship_5      := stringlib.StringToUpperCase(trim(InputRecord.victim_relationship_5, left, right));
	self.sentence_description_5     := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_5, left, right));
	self.sentence_description_5_2   := stringlib.StringToUpperCase(trim(InputRecord.sentence_description_5_2, left, right));
	self.addl_comments_1            := stringlib.StringToUpperCase(trim(InputRecord.addl_comments_1[1..140], left, right));
	self.addl_comments_2            := stringlib.StringToUpperCase(trim(InputRecord.addl_comments_2[1..140], left, right));
	self.orig_dl_number             := stringlib.StringToUpperCase(trim(InputRecord.orig_dl_number, left, right));
	self.orig_dl_state              := stringlib.StringToUpperCase(trim(InputRecord.orig_dl_state, left, right));
	//self.orig_veh_year_1          := stringlib.StringToUpperCase(InputRecord.orig_veh_year_1);
	self.orig_veh_color_1           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_color_1, left, right));
	self.orig_veh_make_model_1      := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_make_model_1, left, right));
	self.orig_veh_plate_1           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_plate_1, left, right));
	self.orig_veh_state_1           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_state_1, left, right));
	//self.orig_veh_year_2          := stringlib.StringToUpperCase(InputRecord.;
	self.orig_veh_color_2           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_color_2, left, right));
	self.orig_veh_make_model_2      := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_make_model_2, left, right));
	self.orig_veh_plate_2           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_plate_2, left, right));
	self.orig_veh_state_2           := stringlib.StringToUpperCase(trim(InputRecord.orig_veh_state_2, left, right));
	self.rawaid						:= InputRecord.append_rawaid;
	self.st							:= if(InputRecord.st = '',
											InputRecord.orig_state,
											InputRecord.st);
	self := InputRecord;
end;

//Cleaned_OKC_Sex_Offender := project(cleanAddress,restAppended(left)):persist('~thor_200::in::test::rawaid_20091120');

export Cleaned_OKC_Sex_Offender := project(name_fix, restAppended(left)) : persist('~thor_data400::Persist::Cleaned_OKC_Sex_Offender_Fix_Name_sample3');