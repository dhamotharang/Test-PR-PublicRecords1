import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, lib_word, INQL_FFD, STD;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

// Functions used to clean data, to re-format names, addresses, ppc and dates and to append DID and SSN

EXPORT _Functions := module

export  nullset := ['none','NONE','','NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null','\'N', '\\N', '\'\\N'];

EXPORT Get_Active_WU (string wuname) := function

	valid_state := ['','unknown','submitted', 'compiling','compiled','blocked','running','wait'];
	d := sort(nothor(WorkunitServices.WorkunitList('',NAMED jobname:=wuname))(wuid <> thorlib.wuid() and state in valid_state), -wuid):independent;
	active_workunit :=  exists(d);

	return active_workunit;

END;

Export Convert_DateTime_Format(string dateTimeToConvert) := function
		dateFormatted := Std.Date.ConvertDateFormat(dateTimeToConvert,'%Y-%m-%d','%Y%m%d'); 
		timeFormatted := Std.Date.ConvertTimeFormat(dateTimeToConvert[12..],'%H:%M:%S','%H%M%S');  
		dateTime:= if(dateFormatted<>' ' and (timeFormatted <>'000000' or dateTimeToConvert[12..]='00:00:00')
		            , dateFormatted + ' ' + timeFormatted,'');
		return datetime;
end; 

Export Clean_ToUpper_Str(string pString) := function
    validStr       		 	:= if(trim(pString,all) in nullset,'',pString);
		cleanStr        		:= trim(stringlib.stringcleanspaces(stringlib.stringfilterout(validStr,',')),left,right);
    upperStr 		 				:= STD.Str.ToUpperCase(cleanStr);
		return upperStr;
end; 

Export Clean_SSN(string pSSN) := function

	Possible_SSN := trim(regexreplace('[^0-9]',pSSn,''),left,right);
	cleaned_SSN  := if(length(Possible_SSN)=9	
												and Possible_SSN not in ut.Set_BadSSN	
												and (unsigned)Possible_SSN > 0
										,Possible_SSN
										,'');
	return cleaned_SSN;
end; 

Export Parse_STD_Names(dataset(INQL_ffd.Layouts.Input_Formatted) ToStdNames  = dataset([], INQL_FFD.Layouts.Input_Formatted)) := function

namesT   :=table(ToStdNames(formatted_full_name<>''),{formatted_full_name,title,fname,mname,lname,name_suffix,clean_name});
namesDd  :=dedup(sort(namesT,formatted_full_name),formatted_full_name);

namesDd trName (namesDd l) :=transform
	cleanName := Address.CleanPersonFML73(trim(STD.Str.CleanSpaces(l.formatted_full_name),left,right));
	self.title       := if(cleanName[1..5] in ['MR','MS'],cleanName[1..5],'');
	self.fname       := cleanName[6..25];
	self.mname       := cleanName[26..45];
	self.lname       := cleanName[46..65];
	self.name_suffix := ut.fGetSuffix(cleanName[66..70]);
	self:=l;
end;

stdNames := project(namesDd,trName(left));
parsedNames := join(distribute(ToStdNames(formatted_full_name<>''),hash(formatted_full_name))
												,distribute(stdNames              						,hash(formatted_full_name))
												,left.formatted_full_name=right.formatted_full_name
												,transform(Inql_ffd.Layouts.Input_Formatted
													,self.title:=right.title 
													,self.fname:=right.fname
													,self.mname:=right.mname
													,self.lname:=right.lname
													,self.name_suffix:=right.name_suffix
													,self:=left)
												,left outer
												,local
												)
												+ ToStdNames(formatted_full_name='')
												;
Return ParsedNames;

end; 

export Parse_STD_Addresses(dataset(INQL_ffd.Layouts.Input_Formatted) ToStdAddresses  = dataset([], INQL_FFD.Layouts.Input_Formatted)) := function

