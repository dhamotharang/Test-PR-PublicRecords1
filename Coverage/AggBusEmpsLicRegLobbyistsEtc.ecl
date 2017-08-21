/*
W20080227-160049-4 used in Employee Directories, LicReg, Lobbyists, Misc Bus
Liquor
FDIC
State Employees
Lobbyists
*/

shared wither_mnliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'MINNESOTA LIQUOR LICENSES'					);
shared wither_txliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'TEXAS LIQUOR LICENSES'							);
shared wither_nhlott 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'NEW HAMPSHIRE LOTTERY SALES AGENTS'	);
shared wither_caliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'CALIFORNIA LIQUOR LICENSES'					);
shared wither_waliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'WASHINGTON LIQUOR LICENSES'					);
shared wither_nblott 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'NEBRASKA LOTTERY SALES AGENTS'			);
shared wither_orlott 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'OREGON LOTTERY SALES AGENTS'				);
shared wither_paliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'PENNSYLVANIA LIQUOR LICENSES'				);
shared wither_njliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'NEW JERSEY LIQUOR LICENSES'					);
shared wither_azliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'ARIZONA LIQUOR LICENSES'						);
shared wither_nyliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'NEW YORK LIQUOR LICENSES'						);
shared wither_usgame 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'U.S. GAMING INDUSTRY RECORDS'				);
shared wither_flswps 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'FLORIDA SWEEPSTAKES REGISTRATIONS'	);
shared wither_nylott 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'NEW YORK LOTTERY SALES AGENTS'			);
shared wither_nbgame 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'NEBRASKA GAMING LICENSES'						);
shared wither_akbiz 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'ALASKA BUSINESS LICENSES'						);
shared wither_coliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'COLORADO LIQUOR LICENSES'						);
shared wither_ohliq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'OHIO LIQUOR LICENSES'								);
shared wither_txlott 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'TEXAS LOTTERY SALES AGENTS'					);
shared wither_valiq 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'VIRGINIA LIQUOR LICENSES'						);
shared wither_ohlott 	:= Wither_and_Die.File_Wither_and_Die_In(cite_id = 'OHIO LOTTERY SALES AGENTS'					);

shared caliq 	:= Liquor_Licenses.Files().base.ca.qa;
shared ohliq 	:= Liquor_Licenses.Files().base.oh.qa;
shared paliq 	:= Liquor_Licenses.Files().base.pa.qa;
shared txliq 	:= Liquor_Licenses.Files().base.tx.qa;

shared fdic_orig := table(govdata.File_FDIC_BDID, {DATEUPDT});
ut.macAppendStandardizedDate(  fdic_orig
															,DATEUPDT
															,dDateStandardized
														);
fdic_clean_layout := 
record
	string DATEUPDT;
	unsigned4 clean_date;
end;
shared fdic_dates := project(dDateStandardized, transform(fdic_clean_layout, self.clean_date	:= (unsigned4)(left.yyyy + left.mm + left.dd); self := left));

