import SANCTN_Mari, standard;

export layout_NonPublic_incident_clean := record
	SANCTN_Mari.layout_Midex_spray.recIncident;
	string8			batch_date_clean	:= '';
	string8     incident_date_clean := '';
	string8			entry_date_clean	:= '';
	string8     modified_date_clean := '';
	string10		cln_submit_phone := '';
	string10		cln_submit_fax := '';
end;

