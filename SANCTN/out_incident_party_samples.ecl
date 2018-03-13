import SANCTN,STANDARD;

file_base_in := dataset('~thor_data400::base::SANCTN::incident',SANCTN.layout_SANCTN_incident_clean,thor);									
file_base_in_father := 	dataset('~thor_data400::base::SANCTN::incident_father',SANCTN.layout_SANCTN_incident_clean,thor);																			 
																
dist_file_in := distribute(file_base_in,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));
dist_file_in_var := distribute(file_base_in_father,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));
//Modifed incident_text length to get the data

Layout_Incident_final := record
SANCTN.layout_SANCTN_incident_in;
	string4000       incident_text := '';
	string8        	incident_date_clean := '';
	string8       	fcr_date_clean := '';
	end;

Layout_Incident_final join_tr(dist_file_in le,dist_file_in_var re) := transform
	self := le;
end;

//Join operation to get updates
join_incident := join(dist_file_in,
						 dist_file_in_var,
						 LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND
						 LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER AND
						 LEFT.ORDER_NUMBER = RIGHT.ORDER_NUMBER AND
						 LEFT.CASE_NUMBER = RIGHT.CASE_NUMBER AND
						 LEFT.JURISDICTION = RIGHT.JURISDICTION AND
						 LEFT.SOURCE_DOCUMENT = RIGHT.SOURCE_DOCUMENT AND
						 LEFT.ADDITIONAL_INFO = RIGHT.ADDITIONAL_INFO AND
						 LEFT.incident_text = RIGHT.incident_text
						,join_tr(LEFT,RIGHT),
						left only,
						local);


sort_in := sort(join_incident,BATCH_NUMBER,INCIDENT_NUMBER,incident_text,local);
dedp_in := dedup(sort_in,BATCH_NUMBER,INCIDENT_NUMBER,incident_text,local);

//Roll up to roll all of the incident_text
Layout_Incident_final rollup_tr(dedp_in le,dedp_in re) := transform
self.incident_text := trim(le.incident_text) + '  . ' + '\n' + trim(re.incident_text);
self := le;
end;

in_roll := rollup(dedp_in,LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND
						 LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER,
						 rollup_tr(LEFT,RIGHT),local);
//o_in_roll := output(sample(in_roll,50),,named('Sanctn_QA_Samples_Incident'));
o_in_roll := output(topn(in_roll,200,-incident_date_clean),,named('Sanctn_QA_Samples_Incident'));

//same applies to party data
file_party_in := dataset( '~thor_data400::base::SANCTN::party',SANCTN.layout_SANCTN_did,thor);
file_party_in_father := dataset( '~thor_data400::base::SANCTN::party_father',SANCTN.layout_SANCTN_did,thor);																			 

dist_file_party := distribute(file_party_in,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));
dist_file_in_party := distribute(file_party_in_father,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));

layout_SANCTN_party_final := record
	SANCTN.layout_SANCTN_party_in;
    string4000     party_text := '';
    Standard.Name;
	string45       cname;
	Standard.L_Address.detailed;
	// unsigned6 	   did := 0;
	// string3 	   did_score := '';
end;

layout_SANCTN_party_final join_tr_par(dist_file_party le,dist_file_in_party re) := transform
	self := le;
end;

joutpar := join(dist_file_party,
								dist_file_in_party,
								LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND 
								LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER AND
								LEFT.PARTY_NUMBER = RIGHT.PARTY_NUMBER AND
								LEFT.ORDER_NUMBER = RIGHT.ORDER_NUMBER AND
								LEFT.PARTY_NAME = RIGHT.PARTY_NAME AND
								LEFT.PARTY_POSITION = RIGHT.PARTY_POSITION AND
								LEFT.PARTY_VOCATION = RIGHT.PARTY_VOCATION AND
								LEFT.PARTY_FIRM = RIGHT.PARTY_FIRM AND
								LEFT.inADDRESS = RIGHT.inADDRESS AND
								LEFT.inCITY = RIGHT.inCITY AND
								LEFT.inSTATE = RIGHT.inSTATE AND
								LEFT.inZIP = RIGHT.inZIP AND
								LEFT.RESTITUTION = RIGHT.RESTITUTION AND
								LEFT.party_text = RIGHT.party_text
								,join_tr_par(LEFT,RIGHT),
								left only,
								local);

