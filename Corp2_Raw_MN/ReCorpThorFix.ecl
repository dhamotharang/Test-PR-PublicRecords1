import corp2, corp2_mapping, ut;

#workunit('protect',true);
#workunit('name', 'Yogurt:Corp2 thor patches ');
#workunit('priority','high');
#workunit('priority',12);
#option ('activitiesPerCpp', 50);

pversion		 		:=	'20160520'; //new version of data

state_origin		:= 'MN';
state_fips	 		:= '27';	
state_desc	 		:= 'MINNESOTA';


dsCurrentCorp		:=	distribute(dataset('~thor_data400::base::corp2::20160603f::corp_xtnd',	corp2.layout_corporate_direct_corp_base_expanded, flat)(corp_state_origin=state_origin),hash(corp_key));
dsCurrentCont 	:=	distribute(dataset('~thor_data400::base::corp2::20160603f::cont_xtnd',	corp2.layout_corporate_direct_cont_base_expanded, flat)(corp_state_origin=state_origin),hash(corp_key));
dsCurrentAR			:=	distribute(dataset('~thor_data400::base::corp2::20160603f::ar_xtnd',		corp2.layout_corporate_direct_ar_base_expanded, flat)(corp_state_origin=state_origin),hash(corp_key));
dsCurrentEvent	:=	distribute(dataset('~thor_data400::base::corp2::20160603f::event_xtnd',	corp2.layout_corporate_direct_event_base_expanded, flat)(corp_state_origin=state_origin),hash(corp_key));
dsCurrentStock	:=	distribute(dataset('~thor_data400::base::corp2::20160603f::stock_xtnd',	corp2.layout_corporate_direct_stock_base_expanded, flat)(corp_state_origin=state_origin),hash(corp_key));

TheRestOfCorp		:=	distribute(dataset('~thor_data400::base::corp2::20160603f::corp_xtnd',	corp2.layout_corporate_direct_corp_base_expanded, flat)(corp_state_origin<>state_origin),hash(corp_key));
TheRestOfCont 	:=	distribute(dataset('~thor_data400::base::corp2::20160603f::cont_xtnd',	corp2.layout_corporate_direct_cont_base_expanded, flat)(corp_state_origin<>state_origin),hash(corp_key));
TheRestOfAR			:=	distribute(dataset('~thor_data400::base::corp2::20160603f::ar_xtnd',		corp2.layout_corporate_direct_ar_base_expanded, flat)(corp_state_origin<>state_origin),hash(corp_key));
TheRestOfEvent	:=	distribute(dataset('~thor_data400::base::corp2::20160603f::event_xtnd',	corp2.layout_corporate_direct_event_base_expanded, flat)(corp_state_origin<>state_origin),hash(corp_key));
TheRestOfStock	:=	distribute(dataset('~thor_data400::base::corp2::20160603f::stock_xtnd',	corp2.layout_corporate_direct_stock_base_expanded, flat)(corp_state_origin<>state_origin),hash(corp_key));

dsMainCorp			:=	distribute(dataset('~thor_data400::in::corp2::20160420::main_mn',		Corp2_Mapping.LayoutsCommon.main, flat)(recordorigin='C'),hash(corp_key));
dsMainCont			:=	distribute(dataset('~thor_data400::in::corp2::20160420::main_mn',		Corp2_Mapping.LayoutsCommon.main, flat)(recordorigin='T'),hash(corp_key));
dsAR						:=	distribute(dataset('~thor_data400::in::corp2::20160420::ar_mn',			Corp2_Mapping.LayoutsCommon.ar, flat),hash(corp_key));
dsEvent					:=	distribute(dataset('~thor_data400::in::corp2::20160420::event_mn',	Corp2_Mapping.LayoutsCommon.events, flat),hash(corp_key));
dsStock					:=	distribute(dataset('~thor_data400::in::corp2::20160420::stock_mn',	Corp2_Mapping.LayoutsCommon.stock, flat),hash(corp_key));