addrsF  := ToStdAddresses (formatted_addr_street<>'' and formatted_addr_lastline<>'');
addrsDd := dedup(addrsF,formatted_addr_street,formatted_addr_lastline,all);

addrsDd trAddr (addrsDd l) := transform
				cleanaddr := address.CleanAddress182(l.formatted_addr_street,l.formatted_addr_lastline);
				self.prim_range := address.CleanAddressFieldsFips(cleanaddr).prim_range;//[1..10];
				self.predir := address.CleanAddressFieldsFips(cleanaddr).predir;
				self.prim_name := address.CleanAddressFieldsFips(cleanaddr).prim_name;
				self.addr_suffix := address.CleanAddressFieldsFips(cleanaddr).addr_suffix;
				self.postdir := address.CleanAddressFieldsFips(cleanaddr).postdir;
				self.unit_desig := address.CleanAddressFieldsFips(cleanaddr).unit_desig;
				self.sec_range := address.CleanAddressFieldsFips(cleanaddr).sec_range;
				self.v_city_name := stringlib.stringfindreplace(address.CleanAddressFieldsFips(cleanaddr).v_city_name, 'XXXXX YY', '');
				self.st := address.CleanAddressFieldsFips(cleanaddr).st;
				self.zip5 :=if( cleanaddr[117..121] <> '99999',  cleanaddr[117..121], '');
				self.zip4 := address.CleanAddressFieldsFips(cleanaddr).zip4;
				self.addr_rec_type := address.CleanAddressFieldsFips(cleanaddr).rec_type;
				self.fips_state := address.CleanAddressFieldsFips(cleanaddr).fips_state;
				self.fips_county := address.CleanAddressFieldsFips(cleanaddr).fips_county;
				self.geo_lat := address.CleanAddressFieldsFips(cleanaddr).geo_lat;
				self.geo_long := address.CleanAddressFieldsFips(cleanaddr).geo_long;
				self.cbsa := '';
				self.geo_blk := address.CleanAddressFieldsFips(cleanaddr).geo_blk;
				self.geo_match := address.CleanAddressFieldsFips(cleanaddr).geo_match;
				self.err_stat := address.CleanAddressFieldsFips(cleanaddr).err_stat;
				SELF := l;
				SELF := [];
END;

addrsP 	:=project(addrsDd, trAddr(left)) ;

parsedAddresses		:=join(distribute(addrsF, hash(formatted_addr_street, formatted_addr_lastline))
															,distribute(addrsP, hash(formatted_addr_street, formatted_addr_lastline))
													,   left.formatted_addr_street=right.formatted_addr_street
													and left.formatted_addr_lastline=right.formatted_addr_lastline
													,transform(Inql_ffd.Layouts.Input_Formatted
															,self.prim_range := if(left.formatted_addr_street=right.formatted_addr_street,right.prim_range,'')
															,self.predir := if(left.formatted_addr_street=right.formatted_addr_street,right.predir,'')
															,self.prim_name := if(left.formatted_addr_street=right.formatted_addr_street,right.prim_name,'')
															,self.addr_suffix := if(left.formatted_addr_street=right.formatted_addr_street,right.addr_suffix,'')
															,self.postdir := if(left.formatted_addr_street=right.formatted_addr_street,right.postdir,'')
															,self.unit_desig := if(left.formatted_addr_street=right.formatted_addr_street,right.unit_desig,'')
															,self.sec_range := if(left.formatted_addr_street=right.formatted_addr_street,right.sec_range,'')
															,self.v_city_name := if(left.formatted_addr_street=right.formatted_addr_street,right.v_city_name,'')
															,self.st := if(left.formatted_addr_street=right.formatted_addr_street,right.st,'')
															,self.zip5 :=if(left.formatted_addr_street=right.formatted_addr_street,right.zip5,'')
															,self.zip4 := if(left.formatted_addr_street=right.formatted_addr_street,right.zip4,'')
															,self.addr_rec_type := if(left.formatted_addr_street=right.formatted_addr_street,right.addr_rec_type,'')
															,self.fips_state := if(left.formatted_addr_street=right.formatted_addr_street,right.fips_state,'')
															,self.fips_county := if(left.formatted_addr_street=right.formatted_addr_street,right.fips_county,'')
															,self.geo_lat := if(left.formatted_addr_street=right.formatted_addr_street,right.geo_lat,'')
															,self.geo_long := if(left.formatted_addr_street=right.formatted_addr_street,right.geo_long,'')
															,self.cbsa := '';
															,self.geo_blk := if(left.formatted_addr_street=right.formatted_addr_street,right.geo_blk,'')
															,self.geo_match := if(left.formatted_addr_street=right.formatted_addr_street,right.geo_match,'')
															,self.err_stat := if(left.formatted_addr_street=right.formatted_addr_street,right.err_stat,'')
															,self:=left)
													,left outer
													,local
												 )
												+ ToStdAddresses(formatted_addr_street='' or formatted_addr_lastline='')
												 ;

