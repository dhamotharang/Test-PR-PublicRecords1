EXPORT SanctnKeyParentFiles := module

import doxie_files, doxie,ut,Data_Services,lib_stringlib;


f_sanctn_party := SANCTN.file_base_party(bdid != 0);

slim_sanctn := record
f_sanctn_party.BDID;
f_sanctn_party.BATCH_NUMBER;
f_sanctn_party.INCIDENT_NUMBER;
f_sanctn_party.PARTY_NUMBER;
end;

export Parentfile_Sanctn_bdid := table(f_sanctn_party,slim_sanctn,BDID,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,few);
//***************************************************************************   //
/*    End of Parent File Sanctn BDID                                  */
//***************************************************************************   //
fin_sanctn := SANCTN.file_base_incident;
//modified according to bug #50821
SANCTN.layout_SANCTN_incident_clean tr(fin_sanctn l) := transform
self.CASE_NUMBER := lib_stringlib.stringlib.StringtoUpperCase(l.CASE_NUMBER);
self := l;
end;

f_sanctn := project(fin_sanctn,tr(LEFT));

slim_sanctn := record
   f_sanctn.CASE_NUMBER;
   f_sanctn.BATCH_NUMBER;
   f_sanctn.INCIDENT_NUMBER;
end;

export Parentfile_Sanctn_casenum := table(f_sanctn,slim_sanctn,CASE_NUMBER,BATCH_NUMBER,INCIDENT_NUMBER,few);
//***************************************************************************   //
/*    End of Parent File Sanctn CASENUM                                */
//***************************************************************************   //



f_sanctn_party := SANCTN.file_base_party(did != 0);

slim_sanctn := record
f_sanctn_party.DID;
f_sanctn_party.BATCH_NUMBER;
f_sanctn_party.INCIDENT_NUMBER;
f_sanctn_party.PARTY_NUMBER;
end;

export Parentfile_Sanctn_did := table(f_sanctn_party,slim_sanctn,DID,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,few);
//***************************************************************************   //
/*    End of Parent File Sanctn CASENUM                                */
//***************************************************************************   //



f_sanctn_party := SANCTN.file_base_party(did != 0);

slim_sanctn := record
f_sanctn_party.DID;
f_sanctn_party.BATCH_NUMBER;
f_sanctn_party.INCIDENT_NUMBER;
f_sanctn_party.PARTY_NUMBER;
end;

export Parentfile_Sanctn_did := table(f_sanctn_party,slim_sanctn,DID,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,few);
//***************************************************************************   //
/*    End of Parent File Sanctn DID                                */
//***************************************************************************   //

f_sanctn_incident := SANCTN.file_base_incident;


layout_SANCTN_incident_key := RECORD
  SANCTN.layout_SANCTN_incident_clean AND NOT [RECORD_TYPE];
END;



/* Mask the SSNs found within the freeform text field */
layout_SANCTN_incident_key tSANCTN_key(f_sanctn_incident L) := transform
   self.incident_text := SANCTN.fMask_SSN(L.incident_text);
   self               := L;
end;