//---------------------------------------------
//CORP
//---------------------------------------------
output(dsCurrentCorp,,named('dsCurrentCorp'));
output(dsMainCorp,,named('dsMainCorp'));
output(count(TheRestOfCorp),named('cnt_TheRestOfCorp'));	// sanity check count
output(count(dsCurrentCorp),named('cnt_dsCurrentCorp'));	// sanity check count
output(count(dsMainCorp),named('cnt_dsMainCorp'));				// sanity check count

KeyNotInCorpUpdate		:=	JOIN(	dsCurrentCorp, dsMainCorp,
																corp2.t2u(LEFT.corp_key) = corp2.t2u(RIGHT.corp_key),
																TRANSFORM(Corp2.Layout_Corporate_Direct_corp_base_expanded,
																					SELF 					:= 	LEFT;
																					),
																Left Only, 
																LOCAL);

CorpToFix							:=	sort(	KeyNotInCorpUpdate,corp_key,local);								
uniqueCorpKeys				:=	dedup(sort(	KeyNotInCorpUpdate,corp_key,local),corp_key,local);												
output(count(uniqueCorpKeys),named('cnt_uniqueCorp2Keys'));			// sanity check count

output(CorpToFix,,named('CorpToFix'));
output(count(CorpToFix),named('cnt_CorpToFix'));			// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.Layout_Corporate_Direct_Corp_Base_Expanded trfCorpFields(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded Input)	:=	transform
			self.corp_ln_name_type_cd        := map(input.corp_ln_name_type_desc = 'LEGAL' 					=> '01',
																							input.corp_ln_name_type_desc = 'TRADEMARK' 			=> '03',
																							input.corp_ln_name_type_desc = 'ASSUMED NAME' 	=> '06',
																							input.corp_ln_name_type_desc = 'RESERVED' 			=> '07',
																							input.corp_ln_name_type_desc = '' and input.corp_orig_org_structure_desc = 'RESERVED NAME' => '07',
																							input.corp_ln_name_type_cd
																							);
			self.corp_ln_name_type_desc      := map(input.corp_ln_name_type_desc = 'LEGAL' 					=> 'LEGAL',
																							input.corp_ln_name_type_desc = 'TRADEMARK' 			=> 'TRADEMARK',
																							input.corp_ln_name_type_desc = 'ASSUMED NAME' 	=> 'ASSUMED NAME',
																							input.corp_ln_name_type_desc = 'RESERVED' 			=> 'RESERVED',
																							input.corp_ln_name_type_desc = '' and input.corp_orig_org_structure_desc = 'RESERVED NAME' => 'RESERVED',
																							input.corp_ln_name_type_cd
																							);
			self.corp_foreign_domestic_ind	 := map(corp2.t2u(input.corp_orig_org_structure_cd) in ['DC','DCI','LLC','41','44','48','50','66','104']						 =>'D',
																							corp2.t2u(input.corp_orig_org_structure_cd) in ['FC','FCI','LFC','FLI','NLP','NLI','42','43','46','49','52'] =>'F',
																							corp2.t2u(input.corp_foreign_domestic_ind)
																						 );
			self.corp_for_profit_ind       	 := map(corp2.t2u(input.corp_orig_org_structure_desc) in ['NON-PROFIT CORPORATION'] 				 	=> 'N',
																							corp2.t2u(input.corp_orig_org_structure_desc) in ['NONPROFIT CORPORATION (FOREIGN)'] 	=> 'N',
																							corp2.t2u(input.corp_orig_org_structure_desc) in ['NONPROFIT CORPORATION (DOMESTIC)'] => 'N',
																							corp2.t2u(input.corp_orig_org_structure_cd)   in ['41','42','NPI','NP'] 							=> 'N',
																							corp2.t2u(input.corp_for_profit_ind)
																						 );
			self.corp_standing	           	 := map(corp2.t2u(input.corp_status_desc) 		in ['ACTIVE'] 																				 => 'Y',
																							corp2.t2u(input.corp_status_desc) not in ['ACTIVE'] and corp2.t2u(input.corp_standing) = 'Y' => '',
																							corp2.t2u(input.corp_standing)
																						 );
			//Per Rosemary, not to worry about corp_address1_type_cd/desc for "MARKHOLDER"/"EXECUTIVE OFFICES", etc.
			self.corp_addl_info           	 := corp2.t2u(input.corp_addl_info);
			self.corp_orig_org_structure_cd  := if (corp2.t2u(input.corp_orig_org_structure_cd) in ['RN','RNI','03'],'',corp2.t2u(input.corp_orig_org_structure_cd));
			temp_orig_org_structure_desc		 := if (corp2.t2u(input.corp_orig_org_structure_cd) in ['RN','RNI','03'],'',corp2.t2u(input.corp_orig_org_structure_desc));
			self.corp_orig_org_structure_desc:= case(corp2.t2u(temp_orig_org_structure_desc),
																							 'DOMESTIC LIMITED LIABILITY COMPANY' => 'LIMITED LIABILITY COMPANY (DOMESTIC)',
																							 'FOREIGN LIMITED LIABILITY COMPANY' 	=> 'LIMITED LIABILITY COMPANY (FOREIGN)',
																							 'FOREIGN LIMITED PARTNERSHIP' 				=> 'LIMITED PARTNERSHIP (FOREIGN)',
																							 corp2.t2u(temp_orig_org_structure_desc)
																							);
			self.corp_forgn_state_cd     		 := if (corp2.t2u(input.corp_forgn_state_cd) = '' and corp2.t2u(input.corp_forgn_state_desc)<>'',
																							corp2_raw_mn.functions.state_codes(input.corp_forgn_state_desc),
																							corp2.t2u(input.corp_forgn_state_cd)
																							);
			self.corp_status_cd          	 	 := '';
    self							               	 :=	input;