return parsedAddresses;

end; 


Export Append_DID_SSN(dataset(Layouts.Input_Formatted) pInFile) := function

Infile := distribute(project(pInFile(fname + lname <> '')
		, transform({unsigned8 id, recordof(pInFile)},
				self.id := hash64(left.fname, left.mname, left.lname, left.name_suffix, left.formatted_ssn, left.formatted_dob, 
													left.prim_range, left.prim_name, left.sec_range, left.zip5, left.st, left.formatted_phone_nbr);
				self := left)), id);

trimInfile := table(infile, {id, appendadl, appendssn,  
														 fname, mname, lname, name_suffix, 
														 formatted_ssn, formatted_dob, formatted_phone_nbr, 
														 prim_range, prim_name, sec_range, zip5, st}, local);																				
														 
dedInfile := dedup(sort(trimInfile, id, local), id, local);

did_match_set := ['A','D','S','P','4','Z'];

did_add.MAC_Match_Flex(dedInfile(fname <> '' and lname <> ''), did_match_set,
						formatted_ssn, formatted_dob, fname, mname, lname, name_suffix,
						prim_range, prim_name, sec_range, zip5, st, formatted_phone_nbr,
						appendadl, recordof(dedInfile),false,'',
						75, DIDedFile);

    candi := DIDedFile(appendadl > 0);
not_candi := DIDedFile(appendadl = 0);

did_add.MAC_Add_SSN_By_DID(candi, appendadl, appendssn, addSSN, false);

AppendedFile := addSSN + not_candi + dedInfile(fname = '' or lname = '');
 
JnRecsBack := join(Infile, distribute(AppendedFile, id), left.id = right.id,
										transform({recordof(pinfile)}, 
															self.appendadl := right.appendadl;										
															self.appendssn := right.appendssn;										
															self := left), left outer, local);

return JnRecsBack + pInFile(fname + lname = '');

end;

Export CleanFields(inputFile,outputFile) := macro // copy of ut.cleanfields modified to filter out '\\N' 

		LOADXML('<xml/>');
		#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))

		#uniquename(myCleanFunction)
		string %myCleanFunction%(string x) := map(trim(x,all) in Inql_FFD._Functions.nullset => ''
		                                         ,stringlib.stringcleanspaces(regexreplace('[^ -~]+',x,' ')));

		#uniquename(tra)
		inputFile %tra%(inputFile le) :=
		TRANSFORM
		#IF (%'doCleanFieldText'%='')
		 #DECLARE(doCleanFieldText)
		#END
		#SET (doCleanFieldText, false)
		#FOR (doCleanFieldMetaInfo)
		 #FOR (Field)
			#IF (%'@type'% = 'string' )
			#SET (doCleanFieldText, 'SELF.' + %'@name'%)
				#APPEND (doCleanFieldText, ':= ' + %'myCleanFunction'% + '(le.')
			#APPEND (doCleanFieldText, %'@name'%)
			#APPEND (doCleanFieldText, ');\n')
			%doCleanFieldText%;
			#END
		 #END
		#END
			SELF := le;
		END;

		outputFile := PROJECT(inputFile, %tra%(LEFT));

	endmacro;