export Parentfile_Sanctn_incident_mindex := project(f_sanctn_incident,tSANCTN_key(LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn INCIDENT MIDEX                        */
//***************************************************************************   //

f_sanctn_incident := SANCTN.file_base_incident;


layout_SANCTN_incident_key := RECORD
  SANCTN.layout_SANCTN_incident_clean AND NOT [PARTY_NUMBER,RECORD_TYPE,MODIFIED_DATE,LOAD_DATE,CLN_MODIFIED_DATE,CLN_LOAD_DATE];
	
END;


/* Mask the SSNs found within the freeform text field */
layout_SANCTN_incident_key tSANCTN_key(f_sanctn_incident L) := transform
   self.incident_text := SANCTN.fMask_SSN(L.incident_text);
   self               := L;
end;

export Parentfile_Sanctn_incident:= project(f_sanctn_incident,tSANCTN_key(LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn INCIDENT                              */
//***************************************************************************   //

f_sanctn_license := SANCTN.file_base_license(cln_license_number != '');



layout_SANCTN_license_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE];
	string26 midex_rpt_nbr;
END;

layout_SANCTN_license_key			tLicenseMidex(f_sanctn_license L) := transform
		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number := ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																													+ tmp_incident_number +'-' 
																													+ cln_party_number);
		SELF := L;
END;

//include non-NMLS records only
Export Parentfile_sanctn_license_midex := project(f_sanctn_license(NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)),
                                tLicenseMidex(LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn License Mindex                         */
//***************************************************************************   //																
f_sanctn_license := SANCTN.file_base_license(cln_license_number != '');
KeyName 			:= 'thor_data400::key::sanctn::';


layout_SANCTN_license_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE];
END;

//modified to include non-NMLS records
Export Parentfile_Sanctn_License_nbr := project(f_sanctn_license(NOT REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),nocase)), 
                                TRANSFORM(layout_SANCTN_license_key, SELF := LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn License nbr                         */
//***************************************************************************   //	


//***************************************************************************   //
/*    End of Parent File Sanctn Linksid                         */
//***************************************************************************   //	


f_sanctn_party := SANCTN.file_base_party;

layout_SANCTN_party_key := RECORD
	SANCTN.layout_SANCTN_did AND NOT [RECORD_TYPE, 
									// UltID, OrgID, SELEID, ProxID, POWID, EmpID, DotID,
									// UltScore, OrgScore, SELEScore, ProxScore, POWScore, EmpScore, DotScore, 
									// UltWeight, OrgWeight, SELEWeight, ProxWeight, POWWeight, EmpWeight, DotWeight,	
									SOURCE_REC_ID, enh_did_src];
	string26 midex_rpt_nbr;
END;

/* Standardized the SSNs found within the freeform text field */
layout_SANCTN_party_key tSANCTN_key(f_sanctn_party L) := transform
   self.party_text := SANCTN.fMask_SSN(L.party_text);
	 
	 tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);

	 tmp_party_number := ut.rmv_ld_zeros(L.PARTY_NUMBER);

	 cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);

	 self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);
	 //populate st field when instate exists and all other address fields are blank and address cleaner does not return a state.
	 self.st 				 := IF(L.st='' and length(trim(L.instate))=2 and L.incity='' and L.inzip='' and L.inaddress='' and  ut.valid_st(L.instate),
										 		 trim(L.instate),
												 L.st);
	 
   self               := L;
END;