end;

CorpFixed	:=	project(CorpToFix, trfCorpFields(left));

output(CorpFixed,,named('CorpFixed'));
output(count(CorpFixed),named('cnt_CorpFixed'));

NewCorpBase := CorpFixed + TheRestOfCorp;

output(NewCorpBase,,named('NewCorpBase'));
output(count(NewCorpBase),named('cnt_NewCorpBase'));

//---------------------------------------------
//CONT
//---------------------------------------------
output(dsCurrentCont,,named('dsCurrentCont'));
output(dsMainCont,,named('dsMainCont'));
output(count(TheRestOfCont),named('cnt_TheRestOfCont'));	// sanity check count
output(count(dsCurrentCont),named('cnt_dsCurrentCont'));	// sanity check count
output(count(dsMainCont),named('cnt_dsMainCont'));				// sanity check count


KeyNotInContUpdate		:=	JOIN(	dsCurrentCont, dsMainCont,
																corp2.t2u(LEFT.corp_key) = corp2.t2u(RIGHT.corp_key),
																TRANSFORM(Corp2.Layout_Corporate_Direct_cont_base_expanded,
																					SELF 					:= 	LEFT;
																					),
																Left Only, 
																LOCAL);

ContToFix				:=	sort(	KeyNotInContUpdate,corp_key,local);								
uniqueContKeys	:=	dedup(sort(	KeyNotInContUpdate,corp_key,local),corp_key,local);												
output(count(uniqueContKeys),named('cnt_uniqueContKeys'));			// sanity check count

