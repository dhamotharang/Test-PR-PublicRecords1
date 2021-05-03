import RoxieKeyBuild,PRTE, _control, STD,prte2,tools,AutoKeyB,Doxie,AutoStandardI,AutoKeyB2,PRTE2_Common,dops,Orbit3;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function
is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 								:= is_running_in_prod AND NOT skipDOPS;

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_0010_Header_BDID, 																Constants.key_prefix + '0010_header::bdid',																		Constants.key_prefix+filedate+ '::0010_header::bdid',																	k1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_0010_Header_FILE_NUMBER, 													Constants.key_prefix + '0010_header::file_number',														Constants.key_prefix+filedate+ '::0010_header::file_number',													k2);
	
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_1000_Executive_Summary_BDID, 											Constants.key_prefix + '1000_executive_summary::bdid',												Constants.key_prefix+filedate+ '::1000_executive_summary::bdid',											k3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_1000_Executive_Summary_FILE_NUMBER,								Constants.key_prefix + '1000_executive_summary::file_number',									Constants.key_prefix+filedate+ '::1000_executive_summary::file_number',								k4);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_2000_Trade_FILE_NUMBER, 													Constants.key_prefix + '2000_Trade::file_number',															Constants.key_prefix+filedate+ '::2000_Trade::file_number',														k5);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_2015_Trade_Payment_Totals_FILE_NUMBER, 						Constants.key_prefix + '2015_Trade_Payment_Totals::file_number',							Constants.key_prefix+filedate+ '::2015_Trade_Payment_Totals::file_number',						k6);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_2020_Trade_Payment_Trends_FILE_NUMBER, 						Constants.key_prefix + '2020_Trade_Payment_Trends::file_number',							Constants.key_prefix+filedate+ '::2020_Trade_Payment_Trends::file_number',						k7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_2025_Trade_Quarterly_Averages_FILE_NUMBER, 				Constants.key_prefix + '2025_Trade_Quarterly_Averages::file_number',					Constants.key_prefix+filedate+ '::2025_Trade_Quarterly_Averages::file_number',					k8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_4010_Bankruptcy_FILE_NUMBER, 											Constants.key_prefix + '4010_Bankruptcy::file_number',												Constants.key_prefix+filedate+ '::4010_Bankruptcy::file_number',											k9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_4020_Tax_Liens_FILE_NUMBER, 											Constants.key_prefix + '4020_Tax_Liens::file_number',													Constants.key_prefix+filedate+ '::4020_Tax_Liens::file_number',												k10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_4030_Judgement_FILE_NUMBER, 											Constants.key_prefix + '4030_Judgement::file_number',													Constants.key_prefix+filedate+ '::4030_Judgement::file_number',												k11);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_4500_Collateral_Accounts_FILE_NUMBER, 						Constants.key_prefix + '4500_Collateral_Accounts::file_number',								Constants.key_prefix+filedate+ '::4500_Collateral_Accounts::file_number',							k12);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_4510_UCC_Filings_FILE_NUMBER, 										Constants.key_prefix + '4510_UCC_Filings::file_number',												Constants.key_prefix+filedate+ '::4510_UCC_Filings::file_number',											k13);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_5000_Bank_Details_FILE_NUMBER, 										Constants.key_prefix + '5000_Bank_Details::file_number',											Constants.key_prefix+filedate+ '::5000_Bank_Details::file_number',										k14);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_5600_Demographic_Data_BDID, 											Constants.key_prefix + '5600_Demographic_data::bdid',													Constants.key_prefix+filedate+ '::5600_Demographic_data::bdid',												k15);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_5600_Demographic_Data_FILE_NUMBER, 								Constants.key_prefix + '5600_Demographic_data::file_number',									Constants.key_prefix+filedate+ '::5600_Demographic_data::file_number',								k16);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_5610_Demographic_Data_FILE_NUMBER, 								Constants.key_prefix + '5610_Demographic_data::file_number',									Constants.key_prefix+filedate+ '::5610_Demographic_data::file_number',								k17);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_6000_Inquiries_FILE_NUMBER, 											Constants.key_prefix + '6000_Inquiries::file_number',													Constants.key_prefix+filedate+ '::6000_Inquiries::file_number',												k18);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_6500_Government_Trade_FILE_NUMBER, 								Constants.key_prefix + '6500_Government_Trade::file_number',									Constants.key_prefix+filedate+ '::6500_Government_Trade::file_number',								k19);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_6510_Government_Debarred_Contractor_FILE_NUMBER, 	Constants.key_prefix + '6510_Government_Debarred_contractor::file_number',		Constants.key_prefix+filedate+ '::6510_Government_Debarred_contractor::file_number',	k20);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.Key_7010_SNP_Data_FILE_NUMBER, 												Constants.key_prefix + '7010_SNP_Data::file_number',													Constants.key_prefix+filedate+ '::7010_SNP_Data::file_number',												k21);


