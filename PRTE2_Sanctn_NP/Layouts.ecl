import prte2_sanctn_np, prte_csv, bipv2, sanctn_mari;

EXPORT Layouts := module

	export rKeySanctn__key__sanctn__np__autokey__address	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__address;
	END;

	export rKeySanctn__key__sanctn__np__autokey__addressb2	:=
	record
	PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__addressb2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__citystname	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__citystname;
	END;

	export rKeySanctn__key__sanctn__np__autokey__citystnameb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__citystnameb2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__fein2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__fein2;
	END;

	rKeySanctn__key__sanctn__np__autokey__name	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__name;
	END;

	export rKeySanctn__key__sanctn__np__autokey__nameb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__nameb2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__namewords2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__namewords2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__payload	:=
	record
	PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__payload;
	END;

	export rKeySanctn__key__sanctn__np__autokey__phone2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__phone2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__phoneb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__phoneb2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__ssn2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__ssn2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__stname	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__stname;
	END;

	export rKeySanctn__key__sanctn__np__autokey__stnameb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__stnameb2;
	END;

	export rKeySanctn__key__sanctn__np__autokey__zip	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__zip;
	END;

	export rKeySanctn__key__sanctn__np__autokey__zipb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__zipb2;
	END;

	export rKeySanctn__key__sanctn__np__bdid	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__bdid;
	END;

	export rKeySanctn__key__sanctn__np__did	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__did;
	END;

	// export rKeySanctn__key__sanctn__np__incident	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__incident;
	// END;

		
	// export rKeySanctn__key__sanctn__np__incidentcode	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__incidentcode;
	//	END;
	
	export IncidentCode_Base := record
			sanctn_mari.layouts_SANCTN_common.Midex_cd;
	end;		

	export Incident_Base := record
		sanctn_mari.layouts_SANCTN_common.SANCTN_incident_base;
	end;	
	
	// export rKeySanctn__key__sanctn__np__incidenttext	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__incidenttext;
	// END;
	
	export IncidentText_Key := record, MAXLENGTH(9000)
		sanctn_mari.layouts_SANCTN_common.SANCTN_incident_text;
	end;
		

	// export rKeySanctn__key__sanctn__np__license_midex	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__license_midex;
	// END;


// Licnese MIDEX Key
	export License_Midex_Key := record
		STRING8		BATCH;
		STRING1	 	DBCODE;
		STRING8		INCIDENT_NUM;
		STRING7		PARTY_NUM;
		STRING20	FIELD_NAME;
		STRING20	LICENSE_TYPE;
		STRING20	CODE_VALUE;
		STRING2		LICENSE_STATE;
		STRING500	OTHER_DESC;
		STRING80  STD_TYPE_DESC;   	
		STRING20	CLN_LICENSE_NUMBER;
		STRING26 	MIDEX_RPT_NBR;
end;
	
	export Party_Midex_Key := record
		SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_srch;
		string26 midex_rpt_nbr;
		BIPV2.IDlayouts.l_xlink_ids;
	end;


	// export rKeySanctn__key__sanctn__np__license_nbr	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__license_nbr;
	// END;
// License NBR Key
	export License_Key := record
		files.sample_incidentcode.BATCH;
		files.sample_incidentcode.INCIDENT_NUM;
		STRING7 	PARTY_NUM;
		STRING20 LICENSE_NBR;
		STRING2  LICENSE_STATE;
		STRING80 LICENSE_TYPE;
		files.sample_incidentcode.CLN_LICENSE_NUMBER;
end;



	// export rKeySanctn__key__sanctn__np__midex_rpt_nbr	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__midex_rpt_nbr_new;
		
	// END;
	
	
	// export rKeySanctn__key__sanctn__np__nmls_id	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__nmls_id;
	// END;

	// NMLS ID Key
	export NMLS_ID_key := record
		files.sample_incidentcode.BATCH;
		files.sample_incidentcode.INCIDENT_NUM;
		STRING7 	PARTY_NUM;
		STRING2  	LICENSE_STATE;
		STRING80 	LICENSE_TYPE;
		STRING20 	NMLS_ID;
		STRING26 	MIDEX_RPT_NBR;
	end;
	
	
	// export rKeySanctn__key__sanctn__np__nmls_midex	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__nmls_midex;
	// END;
	
	// NMLS MIDEX Key
	export NMLS_MIDEX_Key := record
		STRING8		BATCH;
		STRING1	 	DBCODE;
		STRING8		INCIDENT_NUM;
		STRING7		PARTY_NUM;
		STRING20	FIELD_NAME;
		STRING20	LICENSE_TYPE;
		STRING20	CODE_VALUE;
		STRING2		LICENSE_STATE;
		STRING500	OTHER_DESC;
		STRING80  STD_TYPE_DESC;   	
		STRING20	NMLS_ID;
		STRING26 	MIDEX_RPT_NBR;
end;

	// export rKeySanctn__key__sanctn__np__party	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__party;
	// END;
	export Party_Key := record
			SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base - enh_did_src;
	end;		
	
	export rKeySanctn__key__sanctn__np__partytext	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__partytext;
	END;

	// export rKeySanctn__key__sanctn__np__ssn4	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__ssn4;
	// END;
	
	export SSN4_key := record
		STRING4 ssn4;
		STRING8 batch;
		STRING8 incident_num;
		STRING7 party_num;
		// UNSIGNED8 __internal_fpos__;
	end;

	// export rKeySanctn__key__sanctn__np__tin	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__tin;
	// END;
	
	export TIN_Key := record
		files.sample_party.TIN;
		files.sample_party.BATCH;
		files.sample_party.INCIDENT_NUM;
		files.sample_party.PARTY_NUM;
	end;



	// export rKeySanctn__key__sanctn__np__party_aka_dba	:=
	// record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__party_aka_dba;
	// END;
	
	// PaRTY AKE Key
	export PARTY_AKA_DBA_Key := record
  SANCTN_Mari.layouts_SANCTN_common.party_aka_dba AND NOT [FIRST_NAME,MIDDLE_NAME,LAST_NAME,PARTY_KEY];
	end;


	export rKeySanctn__key__sanctn__np__linkids_incident	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__linkids_incident;
	END;


	export rKeySanctn__key__sanctn__np__linkids_party	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__linkids_party;
	END;

end;