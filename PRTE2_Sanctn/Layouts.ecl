import prte_csv, sanctn;

EXPORT Layouts := module

export rKeySanctn__key__sanctn__autokey__address	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__address;
end;

export rKeySanctn__key__sanctn__autokey__addressb2	:=
record
PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__addressb2;
end;

export rKeySanctn__key__sanctn__autokey__citystname	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__citystname;
end;

export rKeySanctn__key__sanctn__autokey__citystnameb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__citystnameb2;
end;

export rKeySanctn__key__sanctn__autokey__name	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__name;
end;

export rKeySanctn__key__sanctn__autokey__nameb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__nameb2;
end;

export rKeySanctn__key__sanctn__autokey__namewords2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__namewords2;
end;

export rKeySanctn__key__sanctn__autokey__payload	:=
record
 PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__payload;

end;

export rKeySanctn__key__sanctn__autokey__ssn2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__ssn2;
end;

export rKeySanctn__key__sanctn__autokey__stname	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__stname;
end;

export rKeySanctn__key__sanctn__autokey__stnameb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__stnameb2;
end;

export rKeySanctn__key__sanctn__autokey__zip	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__zip;
end;

export rKeySanctn__key__sanctn__autokey__zipb2	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__autokey__zipb2;
end;

export rKeySanctn__key__sanctn__bdid	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__bdid;
end;

export rKeySanctn__key__sanctn__did	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__did;
end;

export rKeySanctn__key__sanctn__casenum	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__casenum;
end;

// export rKeySanctn__key__sanctn__incident	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__incident;
// end;

//Incident Key
export Incident_Key := RECORD
  SANCTN.layout_SANCTN_incident_clean AND NOT [PARTY_NUMBER,RECORD_TYPE,MODIFIED_DATE,LOAD_DATE,CLN_MODIFIED_DATE,CLN_LOAD_DATE];
	
END;

// export rKeySanctn__key__sanctn__incident_midex	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__incident_midex;
// end;
export Incident_MIDEX_Key := RECORD
  SANCTN.layout_SANCTN_incident_clean AND NOT [RECORD_TYPE];
END;


// export rKeySanctn__key__sanctn__license_midex	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__license_midex;
// end;

//License Midex
export  License_Midex_Key := RECORD
	SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE];
	string26 midex_rpt_nbr;
END;

// export rKeySanctn__key__sanctn__license_nbr	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__license_nbr;
// end;

//License Key
export License_Key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE];
END;

// export rKeySanctn__key__sanctn__midex_rpt_nbr	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__midex_rpt_nbr_new
// end;

//MIDEX_RPT_NBR Key
export Party_Midex_Key := RECORD
	SANCTN.layout_SANCTN_did AND NOT [RECORD_TYPE, SOURCE_REC_ID, enh_did_src];
	string26 midex_rpt_nbr;
END;


// export rKeySanctn__key__sanctn__nmls_id	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__nmls_id;
// end;

export NMLS_ID_Key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
	STRING20 		NMLS_ID;
	STRING26 		MIDEX_RPT_NBR;
END;


// export rKeySanctn__key__sanctn__nmls_midex	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__nmls_midex;
// end;

export NMLS_MIDEX_KEY := RECORD
 SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
	STRING26 		midex_rpt_nbr;
	STRING20 		NMLS_ID;
END;


export rKeySanctn__key__sanctn__party	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__party;
end;

// export rKeySanctn__key__sanctn__rebuttal	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__rebuttal;
// end;

//Rebuttal Key
export Rebuttal_Key := RECORD
  SANCTN.layout_SANCTN_rebuttal_in AND NOT [RECORD_TYPE];
END;


export rKeySanctn__key__sanctn__ssn4	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__ssn4;
end;

// export rKeySanctn__key__sanctn__party_aka_dba	:=
// record
	// PRTE_CSV.Sanctn.rthor_data400__key__sanctn__party_aka_dba;
// end;

//Party AKA/DBA Key
export AKA_DBA_Key := RECORD
  SANCTN.layout_SANCTN_aka_dba_in AND NOT [RECORD_TYPE,LAST_NAME,FIRST_NAME,MIDDLE_NAME];
END;


export rKeySanctn__key__sanctn__linkids	:=
record
	PRTE_CSV.Sanctn.rthor_data400__key__sanctn__linkids;
end;

end;