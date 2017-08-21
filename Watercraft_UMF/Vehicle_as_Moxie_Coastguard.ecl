import Lib_Stringlib, Watercraft;

string fFeetFromInches(string pValue)
 :=
  if((integer)pValue <> 0,
	 (string)(integer)((integer)pValue / 12),
	 ''
	)
 ;

Watercraft.Layout_Watercraft_Coastguard_Base tVehicleToCoastguard(Watercraft_UMF.File_In_Watercraft pInput)
 :=
  transform
	self.watercraft_key											:=	Watercraft_UMF.fConstruct_Watercraft_Key(pInput.GROUP_KEY,pInput.boat_HULL_ID);
	self.sequence_key											:=	Watercraft_UMF.fConstruct_Sequence_Key(pInput.GROUP_KEY);
	self.state_origin											:=	pInput.STATE_ORIGIN;
	self.source_code											:=	'AW';
	self.vessel_id												:=	pInput.boat_VESSEL_ID;
	self.vessel_database_key									:=	pInput.boat_VESSEL_DBASE_KEY;
	self.name_of_vessel											:=	pInput.boat_VESSEL_NAME;
	self.call_sign												:=	pInput.callsign_CALLSIGN;
	self.official_number										:=	pInput.boat_CGID;
	self.imo_number												:=	pInput.boat_IMO_NBR;
	self.hull_number											:=	pInput.boat_HULL_ID2;
	self.hull_identification_number								:=	pInput.boat_HULL_ID;
	self.vessel_service_type									:=	pInput.boat_VEHICLE_USE;
	self.flag													:=	'';
	self.self_propelled_indicator								:=	''; 		//** if propulsion type is NOT sail **
	self.registered_gross_tons									:=	pInput.boat_REG_GROSS_TONS;
	self.registered_net_tons									:=	pInput.boat_REG_NET_TONS;
	self.registered_length										:=	fFeetFromInches(pInput.vehicle_LENGTH);
	self.registered_breadth										:=	fFeetFromInches(pInput.boat_REG_BREADTH);
	self.registered_depth										:=	fFeetFromInches(pInput.boat_REG_DEPTH);
	self.itc_gross_tons											:=	pInput.boat_ITC_GROSS_TONS;
	self.itc_net_tons											:=	pInput.boat_ITC_NET_TONS;
	self.itc_length												:=	fFeetFromInches(pInput.boat_ITC_LENGTH);
	self.itc_breadth											:=	fFeetFromInches(pInput.boat_ITC_BREADTH);
	self.itc_depth												:=	fFeetFromInches(pInput.boat_ITC_DEPTH);
	self.hailing_port											:=	pInput.boat_HAILINGPORT_ADDR;
	self.hailing_port_state										:=	'';
	self.hailing_port_province									:=	'';
	self.home_port_name											:=	'';
	self.home_port_state										:=	'';
	self.home_port_province										:=	'';
	self.trade_ind_coastwise_unrestricted						:=	'';
	self.trade_ind_limited_coastwise_bowaters_only				:=	'';
	self.trade_ind_limited_coastwise_restricted					:=	'';
	self.trade_ind_limited_coastwise_oil_spill_response_only	:=	'';
	self.trade_ind_limited_coastwise_under_charter_to_citizen	:=	'';
	self.trade_ind_fishery										:=	'';
	self.trade_ind_limited_fishery_only							:=	'';
	self.trade_ind_recreation									:=	'';
	self.trade_ind_limited_recreation_great_lakes_use_only		:=	'';
	self.trade_ind_registry										:=	'';
	self.trade_ind_limited_registry_cross_border_financing		:=	'';
	self.trade_ind_limited_registry_no_foreign_voyage			:=	'';
	self.trade_ind_limited_registry_trade_with_canada_only		:=	'';
	self.trade_ind_great_lakes									:=	'';
	self.vessel_complete_build_city								:=	pInput.boat_VESSEL_COMP_PLACE;
	self.vessel_complete_build_state							:=	'';
	self.vessel_complete_build_province							:=	'';
	self.vessel_complete_build_country							:=	'';
	self.vessel_build_year										:=	'';
	self.vessel_hull_build_city									:=	'';
	self.vessel_hull_build_state								:=	'';
	self.vessel_hull_build_province								:=	'';
	self.vessel_hull_build_country								:=	'';
	self.party_identification_number							:=	pInput.boat_PARTY_IDENT_NBR;
	self.main_hp_ahead											:=	pInput.boat_HP_AHEAD;
	self.main_hp_astern											:=	pInput.boat_HP_ASTERN;
	self.propulsion_type										:=	pInput.boat_PROPULSION;
	self.hull_material											:=	pInput.boat_HULL_TYPE;
	self.ship_yard												:=	'';
	self.hull_builder_name										:=	'';
	self.doc_certificate_status									:=	'';
	self.date_issued											:=	'';
	self.date_expires											:=	'';
	self.hull_design_type										:=	'';
	self.sail_ind												:=	''; 		//** if propulsion type is sail **
	self.party_database_key										:=	'';
	self.itc_tons_cod_ind										:=	'';
  end
 ;

dCGVehiclesDistributed	:= distribute(Watercraft_UMF.File_In_Watercraft(boat_CGID<>'' or boat_IMO_NBR<>'' or boat_ITC_GROSS_TONS<>'' or boat_ITC_NET_TONS<>'' or callsign_CALLSIGN<>''),hash(STATE_ORIGIN,GROUP_KEY));
dCGVehiclesSorted		:= sort(dCGVehiclesDistributed,STATE_ORIGIN,GROUP_KEY,local);
dCGVehiclesDedup		:= dedup(dCGVehiclesSorted,STATE_ORIGIN,GROUP_KEY,local);

export Vehicle_as_Moxie_Coastguard := project(dCGVehiclesDedup,tVehicleToCoastguard(left));
