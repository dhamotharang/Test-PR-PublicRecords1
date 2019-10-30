import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, lib_word, INQL_FFD;
import standard, header_slimsort, didville, business_header,watchdog, mdr, header;

EXPORT Fn_Clean_Parse := module


  export nullset := ['none','NONE','','NULL','null','UNKNOWN','unknown', 'UKNOWN', 'Null','\'N', '\\N', '\'\\N'];
	
	export clean_ssn(string orig_ssn):= function
					pclean_ssn := stringlib.stringfilter(orig_ssn, '0123456789');
					qclean_ssn := if(pclean_ssn not in ['000000000', '0', '0000', '00000'] and pclean_ssn not in ut.Set_BadSSN and pclean_ssn not in NullSet,  pclean_ssn, '');
					return if(length(trim(qclean_ssn, all)) in [4,6], 
															intformat((unsigned8)stringlib.stringfilter(trim(qclean_ssn, all), '0123456789'), 9, 0),
															stringlib.stringfilter(trim(qclean_ssn, all), '0123456789'));
	end;

	export clean_phone(string orig_phone) := function
					pclean_phone := if(orig_phone[1..3] in ['000','XXX','xxx'], '   ', orig_phone[1..3])+ orig_phone[4..10]; /* empty area codes standardized */
					NPAg := pclean_phone[1..3] in ['800','811','822','833','844','855','866','877','888','899'] or orig_phone[1..3] between '200' and '999'; /* toll free area codes */
					NXXg := pclean_phone[4..6] between '001' and '999'; /* valid nxx */
					TBg  := pclean_phone[7..10] between '0000' and '9999'; /* valid tb+ */
					return  map(NPAg and NXXg and TBg => pclean_phone, NXXg and TBg => '   ' + pclean_phone[7..10], '');
	end;

	export tDateAdded(string indate) := function //dates like Dec  1 2009 5:35:32:011AM
		upcaseit 	:= trim(stringlib.stringtouppercase(indate), left, right);
		noTrans := ~regexfind('[B-LN-OQ-Z]', upcaseit); // do not find more than AM PM
		month 	:= map(upcaseit[1..3] = 'JAN' => '01',
						upcaseit[1..3] = 'FEB' => '02',
						upcaseit[1..3] = 'MAR' => '03',
						upcaseit[1..3] = 'APR' => '04',
						upcaseit[1..3] = 'MAY' => '05',
						upcaseit[1..3] = 'JUN' => '06',
						upcaseit[1..3] = 'JUL' => '07',
						upcaseit[1..3] = 'AUG' => '08',
						upcaseit[1..3] = 'SEP' => '09',
						upcaseit[1..3] = 'OCT' => '10',
						upcaseit[1..3] = 'NOV' => '11',
						upcaseit[1..3] = 'DEC' => '12', '');
		DyYr 	:= (string)intformat((integer6)stringlib.stringfilter(upcaseit[4..11], '0123456789'), 6, 1);
		Dy		:= DyYr[1..2];
		Yr		:= DyYr[3..6];
		return stringlib.stringcleanspaces(if(noTrans, stringlib.stringfilterout(upcaseit, '-'), yr+month+dy+' '+upcaseit[12..]));
	end;	

	export tTimeAdded(string dt) := function //dates like 20110101 10:15:123456AM

		time_only 				:= stringlib.stringtouppercase(trim(dt, all)[9..]);
		
		a	:= (string)intformat((integer)time_only[..2], 2, 1);

		remove_nonalphnum1 := regexreplace('[^AMP0-9]', a, '');
		remove_nonalphnum2 := regexreplace('[^AMP0-9]', time_only[3..], '');

		remove_nonalphnum := remove_nonalphnum1 + remove_nonalphnum2;

		ampm 							:= regexreplace('[^AMP]', remove_nonalphnum, '')[..2];
		has_ampm					:= ampm in ['AM','PM'];

		numbs							:= regexreplace('[^0-9]', remove_nonalphnum, '');
		
		hr								:= (integer)numbs[..2];
		
		hr_ampm						:= intformat(map(~has_ampm => hr,
														 has_ampm and ampm = 'AM' and hr < 12 => hr,
														 has_ampm and ampm = 'AM' and hr = 12 => 0,
														 has_ampm and ampm = 'PM' and hr < 12 => hr + 12, 
														 has_ampm and ampm = 'PM' and hr = 12 => 12, 
														 99), 2, 1);
														 
		dt_hr := trim(dt, all)[..8] + ' ' + trim(((string)hr_ampm + numbs[3..8] + '00000000'), all)[..8];

		return dt_hr;
	end;

	export clean_dob(string orig_dob) := function
		clean_yr := map((unsigned8)orig_dob[1..4] between ((unsigned8)ut.getdate[1..4]) - 123 and (unsigned8)ut.getdate[1..4] => orig_dob[1..4], '0000');
		clean_mn := map(orig_dob[5..6] between '01' and '12' => orig_dob[5..6], '00');
		clean_dy := map(clean_mn <> '00' and clean_yr <> '0000' and (unsigned8)orig_dob[7..8] between 1 and ut.Month_Days((unsigned8)(clean_yr+clean_mn)) => orig_dob[7..8],
							clean_mn in ['01','03','05','07','08','10','12'] and orig_dob[7..8] between '01' and '31' => orig_dob[7..8],
							clean_mn in ['04','06','09','11'] and orig_dob[7..8] between '01' and '30' => orig_dob[7..8],
							clean_mn = '02' and orig_dob[7..8] between '01' and '29' => orig_dob[7..8],
							'00');
							
		return stringlib.stringfindreplace(clean_yr + clean_mn + clean_dy, '00000000', '');
	end;
	
  export CleanFields(inputFile,outputFile) := macro

		LOADXML('<xml/>');
		#EXPORTXML(doCleanFieldMetaInfo, recordof(inputFile))

		#uniquename(myCleanFunction)
		string %myCleanFunction%(string x) := stringlib.stringcleanspaces(regexreplace('[^[:print:]]+',trim(stringlib.stringfindreplace(stringlib.stringfindreplace(stringlib.stringtouppercase(
																					map(trim(x,all) in Inql_ffd.Fn_Clean_Parse.nullset => '',
																					    if (stringlib.stringfind(x,'(ROLLUP)',1)>0,
																									stringlib.stringcleanspaces(stringlib.stringfilterout(x,'{}|_><+=*~[]!@#$%^&*?;\"`')),
																									stringlib.stringcleanspaces(stringlib.stringfilterout(x,'{}|_><+=*~[]!@#$%^&*()?;\"`'))
																									)
																							)		
																					), '&amp;', '&'), '\\N',''), left, right),' '));

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
	
	
	
  export parse_name_address(dataset(INQL_ffd.Layouts.Input_Formatted) ToBeStandard  = dataset([], INQL_FFD.Layouts.Input_Formatted)) := Function	
	
		 macNameCleaner(ToBeStandard, CommonNameClean, formatted_full_name , 'F', ' ', 'F');
	   macAddressCleaner(CommonNameClean, CommonNameAddrClean, Clean_ADDR, Clean_ADDR, addr_street, formatted_addr_lastline);

	return project(CommonNameAddrClean, TRANSFORM(Layouts.Input_formatted,
					
					cleanname := left.clean_name;
														
					self.title := stringlib.stringfilter(cleanName[1..5], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.fname := stringlib.stringfilter(cleanName[6..25], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.mname := stringlib.stringfilter(cleanName[26..45], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.lname := stringlib.stringfilter(cleanName[46..65], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');
					self.name_suffix := stringlib.stringfilter(cleanName[66..70], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ-\' ');

					cleanaddr := left.CLEAN_ADDR;
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
					self := left;
					self := [] ));
					
end;
	
export mapppc(string ppc) := 	map(ppc = '4' 	=> '113',
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
