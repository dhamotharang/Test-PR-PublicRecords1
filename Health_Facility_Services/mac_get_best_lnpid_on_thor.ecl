IMPORT BIPV2_Company_Names; 

export mac_get_best_lnpid_on_thor(infile,IDL = '',Input_CNAME = '',
															Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
															Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_FAX = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',
															Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',
															Input_MEDICARE_FACILITY_NUMBER = '',Input_MEDICAID_NUMBER = '',Input_NCPDP_NUMBER = '',Input_Taxonomy = '',Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',
															OutFile, forcePull = false, score = 38) := MACRO
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
	string10 i_taxonomy;
	string2 i_taxonomy_code;
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned8 cnt) := transform
	self.uniqueID := cnt;
  #IF ( #TEXT(Input_CNAME) <> '' )
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))l.Input_CNAME;
  #ELSE
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))'';
  #END
  #IF ( #TEXT(Input_Taxonomy) <> '' )
    SELF.i_taxonomy := (TYPEOF(SELF.i_taxonomy))l.Input_Taxonomy;
		SELF.i_taxonomy_code := (TYPEOF(SELF.i_taxonomy))l.Input_Taxonomy;
  #ELSE
    SELF.i_taxonomy := (TYPEOF(SELF.i_taxonomy))'';
		SELF.i_taxonomy_code := (TYPEOF(SELF.i_taxonomy))''; 
  #END
	self := l;
	self := [];
end;

#uniquename(infile_seq_1)
%infile_seq_1% := project(infile, %AssignSeq%(left, counter));
#uniquename(infile_seq)
%infile_seq% := if(%asIndex%, distribute(%infile_seq_1%, uniqueId), %infile_seq_1%);

#uniquename(add_cnp_nameid)
%add_cnp_nameid% := project (%infile_seq%,transform(BIPV2_Company_Names.layouts.layout_names,self.cnp_nameid := left.uniqueId; self.cnp_name := HealthCareFacility.clean_facility_name(left.cnp_name); self := []));

// #uniquename(pre_clean_cname)
// %pre_clean_cname% := HealthCareFacility.clean_facility_name (%add_cnp_nameid%);
#uniquename(clean_cname)
%clean_cname% := BIPV2_Company_Names.functions.go(%add_cnp_nameid%,FALSE,FALSE);
	
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

// output (%apply_clean_cname%,named('apply_clean_cname'));
/*-------------------------------- Thor Search -------------------------------------------*/
#uniquename(result_thor)
Health_Facility_Services.MAC_MEOW_xLNPID_Batch(%apply_clean_cname%,uniqueID,Input_CNAME,CNP_NAME,CNP_NUMBER,CNP_STORE_NUMBER,CNP_BTYPE,CNP_LOWV,
											Input_PRIM_RANGE,Input_PRIM_NAME,Input_SEC_RANGE,Input_V_CITY_NAME,Input_ST,Input_ZIP,
											Input_TAX_ID,Input_FEIN,Input_PHONE,Input_FAX,Input_LIC_STATE,Input_C_LIC_NBR,Input_DEA_NUMBER,
											Input_VENDOR_ID,Input_NPI_NUMBER,Input_CLIA_NUMBER,Input_MEDICARE_FACILITY_NUMBER,Input_MEDICAID_NUMBER,Input_NCPDP_NUMBER,Input_Taxonomy,i_taxonomy_code,
											Input_BDID,Input_SRC,Input_SOURCE_RID,,,,,%result_thor%, %asIndex%);											

// output (%result_thor%);
#uniquename(result_thor_trim)
Health_Facility_Services.mac_trim_xLNPID_layout(%result_thor%, %result_thor_trim%);
// output (%result_thor%);																
/*------- Final Result ----*/
#uniquename(result)
// %result% := %result_thor_trim%;
%result% := %result_thor%;
// output (%result_thor%);
/*----------------- Join input dataset and results using reference id ---------------------*/
#uniquename(infiledist)
#uniquename(exlinkdist)
%infiledist% := distribute(%infile_seq%, uniqueId);
%exlinkdist% := distribute(%result%, reference);

#uniquename(layout_ref)
%layout_ref% := record
	unsigned8 uniqueID;
	unsigned8 lnpid;
	unsigned3	weight;
	unsigned4	keys_tried;
	string10  iTaxonomy;
	string10  cTaxonomy;
	unsigned2 taxonomy_score;
	unsigned2 best_criteria;
end;

