// PRTE_BIP.PRTE_Proc_Build_BIP_Header_keys('20151019',true);

import _control, prte, prte_bip,BIPV2_Build;

export PRTE_Proc_Build_BIP_Header_keys(string pIndexVersion,boolean pShould_Update_DOPS = false)	:=
function

  rkeythor_data400__bip2_0__translations__date 														:= prte_csv_bip_bh.rthor_data400__bip2_0__translations__date;
	rkeythor_data400__bip_v2__strnbrname 																		:= prte_csv_bip_bh.rthor_data400__bip_v2__strnbrname;
	rkeythor_data400__bipv2_hrchy__key__lgid 																:= prte_csv_bip_bh.rthor_data400__bipv2_hrchy__key__lgid;
	rkeythor_data400__bipv2_hrchy__key__proxid 															:= prte_csv_bip_bh.rthor_data400__bipv2_hrchy__key__proxid;	
	rkeythor_data400__key__bipv2__aml_addr																	:= prte_csv_bip_bh.rthor_data400__bipv2_aml__addr;
	rkeythor_data400__key__bipv2__business_header__linkids									:= prte_csv_bip_bh.rthor_data400__key__bipv2__business_header__linkids;
	rkeythor_data400__key__bipv2__business_header__status 									:= prte_csv_bip_bh.rthor_data400__key__bipv2__business_header__status;
	rkeythor_data400__key__bipv2__industry_linkids													:= prte_csv_bip_bh.rthor_data400__key__bipv2__industry_linkids;
	rkeythor_data400__key__bipv2__license_linkids 													:= prte_csv_bip_bh.rthor_data400__key__bipv2__license_linkids;
	rkeythor_data400__key__bipv2__zipcityst 																:= prte_csv_bip_bh.rthor_data400__key__bipv2__zipcityst;
	rkeythor_data400__key__bipv2_best__linkids 															:= prte_csv_bip_bh.rthor_data400__key__bipv2_best__linkids;
	rkeythor_data400__key__bipv2_biz__preferred															:= prte_csv_bip_bh.rthor_data400__key__bipv2_biz__preferred;
	rkeythor_data400__key__bipv2_lgid3__match_candidates_debug							:= prte_csv_bip_bh.rthor_data400__key__bipv2_lgid3__match_candidates_debug;
	rkeythor_data400__key__bipv2_lgid3__specificities_debug 								:= prte_csv_bip_bh.bipv2_lgid3_specificities_debug.rthor_data400__key__bipv2_lgid3__specificities_debug;
	rkeythor_data400__key__bipv2_seleid_relative__seleid__rel__assoc 				:= prte_csv_bip_bh.rthor_data400__key__bipv2_seleid_relative__seleid__rel__assoc;
	rkeythor_data400__key__bizlinkfull__proxid__meow 												:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__meow;
	rkeythor_data400__key__bizlinkfull__proxid__refs 												:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_address1 						:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_address1;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_address2 						:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_address2;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_address3 						:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_address3;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname 						:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy 			:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st 					:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip 				:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_contact 						:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_contact;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_contact_did 				:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_contact_did;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn 				:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_email 							:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_email;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_fein 								:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_fein;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_phone 							:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_phone;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_sic		 							:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_sic;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_source 							:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_source;
	rkeythor_data400__key__bizlinkfull__proxid__refs__l_url 								:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__refs__l_url;
	rkeythor_data400__key__bizlinkfull__proxid__sup__orgid 									:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__sup__orgid;
	rkeythor_data400__key__bizlinkfull__proxid__sup__proxid 								:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__sup__proxid;
	rkeythor_data400__key__bizlinkfull__proxid__sup__rcid 									:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__sup__rcid;
	rkeythor_data400__key__bizlinkfull__proxid__sup__seleid 								:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__sup__seleid;
	rkeythor_data400__key__bizlinkfull__proxid__wheel__city_clean 					:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__wheel__city_clean;
	rkeythor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean 		:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean;
	rkeythor_data400__key__bizlinkfull__proxid__word__cnp_name 							:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__word__cnp_name;
	rkeythor_data400__key__bizlinkfull__proxid__word__company_url 					:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__word__company_url;
	rkeythor_data400__key__bizlinkfull__proxid__words 											:= prte_csv_bip_bh.rthor_data400__key__bizlinkfull__proxid__words;
	rkeythor_data400__key__proxid__bipv2_proxid__attribute_matches 					:= prte_csv_bip_bh.rthor_data400__key__proxid__bipv2_proxid__attribute_matches;
	rkeythor_data400__key__proxid__bipv2_proxid__match_candidates_debug 		:= prte_csv_bip_bh.rthor_data400__key__proxid__bipv2_proxid__match_candidates_debug;
	rkeythor_data400__key__proxid__bipv2_proxid__specificities_debug 				:= prte_csv_bip_bh.proxid_bipv2_proxid_specificities_debug.rthor_data400__key__proxid__bipv2_proxid__specificities_debug;
	rkeythor_data400__key__proxid__bipv2_relative__assoc 										:= prte_csv_bip_bh.rthor_data400__key__proxid__bipv2_relative__assoc;                                                                                                                                                                                                                                                                                                                  

  //The following file is not an index but is part of the BIPV2FullKeys package.	
	kkeythor_data400__bip_v2__strnbrname 																		:= output(prte_csv_bip_bh.dthor_data400__bip_v2__strnbrname,,'~prte::bip_v2::' + pIndexVersion + '::strnbrname',overwrite);

  kkeythor_data400__bip2_0__translations__date 														:= index(prte_csv_bip_bh.dthor_data400__bip2_0__translations__date,{from},{prte_csv_bip_bh.dthor_data400__bip2_0__translations__date},'~prte::bip2.0::translations::' + pIndexVersion + '::date');
 	kkeythor_data400__bipv2_hrchy__key__lgid 																:= index(prte_csv_bip_bh.dthor_data400__bipv2_hrchy__key__lgid,{lgid},{prte_csv_bip_bh.dthor_data400__bipv2_hrchy__key__lgid},'~prte::bipv2_hrchy::key::' + pIndexVersion + '::lgid');
	kkeythor_data400__bipv2_hrchy__key__proxid 															:= index(prte_csv_bip_bh.dthor_data400__bipv2_hrchy__key__proxid,{proxid},{prte_csv_bip_bh.dthor_data400__bipv2_hrchy__key__proxid},'~prte::bipv2_hrchy::key::' + pIndexVersion + '::proxid');
	kkeythor_data400__key__bipv2__aml_addr																	:= index(prte_csv_bip_bh.dthor_data400__key__bipv2__aml_addr,{zip,prim_range,prim_name,addr_suffix,predir,postdir},{prte_csv_bip_bh.dthor_data400__key__bipv2__aml_addr},'~prte::key::' + pIndexVersion + '::bipv2_aml_addr');
	kkeythor_data400__key__bipv2__business_header__linkids									:= index(prte_csv_bip_bh.dthor_data400__key__bipv2__business_header__linkids,{ultid,orgid,seleid,proxid,powid,empid,dotid},{prte_csv_bip_bh.dthor_data400__key__bipv2__business_header__linkids},'~prte::key::bipv2::business_header::' + pIndexVersion + '::linkids');
	kkeythor_data400__key__bipv2__business_header__status 									:= index(prte_csv_bip_bh.dthor_data400__key__bipv2__business_header__status,{ultid,orgid,seleid,proxid,source,company_status_derived,dt_first_seen,dt_last_seen,dt_vendor_first_reported},{prte_csv_bip_bh.dthor_data400__key__bipv2__business_header__status},'~prte::key::bipv2::business_header::' + pIndexVersion + '::status');
	kkeythor_data400__key__bipv2__industry_linkids													:= index(prte_csv_bip_bh.dthor_data400__key__bipv2__industry_linkids,{ultid,orgid,seleid,proxid,powid,empid,dotid},{prte_csv_bip_bh.dthor_data400__key__bipv2__industry_linkids},'~prte::key::bipv2::' + pIndexVersion + '::industry_linkids');
	kkeythor_data400__key__bipv2__license_linkids 													:= index(prte_csv_bip_bh.dthor_data400__key__bipv2__license_linkids,{ultid,orgid,seleid,proxid,powid,empid,dotid},{prte_csv_bip_bh.dthor_data400__key__bipv2__license_linkids},'~prte::key::bipv2::' + pIndexVersion + '::license_linkids');
	kkeythor_data400__key__bipv2__zipcityst 																:= index(prte_csv_bip_bh.dthor_data400__key__bipv2__zipcityst,{city,state},{prte_csv_bip_bh.dthor_data400__key__bipv2__zipcityst},'~prte::key::bipv2::' + pIndexVersion + '::zipcityst');
	kkeythor_data400__key__bipv2_best__linkids 															:= index(prte_csv_bip_bh.dthor_data400__key__bipv2_best__linkids,{ultid,orgid,seleid,proxid,powid,empid,dotid},{prte_csv_bip_bh.dthor_data400__key__bipv2_best__linkids},'~prte::key::bipv2_best::' + pIndexVersion + '::linkids');
	kkeythor_data400__key__bipv2_biz__preferred															:= index(prte_csv_bip_bh.dthor_data400__key__bipv2_biz__preferred,{cname},{prte_csv_bip_bh.dthor_data400__key__bipv2_biz__preferred},'~prte::key::bipv2::' + pIndexVersion + '::biz_preferred');
	kkeythor_data400__key__bipv2_lgid3__match_candidates_debug							:= index(prte_csv_bip_bh.dthor_data400__key__bipv2_lgid3__match_candidates_debug,{lgid3},{prte_csv_bip_bh.dthor_data400__key__bipv2_lgid3__match_candidates_debug},'~prte::key::bipv2_lgid3::' + pIndexVersion + '::match_candidates_debug');
	kkeythor_data400__key__bipv2_lgid3__specificities_debug 								:= index(prte_csv_bip_bh.dthor_data400__key__bipv2_lgid3__specificities_debug,{_unnamed_1},{prte_csv_bip_bh.dthor_data400__key__bipv2_lgid3__specificities_debug},'~prte::key::bipv2_lgid3::' + pIndexVersion + '::specificities_debug');
	kkeythor_data400__key__bipv2_seleid_relative__seleid__rel__assoc 				:= index(prte_csv_bip_bh.dthor_data400__key__bipv2_seleid_relative__seleid__rel__assoc,{seleid1,seleid2},{prte_csv_bip_bh.dthor_data400__key__bipv2_seleid_relative__seleid__rel__assoc},'~prte::key::bipv2_seleid_relative::' + pIndexVersion + '::seleid::rel::assoc');
	kkeythor_data400__key__bizlinkfull__proxid__meow 												:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__meow,{ultid,orgid,seleid,proxid,powid},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__meow},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::meow');
	kkeythor_data400__key__bizlinkfull__proxid__refs 												:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs,{word_id,field,uid},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_address1 						:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_address1,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_address1');	
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_address2 						:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_address2,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_address2');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_address3 						:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_address3,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_address3');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname 						:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_cnpname');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy 			:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_cnpname_fuzzy');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st 					:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_cnpname_st');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip 				:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_cnpname_zip');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_contact 						:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_contact,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_contact');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_contact_did 				:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_contact_did,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_contact_did');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn 				:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_contact_ssn');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_email 							:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_email,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_email');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_fein 								:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_fein,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_fein');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_phone 							:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_phone,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_phone');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_sic	 								:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_sic,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_sic');	
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_source 							:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_source,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_source');
	kkeythor_data400__key__bizlinkfull__proxid__refs__l_url 								:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__refs__l_url,,'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::refs::l_url');
	kkeythor_data400__key__bizlinkfull__proxid__sup__orgid 									:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__orgid,{orgid},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__orgid},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::sup::orgid');
	kkeythor_data400__key__bizlinkfull__proxid__sup__proxid 								:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__proxid,{proxid},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__proxid},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::sup::proxid');
	kkeythor_data400__key__bizlinkfull__proxid__sup__rcid 									:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__rcid,{rcid},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__rcid},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::sup::rcid');
	kkeythor_data400__key__bizlinkfull__proxid__sup__seleid 								:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__seleid,{seleid},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__sup__seleid},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::sup::seleid');
	kkeythor_data400__key__bizlinkfull__proxid__wheel__city_clean 					:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__wheel__city_clean,{prefix},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__wheel__city_clean},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::wheel::city_clean');
	kkeythor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean 		:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean,{prefix},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::wheel_quick::city_clean');
	kkeythor_data400__key__bizlinkfull__proxid__word__cnp_name 							:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__word__cnp_name,{cnp_name},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__word__cnp_name},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::word::cnp_name');
	kkeythor_data400__key__bizlinkfull__proxid__word__company_url 					:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__word__company_url,{company_url},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__word__company_url},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::word::company_url');
	kkeythor_data400__key__bizlinkfull__proxid__words 											:= index(prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__words,{word},{prte_csv_bip_bh.dthor_data400__key__bizlinkfull__proxid__words},'~prte::key::bizlinkfull::' + pIndexVersion + '::proxid::words');
	kkeythor_data400__key__proxid__bipv2_proxid__attribute_matches 					:= index(prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_proxid__attribute_matches,{proxid1,proxid2},{prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_proxid__attribute_matches},'~prte::key::proxid::bipv2_proxid::' + pIndexVersion + '::attribute_matches');
	kkeythor_data400__key__proxid__bipv2_proxid__match_candidates_debug 		:= index(prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_proxid__match_candidates_debug,{proxid},{prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_proxid__match_candidates_debug},'~prte::key::proxid::bipv2_proxid::' + pIndexVersion + '::match_candidates_debug');
	kkeythor_data400__key__proxid__bipv2_proxid__specificities_debug 				:= index(prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_proxid__specificities_debug,{_unnamed_1},{prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_proxid__specificities_debug},'~prte::key::proxid::bipv2_proxid::' + pIndexVersion + '::specificities_debug');
	kkeythor_data400__key__proxid__bipv2_relative__assoc 										:= index(prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_relative__assoc,{proxid1,proxid2},{prte_csv_bip_bh.dthor_data400__key__proxid__bipv2_relative__assoc},'~prte::key::proxid::bipv2_relative::' + pIndexVersion + '::assoc');
		
	return 
	sequential(
		parallel(
						 kkeythor_data400__bip_v2__strnbrname  //this is not a key but is req'd as part of the BIPV2FullKeys package
			,build(kkeythor_data400__bip2_0__translations__date 															,overwrite)
			,build(kkeythor_data400__bipv2_hrchy__key__lgid 												 					,overwrite)
			,build(kkeythor_data400__bipv2_hrchy__key__proxid 												 				,overwrite)
			,build(kkeythor_data400__key__bipv2__aml_addr 														 				,overwrite)			
			,build(kkeythor_data400__key__bipv2__business_header__linkids		  								,overwrite)			
			,build(kkeythor_data400__key__bipv2__business_header__status 											,overwrite)
			,build(kkeythor_data400__key__bipv2__industry_linkids 														,overwrite)
			,build(kkeythor_data400__key__bipv2__license_linkids		 													,overwrite)						
			,build(kkeythor_data400__key__bipv2__zipcityst 																		,overwrite)
			,build(kkeythor_data400__key__bipv2_best__linkids 																,overwrite)
			,build(kkeythor_data400__key__bipv2_biz__preferred 																,overwrite)
			,build(kkeythor_data400__key__bipv2_lgid3__match_candidates_debug 								,overwrite)
			,build(kkeythor_data400__key__bipv2_lgid3__specificities_debug 										,overwrite)
			,build(kkeythor_data400__key__bipv2_seleid_relative__seleid__rel__assoc 					,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__meow 													,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs 													,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_address1 							,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_address2 							,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_address3 							,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname		 						,overwrite)				
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_fuzzy 					,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_st 						,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_cnpname_zip 						,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_contact			 					,overwrite)		
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_contact_did						,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_contact_ssn 						,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_email			 						,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_fein					 					,overwrite)			
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_phone 									,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_sic 										,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_source 								,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__refs__l_url									 	,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__sup__orgid 										,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__sup__proxid 									  ,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__sup__rcid 											,overwrite)								 
			,build(kkeythor_data400__key__bizlinkfull__proxid__sup__seleid 										,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__wheel__city_clean 							,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__wheel_quick__city_clean 				,overwrite)
			,build(kkeythor_data400__key__bizlinkfull__proxid__word__cnp_name 								,overwrite)			
			,build(kkeythor_data400__key__bizlinkfull__proxid__word__company_url 							,overwrite)	 
			,build(kkeythor_data400__key__bizlinkfull__proxid__words  												,overwrite)
			,build(kkeythor_data400__key__proxid__bipv2_proxid__attribute_matches  						,overwrite)
			,build(kkeythor_data400__key__proxid__bipv2_proxid__match_candidates_debug  			,overwrite)
			,build(kkeythor_data400__key__proxid__bipv2_proxid__specificities_debug  					,overwrite)
			,build(kkeythor_data400__key__proxid__bipv2_relative__assoc  											,overwrite)
      ) //end parallel
      ,BIPV2_Build.PRTE_BIPV2FullKeys_Package(pIndexVersion,,0).outputpackage  //after building keys, output them to make sure their layouts match their prod counterparts
			,if(pShould_Update_DOPS = true  ,PRTE.UpdateVersion(
											    'BIPV2FullKeys'												//	Package name
											    ,pIndexVersion												//	Package version
												  ,_control.MyInfo.EmailAddressNormal	 	//	Who to email with specifics
												  ,'B'																	//	B = Boca, A = Alpharetta
												  ,'N'																	//	N = Non-FCRA, F = FCRA
												  ,'N'                                 	//	N = Do not also include boolean, Y = Include boolean, too
	  									   )  //end PRTE.UpdateVersion
       )
		 	
	); 	//end sequential


end;