//Linkids Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.Key_0010_Header_linkids.Key,													Constants.key_prefix +'0010_header::linkidss',																Constants.key_prefix+filedate+'::0010_header::linkids',																k22);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(keys.Key_5600_Demographic_Data_linkids.Key,								Constants.key_prefix +'5600_Demographic_data::linkids',												Constants.key_prefix+filedate+'::5600_Demographic_data::linkids',											k23);

build_roxie_keys	:=	parallel(	k1, k2, k3, k4, k5, k6, k7, k8, k9, k10, k11, k12, k13, k14, k15, k16, k17, k18, k19, k20, k21, k22, K23);

// -- Move Keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '0010_header::bdid',																		Constants.key_prefix+filedate+'::0010_header::bdid',																	mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '0010_header::file_number',															Constants.key_prefix+filedate+'::0010_header::file_number',														mv2);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '1000_executive_summary::bdid',												Constants.key_prefix+filedate+ '::1000_executive_summary::bdid',											mv3);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '1000_executive_summary::file_number',									Constants.key_prefix+filedate+ '::1000_executive_summary::file_number',								mv4);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '2000_Trade::file_number',															Constants.key_prefix+filedate+ '::2000_Trade::file_number',														mv5);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '2015_Trade_Payment_Totals::file_number',							Constants.key_prefix+filedate+ '::2015_Trade_Payment_Totals::file_number',						mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '2020_Trade_Payment_Trends::file_number',							Constants.key_prefix+filedate+ '::2020_Trade_Payment_Trends::file_number',						mv7);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '2025_Trade_Quarterly_Averages::file_number',					Constants.key_prefix+filedate+ '::2025_Trade_Quarterly_Averages::file_number',					mv8);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '4010_Bankruptcy::file_number',												Constants.key_prefix+filedate+ '::4010_Bankruptcy::file_number',											mv9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '4020_Tax_Liens::file_number',													Constants.key_prefix+filedate+ '::4020_Tax_Liens::file_number',												mv10);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '4030_Judgement::file_number',													Constants.key_prefix+filedate+ '::4030_Judgement::file_number',												mv11);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '4500_Collateral_Accounts::file_number',								Constants.key_prefix+filedate+ '::4500_Collateral_Accounts::file_number',							mv12);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '4510_UCC_Filings::file_number',												Constants.key_prefix+filedate+ '::4510_UCC_Filings::file_number',											mv13);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '5000_Bank_Details::file_number',											Constants.key_prefix+filedate+ '::5000_Bank_Details::file_number',										mv14);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '5600_Demographic_data::bdid',													Constants.key_prefix+filedate+ '::5600_Demographic_data::bdid',												mv15);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '5600_Demographic_data::file_number',									Constants.key_prefix+filedate+ '::5600_Demographic_data::file_number',								mv16);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '5610_Demographic_data::file_number',									Constants.key_prefix+filedate+ '::5610_Demographic_data::file_number',								mv17);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '6000_Inquiries::file_number',													Constants.key_prefix+filedate+ '::6000_Inquiries::file_number',												mv18);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '6500_Government_Trade::file_number',									Constants.key_prefix+filedate+ '::6500_Government_Trade::file_number',								mv19);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '6510_Government_Debarred_contractor::file_number',		Constants.key_prefix+filedate+ '::6510_Government_Debarred_contractor::file_number',	mv20);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '7010_SNP_Data::file_number',													Constants.key_prefix+filedate+ '::7010_SNP_Data::file_number',												mv21);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '0010_header::linkids',																Constants.key_prefix+filedate+ '::0010_header::linkids',															mv22);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName + '5600_Demographic_data::linkids',											Constants.key_prefix+filedate+ '::5600_Demographic_data::linkids',										mv23);

Move_keys	:=	parallel(	mv1, mv2, mv3, mv4, mv5, mv6, mv7, mv8, mv9, mv10, mv11, mv12, mv13, mv14, mv15, mv16, mv17, mv18, mv19, mv20, mv21, mv22, mv23);