export Convert_PPC (string ppc) := map(ppc = '4' 	=> '113',
																	ppc = '5' 	=> '112',
																	ppc = '7' 	=> '112',
																	ppc = '8' 	=> '110',
																	ppc = '10' 	=> '118',
																	ppc = '14' 	=> '114',
																	ppc = '57' 	=> '110',
																	ppc = '73' 	=> '121',
																	ppc = '100' 	=> '110',
																	ppc = '101' 	=> '110',
																	ppc = '102' 	=> '110',
																	ppc = '103' 	=> '110',
																	ppc = '104' 	=> '132',
																	ppc = '105' 	=> '233',
																	ppc = '106' 	=> '115',
																	ppc = '150' 	=> '230',
																	ppc = '151' 	=> '228',
																	ppc = '152' 	=> 'N/A',
																	ppc = '153' 	=> '230',
																	ppc = '154' 	=> 'N/A',
																	ppc = '155' 	=> '226',
																	ppc = '156' 	=> '230',
																	ppc = '157' 	=> '222',
																	ppc = '158' 	=> '223',
																	ppc = '159' 	=> '218',
																	ppc = '160' 	=> 'N/A',
																	ppc = '161' 	=> '219',
																	ppc = '162' 	=> '220',
																	ppc = '163' 	=> '231',
																	ppc = '164' 	=> '113',
																	ppc = '165' 	=> '216',
																	ppc = '166' 	=> '235',
																	ppc = '167' 	=> '212',
																	ppc = '168' 	=> '234',
																	ppc = '5' 	=> '212',
																	ppc = '7' 	=> '212',
																	ppc = '14' 	=> '214',
																	ppc = '8' 	=> '110',
																	ppc = '57' 	=> '110',
																	ppc = '10' 	=> '218',
																	ppc = '73' 	=> '221',
																	ppc = '73' 	=> '221',
																	ppc = '2' 	=> '113',
																	ppc = '2' 	=> '113',
																	ppc = '12' 	=> '110',
																	ppc = '13' 	=> '233',
																	ppc = '??' 	=> '216',
																	ppc = 'AR' 	=> '129',
																	ppc = 'BN' 	=> '127',
																	ppc = 'CL' 	=> '113',
																	ppc = 'CT' 	=> '110',
																	ppc = 'GB' 	=> '227',
																	ppc = 'PY' 	=> '227',
																	ppc = 'RA' 	=> '227',
																	ppc = '4' 	=> '113',
																	ppc = '52' 	=> '110',
																	ppc = '59' 	=> '110',
																	ppc = '60' 	=> '110',
																	ppc = '61' 	=> '110',
																	ppc = '13' 	=> '227',
																	ppc = 'CL' 	=> '113',
																	ppc = 'CT' 	=> '110',
																	ppc = 'CT' 	=> '110',
																	ppc = 'CT' 	=> '110',
																	ppc = 'CT' 	=> '110',
																	ppc = 'RA' 	=> '227',
																	ppc = '10??'	 => '211',
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '230',	
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '224',	
																	ppc = 'N/A - hard coded' => '225',	
																	ppc = 'N/A - hard coded' => '233',	
																	ppc = '0' 	=> '',
																	ppc = '1' 	=> '110',
																	ppc = '2' 	=> '113',
																	ppc = '3' 	=> '218',
																	ppc = '4' 	=> '219',
																	ppc = '5' 	=> '220',
																	ppc = '6' 	=> '222',
																	ppc = '7' 	=> '223',
																	ppc = '8' 	=> '228',
																	ppc = '9' 	=> '230',
																	ppc = '10' 	=> 'N/A',
																	ppc = '11' 	=> '132',
																	ppc = '12' 	=> '228',
																	ppc = '13' 	=> '233',
																	ppc);
end;