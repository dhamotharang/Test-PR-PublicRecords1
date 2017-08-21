import watercraft;


county_reg(string2 code) :=

case(code, 

'01' => 'ADAMS',
'02' => 'ASHLAND',
'03' => 'BARRON',
'04' => 'BAYFIELD',
'05' => 'BROWN',
'06' => 'BUFFALO',
'07' => 'BURNETT',
'08' => 'CALUMET',
'09' => 'CHIPPEWA',
'10' => 'CLARK',
'11' => 'COLUMBIA',
'12' => 'CRAWFORD',
'13' => 'DANE',
'14' => 'DODGE',
'15' => 'DOOR',
'16' => 'DOUGLAS',
'17' => 'DUNN',
'18' => 'EAU CLAIRE',
'19' => 'FLORENCE',
'20' => 'FOND DU LAC',
'21' => 'FOREST',
'22' => 'GRANT',
'23' => 'GREEN',
'24' => 'GREEN LAKE',
'25' => 'IOWA',
'26' => 'IRON',
'27' => 'JACKSON',
'28' => 'JEFFERSON',
'29' => 'JUNEAU',
'30' => 'KENOSHA',
'31' => 'KEWAUNEE',
'32' => 'LA CROSSE',
'33' => 'LAFAYETTE',
'34' => 'LANGLADE',
'35' => 'LINCOLN',
'36' => 'MANITOWOC',
'37' => 'MARATHON',
'38' => 'MARINETTE',
'39' => 'MARQUETTE',
'40' => 'MENOMINEE',
'41' => 'MILWAUKEE',
'42' => 'MONROE',
'43' => 'OCONTO',
'44' => 'ONEIDA',
'45' => 'OUTAGAMIE',
'46' => 'OZAUKEE',
'47' => 'PEPIN',
'48' => 'PIERCE',
'49' => 'POLK',
'50' => 'PORTAGE',
'51' => 'PRICE',
'52' => 'RACINE',
'53' => 'RICHLAND',
'54' => 'ROCK',
'55' => 'RUSK',
'56' => 'ST CROIX',
'57' => 'SAUK',
'58' => 'SAWYER',
'59' => 'SHAWANO',
'60' => 'SHEBOYGAN',
'61' => 'TAYLOR',
'62' => 'TREMPEALEAU',
'63' => 'VERNON',
'64' => 'VILAS',
'65' => 'WALWORTH',
'66' => 'WASHBURN',
'67' => 'WASHINGTON',
'68' => 'WAUKESHA',
'69' => 'WAUPACA',
'70' => 'WAUSHARA',
'71' => 'WINNEBAGO',
'72' => 'WOOD', '');


propulsion_type(string1 code) :=

case(code, 

'1' => 'OUTBOARD',
'2' => 'INBOARD',
'3' => 'INBOARD/STERNDRIVE(I/O)',
'4' => 'AIRBOAT', '');


doc_certificate_status(string1 code) :=

case(code, 

'A' => 'AFFIDAVIT',
'C' => 'CERTIFICATE',
'G' => 'UNKNOWN',
'M' => 'MSO',
'N' => 'NOTARIZED STATEMENT',
'O' => 'OWNER',
'S' => 'SUPPORTING DOCUMENT (I.E. BILL OF SALE)',
'T' => 'TITLE',
'W' => 'WISCONSIN ASSIGNED', '');


Watercraft.Macro_Clean_Hull_ID(watercraft.file_WI_clean_in, watercraft.Layout_WI_clean_in,hull_clean_in)

watercraft.Layout_Watercraft_Coastguard_Base main_mapping_format(hull_clean_in L) := transform


self.watercraft_key					   :=	trim(L.reg_num, left, right);
self.sequence_key				       :=	if(trim(L.reg_date, left, right)<>'',L.reg_DATE,L.LAST_TRANSACTION_DATE);
self.state_origin                      :=  'WI';
self.source_code                       :=  'AW';
self.vessel_id                         :=  '';
self.vessel_database_key               := if(trim(L.FLEETID,left,right)= 'NULL', '', trim(L.FLEETID,left,right));
self.name_of_vessel                    :=  L.BOATNAME;
self.call_sign                         :=  '';
self.official_number                   :=  '';
self.imo_number                        :=  '';
self.hull_number                       :=  '';
self.hull_identification_number        :=  L.HULL_ID;
self.vessel_service_type               :=  L.USE_1;
self.flag                              :=  '';
self.self_propelled_indicator          :=  '';
self.registered_gross_tons             :=  '';
self.registered_net_tons               :=  '';
self.registered_length                 :=  '';
self.registered_breadth                :=  '';
self.registered_depth                  :=  '';
self.itc_gross_tons                    :=  '';
self.itc_net_tons                      :=  '';
self.itc_length                        :=  '';
self.itc_breadth                       :=  '';
self.itc_depth                         :=  '';
self.hailing_port                      :=  '';
self.hailing_port_state                :=  '';
self.hailing_port_province             :=  '';
self.home_port_name                    :=  if(county_reg(L.COUNTY) <> '',county_reg(L.COUNTY) +'COUNTY', '');
self.home_port_state                   :=  '';
self.home_port_province                :=  '';
self.trade_ind_coastwise_unrestricted  :=  '';
self.trade_ind_limited_coastwise_bowaters_only                  :=  '';
self.trade_ind_limited_coastwise_restricted                     :=  '';
self.trade_ind_limited_coastwise_oil_spill_response_only        :=  '';
self.trade_ind_limited_coastwise_under_charter_to_citizen       :=  '';
self.trade_ind_fishery                                          :=  '';
self.trade_ind_limited_fishery_only                             :=  '';
self.trade_ind_recreation                                       :=  '';
self.trade_ind_limited_recreation_great_lakes_use_only          :=  '';
self.trade_ind_registry                                         :=  '';
self.trade_ind_limited_registry_cross_border_financing          :=  '';
self.trade_ind_limited_registry_no_foreign_voyage               :=  '';
self.trade_ind_limited_registry_trade_with_canada_only          :=  '';
self.trade_ind_great_lakes                                      :=  '';
self.vessel_complete_build_city                                 :=  '';
self.vessel_complete_build_state                                :=  '';
self.vessel_complete_build_province                             :=  '';
self.vessel_complete_build_country                              :=  '';
self.vessel_build_year                                          :=  '';
self.vessel_hull_build_city                                     :=  '';
self.vessel_hull_build_state                                    :=  '';
self.vessel_hull_build_province                                 :=  '';
self.vessel_hull_build_country                                  :=  '';
self.party_identification_number                                :=  '';
self.main_hp_ahead                                              :=  '';
self.main_hp_astern                                             :=  '';
self.propulsion_type                                            :=  if(trim(L.ENGINE_TYPE) <> '',propulsion_type(L.ENGINE_TYPE), L.PROP);
self.hull_material                                              :=  '';
self.ship_yard                                                  :=  '';
self.hull_builder_name                                          :=  '';
self.doc_certificate_status                                     :=  doc_certificate_status(L.VERIFIED);
self.date_issued                                                :=  '';
self.date_expires                                               :=  '';
self.hull_design_type                                           :=  '';
self.sail_ind                                                   :=  '';
self.party_database_key                                         :=  '';
self.itc_tons_cod_ind                                           :=  '';

  
end;

export Mapping_WI_as_Coastguard := dedup(project(hull_clean_in, main_mapping_format(left)),all);

