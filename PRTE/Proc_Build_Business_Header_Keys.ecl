import prte_csv,_control,business_header;
/*
  So what we are trying to do here is cut down on the number of csv files that need to be maintained.
  Instead of 1 csv file for each key, have just one csv file for each file that is used to make a batch of keys.
  That is what these functions attempt to do:
    Business_Header.prct_fetch_keys			
    Business_Header.prct_contacts_keys		
    Business_Header.prct_sic_keys				
    Business_Header.prct_Best_Keys				
    Business_Header.prct_Supergroup_keys	

  Each one takes in 1 csv file to create all of it's keys.
	The rest of the keys are built from each's own csv file.  I'm sure they can also be distilled into one csv file per batch of related keys.

  
*/
export Proc_Build_Business_Header_Keys(
   string   pIndexVersion
  ,string   pOldversion                 //this should be set to the previous production version of the keys.  It will copy over the keys needed, but not built here from the previous version.  Look at PRCT DOPS for the version.
  ,boolean  pShouldUpdateDOPS  = true
)	:=
function

	rkeythor_data400__key__business_header__search__addr											:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__addr											;
	rkeythor_data400__key__business_header__search__addr_pr_pn_sr_st					:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__addr_pr_pn_sr_st					;
	rkeythor_data400__key__business_header__search__addr_pr_pn_zip						:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__addr_pr_pn_zip						;
	rkeythor_data400__key__business_header__search__addr_st									  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__addr_st									;
	rkeythor_data400__key__business_header__search__addr_zip									:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__addr_zip									;
	rkeythor_data400__key__business_header__search__bdid_city_zip_fein_phone	:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__bdid_city_zip_fein_phone	;
	rkeythor_data400__key__business_header__search__bdid_pl									  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__bdid_pl									;
	rkeythor_data400__key__business_header__search__companyname							  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__companyname							;
	rkeythor_data400__key__business_header__search__companyname_bdid_cn_bdids := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__companyname_bdid_cn_bdids;
	rkeythor_data400__key__business_header__search__conamewords							  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__conamewords							;
	rkeythor_data400__key__business_header__search__fein											:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__fein											;
	rkeythor_data400__key__business_header__search__phone										  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__phone										;
	rkeythor_data400__key__business_header__search__bdid_seq                  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__bdid_seq                        ;		
	rkeythor_data400__key__business_header__search__siccode_zip   						:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__siccode_zip    						;		
	rkeythor_data400__key__business_header__search__zipprlname                := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__zipprlname                      ;		
	rkeythor_data400__key__business_header__search__conamewordsmetaphone      := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__conamewordsmetaphone            ;		
	rkeythor_data400__key__business_header__search__rcid                      := PRTE_CSV.Business_Header.rthor_data400__key__business_header__search__rcid                            ;		
	rkeythor_data400__key__business_header__hri__oldnpa_oldnxx								:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__oldnpa_oldnxx								;
	rkeythor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		;
	rkeythor_data400__key__business_header__aca_institutions__address				  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__aca_institutions__address				;
	rkeythor_data400__key__business_header__hri__phone10_v2									  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__phone10_v2									;
	rkeythor_data400__key__business_header__hri__risk_bdid									  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__risk_bdid										;
	rkeythor_data400__key__business_header__hri__risk_geolink									:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__risk_geolink								;
	rkeythor_data400__key__business_header__filtered__hri__address						:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__filtered__hri__address						;
	rkeythor_data400__key__business_header__filtered__hri__phone10_v2				  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__filtered__hri__phone10_v2				;		
	rkeythor_data400__key__business_header__hri__sic_z5          							:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__sic_z5          						;		
	rkeythor_data400__key__business_header__address_siccode      							:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__address_siccode      						;		
	rkeythor_data400__key__business_header__hri__address_siccode 							:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__address_siccode 						;		
	rkeythor_data400__key__business_header__risk__bdid_risk      							:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__risk__bdid_risk      						;		
	rkeythor_data400__key__business_header__bdl2__bdid												:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__bdl2__bdid												;
	rkeythor_data400__key__business_header__bdl2__bdl												  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__bdl2__bdl												;
	// rkeythor_data400__key__business_header__best__filepos_data								:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__best__filepos_data								;
	// rkeythor_data400__key__business_header__best__filepos_data_knowx					:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__best__filepos_data_knowx					;
	// rkeythor_data400__key__business_header__contacts__bdid										:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__bdid										;
	// rkeythor_data400__key__business_header__contacts__did										  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__did										;
	// rkeythor_data400__key__business_header__contacts__filepos								  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__filepos								;
	// rkeythor_data400__key__business_header__contacts__ssn										  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__ssn										;
	// rkeythor_data400__key__business_header__contacts__state_city_name				  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__state_city_name				;
	// rkeythor_data400__key__business_header__contacts__state_lfname						:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__state_lfname						;
	rkeythor_data400__key__business_header__hri__address											:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__hri__address											;
	rkeythor_data400__key__business_header__relatives__bdid1									:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__relatives__bdid1									;
	rkeythor_data400__key__business_header__relatives_group__groupid                := PRTE_CSV.Business_Header.rthor_data400__key__business_header__relatives_group__groupid                ;		
	rkeythor_data400__key__business_header__risk__bdid												:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__risk__bdid												;
	rkeythor_data400__key__business_header__risk__did												  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__risk__did												;
	rkeythor_data400__key__business_header__risk__fein												:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__risk__fein												;
	rkeythor_data400__key__business_header__risk__fein_company_name					  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__risk__fein_company_name					;
	rkeythor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range;		
	// rkeythor_data400__key__business_header__supergroup__bdid									:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__supergroup__bdid									;
	// rkeythor_data400__key__business_header__supergroup__groupid							  := PRTE_CSV.Business_Header.rthor_data400__key__business_header__supergroup__groupid							;

	// rkeythor_data400__key__business_header__base__address							  			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__address										;		
	// rkeythor_data400__key__business_header__base__fein								  			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__fein												;		
	// rkeythor_data400__key__business_header__base__name								  			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__name												;		
	// rkeythor_data400__key__business_header__base__phone								   			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__phone											;		
	// rkeythor_data400__key__business_header__base__st_city_name				   			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__st_city_name								;		
	// rkeythor_data400__key__business_header__base__st_name							   			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__st_name										;		
	// rkeythor_data400__key__business_header__base__street							   			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__street											;		
	// rkeythor_data400__key__business_header__base__zip									   			:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__base__zip												;		

                                                                       			
	// rkeythor_data400__key__business_header__contacts__bdid_score                    := PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__bdid_score                    ;		
	// rkeythor_data400__key__business_header__contacts__company_title                 := PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__company_title                 ;		
	rkeythor_data400__key__business_header__eda__word_freq                          := PRTE_CSV.Business_Header.rthor_data400__key__business_header__eda__word_freq                          ;		

	dkeythor_data400__key__business_header__search__addr											:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__addr											,rkeythor_data400__key__business_header__search__addr											);
	dkeythor_data400__key__business_header__search__addr_pr_pn_sr_st					:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__addr_pr_pn_sr_st					,rkeythor_data400__key__business_header__search__addr_pr_pn_sr_st					);
	dkeythor_data400__key__business_header__search__addr_pr_pn_zip						:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__addr_pr_pn_zip						,rkeythor_data400__key__business_header__search__addr_pr_pn_zip						);
	dkeythor_data400__key__business_header__search__addr_st									  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__addr_st									,rkeythor_data400__key__business_header__search__addr_st									);
	dkeythor_data400__key__business_header__search__addr_zip									:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__addr_zip									,rkeythor_data400__key__business_header__search__addr_zip									);
	dkeythor_data400__key__business_header__search__bdid_city_zip_fein_phone	:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_city_zip_fein_phone	,rkeythor_data400__key__business_header__search__bdid_city_zip_fein_phone	);
	dkeythor_data400__key__business_header__search__bdid_pl									  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_pl									,rkeythor_data400__key__business_header__search__bdid_pl									);
	dkeythor_data400__key__business_header__search__companyname							  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__companyname							,rkeythor_data400__key__business_header__search__companyname							);
	dkeythor_data400__key__business_header__search__companyname_bdid_cn_bdids := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__companyname_bdid_cn_bdids,rkeythor_data400__key__business_header__search__companyname_bdid_cn_bdids);
	dkeythor_data400__key__business_header__search__conamewords							  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__conamewords							,rkeythor_data400__key__business_header__search__conamewords							);
	dkeythor_data400__key__business_header__search__fein											:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__fein											,rkeythor_data400__key__business_header__search__fein											);
	dkeythor_data400__key__business_header__search__phone										  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__phone										,rkeythor_data400__key__business_header__search__phone										);
	dkeythor_data400__key__business_header__search__bdid_seq                  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__bdid_seq                 ,rkeythor_data400__key__business_header__search__bdid_seq                        );	
	dkeythor_data400__key__business_header__search__siccode_zip               := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__siccode_zip              ,rkeythor_data400__key__business_header__search__siccode_zip              );		
	dkeythor_data400__key__business_header__search__zipprlname                := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__zipprlname               ,rkeythor_data400__key__business_header__search__zipprlname                      );		
	dkeythor_data400__key__business_header__search__conamewordsmetaphone      := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__conamewordsmetaphone     ,rkeythor_data400__key__business_header__search__conamewordsmetaphone            );		
	dkeythor_data400__key__business_header__search__rcid                      := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__search__rcid                     ,rkeythor_data400__key__business_header__search__rcid                            );		
	dkeythor_data400__key__business_header__hri__oldnpa_oldnxx								:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__oldnpa_oldnxx								,rkeythor_data400__key__business_header__hri__oldnpa_oldnxx								);
	dkeythor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		,rkeythor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		);
	dkeythor_data400__key__business_header__hri__phone10_v2									  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__phone10_v2									,rkeythor_data400__key__business_header__hri__phone10_v2									);
	dkeythor_data400__key__business_header__hri__risk_bdid									  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__risk_bdid										,rkeythor_data400__key__business_header__hri__risk_bdid										);
	dkeythor_data400__key__business_header__hri__risk_geolink									:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__risk_geolink								,rkeythor_data400__key__business_header__hri__risk_geolink								);
	dkeythor_data400__key__business_header__filtered__hri__address						:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__filtered__hri__address						,rkeythor_data400__key__business_header__filtered__hri__address						);
	dkeythor_data400__key__business_header__filtered__hri__phone10_v2				  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__filtered__hri__phone10_v2				,rkeythor_data400__key__business_header__filtered__hri__phone10_v2				);		
	dkeythor_data400__key__business_header__hri__sic_z5         							:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__sic_z5         							,rkeythor_data400__key__business_header__hri__sic_z5         				);		
	dkeythor_data400__key__business_header__address_siccode     							:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__address_siccode     							,rkeythor_data400__key__business_header__address_siccode     				);		
	dkeythor_data400__key__business_header__hri__address_siccode							:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__address_siccode							,rkeythor_data400__key__business_header__hri__address_siccode				);		
	dkeythor_data400__key__business_header__risk__bdid_risk     							:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__risk__bdid_risk     							,rkeythor_data400__key__business_header__risk__bdid_risk     				);		
	dkeythor_data400__key__business_header__aca_institutions__address				  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__aca_institutions__address				,rkeythor_data400__key__business_header__aca_institutions__address				);
	dkeythor_data400__key__business_header__bdl2__bdid												:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__bdl2__bdid												,rkeythor_data400__key__business_header__bdl2__bdid												);
	dkeythor_data400__key__business_header__bdl2__bdl												  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__bdl2__bdl												,rkeythor_data400__key__business_header__bdl2__bdl												);
	// dkeythor_data400__key__business_header__best__filepos_data								:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__best__filepos_data								,rkeythor_data400__key__business_header__best__filepos_data								);
	// dkeythor_data400__key__business_header__best__filepos_data_knowx					:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__best__filepos_data_knowx					,rkeythor_data400__key__business_header__best__filepos_data_knowx					);
	// dkeythor_data400__key__business_header__contacts__bdid										:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__bdid										,rkeythor_data400__key__business_header__contacts__bdid										);
	// dkeythor_data400__key__business_header__contacts__did										  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__did										,rkeythor_data400__key__business_header__contacts__did										);
	// dkeythor_data400__key__business_header__contacts__filepos								  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__filepos								,rkeythor_data400__key__business_header__contacts__filepos								);
	// dkeythor_data400__key__business_header__contacts__ssn										  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__ssn										,rkeythor_data400__key__business_header__contacts__ssn										);
	// dkeythor_data400__key__business_header__contacts__state_city_name				  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__state_city_name				,rkeythor_data400__key__business_header__contacts__state_city_name				);
	// dkeythor_data400__key__business_header__contacts__state_lfname						:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__state_lfname						,rkeythor_data400__key__business_header__contacts__state_lfname						);
	dkeythor_data400__key__business_header__hri__address											:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__hri__address											,rkeythor_data400__key__business_header__hri__address											);
	dkeythor_data400__key__business_header__relatives__bdid1									:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__relatives__bdid1									,rkeythor_data400__key__business_header__relatives__bdid1									);
	dkeythor_data400__key__business_header__relatives_group__groupid                := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__relatives_group__groupid                ,rkeythor_data400__key__business_header__relatives_group__groupid                );		
	dkeythor_data400__key__business_header__risk__bdid												:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__risk__bdid												,rkeythor_data400__key__business_header__risk__bdid												);
	dkeythor_data400__key__business_header__risk__did												  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__risk__did												,rkeythor_data400__key__business_header__risk__did												);
	dkeythor_data400__key__business_header__risk__fein												:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__risk__fein												,rkeythor_data400__key__business_header__risk__fein												);
	dkeythor_data400__key__business_header__risk__fein_company_name					  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__risk__fein_company_name					,rkeythor_data400__key__business_header__risk__fein_company_name					);
	dkeythor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range,rkeythor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range);		
	// dkeythor_data400__key__business_header__supergroup__bdid									:= project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__supergroup__bdid									,rkeythor_data400__key__business_header__supergroup__bdid									);
	// dkeythor_data400__key__business_header__supergroup__groupid							  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__supergroup__groupid							,rkeythor_data400__key__business_header__supergroup__groupid							);

	// dkeythor_data400__key__business_header__base__address										  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__address										,rkeythor_data400__key__business_header__base__address										);		
	// dkeythor_data400__key__business_header__base__fein											  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__fein												,rkeythor_data400__key__business_header__base__fein												);		
	// dkeythor_data400__key__business_header__base__name											  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__name												,rkeythor_data400__key__business_header__base__name												);		
	// dkeythor_data400__key__business_header__base__phone											  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__phone											,rkeythor_data400__key__business_header__base__phone											);		
	// dkeythor_data400__key__business_header__base__st_city_name							  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__st_city_name								,rkeythor_data400__key__business_header__base__st_city_name								);		
	// dkeythor_data400__key__business_header__base__st_name										  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__st_name										,rkeythor_data400__key__business_header__base__st_name										);		
	// dkeythor_data400__key__business_header__base__street										  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__street											,rkeythor_data400__key__business_header__base__street											);		
	// dkeythor_data400__key__business_header__base__zip												  := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__base__zip												,rkeythor_data400__key__business_header__base__zip												);		

	// dkeythor_data400__key__business_header__contacts__bdid_score                    := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__bdid_score                    ,rkeythor_data400__key__business_header__contacts__bdid_score                    );		
	// dkeythor_data400__key__business_header__contacts__company_title                 := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__company_title                 ,rkeythor_data400__key__business_header__contacts__company_title                 );		
	dkeythor_data400__key__business_header__eda__word_freq                          := project(PRTE_CSV.Business_Header.dthor_data400__key__business_header__eda__word_freq                          ,rkeythor_data400__key__business_header__eda__word_freq                          );		

	kkeythor_data400__key__business_header__search__addr 											:= index(dkeythor_data400__key__business_header__search__addr											, {prim_name,zip,sec_range,prim_range}																					, {dkeythor_data400__key__business_header__search__addr											}, '~prte::key::business_header::' + pIndexVersion + '::search::addr'                        );
	kkeythor_data400__key__business_header__search__addr_pr_pn_sr_st 					:= index(dkeythor_data400__key__business_header__search__addr_pr_pn_sr_st					, {state,prim_name,prim_range,sec_range,cn2,indic,sec,bdid,cn_pr_pn_sr_st_bdids}, {dkeythor_data400__key__business_header__search__addr_pr_pn_sr_st					}, '~prte::key::business_header::' + pIndexVersion + '::search::addr.pr.pn.sr.st'            );
	kkeythor_data400__key__business_header__search__addr_pr_pn_zip 						:= index(dkeythor_data400__key__business_header__search__addr_pr_pn_zip						, {zip,prim_name,prim_range,cn2,indic,sec,bdid,cn_pr_pn_zip_bdids}							, {dkeythor_data400__key__business_header__search__addr_pr_pn_zip						}, '~prte::key::business_header::' + pIndexVersion + '::search::addr.pr.pn.zip'              );
	kkeythor_data400__key__business_header__search__addr_st 									:= index(dkeythor_data400__key__business_header__search__addr_st									, {state,cn2,indic,sec,bdid,cn_st_bdids}																				, {dkeythor_data400__key__business_header__search__addr_st									}, '~prte::key::business_header::' + pIndexVersion + '::search::addr.st'                     );
	kkeythor_data400__key__business_header__search__addr_zip 									:= index(dkeythor_data400__key__business_header__search__addr_zip									, {zip,cn2,indic,sec,bdid,cn_zip_bdids}																					, {dkeythor_data400__key__business_header__search__addr_zip									}, '~prte::key::business_header::' + pIndexVersion + '::search::addr.zip'                    );
	kkeythor_data400__key__business_header__search__bdid_city_zip_fein_phone 	:= index(dkeythor_data400__key__business_header__search__bdid_city_zip_fein_phone	, {bdid,city,zip,fein,phone}																										, {dkeythor_data400__key__business_header__search__bdid_city_zip_fein_phone	}, '~prte::key::business_header::' + pIndexVersion + '::search::bdid.city.zip.fein.phone'    );
	kkeythor_data400__key__business_header__search__bdid_pl 									:= index(dkeythor_data400__key__business_header__search__bdid_pl									, {bdid}																																				, {dkeythor_data400__key__business_header__search__bdid_pl									}, '~prte::key::business_header::' + pIndexVersion + '::search::bdid.pl'                     );
	kkeythor_data400__key__business_header__search__companyname								:= index(dkeythor_data400__key__business_header__search__companyname							, {clean_company_name20,clean_company_name60}																		, {dkeythor_data400__key__business_header__search__companyname							}, '~prte::key::business_header::' + pIndexVersion + '::search::companyname'                 );
	kkeythor_data400__key__business_header__search__companyname_bdid_cn_bdids := index(dkeythor_data400__key__business_header__search__companyname_bdid_cn_bdids, {clean_company_name20,clean_company_name60,bdid,cn_bdids}											, {dkeythor_data400__key__business_header__search__companyname_bdid_cn_bdids}, '~prte::key::business_header::' + pIndexVersion + '::search::companyname.bdid.cn_bdids'   );
	kkeythor_data400__key__business_header__search__conamewords								:= index(dkeythor_data400__key__business_header__search__conamewords							, {word,state,seq,bh_filepos,bdid}																							, {dkeythor_data400__key__business_header__search__conamewords							}, '~prte::key::business_header::' + pIndexVersion + '::search::conamewords'                 );
	kkeythor_data400__key__business_header__search__fein											:= index(dkeythor_data400__key__business_header__search__fein											, {fein,company_name,bdid,cn_f_bdids}																						, {dkeythor_data400__key__business_header__search__fein											}, '~prte::key::business_header::' + pIndexVersion + '::search::fein'                        );
	kkeythor_data400__key__business_header__search__phone											:= index(dkeythor_data400__key__business_header__search__phone										, {phone,company_name,bdid,cn_p_bdids,prim_range,prim_name,sec_range,zip}				, {dkeythor_data400__key__business_header__search__phone										}, '~prte::key::business_header::' + pIndexVersion + '::search::phone'                       );
	kkeythor_data400__key__business_header__search__bdid_seq                  := index(dkeythor_data400__key__business_header__search__bdid_seq                 , {bdid, seq}                                                                      ,{bdid2}                                                           , '~prte::key::business_header::' + pIndexVersion + '::search::bdid.seq'                             );
	kkeythor_data400__key__business_header__search__siccode_zip               := index(dkeythor_data400__key__business_header__search__siccode_zip              , {sic_code, z5:= zip},{lat,long,prim_range,predir,prim_name,suffix := addr_suffix,postdir,unit_desig,sec_range,city,state,z4:=zip4, bdid, source}           , '~prte::key::business_header::' + pIndexVersion + '::search::siccode_zip'                 );	
	kkeythor_data400__key__business_header__search__zipprlname                := index(dkeythor_data400__key__business_header__search__zipprlname               , {dkeythor_data400__key__business_header__search__zipprlname                     }                                                                   , '~prte::key::business_header::' + pIndexVersion + '::search::zipprlname'                           );
	kkeythor_data400__key__business_header__search__conamewordsmetaphone      := index(dkeythor_data400__key__business_header__search__conamewordsmetaphone     , {metaphone, state, zip}                                                         ,{bdid}                                                             , '~prte::key::business_header::' + pIndexVersion + '::search::conamewordsmetaphone'                 );
	kkeythor_data400__key__business_header__search__rcid                      := index(dkeythor_data400__key__business_header__search__rcid                     , {rcid, bdid}                                                                                                                                        , '~prte::key::business_header::' + pIndexVersion + '::search::rcid'                                 );
	kkeythor_data400__key__business_header__hri__oldnpa_oldnxx 								:= index(dkeythor_data400__key__business_header__hri__oldnpa_oldnxx								, {old_npa,old_nxx}																															, {dkeythor_data400__key__business_header__hri__oldnpa_oldnxx								}, '~prte::key::business_header::' + pIndexVersion + '::hri::oldnpa.oldnxx'									 );
	kkeythor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates 		:= index(dkeythor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		, {old_npa,old_nxx}																															, {dkeythor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates		}, '~prte::key::business_header::' + pIndexVersion + '::hri::oldnpa.oldnxx.fixeddates'       );
	kkeythor_data400__key__business_header__hri__phone10_v2										:= index(dkeythor_data400__key__business_header__hri__phone10_v2									, {phone10}																																			, {dkeythor_data400__key__business_header__hri__phone10_v2									}, '~prte::key::business_header::' + pIndexVersion + '::hri::phone10_v2'                    );
	kkeythor_data400__key__business_header__hri__risk_bdid										:= index(dkeythor_data400__key__business_header__hri__risk_bdid										, {bdid}																																				, {dkeythor_data400__key__business_header__hri__risk_bdid										}, '~prte::key::business_header::' + pIndexVersion + '::business_risk_bdid'                  );
	kkeythor_data400__key__business_header__hri__risk_geolink									:= index(dkeythor_data400__key__business_header__hri__risk_geolink								, {geolink}																																			, {dkeythor_data400__key__business_header__hri__risk_geolink								}, '~prte::key::business_header::' + pIndexVersion + '::business_risk_geolink'               );
	kkeythor_data400__key__business_header__filtered__hri__address						:= index(dkeythor_data400__key__business_header__filtered__hri__address						, {z5,prim_name,suffix,predir,postdir,prim_range,sec_range,dt_first_seen}				, {dkeythor_data400__key__business_header__filtered__hri__address						}, '~prte::key::business_header::filtered::' + pIndexVersion + '::hri::address'              );
	kkeythor_data400__key__business_header__filtered__hri__phone10_v2					:= index(dkeythor_data400__key__business_header__filtered__hri__phone10_v2				, {phone10}																																			, {dkeythor_data400__key__business_header__filtered__hri__phone10_v2				}, '~prte::key::business_header::filtered::' + pIndexVersion + '::hri::phone10_v2'           );
	kkeythor_data400__key__business_header__hri__sic_z5         							:= index(dkeythor_data400__key__business_header__hri__sic_z5         							, {sic_code, z5:= zip},{lat,long,prim_range,predir,prim_name,suffix := addr_suffix,postdir,unit_desig,sec_range,city,state,z4:=zip4, bdid, source}               , '~prte::key::business_header::' + pIndexVersion + '::hri::sic.z5'         );
	kkeythor_data400__key__business_header__address_siccode     							:= index(dkeythor_data400__key__business_header__address_siccode     							, {z5 := zip,prim_name,suffix := addr_suffix,predir,postdir,prim_range,sec_range}, {sic_code, source                                                            }, '~prte::key::business_header::' + pIndexVersion + '::address_siccode'     );
	kkeythor_data400__key__business_header__hri__address_siccode							:= index(dkeythor_data400__key__business_header__hri__address_siccode							, {z5 := zip,prim_name,suffix := addr_suffix,predir,postdir,prim_range,sec_range}, {sic_code, Source                                                            }, '~prte::key::business_header::' + pIndexVersion + '::hri::address_siccode');
	kkeythor_data400__key__business_header__risk__bdid_risk     							:= index(dkeythor_data400__key__business_header__risk__bdid_risk     							, {bdid     }								                                                     , {dkeythor_data400__key__business_header__risk__bdid_risk											}, '~prte::key::business_header::' + pIndexVersion + '::risk::bdid.risk'     );
	kkeythor_data400__key__business_header__aca_institutions__address 				:= index(dkeythor_data400__key__business_header__aca_institutions__address				, {prim_name,prim_range,zip,sec_range}																					, {dkeythor_data400__key__business_header__aca_institutions__address				}, '~prte::key::business_header::' + pIndexVersion + '::aca_institutions::address'           );
	kkeythor_data400__key__business_header__bdl2__bdid 												:= index(dkeythor_data400__key__business_header__bdl2__bdid												, {bdid}																																				, {dkeythor_data400__key__business_header__bdl2__bdid												}, '~prte::key::business_header::' + pIndexVersion + '::bdl2::bdid'                          );
	kkeythor_data400__key__business_header__bdl2__bdl 												:= index(dkeythor_data400__key__business_header__bdl2__bdl												, {bdl}																																					, {dkeythor_data400__key__business_header__bdl2__bdl												}, '~prte::key::business_header::' + pIndexVersion + '::bdl2::bdl'                           );
	// kkeythor_data400__key__business_header__best__filepos_data 								:= index(dkeythor_data400__key__business_header__best__filepos_data								, {bdid}																																				, {dkeythor_data400__key__business_header__best__filepos_data								}, '~prte::key::business_header::' + pIndexVersion + '::best::filepos.data'                  );
	// kkeythor_data400__key__business_header__best__filepos_data_knowx 					:= index(dkeythor_data400__key__business_header__best__filepos_data_knowx					, {bdid}																																				, {dkeythor_data400__key__business_header__best__filepos_data_knowx					}, '~prte::key::business_header::' + pIndexVersion + '::best::filepos.data.knowx'            );
	// kkeythor_data400__key__business_header__contacts__bdid 										:= index(dkeythor_data400__key__business_header__contacts__bdid										, {bdid}																																				, {dkeythor_data400__key__business_header__contacts__bdid										}, '~prte::key::business_header::' + pIndexVersion + '::contacts::bdid'                      );
	// kkeythor_data400__key__business_header__contacts__did 										:= index(dkeythor_data400__key__business_header__contacts__did										, {did}																																					, {dkeythor_data400__key__business_header__contacts__did										}, '~prte::key::business_header::' + pIndexVersion + '::contacts::did'                       );
	// kkeythor_data400__key__business_header__contacts__filepos 								:= index(dkeythor_data400__key__business_header__contacts__filepos								, {fp}																																					, {dkeythor_data400__key__business_header__contacts__filepos								}, '~prte::key::business_header::' + pIndexVersion + '::contacts::filepos'                   );
	// kkeythor_data400__key__business_header__contacts__ssn 										:= index(dkeythor_data400__key__business_header__contacts__ssn										, {ssn}																																					, {dkeythor_data400__key__business_header__contacts__ssn										}, '~prte::key::business_header::' + pIndexVersion + '::contacts::ssn'                       );
	// kkeythor_data400__key__business_header__contacts__state_city_name 				:= index(dkeythor_data400__key__business_header__contacts__state_city_name				, {lname,state,city,fname,mname}																								, {dkeythor_data400__key__business_header__contacts__state_city_name				}, '~prte::key::business_header::' + pIndexVersion + '::contacts::state.city.name'           );
	// kkeythor_data400__key__business_header__contacts__state_lfname 						:= index(dkeythor_data400__key__business_header__contacts__state_lfname						, {state,dph_lname,lname,pfname,fname}																					, {dkeythor_data400__key__business_header__contacts__state_lfname						}, '~prte::key::business_header::' + pIndexVersion + '::contacts::state.lfname'              );
	kkeythor_data400__key__business_header__hri__address 											:= index(dkeythor_data400__key__business_header__hri__address											, {z5,prim_name,suffix,predir,postdir,prim_range,sec_range,dt_first_seen}				, {dkeythor_data400__key__business_header__hri__address											}, '~prte::key::business_header::' + pIndexVersion + '::hri::address'                        );
	kkeythor_data400__key__business_header__relatives__bdid1 									:= index(dkeythor_data400__key__business_header__relatives__bdid1									, {bdid1}																																				, {dkeythor_data400__key__business_header__relatives__bdid1									}, '~prte::key::business_header::' + pIndexVersion + '::relatives::bdid1'                    );
	kkeythor_data400__key__business_header__relatives_group__groupid                := index(dkeythor_data400__key__business_header__relatives_group__groupid                , {dkeythor_data400__key__business_header__relatives_group__groupid.group_id}      ,{dkeythor_data400__key__business_header__relatives_group__groupid}, '~prte::key::business_header::' + pIndexVersion + '::relatives_group::groupid'                     );
	kkeythor_data400__key__business_header__risk__bdid 												:= index(dkeythor_data400__key__business_header__risk__bdid												, {bdid}																																				, {dkeythor_data400__key__business_header__risk__bdid												}, '~prte::key::business_header::' + pIndexVersion + '::risk::bdid'                          );
	kkeythor_data400__key__business_header__risk__did 												:= index(dkeythor_data400__key__business_header__risk__did												, {did}																																					, {dkeythor_data400__key__business_header__risk__did												}, '~prte::key::business_header::' + pIndexVersion + '::risk::did'                           );
	kkeythor_data400__key__business_header__risk__fein 												:= index(dkeythor_data400__key__business_header__risk__fein												, {fein}																																				, {dkeythor_data400__key__business_header__risk__fein												}, '~prte::key::business_header::' + pIndexVersion + '::risk::fein'                          );
	kkeythor_data400__key__business_header__risk__fein_company_name 					:= index(dkeythor_data400__key__business_header__risk__fein_company_name					, {fein,company_name}																														, {dkeythor_data400__key__business_header__risk__fein_company_name					}, '~prte::key::business_header::' + pIndexVersion + '::risk::fein.company_name'             );
	kkeythor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range:= index(dkeythor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range, {zip,prim_range,prim_name,sec_range},{bdid,source,source_group,dt_first_seen,dt_last_seen,dt_vendor_first_reported,dt_vendor_last_reported,company_name,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,city,state,zip,zip4,county,msa,geo_lat,geo_long,phone,phone_score,fein,current,dppa}, '~prte::key::business_header::' + pIndexVersion + '::risk::zip.prim_range.prim_name.sec_range'     );
	// kkeythor_data400__key__business_header__supergroup__bdid									:= index(dkeythor_data400__key__business_header__supergroup__bdid									, {bdid}																																				, {dkeythor_data400__key__business_header__supergroup__bdid									}, '~prte::key::business_header::' + pIndexVersion + '::supergroup::bdid'                    );
	// kkeythor_data400__key__business_header__supergroup__groupid								:= index(dkeythor_data400__key__business_header__supergroup__groupid							, {group_id}																																		, {dkeythor_data400__key__business_header__supergroup__groupid							}, '~prte::key::business_header::' + pIndexVersion + '::supergroup::groupid'                 );

	// kkeythor_data400__key__business_header__base__address											:= index(dkeythor_data400__key__business_header__base__address										, {dkeythor_data400__key__business_header__base__address			}									/*, {dkeythor_data400__key__business_header__base__address										}*/, '~prte::key::business_header::' + pIndexVersion + '::base::address'      );
	// kkeythor_data400__key__business_header__base__fein												:= index(dkeythor_data400__key__business_header__base__fein												, {dkeythor_data400__key__business_header__base__fein					}									/*, {dkeythor_data400__key__business_header__base__fein												}*/, '~prte::key::business_header::' + pIndexVersion + '::base::fein'         );
	// kkeythor_data400__key__business_header__base__name												:= index(dkeythor_data400__key__business_header__base__name												, {dkeythor_data400__key__business_header__base__name					}									/*, {dkeythor_data400__key__business_header__base__name												}*/, '~prte::key::business_header::' + pIndexVersion + '::base::name'         );
	// kkeythor_data400__key__business_header__base__phone												:= index(dkeythor_data400__key__business_header__base__phone											, {dkeythor_data400__key__business_header__base__phone				}									/*, {dkeythor_data400__key__business_header__base__phone											}*/, '~prte::key::business_header::' + pIndexVersion + '::base::phone'        );
	// kkeythor_data400__key__business_header__base__st_city_name								:= index(dkeythor_data400__key__business_header__base__st_city_name								, {dkeythor_data400__key__business_header__base__st_city_name	}									/*, {dkeythor_data400__key__business_header__base__st_city_name								}*/, '~prte::key::business_header::' + pIndexVersion + '::base::st.city.name' );
	// kkeythor_data400__key__business_header__base__st_name											:= index(dkeythor_data400__key__business_header__base__st_name										, {dkeythor_data400__key__business_header__base__st_name			}									/*, {dkeythor_data400__key__business_header__base__st_name										}*/, '~prte::key::business_header::' + pIndexVersion + '::base::st.name'      );
	// kkeythor_data400__key__business_header__base__street											:= index(dkeythor_data400__key__business_header__base__street											, {dkeythor_data400__key__business_header__base__street				}									/*, {dkeythor_data400__key__business_header__base__street											}*/, '~prte::key::business_header::' + pIndexVersion + '::base::street'       );
	// kkeythor_data400__key__business_header__base__zip													:= index(dkeythor_data400__key__business_header__base__zip												, {dkeythor_data400__key__business_header__base__zip					}									/*, {dkeythor_data400__key__business_header__base__zip												}*/, '~prte::key::business_header::' + pIndexVersion + '::base::zip'          );


	// kkeythor_data400__key__business_header__contacts__bdid_score                    := index(dkeythor_data400__key__business_header__contacts__bdid_score                    , {bdid, score}                                                                    ,{did, bdid2}                                                      , '~prte::key::business_header::' + pIndexVersion + '::contacts::bdid.score'                         );
	// kkeythor_data400__key__business_header__contacts__company_title                 := index(dkeythor_data400__key__business_header__contacts__company_title                 , {company_title}                                                                  ,{decode_company_title}                                            , '~prte::key::business_header::' + pIndexVersion + '::contacts::company_title'                      );
	kkeythor_data400__key__business_header__eda__word_freq                          := index(dkeythor_data400__key__business_header__eda__word_freq                          , {string30 word := word,unsigned8 freq := freq                                   },{dkeythor_data400__key__business_header__eda__word_freq          }, '~prte::key::business_header::' + pIndexVersion + '::eda::word.freq'                               );


	return 
	sequential(
		parallel(
			 Business_Header.prct_fetch_keys			(pIndexVersion)
			,Business_Header.prct_contacts_keys		(pIndexVersion)
			,Business_Header.prct_sic_keys				(pIndexVersion)
			,Business_Header.prct_Best_Keys				(pIndexVersion)
			,Business_Header.prct_Supergroup_keys	(pIndexVersion)
			,build(kkeythor_data400__key__business_header__search__addr 											,update)
			,build(kkeythor_data400__key__business_header__search__addr_pr_pn_sr_st 					,update)
			,build(kkeythor_data400__key__business_header__search__addr_pr_pn_zip 						,update)
			,build(kkeythor_data400__key__business_header__search__addr_st 										,update)
			,build(kkeythor_data400__key__business_header__search__addr_zip 									,update)
			,build(kkeythor_data400__key__business_header__search__bdid_city_zip_fein_phone 	,update)
			,build(kkeythor_data400__key__business_header__search__bdid_pl 										,update)
			,build(kkeythor_data400__key__business_header__search__companyname								,update)
			,build(kkeythor_data400__key__business_header__search__companyname_bdid_cn_bdids 	,update)
			,build(kkeythor_data400__key__business_header__search__conamewords								,update)
			,build(kkeythor_data400__key__business_header__search__fein												,update)
			,build(kkeythor_data400__key__business_header__search__phone											,update)
			,build(kkeythor_data400__key__business_header__search__bdid_seq                   ,update)
			,build(kkeythor_data400__key__business_header__search__siccode_zip                ,update)
			,build(kkeythor_data400__key__business_header__search__zipprlname                 ,update)
			,build(kkeythor_data400__key__business_header__search__conamewordsmetaphone       ,update)
			,build(kkeythor_data400__key__business_header__search__rcid                       ,update)
			,build(kkeythor_data400__key__business_header__hri__oldnpa_oldnxx 								,update)
			,build(kkeythor_data400__key__business_header__hri__oldnpa_oldnxx_fixeddates 			,update)
			,build(kkeythor_data400__key__business_header__hri__address 											,update)
			,build(kkeythor_data400__key__business_header__hri__phone10_v2										,update)
			,build(kkeythor_data400__key__business_header__hri__risk_bdid											,update)
			,build(kkeythor_data400__key__business_header__hri__risk_geolink									,update)
			,build(kkeythor_data400__key__business_header__filtered__hri__address							,update)
			,build(kkeythor_data400__key__business_header__filtered__hri__phone10_v2					,update)
			,build(kkeythor_data400__key__business_header__hri__sic_z5         								,update)
			,build(kkeythor_data400__key__business_header__address_siccode     								,update)
			,build(kkeythor_data400__key__business_header__hri__address_siccode								,update)
			,build(kkeythor_data400__key__business_header__risk__bdid_risk     								,update)
			,build(kkeythor_data400__key__business_header__aca_institutions__address 					,update)
			,build(kkeythor_data400__key__business_header__bdl2__bdid 												,update)
			,build(kkeythor_data400__key__business_header__bdl2__bdl 													,update)
			// ,build(kkeythor_data400__key__business_header__best__filepos_data 								,update)
			// ,build(kkeythor_data400__key__business_header__best__filepos_data_knowx 					,update)
			// ,build(kkeythor_data400__key__business_header__contacts__bdid 										,update)
			// ,build(kkeythor_data400__key__business_header__contacts__did 											,update)
			// ,build(kkeythor_data400__key__business_header__contacts__filepos 									,update)
			// ,build(kkeythor_data400__key__business_header__contacts__ssn 											,update)
			// ,build(kkeythor_data400__key__business_header__contacts__state_city_name 					,update)
			// ,build(kkeythor_data400__key__business_header__contacts__state_lfname 						,update)
			,build(kkeythor_data400__key__business_header__relatives__bdid1 									,update)
			,build(kkeythor_data400__key__business_header__relatives_group__groupid           ,update)
			,build(kkeythor_data400__key__business_header__risk__bdid 												,update)
			,build(kkeythor_data400__key__business_header__risk__did 													,update)
			,build(kkeythor_data400__key__business_header__risk__fein 												,update)
			,build(kkeythor_data400__key__business_header__risk__fein_company_name 						,update)
			,build(kkeythor_data400__key__business_header__risk__zip_prim_range_prim_name_sec_range,update)
			// ,build(kkeythor_data400__key__business_header__supergroup__bdid										,update)
			// ,build(kkeythor_data400__key__business_header__supergroup__groupid								,update)

			// ,build(kkeythor_data400__key__business_header__base__address											,update)
			// ,build(kkeythor_data400__key__business_header__base__fein													,update)
			// ,build(kkeythor_data400__key__business_header__base__name													,update)
			// ,build(kkeythor_data400__key__business_header__base__phone												,update)
			// ,build(kkeythor_data400__key__business_header__base__st_city_name									,update)
			// ,build(kkeythor_data400__key__business_header__base__st_name											,update)
			// ,build(kkeythor_data400__key__business_header__base__street												,update)
			// ,build(kkeythor_data400__key__business_header__base__zip													,update)


			// ,build(kkeythor_data400__key__business_header__contacts__bdid_score                    ,update)
			// ,build(kkeythor_data400__key__business_header__contacts__company_title                 ,update)
			,build(kkeythor_data400__key__business_header__eda__word_freq                          ,update)
		)
		,prte.CopyMissingKeys('BusinessHeaderKeys'	,pIndexVersion,pOldversion)	//copy missing keys not built above
		,prte.CopyMissingKeys('ACAInstitutionsKeys'	,pIndexVersion,pOldversion)	//copy missing keys not built above
		,prte.CopyMissingKeys('AddressHRIKeys'			,pIndexVersion,pOldversion)	//copy missing keys not built above
		,iff(pShouldUpdateDOPS  ,PRTE.UpdateVersion(
				'BusinessHeaderKeys'								//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		))
		,iff(pShouldUpdateDOPS  ,PRTE.UpdateVersion(
				'ACAInstitutionsKeys'								//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		))
		,iff(pShouldUpdateDOPS  ,PRTE.UpdateVersion(
				'AddressHRIKeys'								//	Package name
			 ,pIndexVersion												//	Package version
			 ,_control.MyInfo.EmailAddressNormal	//	Who to email with specifics
			 ,'N'																	//  auto_pkg (optional) -- don't use it
			 ,'N'																	//	N = Non-FCRA, F = FCRA
			 ,'N'                                 //	N = Do not also include boolean, Y = Include boolean, too
		))
	);


end;