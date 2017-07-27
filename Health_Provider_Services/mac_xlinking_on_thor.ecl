export mac_xlinking_on_thor(infile,IDL = '',Input_FNAME = '',Input_MNAME = '',Input_LNAME = '',Input_SNAME = '',Input_GENDER = '',
															Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
															Input_SSN = '',Input_DOB = '',Input_PHONE = '',Input_LIC_STATE = '',Input_LIC_NBR = '',
															Input_TAX_ID = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',Input_NPI_NUMBER = '',
															Input_UPIN = '',Input_DID = '',Input_BDID = '',Input_SRC = '',
															Input_SOURCE_RID = '',OutFile, forcePull = false, score = 38, distance = 6) := MACRO

#uniquename(asindex)
%asIndex% := if(forcePull = true, false, if(thorlib.nodes() < 400 or count(infile) < 13000000, true, false));

#uniquename(layout_seq)
%layout_seq% := record
	unsigned4 uniqueID;
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
%result% := %result_thor%;
/*----------------- Join input dataset and results using reference id ---------------------*/
#uniquename(infiledist)
#uniquename(exlinkdist)
%infiledist% := distribute(%infile_seq%, uniqueId);
%exlinkdist% := distribute(%result%, reference);

#uniquename(AssignDID)
recordof(infile) %assignDID%(%infiledist% l, %exlinkdist% r) := transform
	de_result := dedup(sort (r.results,-weight,-fnameweight,-lnameweight),weight);
	idlWeightDiff := if(count(de_result) > 1, de_result[1].weight - de_result[2].weight, 0);
	totalResults 	:= count(de_result);
	self.total_score	:=	de_result[1].weight;
	self.lnpid 		:= if((idlWeightDiff >= distance or totalResults = 1)  and de_result[1].weight >= score, de_result[1].lnpid, 0);
	// idlWeightDiff := if(count(r.results) > 1, r.results[1].weight - r.results[2].weight, 0);
	// totalResults 	:= count(r.results);
	// self.total_score	:=	r.results[1].weight;
	// self.lnpid 		:= if((idlWeightDiff >= distance or totalResults = 1)  and r.results[1].weight >= score, r.results[1].lnpid, 0);
	self := l;
end;

outfile := join(%infiledist%, %exlinkdist%, left.uniqueid = right.reference, %assignDID%(left, right), left outer, local);
output (%infiledist%);
output (%exlinkdist%);
endmacro;