#uniquename(getLNPID)
%layout_ref% %getLNPID% (Health_Facility_Services.Process_xLNPID_Layouts.OutputLayout_Batch l, INTEGER C) := transform
	self.uniqueID := l.reference;
	self.lnpid		:= l.Results[c].lnpid;
	self.weight		:= l.Results[c].weight;
	self.keys_tried	:=	l.Results[c].keys_used;
	self.iTaxonomy	:=	'';
	self.cTaxonomy	:=	l.Results[c].Taxonomy;
	self.taxonomy_score := max(l.Results[c].TAXONOMYWeight,0);
	self.best_criteria := 0; 
	// self.best_criteria := map (l.Results[c].weight > score => 
		// max(l.Results[c].CNP_NAMEWeight,0) +
		// max(l.Results[c].CNP_NUMBERWeight,0) +
		// max(l.Results[c].CNP_STORE_NUMBERWeight,0) +
		// max(l.Results[c].CNP_BTYPEWeight,0) +
		// max(l.Results[c].CNP_LOWVWeight,0) +
		// max(l.Results[c].PRIM_RANGEWeight,0) +
		// max(l.Results[c].PRIM_NAMEWeight,0) +
		// max(l.Results[c].SEC_RANGEWeight,0) +
		// max(l.Results[c].V_CITY_NAMEWeight,0) +
		// max(l.Results[c].STWeight,0) +
		// max(l.Results[c].ZIPWeight,0) +
		// max(l.Results[c].TAX_IDWeight,0) +
		// max(l.Results[c].FEINWeight,0) +
		// max(l.Results[c].PHONEWeight,0) +
		// max(l.Results[c].FAXWeight,0) +
		// max(l.Results[c].LIC_STATEWeight,0) +
		// max(l.Results[c].C_LIC_NBRWeight,0) +
		// max(l.Results[c].DEA_NUMBERWeight,0) +
		// max(l.Results[c].VENDOR_IDWeight,0) +
		// max(l.Results[c].NPI_NUMBERWeight,0) +
		// max(l.Results[c].CLIA_NUMBERWeight,0) +
		// max(l.Results[c].MEDICARE_FACILITY_NUMBERWeight,0) +
		// max(l.Results[c].MEDICAID_NUMBERWeight,0) +
		// max(l.Results[c].NCPDP_NUMBERWeight,0) +
		// max(l.Results[c].TAXONOMYWeight,0) +
		// max(l.Results[c].BDIDWeight,0) +
		// max(l.Results[c].SRCWeight,0) +
		// max(l.Results[c].SOURCE_RIDWeight,0) +
		// max(l.Results[c].FAC_NAMEWeight,0) +
		// max(l.Results[c].ADDR1Weight,0) +
		// max(l.Results[c].LOCALEWeight,0) +
		// max(l.Results[c].ADDRESWeight,0),0);
end;

#uniquename(lnpid_file)
%lnpid_file% := normalize (%exlinkdist%,min(count(LEFT.Results),10),%getLNPID%(LEFT,COUNTER));
// output (%lnpid_file%);

#uniquename(j_file)
%j_file% := join (%lnpid_file%,%infiledist%,left.uniqueID = right.uniqueID,transform(%layout_ref%, self.iTaxonomy := right.i_taxonomy; self := left;),left outer,local);

#uniquename(t_score)
%t_score% := join (%j_file%,Health_Facility_Services.File_Taxonomy,left.iTaxonomy = right.taxonomy and left.cTaxonomy = right.taxonomy2,transform(%layout_ref%, self.best_criteria := left.best_criteria + (left.taxonomy_score * right.scores) / 100; self := left;),left outer,lookup, local);
// output (%t_score%);

#uniquename(sort_lnpid)
%sort_lnpid% := sort(%t_score%,uniqueID,-best_criteria,-weight,local);

#uniquename(best_lnpid)
%best_lnpid% := dedup(sort(%t_score%,uniqueID,-best_criteria,-weight,local),uniqueID,local);
// output (%sort_lnpid%);
#uniquename(AssignDID)
recordof(infile) %assignDID%(%infiledist% l, %best_lnpid% r) := transform
	self.lnpid 				:= if(r.weight >= score, r.lnpid, 0);
	// self.total_score 	:= r.weight;
	// self.keys_tried		:=	r.keys_tried;
	// self.best_criteria:= r.best_criteria;
	self := l;
end;

outfile := join(%infiledist%, %best_lnpid%, left.uniqueid = right.uniqueid, %assignDID%(left, right), left outer, local);
endmacro;