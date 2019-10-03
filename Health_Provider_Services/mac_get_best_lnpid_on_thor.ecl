export mac_get_best_lnpid_on_thor (infile,IDL = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',
																		Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',
																		Input_ST = '',Input_ZIP = '',Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_LIC_NBR = '',
																		Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',
																		Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',
																		Input_SOURCE_RID = '',OutFile, forcePull = false, score = 38) := MACRO

#uniquename(asindex)
%asIndex% := if(forcePull = true, false, if(thorlib.nodes() < 400 or count(infile) < 13000000, true, false));

#uniquename(layout_seq)
%layout_seq% := record
	unsigned8 uniqueID;
	recordof(infile);
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned4 cnt) := transform
	self.uniqueID := cnt;
	self := l;
end;

#uniquename(infile_seq_1)
%infile_seq_1% := project(infile, %AssignSeq%(left, counter));
#uniquename(infile_seq)
%infile_seq% := if(%asIndex%, distribute(%infile_seq_1%, uniqueId), %infile_seq_1%);
// output (%infile_seq%);
/*-------------------------------- Thor Search -------------------------------------------*/
#uniquename(result_thor)
Health_Provider_Services.MAC_MEOW_xLNPID_Batch(%infile_seq%,uniqueID,Input_FNAME,Input_MNAME,Input_LNAME,Input_SNAME,
											Input_GENDER,
											Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_NAME,Input_ST,Input_ZIP,
											Input_SSN,Input_SSN,Input_DOB,Input_DOB,Input_Phone,Input_LIC_STATE,Input_LIC_NBR,
											Input_TAX_ID,Input_TAX_ID,Input_DEA_NUMBER,Input_VENDOR_ID,Input_NPI_NUMBER,Input_NPI_NUMBER,
											Input_UPIN,Input_DID,Input_BDID,
											Input_SRC,Input_SOURCE_RID,,,,,,,%result_thor%, %asIndex%);		
											
#uniquename(result_thor_trim)
Health_Provider_Services.mac_trim_xLNPID_layout(%result_thor%, %result_thor_trim%);
																
/*------- Final Result ----*/
#uniquename(result)
// %result% := %result_thor_trim%;
//output (%result_thor%);
%result% := %result_thor%;
/*----------------- Join input dataset and results using reference id ---------------------*/
#uniquename(infiledist)
#uniquename(exlinkdist)
%infiledist% := distribute(%infile_seq%, uniqueId);
%exlinkdist% := distribute(%result%, reference);
// output (%exlinkdist%);
#uniquename(layout_ref)
%layout_ref% := record
	unsigned8 uniqueID;
	unsigned8 lnpid;
	unsigned3	weight;
	UNSIGNED4 keys_tried;
	UNSIGNED2	best_criteria;
end;

#uniquename(getLNPID)
%layout_ref% %getLNPID% (Health_Provider_Services.Process_xLNPID_Layouts.OutputLayout_Batch l, INTEGER C) := transform,skip (l.Results[c].weight < 10)
	self.uniqueID				:= l.reference;
	self.weight					:= l.Results[c].weight;
	self.keys_tried			:= l.Results[c].keys_used;
	name_weight					:= l.Results[c].fnameweight + l.Results[c].mnameweight + l.Results[c].lnameweight + l.Results[c].snameweight;
	mainname_weight			:= if (l.Results[c].mainnameweight > l.Results[c].fullnameweight,l.Results[c].mainnameweight,l.Results[c].fullnameweight);
	name_score			:= map (mainname_weight > 0 and name_weight > 0 and mainname_weight >= name_weight => mainname_weight, 
												  mainname_weight > 0 and name_weight > 0 and mainname_weight <  name_weight => name_weight,0);
	address_score       := if (name_score > 0, l.Results[c].PRIM_RANGEWeight + l.Results[c].PRIM_NameWeight + l.Results[c].Sec_RANGEWeight + l.Results[c].V_CITY_NAMEWeight + l.Results[c].STWeight + l.Results[c].ZIPWeight,0);
  dob_score           := map (name_score > 0 and l.Results[c].DOBWeight > 0 and l.Results[c].DOBWeight > l.Results[c].CNSMR_DOBWeight => l.Results[c].DOBWeight, 
                              name_score > 0 and l.Results[c].CNSMR_DOBWeight > 0 => l.Results[c].CNSMR_DOBWeight,0);
	lic_score 					:= map (name_score > 0 and l.Results[c].C_LIC_NBRWeight > 0 => l.Results[c].C_LIC_NBRWeight, 0);
	npi_score						:= map (name_score > 0 and l.Results[c].NPI_NUMBERWeight > 0 => l.Results[c].NPI_NUMBERWeight, 0);
	dea_score						:= map (name_score > 0 and l.Results[c].DEA_NUMBERWeight > 0 => l.Results[c].DEA_NUMBERWeight, 0);
	tax_score						:= map (name_score > 0 and l.Results[c].BILLING_TAX_IDWeight > 0 => l.Results[c].BILLING_TAX_IDWeight, 0);
	ssn_score						:= map (name_score > 0 and l.Results[c].SSNWeight > 0 => l.Results[c].SSNWeight, 0);
	upin_score					:= map (name_score > 0 and l.Results[c].UPINWeight > 0 => l.Results[c].UPINWeight, 0);
	self.best_criteria	:= 0;
	self.lnpid					:= l.Results[c].lnpid;
end;

#uniquename(lnpid_file)
%lnpid_file% := normalize (%exlinkdist%,min(count(LEFT.Results),50),%getLNPID%(LEFT,COUNTER));
#uniquename(best_lnpid)
// output (%lnpid_file%);
%best_lnpid% := dedup(sort(%lnpid_file%,uniqueID, -weight,-best_criteria,local),uniqueID,local);
#uniquename(AssignDID)
recordof(infile) %assignDID%(%infiledist% l, %best_lnpid% r) := transform
	self.lnpid 		:= if(r.weight >= score, r.lnpid, 0);
	// self.keys_tried := r.keys_tried;
	// self.total_score 			:= r.weight;
	self := l;
end;

outfile := join(%infiledist%, %best_lnpid%, left.uniqueid = right.uniqueid, %assignDID%(left, right), left outer, local);
// outfile := %result_thor%;
endmacro;