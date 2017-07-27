export layout_corp2_search_rollup := record
	string30 corp_key; 
	string32  corp_orig_sos_charter_nbr;
	string32  corp_sos_charter_nbr; 
	string2	  corp_state_origin;
	string25 corp_state_origin_decoded;

dataset(corp2_services.layout_contact_search) contacts{maxcount(50)};
dataset(corp2_services.layout_corp_search) corp_hist{maxcount(50)};
end;