shared CO_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'CO', source_description = 'STATE EMPLOYEES'									);
shared US_DOI_EMPLOYEES										:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'DOI EMPLOYEES'										);
shared TX_MIDLAND_COUNTY_EMPLOYEES				:= govdata.File_Gov_Phones_Base(state_origin = 'TX', source_description = 'MIDLAND COUNTY EMPLOYEES'				);
shared AR_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'AR', source_description = 'STATE EMPLOYEES'									);
shared US_DOS_EMPLOYEES										:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'DOS EMPLOYEES'										);
shared AK_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'AK', source_description = 'STATE EMPLOYEES'									);
shared KS_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'KS', source_description = 'STATE EMPLOYEES'									);
shared NV_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'NV', source_description = 'STATE EMPLOYEES'									);
shared MD_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'MD', source_description = 'STATE EMPLOYEES'									);
shared NE_CONNECTING_POINT_EMPLOYEES			:= govdata.File_Gov_Phones_Base(state_origin = 'NE', source_description = 'CONNECTING POINT EMPLOYEES'			);
shared ND_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'ND', source_description = 'STATE EMPLOYEES'									);
shared VA_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'VA', source_description = 'STATE EMPLOYEES'									);
shared US_US_DEPT_OF_ST_BUREAU_OF_ADMIN		:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'US DEPT OF ST BUREAU OF ADMIN'		);
shared DC_PREFERRED_LENDERS								:= govdata.File_Gov_Phones_Base(state_origin = 'DC', source_description = 'PREFERRED LENDERS'								);
shared MO_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'MO', source_description = 'STATE EMPLOYEES' or source_description = 'STATE_EMPLOYEES'									);
shared WV_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'WV', source_description = 'STATE EMPLOYEES'									);
shared IL_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'IL', source_description = 'STATE EMPLOYEES'									);
shared SC_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'SC', source_description = 'STATE EMPLOYEES'									);
shared MD_People_At_Work									:= govdata.File_Gov_Phones_Base(state_origin = 'MD', source_description = 'People At Work'									);
shared OR_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'OR', source_description = 'STATE EMPLOYEES'									);
shared NH_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'NH', source_description = 'STATE EMPLOYEES'									);
shared ID_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'ID', source_description = 'STATE EMPLOYEES'									);
shared CA_CHICO_CITY_EMPLOYEES						:= govdata.File_Gov_Phones_Base(state_origin = 'CA', source_description = 'CHICO CITY EMPLOYEES'						);
shared TX_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'TX', source_description = 'STATE EMPLOYEES'									);
shared UT_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'UT', source_description = 'STATE EMPLOYEES'									);
shared US_ED_EMPLOYEES										:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'ED EMPLOYEES'										);
shared US_EPA_EMPLOYEES										:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'EPA EMPLOYEES'										);
shared GA_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'GA', source_description = 'STATE EMPLOYEES'									);
shared SD_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'SD', source_description = 'STATE EMPLOYEES'									);
shared MS_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'MS', source_description = 'STATE EMPLOYEES'									);
shared IN_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'IN', source_description = 'STATE EMPLOYEES'									);
shared PA_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'PA', source_description = 'STATE EMPLOYEES'									);
shared OH_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'OH', source_description = 'STATE EMPLOYEES'									);
shared US_US_FISH_AND_WILDLIFE_EMPLOYEES	:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'US FISH AND WILDLIFE EMPLOYEES'	);
shared AL_DIR_EMPLOYEES										:= govdata.File_Gov_Phones_Base(state_origin = 'AL', source_description = 'DIR EMPLOYEES'										);
shared CA_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'CA', source_description = 'STATE EMPLOYEES'									);
shared DC_CRC_INSURANCE_EMPLOYEES					:= govdata.File_Gov_Phones_Base(state_origin = 'DC', source_description = 'CRC INSURANCE EMPLOYEES'					);
shared FL_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'FL', source_description = 'STATE EMPLOYEES'									);
shared NY_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'NY', source_description = 'STATE EMPLOYEES'									);
shared NC_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'NC', source_description = 'STATE EMPLOYEES'									);
shared CA_CITY_OF_OAKLAND_EMPLOYEES				:= govdata.File_Gov_Phones_Base(state_origin = 'CA', source_description = 'CITY OF OAKLAND EMPLOYEES'				);
shared US_USDA_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'USDA EMPLOYEES'									);
shared US_DOE_EMPLOYEES										:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'DOE EMPLOYEES'										);
shared KY_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'KY', source_description = 'STATE EMPLOYEES'									);
shared US_FEMA_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'US', source_description = 'FEMA EMPLOYEES'									);
shared CT_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'CT', source_description = 'STATE EMPLOYEES'									);
shared NJ_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'NJ', source_description = 'STATE EMPLOYEES'									);
shared DC_DOL_EMPLOYEES										:= govdata.File_Gov_Phones_Base(state_origin = 'DC', source_description = 'DOL EMPLOYEES'										);
shared WI_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'WI', source_description = 'STATE EMPLOYEES'									);
shared AR_BAXTER_COUNTY_EMPLOYEES					:= govdata.File_Gov_Phones_Base(state_origin = 'AR', source_description = 'BAXTER COUNTY EMPLOYEES'					);
shared MN_STATE_EMPLOYEES									:= govdata.File_Gov_Phones_Base(state_origin = 'MN', source_description = 'STATE EMPLOYEES'									);
 
shared NJ_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'NJ');
shared NH_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'NH');
shared ME_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'ME');
shared NV_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'NV');
shared MA_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'MA');
shared MN_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'MN');
shared MO_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'MO');
shared NY_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'NY');
shared MI_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'MI');
shared KY_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'KY');
shared LA_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'LA');
shared OR_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'OR');
shared KS_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'KS');
shared OH_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'OH');
shared DC_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'DC');
shared OK_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'OK');
shared WY_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'WY');
shared TX_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'TX');
shared CA_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'CA');
shared CO_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'CO');
shared WV_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'WV');
shared AZ_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'AZ');
shared TN_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'TN');
shared SD_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'SD');
shared AR_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'AR');
shared AK_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'AK');
shared AL_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'AL');
shared VA_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'VA');
shared UT_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'UT');
shared RI_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'RI');
shared GA_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'GA');
shared VT_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'VT');
shared FL_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'FL');
shared IA_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'IA');
shared ID_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'ID');
shared IN_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'IN');
shared HI_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'HI');
shared NC_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'NC');
shared MT_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'MT');
shared MS_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'MS');
shared ND_lobbyists := Lobbyists.Cleaned_Lobbyists(source_state = 'ND');