//-- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName	+'0010_header::bdid',		                       	'Q',mv1_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName +'0010_header::file_number',                   	'Q',mv2_qa,2);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '1000_executive_summary::bdid',								'Q',mv3_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '1000_executive_summary::file_number',								'Q',mv4_qa,2);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '2000_Trade::file_number',										'Q',mv5_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '2015_Trade_Payment_Totals::file_number',			'Q',mv6_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '2020_Trade_Payment_Trends::file_number',			'Q',mv7_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '2025_Trade_Quarterly_Averages::file_number',	'Q',mv8_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '4010_Bankruptcy::file_number',								'Q',mv9_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '4020_Tax_Liens::file_number',								'Q',mv10_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '4030_Judgement::file_number',								'Q',mv11_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '4500_Collateral_Accounts::file_number',			'Q',mv12_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '4510_UCC_Filings::file_number',							'Q',mv13_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '5000_Bank_Details::file_number',							'Q',mv14_qa,2);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '5600_Demographic_data::bdid',								'Q',mv15_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '5600_Demographic_data::file_number',					'Q',mv16_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '5610_Demographic_data::file_number',					'Q',mv17_qa,2);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '6000_Inquiries::file_number',								'Q',mv18_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '6500_Government_Trade::file_number',					'Q',mv19_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '6510_Government_Debarred_contractor::file_number',		'Q',mv20_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '7010_SNP_Data::file_number',									'Q',mv21_qa,2);

RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '0010_header::linkids',												'Q',mv22_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + '5600_Demographic_data::linkids',							'Q',mv23_qa,2);

To_qa	:=	parallel(mv1_qa, mv2_qa, mv3_qa, mv4_qa, mv5_qa, mv6_qa, mv7_qa, mv8_qa, mv9_qa, mv10_qa, mv11_qa, 
									 mv11_qa, mv12_qa, mv13_qa, mv14_qa, mv15_qa, mv16_qa, mv17_qa, mv18_qa, mv19_qa, mv20_qa,
									 mv21_qa, mv22_qa, mv23_qa);

//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');		
		updatedops   		 		:= PRTE.UpdateVersion('EBRKeys',filedate,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
    PerformUpdateOrNot 	:= IF(doDOPS,sequential(updatedops),NoUpdate);
		
		key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));

build_autokeys(string filedate) := function

layouts.autokey	 normcities(Files.ds_0010_Header_Base le,integer C):=transform
self.business_city := choose(C,le.city,
																if(le.city=le.p_city_name,skip,le.p_city_name),
																			if(le.p_city_name=le.v_city_name 
																							or le.city=le.v_city_name,skip,le.v_city_name));
self := le;
self :=[];
end;

normedcities :=normalize(Files.ds_0010_Header_Base,if(left.v_city_name <> left.p_city_name 
																										or left.city <> left.p_city_name 
																										or left.city <> left.v_city_name,3,1),
																										normcities(left,counter));

layouts.autokey 	normzips(layouts.autokey le,integer C):=transform
self.business_zip 					:=choose(C,le.zip,le.orig_zip);
self.business_phone_number 	:=(unsigned5)le.phone_number;
self :=le;
end;

normedzipscities := normalize(normedcities,if(left.orig_zip <> left.zip,2,1),normzips(left,counter));

AutoKeyB.MAC_Build(normedzipscities,
										zero1,zero1,zero1,
										zero1,
										zero1,
										zero1,
										zero1,zero2,zero3,zero4,zero5,zero6,
										zero,
										zero,zero,zero,
										zero,zero,zero,
										zero,zero,zero,
										zero,
										zero,
										company_name,
										zero,
										business_phone_number,
										prim_name,prim_range,state_code,business_city,business_zip,sec_range,
										bdid,
										constants.autokeyname,
										constants.ak_logical(filedate),
										outaction,false,
										constants.ak_skipSet,true,constants.str_typeStr,TRUE,,,) 
									
									
AutoKeyB.MAC_AcceptSK_to_QA(constants.autokeyName, mymove)
 
retval := sequential(outaction,mymove);

return retval;

end;


// -- Actions
buildKey	:=	sequential(
											build_roxie_keys
											,Move_keys
											,to_qa
											,build_autokeys(filedate)
											,copy_seeds(filedate)
											,updatedops
											,key_validation
											);
													
return	buildKey;

end;													
			