output(ContToFix,,named('ContToFix'));
output(count(ContToFix),named('cnt_ContToFix'));			// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.Layout_Corporate_Direct_cont_base_expanded trfContFields(Corp2.Layout_Corporate_Direct_cont_base_expanded Input)	:=	transform
		self.cont_address_type_cd					 := if(input.cont_address_type_cd = '' and corp2.t2u(input.cont_address_line1+input.cont_address_line2+input.cont_address_line3+input.cont_address_line4)<>'',
																						 'T',
																						 input.cont_address_type_cd
																						 );
		self.cont_address_type_desc				 := if(input.cont_address_type_desc = '' and corp2.t2u(input.cont_address_line1+input.cont_address_line2+input.cont_address_line3+input.cont_address_line4)<>'',
																						 'CONTACT ADDRESS',
																						 input.cont_address_type_desc
																						 );
		self.cont_title_desc							 := if(corp2.t2u(input.cont_title_desc)='',
																						 map(corp2.t2u(input.cont_type_desc)='CHIEF EXECUTIVE OFFICER' =>'CHIEF EXECUTIVE OFFICER',
																								 corp2.t2u(input.cont_type_desc)='NAMEHOLDER'							 =>'NAMEHOLDER',																						 
																								 corp2.t2u(input.cont_title_desc)
																								),
																						 corp2.t2u(input.cont_title_desc)
																						);																						 
		self.cont_type_desc								 := map(corp2.t2u(self.cont_title_desc)='CHIEF EXECUTIVE OFFICER' =>'OFFICER',
																							corp2.t2u(self.cont_title_desc)='NAMEHOLDER'							=>'OWNER',
																							corp2.t2u(input.cont_type_desc)
																						 );
		self.cont_type_cd									 := map(self.cont_type_desc ='OFFICER' => 'F',
																							self.cont_type_desc ='OWNER'	 => 'O',
																							corp2.t2u(input.cont_type_cd)
																						 );																						 																							
    self							               	 :=	input;
end;

ContFixed	:=	project(ContToFix, trfContFields(left));

output(ContFixed,,named('ContFixed'));
output(count(ContFixed),named('cnt_ContFixed'));

NewContBase := ContFixed + TheRestOfCont;

output(NewContBase,,named('NewContBase'));
output(count(NewContBase),named('cnt_NewContBase'));

//---------------------------------------------
//AR
//---------------------------------------------
output(dsCurrentAR,named('dsCurrentAR'));
output(dsAR,named('dsAR'));
output(count(TheRestOfAR),named('cnt_TheRestOfAR'));	// sanity check count
output(count(dsCurrentAR),named('cnt_dsCurrentAR'));	// sanity check count
output(count(dsAR),named('cnt_dsAR'));				// sanity check count


KeyNotInARUpdate	:=	JOIN(	dsCurrentAR, dsAR,
																corp2.t2u(LEFT.corp_key) = corp2.t2u(RIGHT.corp_key),
																TRANSFORM(Corp2.layout_corporate_direct_ar_base_expanded,
																					SELF 					:= 	LEFT;
																					),
																Left Only, 
																LOCAL);

ARToFix					:=	sort(	KeyNotInARUpdate,corp_key,local);								
uniqueARKeys		:=	dedup(sort(	KeyNotInARUpdate,corp_key,local),corp_key,local);												
output(count(uniqueARKeys),named('cnt_uniqueARKeys'));			// sanity check count

output(ARToFix,,named('ARToFix'));
output(count(ARToFix),named('cnt_ARToFix'));			// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.layout_corporate_direct_ar_base_expanded trfARFields(Corp2.layout_corporate_direct_ar_base_expanded Input)	:=	transform
    self							               	 :=	input;
end;

ARFixed	:=	project(ARToFix, trfARFields(left));

output(ARFixed,,named('ARFixed'));
output(count(ARFixed),named('cnt_ARFixed'));

NewARBase := ARFixed + TheRestOfAR;

output(NewARBase,named('NewARBase'));
output(count(NewARBase),named('cnt_NewARBase'));

//---------------------------------------------
//Events
//---------------------------------------------
output(dsCurrentEvent,,named('dsCurrentEvent'));
output(dsEvent,named('dsEvent'));
output(count(TheRestOfEvent),named('cnt_TheRestOfEvent'));	// sanity check count
output(count(dsCurrentEvent),named('cnt_dsCurrentEvent'));	// sanity check count
output(count(dsEvent),named('cnt_dsEvent'));				// sanity check count