ut.macGetCoverageDates(wither_mnliq 	,'MINNESOTA LIQUOR LICENSES'						,dt_first_seen		,dt_last_seen		,wither_mnliq_coverage	,true	);
ut.macGetCoverageDates(wither_txliq 	,'TEXAS LIQUOR LICENSES'								,dt_first_seen		,dt_last_seen		,wither_txliq_coverage	,true	);
ut.macGetCoverageDates(wither_nhlott	,'NEW HAMPSHIRE LOTTERY SALES AGENTS'		,dt_first_seen		,dt_last_seen		,wither_nhlott_coverage	,true	);
ut.macGetCoverageDates(wither_caliq 	,'CALIFORNIA LIQUOR LICENSES'						,dt_first_seen		,dt_last_seen		,wither_caliq_coverage	,true	);
ut.macGetCoverageDates(wither_waliq 	,'WASHINGTON LIQUOR LICENSES'						,dt_first_seen		,dt_last_seen		,wither_waliq_coverage	,true	);
ut.macGetCoverageDates(wither_nblott	,'NEBRASKA LOTTERY SALES AGENTS'				,dt_first_seen		,dt_last_seen		,wither_nblott_coverage	,true	);
ut.macGetCoverageDates(wither_orlott	,'OREGON LOTTERY SALES AGENTS'					,dt_first_seen		,dt_last_seen		,wither_orlott_coverage	,true	);
ut.macGetCoverageDates(wither_paliq 	,'PENNSYLVANIA LIQUOR LICENSES'					,dt_first_seen		,dt_last_seen		,wither_paliq_coverage	,true	);
ut.macGetCoverageDates(wither_njliq 	,'NEW JERSEY LIQUOR LICENSES'						,dt_first_seen		,dt_last_seen		,wither_njliq_coverage	,true	);
ut.macGetCoverageDates(wither_azliq 	,'ARIZONA LIQUOR LICENSES'							,dt_first_seen		,dt_last_seen		,wither_azliq_coverage	,true	);
ut.macGetCoverageDates(wither_nyliq 	,'NEW YORK LIQUOR LICENSES'							,dt_first_seen		,dt_last_seen		,wither_nyliq_coverage	,true	);
ut.macGetCoverageDates(wither_usgame	,'U.S. GAMING INDUSTRY RECORDS'					,dt_first_seen		,dt_last_seen		,wither_usgame_coverage	,true	);
ut.macGetCoverageDates(wither_flswps	,'FLORIDA SWEEPSTAKES REGISTRATIONS'		,dt_first_seen		,dt_last_seen		,wither_flswps_coverage	,true	);
ut.macGetCoverageDates(wither_nylott	,'NEW YORK LOTTERY SALES AGENTS'				,dt_first_seen		,dt_last_seen		,wither_nylott_coverage	,true	);
ut.macGetCoverageDates(wither_nbgame	,'NEBRASKA GAMING LICENSES'							,dt_first_seen		,dt_last_seen		,wither_nbgame_coverage	,true	);
ut.macGetCoverageDates(wither_akbiz 	,'ALASKA BUSINESS LICENSES'							,dt_first_seen		,dt_last_seen		,wither_akbiz_coverage	,true	);
ut.macGetCoverageDates(wither_coliq 	,'COLORADO LIQUOR LICENSES'							,dt_first_seen		,dt_last_seen		,wither_coliq_coverage	,true	);
ut.macGetCoverageDates(wither_ohliq 	,'OHIO LIQUOR LICENSES'									,dt_first_seen		,dt_last_seen		,wither_ohliq_coverage	,true	);
ut.macGetCoverageDates(wither_txlott	,'TEXAS LOTTERY SALES AGENTS'						,dt_first_seen		,dt_last_seen		,wither_txlott_coverage	,true	);
ut.macGetCoverageDates(wither_valiq 	,'VIRGINIA LIQUOR LICENSES'							,dt_first_seen		,dt_last_seen		,wither_valiq_coverage	,true	);
ut.macGetCoverageDates(wither_ohlott	,'OHIO LOTTERY SALES AGENTS'						,dt_first_seen		,dt_last_seen		,wither_ohlott_coverage	,true	);
                                                                                                       
