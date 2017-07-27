export mac_xlinking_on_thor(infile,IDL = '',Input_CNAME = '',
															Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
															Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_FAX = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',
															Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',
															Input_MEDICARE_FACILITY_NUMBER = '',Input_MEDICAID_NUMBER = '',Input_NCPDP_NUMBER = '',Input_TAXONOMY = '', Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',
															OutFile, forcePull = false, score = 38, distance = 6) := MACRO

#uniquename(asindex)
%asIndex% := if(forcePull = true, false, if(thorlib.nodes() < 400 or count(infile) < 13000000, true, false));

#uniquename(layout_seq)
%layout_seq% := record
	unsigned8 uniqueID;
	string250 cnp_name;
	string10 cnp_number;	
	string10 cnp_store_number;
	string10 cnp_btype;		
	string20 cnp_lowv;
	recordof(infile);
	string2 iTaxonomy_code;
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned8 cnt) := transform
	self.uniqueID := cnt;
  #IF ( #TEXT(Input_CNAME) <> '' )
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))l.Input_CNAME;
  #ELSE
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))'';
  #END
	SELF.iTaxonomy_code := (TYPEOF(SELF.Input_Taxonomy))l.Input_Taxonomy[1..2];
	self := l;
	self := [];
end;

#uniquename(infile_seq_1)
%infile_seq_1% := project(infile, %AssignSeq%(left, counter));
#uniquename(infile_seq)
%infile_seq% := if(%asIndex%, distribute(%infile_seq_1%, uniqueId), %infile_seq_1%);

#uniquename(add_cnp_nameid)
%add_cnp_nameid% := project (%infile_seq%,transform(BIPV2_Company_Names.layouts.layout_names,self.cnp_nameid := left.uniqueId; self.cnp_name := left.cnp_name; self := []));

#uniquename(clean_cname)
%clean_cname% := BIPV2_Company_Names.functions.go(%add_cnp_nameid%,TRUE,FALSE);
	
#uniquename(apply_clean_cname)
%apply_clean_cname% := join (%infile_seq%,%clean_cname%,left.uniqueId = right.cnp_nameid,
													transform (%layout_seq%,
																		 // SELF.cnp_nameid				:= RIGHT.cnp_nameid;
																		 SELF.cnp_name					:= RIGHT.cnp_name;
																		 SELF.cnp_number				:= RIGHT.cnp_number;
																		 SELF.cnp_store_number	:= RIGHT.cnp_store_number;
																		 SELF.cnp_btype					:= RIGHT.cnp_btype;
																		 SELF.cnp_lowv					:= RIGHT.cnp_lowv;
																		 SELF := LEFT;),LEFT OUTER,LOCAL);

//output (%apply_clean_cname%);
/*-------------------------------- Thor Search -------------------------------------------*/
#uniquename(result_thor)
Health_Facility_Services.MAC_MEOW_xLNPID_Batch(%apply_clean_cname%,uniqueID,Input_CNAME,CNP_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,
											Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_NAME,Input_ST,Input_ZIP,
											Input_TAX_ID,Input_FEIN,Input_PHONE,Input_FAX,Input_LIC_STATE,Input_C_LIC_NBR,Input_DEA_NUMBER,
											Input_VENDOR_ID,Input_NPI_NUMBER,Input_CLIA_NUMBER,Input_MEDICARE_FACILITY_NUMBER,Input_MEDICAID_NUMBER,Input_NCPDP_NUMBER,
											Input_TAXONOMY,iTaxonomy_code,Input_BDID,Input_SRC,Input_SOURCE_RID,,,,,%result_thor%, %asIndex%);											

output (%result_thor%);
#uniquename(result_thor_trim)
Health_Facility_Services.mac_trim_xLNPID_layout(%result_thor%, %result_thor_trim%);
																
/*------- Final Result ----*/
#uniquename(result)
%result% := %result_thor_trim%;
//%result% := %result_thor%;
/*----------------- Join input dataset and results using reference id ---------------------*/
#uniquename(infiledist)
#uniquename(exlinkdist)
%infiledist% := distribute(%infile_seq%, uniqueId);
%exlinkdist% := distribute(%result%, reference);

#uniquename(AssignDID)
recordof(infile) %assignDID%(%infiledist% l, %exlinkdist% r) := transform
	idlWeightDiff := if(count(r.results) > 1, r.results[1].weight - r.results[2].weight, 0);
	totalResults 	:= count(r.results);
	self.total_score	:=	r.results[1].weight;
	self.lnpid 		:= if((idlWeightDiff >= distance or totalResults = 1)  and r.results[1].weight >= score, r.results[1].lnpid, 0);
	self := l;
end;

outfile := join(%infiledist%, %exlinkdist%, left.uniqueid = right.reference, %assignDID%(left, right), left outer, local);

endmacro;