KeyNotInEventUpdate	:=	JOIN(dsCurrentEvent, dsEvent,
														 corp2.t2u(LEFT.corp_key) = corp2.t2u(RIGHT.corp_key),
														 TRANSFORM(Corp2.layout_corporate_direct_event_base_expanded,
															 				 SELF 					:= 	LEFT;
																			),
														 Left Only, 
														 LOCAL);

EventsToFix					:=	sort(KeyNotInEventUpdate,corp_key,local);								
uniqueEventsKeys		:=	dedup(sort(KeyNotInEventUpdate,corp_key,local),corp_key,local);												
output(count(uniqueEventsKeys),named('cnt_uniqueEventsKeys'));			// sanity check count

output(EventsToFix,named('EventsToFix'));
output(count(EventsToFix),named('cnt_EventsToFix'));			// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.layout_corporate_direct_event_base_expanded trfEventsFields(Corp2.layout_corporate_direct_event_base_expanded Input)	:=	transform
    self							               	 :=	input;
end;

EventsFixed		:=	project(EventsToFix, trfEventsFields(left));

output(EventsFixed,named('EventsFixed'));
output(count(EventsFixed),named('cnt_EventsFixed'));

NewEventsBase := EventsFixed + TheRestOfEvent;

output(NewEventsBase,,named('NewEventsBase'));
output(count(NewEventsBase),named('cnt_NewEventsBase'));


//---------------------------------------------
//Stock
//---------------------------------------------
output(dsCurrentStock,,named('dsCurrentStock'));
output(dsStock,named('dsStock'));
output(count(TheRestOfStock),named('cnt_TheRestOfStock'));	// sanity check count
output(count(dsCurrentStock),named('cnt_dsCurrentStock'));	// sanity check count
output(count(dsStock),named('cnt_dsStock'));				// sanity check count

KeyNotInStockUpdate	:=	JOIN(dsCurrentStock, dsStock,
														 corp2.t2u(LEFT.corp_key) = corp2.t2u(RIGHT.corp_key),
														 TRANSFORM(Corp2.layout_corporate_direct_stock_base_expanded,
															 				 SELF 					:= 	LEFT;
																			),
														 Left Only, 
														 LOCAL);

StocksToFix					:=	sort(KeyNotInStockUpdate,corp_key,local);								
uniqueStocksKeys		:=	dedup(sort(KeyNotInStockUpdate,corp_key,local),corp_key,local);												
output(count(uniqueStocksKeys),named('cnt_uniqueStocksKeys'));			// sanity check count

output(StocksToFix,named('StocksToFix'));
output(count(StocksToFix),named('cnt_StocksToFix'));			// sanity check count

//--------------------------------------------
// Transform to fix the data
Corp2.layout_corporate_direct_stock_base_expanded trfStocksFields(Corp2.layout_corporate_direct_stock_base_expanded Input)	:=	transform
    self							               	 :=	input;
end;

StocksFixed		:=	project(StocksToFix, trfStocksFields(left));

output(StocksFixed,named('StocksFixed'));
output(count(StocksFixed),named('cnt_StocksFixed'));

NewStocksBase := StocksFixed + TheRestOfStock;

output(NewStocksBase,,named('NewStocksBase'));
output(count(NewStocksBase),named('cnt_NewStocksBase'));
//---------------------------------------------
// output new version of the data, clear superfiles & add to superfiles							
//sequential(	output(NewCorpBase,,	'~thor_data400::base::corp2::' + pversion + '::corp_xtnd',overwrite,__compressed__),						
						// parallel(	FileServices.clearsuperfile('~thor_data400::base::corp2::built::corp_xtnd'),
											// FileServices.clearsuperfile('~thor_data400::base::corp2::qa::corp_xtnd') ),
						// parallel(	Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::corp_xtnd',
																									// '~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	),
											// Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::corp_xtnd',
		    																	// '~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	)	)
					//);		
				
				