sort_pty := sort(joutpar,BATCH_NUMBER,INCIDENT_NUMBER,party_text,local);
dedp_pty := dedup(sort_pty,BATCH_NUMBER,INCIDENT_NUMBER,party_text,local);

layout_SANCTN_party_final rollup_tr_pty(dedp_pty le,dedp_pty re) := transform
self.party_text := trim(le.party_text) + '  . '+ '\n' + trim(re.party_text);
self := le;
end;

par_roll := rollup(dedp_pty,LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND
						 LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER,
						 rollup_tr_pty(LEFT,RIGHT),local);
//o_par_roll := output(sample(par_roll,50),,named('Sanctn_QA_Samples_Party'));
o_par_roll := output(topn(par_roll,200,-incident_number),,named('Sanctn_QA_Samples_Party'));


//License data
file_license := dataset( '~thor_data400::base::SANCTN::license_nbr',SANCTN.layout_SANCTN_license_clean,thor);
file_license_father := dataset( '~thor_data400::base::SANCTN::license_nbr_father',SANCTN.layout_SANCTN_license_clean,thor);																			 

dist_file_license := distribute(file_license,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));
dist_file_license_father := distribute(file_license_father,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));

SANCTN.layout_SANCTN_license_clean joinLicense(dist_file_license L, dist_file_license_father R) := TRANSFORM
	SELF := L;
END;
	
//Join operation to get updates
join_license := join(dist_file_license,
						          dist_file_license_father,
											LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND
											LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER  
											,joinLicense(LEFT, RIGHT),
											left only,
											local);

sort_lic := sort(join_license,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,ORDER_NUMBER,CLN_LICENSE_NUMBER,local);
dedp_lic := dedup(sort_lic,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_NUMBER,ORDER_NUMBER,CLN_LICENSE_NUMBER,local);
//odedp_lic := output(sample(dedp_lic,50),,named('Sanctn_QA_Samples_License'));

SANCTN.layout_SANCTN_license_clean rollup_tr_lic(dedp_lic le,dedp_lic re) := transform
self.license_number := trim(le.license_number) + '/'+ trim(re.license_number);
self := le;
end;

lic_roll := rollup(dedp_lic,LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND
						 LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER,
						 rollup_tr_lic(LEFT,RIGHT),local);
//o_lic_roll := output(lic_roll,,named('Sanctn_QA_Samples_License'));
o_lic_roll := output(topn(lic_roll,200,-incident_number),,named('Sanctn_QA_Samples_License'));

//Rebuttal data
file_rebuttal := dataset( '~thor_data400::base::SANCTN::rebuttal',SANCTN.layout_SANCTN_rebuttal_in,thor);
file_rebuttal_father := dataset( '~thor_data400::base::SANCTN::rebuttal_father',SANCTN.layout_SANCTN_rebuttal_in,thor);																			 

dist_file_rebuttal := distribute(file_rebuttal,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));
dist_file_rebuttal_father := distribute(file_rebuttal_father,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));

Layout_rebuttal_final := record
SANCTN.layout_SANCTN_rebuttal_in;
	string4000       incident_text := '';
	string8        	incident_date_clean := '';
	string8       	fcr_date_clean := '';
	end;

Layout_rebuttal_final tx_rebuttal(dist_file_rebuttal le,dist_file_rebuttal_father re) := transform
	self := le;
end;

//Join operation to get updates
join_rebuttal := join(dist_file_rebuttal,
											dist_file_rebuttal_father,
											LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND
											LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER AND
											LEFT.ORDER_NUMBER  = RIGHT.ORDER_NUMBER AND  
											LEFT.PARTY_TEXT  = RIGHT.PARTY_TEXT 
											,tx_rebuttal(LEFT,RIGHT),
											left only,
											local);

sort_rebuttal := sort(join_rebuttal,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_TEXT,local);
dedp_rebuttal := dedup(sort_rebuttal,BATCH_NUMBER,INCIDENT_NUMBER,PARTY_TEXT,local);