Export Parentfile_sanctn_midex_rpt_nbr := project(f_sanctn_party, tSANCTN_key(LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn midex_rpt_nbr                         */
//***************************************************************************  //	

//include standard type description and license number. Standard type description are different for various NMLS licenses.
layout_SANCTN_nmls_id_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
	STRING20 		NMLS_ID;
	//STRING50 		NMLS_ID_TYPE;
	STRING26 		MIDEX_RPT_NBR;
END;

f_sanctn_license := SANCTN.file_base_license(CLN_LICENSE_NUMBER<>'');

//Populate Midex and NMLS_ID fields
layout_SANCTN_nmls_id_key populateMidex(SANCTN.layout_SANCTN_license_clean l) := transform
  self.MIDEX_RPT_NBR := TRIM(L.BATCH_NUMBER,LEFT,RIGHT) + '-' +
	              ut.rmv_ld_zeros(L.INCIDENT_NUMBER) + '-' +
								ut.rmv_ld_zeros(L.PARTY_NUMBER);
	SELF.NMLS_ID := L.CLN_LICENSE_NUMBER;
	//Blank out the license state if it is NMLS
	SELF.LICENSE_STATE := IF(TRIM(L.LICENSE_STATE)='NMLS','',TRIM(L.LICENSE_STATE));
	//SELF.NMLS_ID_TYPE := 'NMLS ID';
	SELF := L;
	SELF := [];
END;

Export Parentfile_sanctn_numls_id := project(f_sanctn_license(REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)), 
                            populateMidex(LEFT));

//***************************************************************************   //
/*    End of Parent File Sanctn nmls_id                              */
//***************************************************************************  //

//filter out records that have blank clean license number
//f_sanctn_license := SANCTN.file_base_license(license_number != '');
f_sanctn_license := SANCTN.file_base_license(cln_license_number != '');

layout_SANCTN_license_key := RECORD
  SANCTN.layout_SANCTN_license_clean AND NOT [RECORD_TYPE, CLN_LICENSE_NUMBER];
	STRING26 		midex_rpt_nbr;
	STRING20 		NMLS_ID;
	//STRING50 		NMLS_ID_TYPE;

END;

layout_SANCTN_license_key			tNMLSLicenseMidex(f_sanctn_license L) := transform

		tmp_incident_number := ut.rmv_ld_zeros(L.INCIDENT_NUMBER);
		tmp_party_number := ut.rmv_ld_zeros(L.PARTY_NUMBER);
		cln_party_number := if(trim(tmp_party_number) = '0','',tmp_party_number);
		self.midex_rpt_nbr := StringLib.StringCleanSpaces(trim(L.BATCH_NUMBER)+'-' 
																										+ tmp_incident_number +'-' 
																										+ cln_party_number);
		SELF.NMLS_ID := L.CLN_LICENSE_NUMBER;
		//Blank out the license state if it is NMLS
		SELF.LICENSE_STATE := IF(TRIM(L.LICENSE_STATE)='NMLS','',TRIM(L.LICENSE_STATE));
		//SELF.NMLS_ID_TYPE := 'NMLS ID';
		SELF := L;
		SELF := [];

END;

Export Parentfile_sanctn_nmls_midex := project(f_sanctn_license(REGEXFIND('NMLS', TRIM(LICENSE_TYPE,LEFT,RIGHT),NOCASE)),
                                tNMLSLicenseMidex(LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn nmls_midex                            */
//***************************************************************************  //

f_sanctn_aka_dba := SANCTN.file_base_party_aka_dba;

KeyName 			:= 'thor_data400::key::sanctn::';

layout_SANCTN_aka_dba_key := RECORD
  SANCTN.layout_SANCTN_aka_dba_in AND NOT [RECORD_TYPE,LAST_NAME,FIRST_NAME,MIDDLE_NAME];
END;

Export ParentFile_sanctn_party_aka_dba := project(f_sanctn_aka_dba , TRANSFORM(layout_SANCTN_aka_dba_key, SELF := LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn Party_AKA_DBA                          */
//***************************************************************************  //

f_sanctn_party := SANCTN.file_base_party;

layout_SANCTN_party_key := SANCTN.layout_SANCTN_party_clean_orig;


/* Mask the SSNs found within the freeform text field */
layout_SANCTN_party_key tSANCTN_key(f_sanctn_party L) := transform
	 self.BATCH_NUMBER		:= trim(L.BATCH_NUMBER,left,right);
	 self.INCIDENT_NUMBER := trim(L.INCIDENT_NUMBER,left,right);
	 self.PARTY_NUMBER		:= trim(L.PARTY_NUMBER,left,right);
   self.party_text := SANCTN.fMask_SSN(L.party_text);
	 //populate st field when instate exists and all other address fields are blank and address cleaner does not return a state.
	 self.st 				 := IF(L.st='' and length(trim(L.instate))=2 and L.incity='' and L.inzip='' and L.inaddress='' and  ut.valid_st(L.instate),
										 		 trim(L.instate),
												 L.st);
   self            := L;
end;

Export Parentfile_sanctn_party := project(f_sanctn_party, tSANCTN_key(LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn Party                                 */
//***************************************************************************  //
f_sanctn_rebuttal := SANCTN.file_base_rebuttal;

KeyName 			:= 'thor_data400::key::sanctn::';

layout_SANCTN_rebuttal_key := RECORD
  SANCTN.layout_SANCTN_rebuttal_in AND NOT [RECORD_TYPE];
END;

Export Parentfile_sanctn_rebuttal := project(f_sanctn_rebuttal, TRANSFORM(layout_SANCTN_rebuttal_key, SELF := LEFT));
//***************************************************************************   //
/*    End of Parent File Sanctn Rebuttal                               */
//***************************************************************************  //

f_sanctn_party := SANCTN.file_base_party;


slim_SSN := record
string9 SSNUMBER;
f_sanctn_party.BATCH_NUMBER;
f_sanctn_party.INCIDENT_NUMBER;
f_sanctn_party.PARTY_NUMBER;
end;


slim_SSN 		tSANCTN_key(f_sanctn_party L) := transform
filterInvalidChar := stringlib.stringfilterout(stringlib.stringtouppercase(L.SSNUMBER),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-');
self.SSNUMBER := if(filterInvalidChar != '',filterInvalidChar,L.SSN_APPENDED);
self               := L;
end;

dsParty := project(f_sanctn_party, tSANCTN_key(LEFT));
dsParty_srt := SORT(dsParty,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,SSNUMBER);
dsParty_dedup := dedup(dsParty_srt,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,SSNUMBER);
dsParty_filter := dsParty_dedup(SSNUMBER[6..9] != '');

ssn4layout := RECORD
  string4 ssn4;
  string8 batch_number;
  string8 incident_number;
  string8 party_number;
 END;
ssn4layout ssn4_string(dsParty_filter l):=transform
	
self.ssn4 := (string)l.SSNUMBER[6..9];
self.batch_number := l.batch_number;
self.incident_number := l.incident_number;
self.party_number := l.party_number;
end;

Export ParentFile_sanctn_ssn4  := project(dsParty_filter,ssn4_string(LEFT));


//***************************************************************************   //
/*    End of Parent File Sanctn Rebuttal                               */
//***************************************************************************  //
end;