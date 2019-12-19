IMPORT GlobalWatchLists_Preprocess, std, address, ut;

EXPORT  ProcessDebarredParties := FUNCTION

	paren_pattern 				:= '^(.*)\\((.*)\\)(.*)$';

	GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout xFormAKA(GlobalWatchLists_Preprocess.Layouts.rDebarredParties L) := TRANSFORM	
		ClnAKA				 := IF(STD.Str.Find(STD.Str.ToUpperCase(L.name_info), 'A.K.A', 1) > 0, REGEXREPLACE('(A.K.A. |A.K.A )',STD.Str.ToUpperCase(L.name_info),'AKA '),L.name_info);
		self.aka 			 := MAP(REGEXFIND(paren_pattern,ClnAKA) => REGEXFIND(paren_pattern,ClnAKA,2),
													STD.Str.Find(ClnAKA, 'AKA ', 1) > 0 => TRIM(ClnAKA, left, right)[STD.Str.Find(ClnAKA, 'AKA ',1)+3..],
													'');
		// self.aka 			 := if(STD.Str.Find(L.name_info, 'aka ', 1) > 0 or STD.Str.Find(L.name_info, 'AKA ', 1) > 0
												// ,STD.Str.FilterOut(TRIM(L.name_info, left, right)[STD.Str.Find(REGEXREPLACE('AKA ', L.name_info, 'aka '), 'aka ', 1) + 3..(length(L.name_info) - (STD.Str.Find(regexreplace('AKA ', L.name_info, 'aka '), 'aka ', 1))+4) + (STD.Str.Find(REGEXREPLACE('AKA ', L.name_info, 'aka '), 'aka ', 1) + 3)], ')')
												// ,'');
		self.name_info := IF(STD.Str.Find(L.name_info, 'aka ', 1) > 0 or STD.Str.Find(L.name_info, 'AKA ', 1) > 0 or STD.Str.Find(L.name_info, '(', 1) > 0
												,TRIM(L.name_info, left, right)[1..STD.Str.Find(L.name_info, '(', 1) - 1]
												,L.name_info);
		self.DOB 								:= STD.Str.ToUpperCase(L.DOB);
   	self.registration_info 	:= L.registration_info;
   	self.Date 							:= L.Date;
		self.orig_raw_name			:= L.name_info;
	END;
	
	fmtsin := [
		'%m/%d/%Y',
		'%m-%d-%y',
		'%Y-%m-%d'
	];
	fmtout := '%Y%m%d';
	
	suffix_set := '( JR.| SR.)';
	GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout2 FormatFields(GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout L, INTEGER Ctr) := TRANSFORM
		self.ent_key 				:= 'DTC' + INTFORMAT(Ctr, 3, 1);
		self.source 				:= 'Defense Trade Controls (DTC)Debarred Parties';
		self.lst_vend_upd 	:= GlobalWatchLists_Preprocess.Versions.DebbaredParties_Version;
		tempFirm						:= IF((STD.Str.Find(L.name_info,',', 1)   = 0 or
															STD.Str.Find(L.name_info,'Ltd', 1)  > 0 or 
															STD.Str.Find(L.name_info,'Inc', 1)  > 0 or 
															STD.Str.Find(L.name_info,'Corp', 1) > 0) and 
															STD.Str.Find(L.name_info,'Gia An Du',1) = 0
															,L.name_info
															,'');
		self.lstd_firm 			:= ut.CleanSpacesAndUpper(tempFirm);
		tempName						:= ut.CleanSpacesAndUpper(IF((STD.Str.Find(L.name_info,',', 1)   > 0  and 
																											STD.Str.Find(L.name_info,'Ltd', 1)  = 0  and 
																											STD.Str.Find(L.name_info,'Inc', 1)  = 0  and 
																											STD.Str.Find(L.name_info,'Corp', 1) = 0) or 
																											STD.Str.Find(L.name_info,'Gia An Du',1) > 0
																											,L.name_info 
																											,''));
		self.lstd_entity 		:= tempName;
		self.aka 						:= ut.CleanSpacesAndUpper(REGEXREPLACE('AKA', L.aka, '',NOCASE));
		self.fr_citation_1 	:= ut.CleanSpacesAndUpper(L.registration_info);
		self.eff_dt_1 			:= STD.Date.ConvertDateFormatMultiple(L.Date, fmtsin, fmtout);
		tempDOB							:= MAP(L.DOB[1..3] = 'JAN' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'01'+'00',
															L.DOB[1..3] = 'FEB' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'02'+'00',
															L.DOB[1..3] = 'MAR' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'03'+'00',
															L.DOB[1..3] = 'APR' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'04'+'00',
															L.DOB[1..3] = 'MAY' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'05'+'00',
															L.DOB[1..3] = 'JUN' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'06'+'00',
															L.DOB[1..3] = 'JUL' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'07'+'00',
															L.DOB[1..3] = 'AUG' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'08'+'00',
															L.DOB[1..3] = 'SEP' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'09'+'00',
															L.DOB[1..3] = 'OCT' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'10'+'00',
															L.DOB[1..3] = 'NOV' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'11'+'00',
															L.DOB[1..3] = 'DEC' => TRIM(L.DOB[STD.Str.Find(L.DOB, ',', 1) +2..],LEFT,RIGHT)+'12'+'00','');
		//self.dob 						:= STD.Date.ConvertDateFormatMultiple(L.DOB, fmtsin, fmtout);
		self.dob						:= tempDOB;
		self.orig_raw_name	:= ut.CleanSpacesAndUpper(L.orig_raw_name);
	END;
	
	dsIntermediate := PROJECT(PROJECT(GlobalWatchLists_Preprocess.Files.dsDebarredParties(TRIM(name_info,ALL)<> ''), xFormAKA(left)), FormatFields(left, counter));
	
		GlobalWatchLists_Preprocess.rOutLayout Redefine1(GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout2 L) := TRANSFORM
		self.pty_key 								:= L.ent_key;
		self.source 								:= L.source;
		self.orig_pty_name 					:= IF(TRIM(L.lstd_firm, left, right) <> '', L.lstd_firm, L.lstd_entity);
		self.orig_vessel_name 			:= '';
		self.name_type 							:= 'PRIMARY';
		self.remarks_1 							:= IF(L.fr_citation_1 <> '', TRIM(L.fr_citation_1, left, right) + ' ,EFFECTIVE DATE: ' + TRIM(TRIM(L.eff_dt_1, left, right)[1..9], left, right), '');
		self.cname_clean 						:= IF(TRIM(L.lstd_firm, left, right) <> '', STD.Str.ToUpperCase(L.lstd_firm), '');
		ClnNameSuffix								:= IF(REGEXFIND(suffix_set,L.lstd_entity),REGEXREPLACE('^([A-Z]+),',L.lstd_entity,'$1 '),L.lstd_entity);
		ParseFirstName							:= TRIM(IF(TRIM(ClnNameSuffix, left, right) <> '' and STD.Str.Find(ClnNameSuffix, ',', 1) > 0
																					,TRIM(ClnNameSuffix[STD.Str.Find(ClnNameSuffix, ',', 1)+1..75+STD.Str.Find(ClnNameSuffix, ',', 1)+1-1], left, right)
																					,'')
																			 ,left,right);
		ParseLastName								:= TRIM(IF(TRIM(ClnNameSuffix, left, right) <> '' and STD.Str.Find(ClnNameSuffix, ',', 1) > 0
																					,TRIM(ClnNameSuffix[1..STD.Str.Find(ClnNameSuffix, ',', 1)-1], left, right)
																					,'')
																			,left,right);
		self.pname_clean 						:= IF(TRIM(ClnNameSuffix, left, right) <> '' and STD.Str.Find(ClnNameSuffix, ',', 1) > 0 and ~REGEXFIND(suffix_set,ClnNameSuffix)
																		,Address.CleanPersonLFM73(ClnNameSuffix)
																		,IF(TRIM(ClnNameSuffix, left, right) <> '' and STD.Str.Find(ClnNameSuffix, ',', 1) > 0 and REGEXFIND(suffix_set,ClnNameSuffix)
																		,Address.CleanPersonFML73(ParseFirstName+' '+ParseLastName)
																			,IF(TRIM(ClnNameSuffix, left, right) <> '' and STD.Str.Find(ClnNameSuffix, ',', 1) = 0
																					,Address.CleanPersonFML73(ClnNameSuffix)
																					,'')));
		self.addr_clean 						:= '';
		self.date_first_seen 				:= L.lst_vend_upd;
		self.date_last_seen 				:= L.lst_vend_upd;
		self.date_vendor_first_reported := L.lst_vend_upd;
		self.date_vendor_last_reported 	:= L.lst_vend_upd;
		self.orig_first_name 				:= ParseFirstName;
		self.orig_last_name 				:= ParseLastName;
		self.orig_aka_id 						:= '';
		self.orig_aka_type 					:= '';
		self.orig_aka_category 			:= '';
		self.orig_giv_designator 		:= IF(TRIM(L.lstd_firm, left, right) <> '', 'G', 'I');
		self.orig_address_id 				:= '';
		self.orig_date_last_updated := L.lst_vend_upd;
		self.orig_federal_register_citation_1 := L.fr_citation_1;
		self.orig_federal_register_citation_date_1 := TRIM(L.eff_dt_1, left, right);
		self.orig_dob_1 						:= L.DOB;
		self.orig_raw_name					:= L.orig_raw_name;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout3 Redefine2(GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout2 L) := TRANSFORM
		self.lstd_entity 	:= IF(TRIM(L.lstd_firm, left, right) <> '', L.aka, '');
		self.aka_flag 		:= 'AKA';
		self.eff_dt_1 		:= TRIM(L.eff_dt_1, left, right)[1..9];
		self.orig_raw_name:= L.orig_raw_name;
		self.num 					:= IF(TRIM(L.aka, left, right) <> '' and TRIM(L.lstd_firm, left, right) <> ''
													,IF(STD.Str.Find(L.aka, ';', 1) > 0 and STD.Str.Find(L.aka[STD.Str.Find(L.aka, ';', 1)+1..length(L.aka) + STD.Str.Find(L.aka, ';', 1)+1-1], ';', 1) > 0
															,3
															,IF(STD.Str.Find(L.aka, ';', 1) > 0															
																,2
																,1))
													,0);
		self := L;
	END;
	
	GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout3 Redefine3(GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout2 L) := TRANSFORM
		self.lstd_entity 	:= IF(TRIM(L.lstd_entity, left, right) <> '' AND TRIM(L.lstd_firm, left, right) = '', L.aka, '');
		self.aka_flag 		:= 'AKA';
		self.eff_dt_1 		:= TRIM(L.eff_dt_1, left, right)[1..9];
		self.orig_raw_name:= L.orig_raw_name;
		self.num 					:= IF(TRIM(L.aka, left, right) <> '' and TRIM(L.lstd_entity, left, right) <> '' and STD.Str.Find(L.aka, ';', 1) = 0
												,1
												,IF(TRIM(L.aka, left, right) <> '' and TRIM(L.lstd_entity, left, right) <> '' and STD.Str.Find(L.aka, ';', 1) > 0
													,STD.Str.CountWords(L.aka,';')
													,0));
		self 							:= L;
	END;
	
	Primary 			:= PROJECT(dsIntermediate, Redefine1(left));
	dsFirmAkas 		:= PROJECT(dsIntermediate, Redefine2(left))(TRIM(lstd_entity, left, right) <> '');
	dsPersonAkas 	:= PROJECT(dsIntermediate, Redefine3(left))(TRIM(lstd_entity, left, right) <> '');
	
		GlobalWatchLists_Preprocess.rOutLayout NormFirmAkas(GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout3 L, INTEGER C) := TRANSFORM
		string150 new_orig_Organization := STD.Str.SplitWords(L.lstd_entity, ';')[C];
		self.pty_key 							:= TRIM(L.ent_key, left, right);
		self.source 							:= L.source;
		self.orig_pty_name 				:= TRIM(new_orig_Organization, left, right);
		self.orig_vessel_name 		:= '';
		self.name_type 						:= L.aka_flag;
		self.remarks_1 						:= IF(L.fr_citation_1 <> '', TRIM(L.fr_citation_1, left, right) + ' ,EFFECTIVE DATE: ' + TRIM(TRIM(L.eff_dt_1, left, right)[1..9], left, right), '');
		self.cname_clean 					:= TRIM(STD.Str.ToUpperCase(REGEXREPLACE('SUCESSOR IS', REGEXREPLACE('FORMERLY', new_orig_Organization, ''), '')), left, right);  //string(174) citation;
		self.pname_clean 					:= '';
		self.addr_clean 					:= '';
		self.date_first_seen 			:= L.lst_vend_upd;
		self.date_last_seen 			:= L.lst_vend_upd;
		self.date_vendor_first_reported := L.lst_vend_upd;
		self.date_vendor_last_reported 	:= L.lst_vend_upd;
		self.orig_aka_id 					:= '';
		self.orig_aka_type 				:= L.aka_flag;
		self.orig_aka_category 		:= '';
		self.orig_giv_designator 	:= 'G';
		self.orig_address_id 			:= '';
		self.orig_federal_register_citation_1 := L.fr_citation_1;
		self.orig_federal_register_citation_date_1 := TRIM(L.eff_dt_1, left, right);
		self.orig_raw_name				:= L.orig_raw_name;
	END;
	
	NormalizedFirmAkas := NORMALIZE(dsFirmAkas, LEFT.num, NormFirmAkas(LEFT,COUNTER));

  GlobalWatchLists_Preprocess.rOutLayout NormPersonAkas(GlobalWatchLists_Preprocess.IntermediaryLayoutDebbaredParties.tempLayout3 L, INTEGER C) := TRANSFORM
		string150 new_orig_Person := STD.Str.SplitWords(L.lstd_entity, ';')[C];
		self.pty_key 							:= TRIM(L.ent_key, left, right);
		self.source 							:= L.source;
		self.orig_pty_name 				:= TRIM(new_orig_Person, left, right);
		self.orig_vessel_name 		:= '';
		self.name_type 						:= L.aka_flag;
		self.remarks_1 						:= IF(L.fr_citation_1 <> '', TRIM(L.fr_citation_1, left, right) + ' ,EFFECTIVE DATE: ' + TRIM(TRIM(L.eff_dt_1, left, right)[1..9], left, right), '');
		self.cname_clean 					:= '';
		self.pname_clean 					:= Address.CleanPersonFML73(new_orig_Person);
		self.addr_clean 					:= '';
		self.date_first_seen 			:= L.lst_vend_upd;
		self.date_last_seen 			:= L.lst_vend_upd;
		self.date_vendor_first_reported := L.lst_vend_upd;
		self.date_vendor_last_reported 	:= L.lst_vend_upd;
		self.orig_aka_id 					:= '';
		self.orig_aka_type 				:= L.aka_flag;
		self.orig_aka_category 		:= '';
		self.orig_giv_designator 	:= 'I';
		self.orig_address_id 			:= '';
		self.orig_federal_register_citation_1 := L.fr_citation_1;
		self.orig_federal_register_citation_date_1 := TRIM(L.eff_dt_1, left, right);
		self.orig_dob_1 					:= L.DOB;
		self.orig_raw_name				:= L.orig_raw_name;
	END;
	
	NormalizedPersonAkas := NORMALIZE(dsPersonAkas, LEFT.num, NormPersonAkas(LEFT,COUNTER));
	
	dConcatAll	:= Primary + NormalizedFirmAkas + NormalizedPersonAkas;
	
	return dConcatAll(orig_pty_name <> '' and orig_pty_name <> 'NAME');
		
END;