import SANCTN, lib_stringlib;

export layout_SANCTN_incident_clean := record
	SANCTN.layout_SANCTN_incident_in;
	string255  incident_text := '';
	string8    incident_date_clean := '';
	string8    fcr_date_clean := '';
	string8    cln_modified_date := '';
  string8		 cln_load_date := '';
  end;