ut.macGetCoverageDates(caliq					,'CALIFORNIA LIQUOR LICENSES NEW'				,dt_first_seen		,dt_last_seen		,caliq_coverage					,false);
ut.macGetCoverageDates(ohliq					,'OHIO LIQUOR LICENSES NEW'							,dt_first_seen		,dt_last_seen		,ohliq_coverage					,false);
ut.macGetCoverageDates(paliq					,'PENNSYLVANIA LIQUOR LICENSES NEW'			,dt_first_seen		,dt_last_seen		,paliq_coverage					,false);
ut.macGetCoverageDates(txliq					,'TEXAS LIQUOR LICENSES NEW'						,dt_first_seen		,dt_last_seen		,txliq_coverage					,false);
                                                                                                       
ut.macGetCoverageDates(fdic_dates			,'FDIC Institutions'										,clean_date				,clean_date			,fdic_coverage					,false);

ut.macGetCoverageDates(CO_STATE_EMPLOYEES											,'CO_STATE_EMPLOYEES'									,record_date			,record_date		,CO_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(US_DOI_EMPLOYEES												,'US_DOI_EMPLOYEES'										,record_date			,record_date		,US_DOI_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(TX_MIDLAND_COUNTY_EMPLOYEES						,'TX_MIDLAND_COUNTY_EMPLOYEES'				,record_date			,record_date		,TX_MIDLAND_COUNTY_EMPLOYEES_coverage				,true);
ut.macGetCoverageDates(AR_STATE_EMPLOYEES											,'AR_STATE_EMPLOYEES'									,record_date			,record_date		,AR_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(US_DOS_EMPLOYEES												,'US_DOS_EMPLOYEES'										,record_date			,record_date		,US_DOS_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(AK_STATE_EMPLOYEES											,'AK_STATE_EMPLOYEES'									,record_date			,record_date		,AK_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(KS_STATE_EMPLOYEES											,'KS_STATE_EMPLOYEES'									,record_date			,record_date		,KS_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(NV_STATE_EMPLOYEES											,'NV_STATE_EMPLOYEES'									,record_date			,record_date		,NV_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(MD_STATE_EMPLOYEES											,'MD_STATE_EMPLOYEES'									,record_date			,record_date		,MD_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(NE_CONNECTING_POINT_EMPLOYEES					,'NE_CONNECTING_POINT_EMPLOYEES'			,record_date			,record_date		,NE_CONNECTING_POINT_EMPLOYEES_coverage			,true);
ut.macGetCoverageDates(ND_STATE_EMPLOYEES											,'ND_STATE_EMPLOYEES'									,record_date			,record_date		,ND_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(VA_STATE_EMPLOYEES											,'VA_STATE_EMPLOYEES'									,record_date			,record_date		,VA_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(US_US_DEPT_OF_ST_BUREAU_OF_ADMIN				,'US_US_DEPT_OF_ST_BUREAU_OF_ADMIN'		,record_date			,record_date		,US_US_DEPT_OF_ST_BUREAU_OF_ADMIN_coverage	,true);
ut.macGetCoverageDates(DC_PREFERRED_LENDERS										,'DC_PREFERRED_LENDERS'								,record_date			,record_date		,DC_PREFERRED_LENDERS_coverage							,true);
ut.macGetCoverageDates(MO_STATE_EMPLOYEES											,'MO_STATE_EMPLOYEES'									,record_date			,record_date		,MO_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(WV_STATE_EMPLOYEES											,'WV_STATE_EMPLOYEES'									,record_date			,record_date		,WV_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(IL_STATE_EMPLOYEES											,'IL_STATE_EMPLOYEES'									,record_date			,record_date		,IL_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(SC_STATE_EMPLOYEES											,'SC_STATE_EMPLOYEES'									,record_date			,record_date		,SC_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(MD_People_At_Work											,'MD_People_At_Work'									,record_date			,record_date		,MD_People_At_Work_coverage									,true);
ut.macGetCoverageDates(OR_STATE_EMPLOYEES											,'OR_STATE_EMPLOYEES'									,record_date			,record_date		,OR_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(NH_STATE_EMPLOYEES											,'NH_STATE_EMPLOYEES'									,record_date			,record_date		,NH_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(ID_STATE_EMPLOYEES											,'ID_STATE_EMPLOYEES'									,record_date			,record_date		,ID_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(CA_CHICO_CITY_EMPLOYEES								,'CA_CHICO_CITY_EMPLOYEES'						,record_date			,record_date		,CA_CHICO_CITY_EMPLOYEES_coverage						,true);
ut.macGetCoverageDates(TX_STATE_EMPLOYEES											,'TX_STATE_EMPLOYEES'									,record_date			,record_date		,TX_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(UT_STATE_EMPLOYEES											,'UT_STATE_EMPLOYEES'									,record_date			,record_date		,UT_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(US_ED_EMPLOYEES												,'US_ED_EMPLOYEES'										,record_date			,record_date		,US_ED_EMPLOYEES_coverage										,true);
ut.macGetCoverageDates(US_EPA_EMPLOYEES												,'US_EPA_EMPLOYEES'										,record_date			,record_date		,US_EPA_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(GA_STATE_EMPLOYEES											,'GA_STATE_EMPLOYEES'									,record_date			,record_date		,GA_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(SD_STATE_EMPLOYEES											,'SD_STATE_EMPLOYEES'									,record_date			,record_date		,SD_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(MS_STATE_EMPLOYEES											,'MS_STATE_EMPLOYEES'									,record_date			,record_date		,MS_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(IN_STATE_EMPLOYEES											,'IN_STATE_EMPLOYEES'									,record_date			,record_date		,IN_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(PA_STATE_EMPLOYEES											,'PA_STATE_EMPLOYEES'									,record_date			,record_date		,PA_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(OH_STATE_EMPLOYEES											,'OH_STATE_EMPLOYEES'									,record_date			,record_date		,OH_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(US_US_FISH_AND_WILDLIFE_EMPLOYEES			,'US_US_FISH_AND_WILDLIFE_EMPLOYEES'	,record_date			,record_date		,US_US_FISH_AND_WILDLIFE_EMPLOYEES_coverage	,true);
ut.macGetCoverageDates(AL_DIR_EMPLOYEES												,'AL_DIR_EMPLOYEES'										,record_date			,record_date		,AL_DIR_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(CA_STATE_EMPLOYEES											,'CA_STATE_EMPLOYEES'									,record_date			,record_date		,CA_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(DC_CRC_INSURANCE_EMPLOYEES							,'DC_CRC_INSURANCE_EMPLOYEES'					,record_date			,record_date		,DC_CRC_INSURANCE_EMPLOYEES_coverage				,true);
ut.macGetCoverageDates(FL_STATE_EMPLOYEES											,'FL_STATE_EMPLOYEES'									,record_date			,record_date		,FL_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(NY_STATE_EMPLOYEES											,'NY_STATE_EMPLOYEES'									,record_date			,record_date		,NY_STATE_EMPLOYEES_coverage								,true);	
ut.macGetCoverageDates(NC_STATE_EMPLOYEES											,'NC_STATE_EMPLOYEES'									,record_date			,record_date		,NC_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(CA_CITY_OF_OAKLAND_EMPLOYEES						,'CA_CITY_OF_OAKLAND_EMPLOYEES'				,record_date			,record_date		,CA_CITY_OF_OAKLAND_EMPLOYEES_coverage			,true);
ut.macGetCoverageDates(US_USDA_EMPLOYEES											,'US_USDA_EMPLOYEES	'									,record_date			,record_date		,US_USDA_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(US_DOE_EMPLOYEES												,'US_DOE_EMPLOYEES'										,record_date			,record_date		,US_DOE_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(KY_STATE_EMPLOYEES											,'KY_STATE_EMPLOYEES'									,record_date			,record_date		,KY_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(US_FEMA_EMPLOYEES											,'US_FEMA_EMPLOYEES'									,record_date			,record_date		,US_FEMA_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(CT_STATE_EMPLOYEES											,'CT_STATE_EMPLOYEES'									,record_date			,record_date		,CT_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(NJ_STATE_EMPLOYEES											,'NJ_STATE_EMPLOYEES'									,record_date			,record_date		,NJ_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(DC_DOL_EMPLOYEES												,'DC_DOL_EMPLOYEES'										,record_date			,record_date		,DC_DOL_EMPLOYEES_coverage									,true);
ut.macGetCoverageDates(WI_STATE_EMPLOYEES											,'WI_STATE_EMPLOYEES'									,record_date			,record_date		,WI_STATE_EMPLOYEES_coverage								,true);
ut.macGetCoverageDates(AR_BAXTER_COUNTY_EMPLOYEES							,'AR_BAXTER_COUNTY_EMPLOYEES'					,record_date			,record_date		,AR_BAXTER_COUNTY_EMPLOYEES_coverage				,true);
ut.macGetCoverageDates(MN_STATE_EMPLOYEES											,'MN_STATE_EMPLOYEES'									,record_date			,record_date		,MN_STATE_EMPLOYEES_coverage								,true);
                                           
ut.macGetCoverageDates(NJ_lobbyists	,'NJ_lobbyists'	,lobby_registration_date	,lobby_registration_date	,NJ_lobbyists_coverage	,true);
ut.macGetCoverageDates(NH_lobbyists	,'NH_lobbyists'	,lobby_registration_date	,lobby_registration_date	,NH_lobbyists_coverage	,true);
ut.macGetCoverageDates(ME_lobbyists	,'ME_lobbyists'	,lobby_registration_date	,lobby_registration_date	,ME_lobbyists_coverage	,true);
ut.macGetCoverageDates(NV_lobbyists	,'NV_lobbyists'	,lobby_registration_date	,lobby_registration_date	,NV_lobbyists_coverage	,true);
ut.macGetCoverageDates(MA_lobbyists	,'MA_lobbyists'	,lobby_registration_date	,lobby_registration_date	,MA_lobbyists_coverage	,true);
ut.macGetCoverageDates(MN_lobbyists	,'MN_lobbyists'	,lobby_registration_date	,lobby_registration_date	,MN_lobbyists_coverage	,true);
ut.macGetCoverageDates(MO_lobbyists	,'MO_lobbyists'	,lobby_registration_date	,lobby_registration_date	,MO_lobbyists_coverage	,true);
ut.macGetCoverageDates(NY_lobbyists	,'NY_lobbyists'	,lobby_registration_date	,lobby_registration_date	,NY_lobbyists_coverage	,true);
ut.macGetCoverageDates(MI_lobbyists	,'MI_lobbyists'	,lobby_registration_date	,lobby_registration_date	,MI_lobbyists_coverage	,true);
ut.macGetCoverageDates(KY_lobbyists	,'KY_lobbyists'	,lobby_registration_date	,lobby_registration_date	,KY_lobbyists_coverage	,true);
ut.macGetCoverageDates(LA_lobbyists	,'LA_lobbyists'	,lobby_registration_date	,lobby_registration_date	,LA_lobbyists_coverage	,true);
ut.macGetCoverageDates(OR_lobbyists	,'OR_lobbyists'	,lobby_registration_date	,lobby_registration_date	,OR_lobbyists_coverage	,true);
ut.macGetCoverageDates(KS_lobbyists	,'KS_lobbyists'	,lobby_registration_date	,lobby_registration_date	,KS_lobbyists_coverage	,true);
ut.macGetCoverageDates(OH_lobbyists	,'OH_lobbyists'	,lobby_registration_date	,lobby_registration_date	,OH_lobbyists_coverage	,true);
ut.macGetCoverageDates(DC_lobbyists	,'DC_lobbyists'	,lobby_registration_date	,lobby_registration_date	,DC_lobbyists_coverage	,true);
ut.macGetCoverageDates(OK_lobbyists	,'OK_lobbyists'	,lobby_registration_date	,lobby_registration_date	,OK_lobbyists_coverage	,true);
ut.macGetCoverageDates(WY_lobbyists	,'WY_lobbyists'	,lobby_registration_date	,lobby_registration_date	,WY_lobbyists_coverage	,true);
ut.macGetCoverageDates(TX_lobbyists	,'TX_lobbyists'	,lobby_registration_date	,lobby_registration_date	,TX_lobbyists_coverage	,true);
ut.macGetCoverageDates(CA_lobbyists	,'CA_lobbyists'	,lobby_registration_date	,lobby_registration_date	,CA_lobbyists_coverage	,true);
ut.macGetCoverageDates(CO_lobbyists	,'CO_lobbyists'	,lobby_registration_date	,lobby_registration_date	,CO_lobbyists_coverage	,true);
ut.macGetCoverageDates(WV_lobbyists	,'WV_lobbyists'	,lobby_registration_date	,lobby_registration_date	,WV_lobbyists_coverage	,true);
ut.macGetCoverageDates(AZ_lobbyists	,'AZ_lobbyists'	,lobby_registration_date	,lobby_registration_date	,AZ_lobbyists_coverage	,true);
ut.macGetCoverageDates(TN_lobbyists	,'TN_lobbyists'	,lobby_registration_date	,lobby_registration_date	,TN_lobbyists_coverage	,true);
ut.macGetCoverageDates(SD_lobbyists	,'SD_lobbyists'	,lobby_registration_date	,lobby_registration_date	,SD_lobbyists_coverage	,true);
ut.macGetCoverageDates(AR_lobbyists	,'AR_lobbyists'	,lobby_registration_date	,lobby_registration_date	,AR_lobbyists_coverage	,true);
ut.macGetCoverageDates(AK_lobbyists	,'AK_lobbyists'	,lobby_registration_date	,lobby_registration_date	,AK_lobbyists_coverage	,true);
ut.macGetCoverageDates(AL_lobbyists	,'AL_lobbyists'	,lobby_registration_date	,lobby_registration_date	,AL_lobbyists_coverage	,true);
ut.macGetCoverageDates(VA_lobbyists	,'VA_lobbyists'	,lobby_registration_date	,lobby_registration_date	,VA_lobbyists_coverage	,true);
ut.macGetCoverageDates(UT_lobbyists	,'UT_lobbyists'	,lobby_registration_date	,lobby_registration_date	,UT_lobbyists_coverage	,true);
ut.macGetCoverageDates(RI_lobbyists	,'RI_lobbyists'	,lobby_registration_date	,lobby_registration_date	,RI_lobbyists_coverage	,true);
ut.macGetCoverageDates(GA_lobbyists	,'GA_lobbyists'	,lobby_registration_date	,lobby_registration_date	,GA_lobbyists_coverage	,true);
ut.macGetCoverageDates(VT_lobbyists	,'VT_lobbyists'	,lobby_registration_date	,lobby_registration_date	,VT_lobbyists_coverage	,true);
ut.macGetCoverageDates(FL_lobbyists	,'FL_lobbyists'	,lobby_registration_date	,lobby_registration_date	,FL_lobbyists_coverage	,true);
ut.macGetCoverageDates(IA_lobbyists	,'IA_lobbyists'	,lobby_registration_date	,lobby_registration_date	,IA_lobbyists_coverage	,true);
ut.macGetCoverageDates(ID_lobbyists	,'ID_lobbyists'	,lobby_registration_date	,lobby_registration_date	,ID_lobbyists_coverage	,true);
ut.macGetCoverageDates(IN_lobbyists	,'IN_lobbyists'	,lobby_registration_date	,lobby_registration_date	,IN_lobbyists_coverage	,true);
ut.macGetCoverageDates(HI_lobbyists	,'HI_lobbyists'	,lobby_registration_date	,lobby_registration_date	,HI_lobbyists_coverage	,true);
ut.macGetCoverageDates(NC_lobbyists	,'NC_lobbyists'	,lobby_registration_date	,lobby_registration_date	,NC_lobbyists_coverage	,true);
ut.macGetCoverageDates(MT_lobbyists	,'MT_lobbyists'	,lobby_registration_date	,lobby_registration_date	,MT_lobbyists_coverage	,true);
ut.macGetCoverageDates(MS_lobbyists	,'MS_lobbyists'	,lobby_registration_date	,lobby_registration_date	,MS_lobbyists_coverage	,true);
ut.macGetCoverageDates(ND_lobbyists	,'ND_lobbyists'	,lobby_registration_date	,lobby_registration_date	,ND_lobbyists_coverage	,true);
                                                                                                  

all_coverage := 
		wither_mnliq_coverage		
	+ wither_txliq_coverage	
	+ wither_nhlott_coverage	
	+ wither_caliq_coverage	
	+ wither_waliq_coverage	
	+ wither_nblott_coverage	
	+ wither_orlott_coverage	
	+ wither_paliq_coverage	
	+ wither_njliq_coverage	
	+ wither_azliq_coverage	
	+ wither_nyliq_coverage	
	+ wither_usgame_coverage	
	+ wither_flswps_coverage	
	+ wither_nylott_coverage	
	+ wither_nbgame_coverage	
	+ wither_akbiz_coverage	
	+ wither_coliq_coverage	
	+ wither_ohliq_coverage	
	+ wither_txlott_coverage	
	+ wither_valiq_coverage	
	+ wither_ohlott_coverage	
	+ caliq_coverage	
	+ ohliq_coverage		
	+ paliq_coverage	
	+ txliq_coverage	
	+ fdic_coverage		
	+ CO_STATE_EMPLOYEES_coverage								
	+ US_DOI_EMPLOYEES_coverage									
	+ TX_MIDLAND_COUNTY_EMPLOYEES_coverage				
	+ AR_STATE_EMPLOYEES_coverage								
	+ US_DOS_EMPLOYEES_coverage										
	+ AK_STATE_EMPLOYEES_coverage									
	+ KS_STATE_EMPLOYEES_coverage									
	+ NV_STATE_EMPLOYEES_coverage									
	+ MD_STATE_EMPLOYEES_coverage								
	+ NE_CONNECTING_POINT_EMPLOYEES_coverage			
	+ ND_STATE_EMPLOYEES_coverage								
	+ VA_STATE_EMPLOYEES_coverage									
	+ US_US_DEPT_OF_ST_BUREAU_OF_ADMIN_coverage	
	+ DC_PREFERRED_LENDERS_coverage								
	+ MO_STATE_EMPLOYEES_coverage								
	+ WV_STATE_EMPLOYEES_coverage									
	+ IL_STATE_EMPLOYEES_coverage								
	+ SC_STATE_EMPLOYEES_coverage								
	+ MD_People_At_Work_coverage										
	+ OR_STATE_EMPLOYEES_coverage									
	+ NH_STATE_EMPLOYEES_coverage								
	+ ID_STATE_EMPLOYEES_coverage								
	+ CA_CHICO_CITY_EMPLOYEES_coverage						
	+ TX_STATE_EMPLOYEES_coverage								
	+ UT_STATE_EMPLOYEES_coverage									
	+ US_ED_EMPLOYEES_coverage											
	+ US_EPA_EMPLOYEES_coverage										
	+ GA_STATE_EMPLOYEES_coverage									
	+ SD_STATE_EMPLOYEES_coverage								
	+ MS_STATE_EMPLOYEES_coverage								
	+ IN_STATE_EMPLOYEES_coverage								
	+ PA_STATE_EMPLOYEES_coverage									
	+ OH_STATE_EMPLOYEES_coverage								
	+ US_US_FISH_AND_WILDLIFE_EMPLOYEES_coverage		
	+ AL_DIR_EMPLOYEES_coverage									
	+ CA_STATE_EMPLOYEES_coverage									
	+ DC_CRC_INSURANCE_EMPLOYEES_coverage				
	+ FL_STATE_EMPLOYEES_coverage								
	+ NY_STATE_EMPLOYEES_coverage									
	+ NC_STATE_EMPLOYEES_coverage									
	+ CA_CITY_OF_OAKLAND_EMPLOYEES_coverage			
	+ US_USDA_EMPLOYEES_coverage									
	+ US_DOE_EMPLOYEES_coverage									
	+ KY_STATE_EMPLOYEES_coverage								
	+ US_FEMA_EMPLOYEES_coverage										
	+ CT_STATE_EMPLOYEES_coverage									
	+ NJ_STATE_EMPLOYEES_coverage									
	+ DC_DOL_EMPLOYEES_coverage										
	+ WI_STATE_EMPLOYEES_coverage								
	+ AR_BAXTER_COUNTY_EMPLOYEES_coverage				
	+ MN_STATE_EMPLOYEES_coverage								
	+ NJ_lobbyists_coverage
	+ NH_lobbyists_coverage
	+ ME_lobbyists_coverage	
	+ NV_lobbyists_coverage
	+ MA_lobbyists_coverage	
	+ MN_lobbyists_coverage
	+ MO_lobbyists_coverage
	+ NY_lobbyists_coverage	
	+ MI_lobbyists_coverage	
	+ KY_lobbyists_coverage
	+ LA_lobbyists_coverage
	+ OR_lobbyists_coverage
	+ KS_lobbyists_coverage
	+ OH_lobbyists_coverage	
	+ DC_lobbyists_coverage	
	+ OK_lobbyists_coverage	
	+ WY_lobbyists_coverage	
	+ TX_lobbyists_coverage
	+ CA_lobbyists_coverage
	+ CO_lobbyists_coverage
	+ WV_lobbyists_coverage	
	+ AZ_lobbyists_coverage
	+ TN_lobbyists_coverage	
	+ SD_lobbyists_coverage
	+ AR_lobbyists_coverage	
	+ AK_lobbyists_coverage
	+ AL_lobbyists_coverage
	+ VA_lobbyists_coverage	
	+ UT_lobbyists_coverage	
	+ RI_lobbyists_coverage
	+ GA_lobbyists_coverage
	+ VT_lobbyists_coverage
	+ FL_lobbyists_coverage
	+ IA_lobbyists_coverage	
	+ ID_lobbyists_coverage	
	+ IN_lobbyists_coverage	
	+ HI_lobbyists_coverage	
	+ NC_lobbyists_coverage
	+ MT_lobbyists_coverage
	+ MS_lobbyists_coverage
	+ ND_lobbyists_coverage	
	;

output(all_coverage, all);