//Roll up to roll all of the incident_text
Layout_rebuttal_final rollup_rebuttal(dedp_rebuttal le,dedp_rebuttal re) := transform
self.party_text := trim(le.party_text) + '  . ' + '\n' + trim(re.party_text);
self := le;
end;

rebuttal_roll := rollup(dedp_rebuttal,
                        LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND
						            LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER,
						            rollup_rebuttal(LEFT,RIGHT),local);

//o_rebuttal_roll := output(sample(rebuttal_roll,50),,named('Sanctn_QA_Samples_Rebuttal'));
o_rebuttal_roll := output(topn(rebuttal_roll,200,-incident_date_clean),,named('Sanctn_QA_Samples_Rebuttal'));


//Final layout combined incident and party and license
Layout_Incident_Party := record
STRING8   BATCH_NUMBER;
	STRING8   INCIDENT_NUMBER;
	STRING8   PARTY_NUMBER;
	STRING1   RECORD_TYPE;
	STRING4   ORDER_NUMBER;
	STRING8  AG_CODE;
	STRING20 CASE_NUMBER;
	STRING8  INCIDENT_DATE;
	STRING90 JURISDICTION;
	STRING70 SOURCE_DOCUMENT;
	STRING70 ADDITIONAL_INFO;
	STRING70 AGENCY;
	STRING10 ALLEGED_AMOUNT;
	STRING10 ESTIMATED_LOSS;
	STRING10 FCR_DATE;
	STRING45  PARTY_NAME;
	STRING45  PARTY_POSITION;
	STRING45  PARTY_VOCATION;
	STRING70  PARTY_FIRM;
	STRING45  inADDRESS;
	STRING45  inCITY;
	STRING20  inSTATE;
	STRING10  inZIP;
	STRING11  SSNUMBER;
	STRING10  FINES_LEVIED;
	STRING10  RESTITUTION;
	STRING1   OK_FOR_FCR;
	string4000       incident_text := '';
	string8        	incident_date_clean := '';
	string8       	fcr_date_clean := '';
	string4000      party_text := '';
	string45       cname;
	//Added for license information
	STRING50  CLN_LICENSE_NUMBER;
	STRING50 	LICENSE_TYPE;
	STRING20	LICENSE_STATE;
	STRING50	STD_TYPE_DESC;

end;

dist_file_inup := distribute(in_roll,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));
dist_file_partyup := distribute(par_roll,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));
dist_file_licup := distribute(dedp_lic,HASH32(BATCH_NUMBER,INCIDENT_NUMBER));

Layout_Incident_Party join_tr_final1(dist_file_inup le,dist_file_partyup re) := transform
	self.party_number := re.party_number;	
	self := le;
	self := re;
	self := [];
end;

joutfinal1 := join(dist_file_inup,
									dist_file_partyup,
									LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND 
									LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER 
									,join_tr_final1(LEFT,RIGHT),
									local);
									
Layout_Incident_Party join_tr_final2(joutfinal1 le,dist_file_licup re) := transform
 	self.CLN_LICENSE_NUMBER := re.CLN_LICENSE_NUMBER;
 	self.LICENSE_TYPE := re.LICENSE_TYPE;
 	self.LICENSE_STATE := re.LICENSE_STATE;
 	self.STD_TYPE_DESC := re.STD_TYPE_DESC;
	self := le;
end;

joutfinal2 := join(joutfinal1,
									lic_roll,
									LEFT.BATCH_NUMBER = RIGHT.BATCH_NUMBER AND 
									LEFT.INCIDENT_NUMBER = RIGHT.INCIDENT_NUMBER
									,join_tr_final2(LEFT,RIGHT),
									//LEFT OUTER,
									LOCAL);

ojoutfinal := output(topn(joutfinal2,200,-incident_date_clean),,named('Sanctn_QA_Samples_Incident_Party_License'));

export out_incident_party_samples := parallel(o_in_roll
                                             ,o_par_roll
                                             ,o_lic_roll
                                             ,o_rebuttal_roll
                                             ,ojoutfinal
 																						 );