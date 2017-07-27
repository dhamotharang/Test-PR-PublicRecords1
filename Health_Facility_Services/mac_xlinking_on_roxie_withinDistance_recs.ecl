EXPORT mac_xlinking_on_roxie_withinDistance_recs (infile,IDL = '',Input_CNAME = '',
															Input_PRIM_NAME = '',Input_PRIM_RANGE = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
															Input_TAX_ID = '',Input_FEIN = '',Input_PHONE = '',Input_FAX = '',Input_LIC_STATE = '',Input_C_LIC_NBR = '',Input_DEA_NUMBER = '',Input_VENDOR_ID = '',
															Input_NPI_NUMBER = '',Input_CLIA_NUMBER = '',
															Input_MEDICARE_FACILITY_NUMBER = '',Input_MEDICAID_NUMBER = '',Input_NCPDP_NUMBER = '',Input_Taxonomy = '',Input_BDID = '',Input_SRC = '',Input_SOURCE_RID = '',
															OutFile, Input_IDL = '', Match_Records = false, Full_Match = false, score = 38, distance = 6) := MACRO



#uniquename(in_score)
%in_score% := score;
#uniquename(in_distance)
%in_distance% := distance;

#uniquename(layout_seq)
%layout_seq% := record
	unsigned8 uniqueID;
	string250 cnp_name;
	string10 cnp_number;	
	string10 cnp_store_number;
	string10 cnp_btype;		
	string20 cnp_lowv;
	recordof(infile);
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned8 cnt) := transform
	self.uniqueID := cnt;
  #IF ( #TEXT(Input_CNAME) <> '' )
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))l.Input_CNAME;
  #ELSE
    SELF.cnp_name := (TYPEOF(SELF.cnp_name))'';
  #END
	self := l;
	self := [];
end;

#uniquename(infile_seq)
%infile_seq% := project(infile, %AssignSeq%(left, counter));

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

#uniquename(into)
Health_Facility_Services.Process_xLNPID_Layouts.InputLayout %into%(%apply_clean_cname% le) := TRANSFORM
  SELF.UniqueId := le.UniqueID;
  SELF.MaxIds := 50;
  #IF ( #TEXT(Input_CNAME) <> '' )
    SELF.CNAME := (TYPEOF(SELF.CNAME))le.Input_CNAME;
  #ELSE
    SELF.CNAME := (TYPEOF(SELF.CNAME))'';
  #END
  #IF ( #TEXT(Input_CNP_NAME) <> '' )
    SELF.CNP_NAME := (TYPEOF(SELF.CNP_NAME))le.CNP_NAME;
  #ELSE
    SELF.CNP_NAME := (TYPEOF(SELF.CNP_NAME))'';
  #END
  #IF ( #TEXT(Input_CNP_NUMBER) <> '' )
    SELF.CNP_NUMBER := (TYPEOF(SELF.CNP_NUMBER))le.CNP_NUMBER;
  #ELSE
    SELF.CNP_NUMBER := (TYPEOF(SELF.CNP_NUMBER))'';
  #END
  #IF ( #TEXT(Input_CNP_STORE_NUMBER) <> '' )
    SELF.CNP_STORE_NUMBER := (TYPEOF(SELF.CNP_STORE_NUMBER))le.CNP_STORE_NUMBER;
  #ELSE
    SELF.CNP_STORE_NUMBER := (TYPEOF(SELF.CNP_STORE_NUMBER))'';
  #END
  #IF ( #TEXT(Input_CNP_BTYPE) <> '' )
    SELF.CNP_BTYPE := (TYPEOF(SELF.CNP_BTYPE))le.CNP_BTYPE;
  #ELSE
    SELF.CNP_BTYPE := (TYPEOF(SELF.CNP_BTYPE))'';
  #END
  #IF ( #TEXT(Input_CNP_LOWV) <> '' )
    SELF.CNP_LOWV := (TYPEOF(SELF.CNP_LOWV))le.CNP_LOWV;
  #ELSE
    SELF.CNP_LOWV := (TYPEOF(SELF.CNP_LOWV))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.PRIM_RANGE;
  #ELSE
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
    SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))le.Input_V_CITY_NAME;
  #ELSE
    SELF.V_CITY_NAME := (TYPEOF(SELF.V_CITY_NAME))'';
  #END
  #IF ( #TEXT(Input_ST) <> '' )
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
  #ELSE
    SELF.ST := (TYPEOF(SELF.ST))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
  #ELSE
    SELF.ZIP := (TYPEOF(SELF.ZIP))'';
  #END
  #IF ( #TEXT(Input_TAX_ID) <> '' )
    SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))le.Input_TAX_ID;
  #ELSE
    SELF.TAX_ID := (TYPEOF(SELF.TAX_ID))'';
  #END
  #IF ( #TEXT(Input_FEIN) <> '' )
    SELF.FEIN := (TYPEOF(SELF.FEIN))le.Input_FEIN;
  #ELSE
    SELF.FEIN := (TYPEOF(SELF.FEIN))'';
  #END
  #IF ( #TEXT(Input_PHONE) <> '' )
    SELF.PHONE := (TYPEOF(SELF.PHONE))le.Input_PHONE;
  #ELSE
    SELF.PHONE := (TYPEOF(SELF.PHONE))'';
  #END
  #IF ( #TEXT(Input_FAX) <> '' )
    SELF.FAX := (TYPEOF(SELF.FAX))le.Input_FAX;
  #ELSE
    SELF.FAX := (TYPEOF(SELF.FAX))'';
  #END
  #IF ( #TEXT(Input_LIC_STATE) <> '' )
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))le.Input_LIC_STATE;
  #ELSE
    SELF.LIC_STATE := (TYPEOF(SELF.LIC_STATE))'';
  #END
  #IF ( #TEXT(Input_C_LIC_NBR) <> '' )
    SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))le.Input_C_LIC_NBR;
  #ELSE
    SELF.C_LIC_NBR := (TYPEOF(SELF.C_LIC_NBR))'';
  #END
  #IF ( #TEXT(Input_DEA_NUMBER) <> '' )
    SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))le.Input_DEA_NUMBER;
  #ELSE
    SELF.DEA_NUMBER := (TYPEOF(SELF.DEA_NUMBER))'';
  #END
  #IF ( #TEXT(Input_VENDOR_ID) <> '' )
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))le.Input_VENDOR_ID;
  #ELSE
    SELF.VENDOR_ID := (TYPEOF(SELF.VENDOR_ID))'';
  #END
  #IF ( #TEXT(Input_NPI_NUMBER) <> '' )
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))le.Input_NPI_NUMBER;
  #ELSE
    SELF.NPI_NUMBER := (TYPEOF(SELF.NPI_NUMBER))'';
  #END
  #IF ( #TEXT(Input_CLIA_NUMBER) <> '' )
    SELF.CLIA_NUMBER := (TYPEOF(SELF.CLIA_NUMBER))le.Input_CLIA_NUMBER;
  #ELSE
    SELF.CLIA_NUMBER := (TYPEOF(SELF.CLIA_NUMBER))'';
  #END
  #IF ( #TEXT(Input_MEDICARE_FACILITY_NUMBER) <> '' )
    SELF.MEDICARE_FACILITY_NUMBER := (TYPEOF(SELF.MEDICARE_FACILITY_NUMBER))le.Input_MEDICARE_FACILITY_NUMBER;
  #ELSE
    SELF.MEDICARE_FACILITY_NUMBER := (TYPEOF(SELF.MEDICARE_FACILITY_NUMBER))'';
  #END
  #IF ( #TEXT(Input_MEDICAID_NUMBER) <> '' )
    SELF.MEDICAID_NUMBER := (TYPEOF(SELF.MEDICAID_NUMBER))le.Input_MEDICAID_NUMBER;
  #ELSE
    SELF.MEDICAID_NUMBER := (TYPEOF(SELF.MEDICAID_NUMBER))'';
  #END
  #IF ( #TEXT(Input_NCPDP_NUMBER) <> '' )
    SELF.NCPDP_NUMBER := (TYPEOF(SELF.NCPDP_NUMBER))le.Input_NCPDP_NUMBER;
  #ELSE
    SELF.NCPDP_NUMBER := (TYPEOF(SELF.NCPDP_NUMBER))'';
  #END
  #IF ( #TEXT(Input_TAXONOMY) <> '' )
    SELF.TAXONOMY := (TYPEOF(SELF.TAXONOMY))le.Input_TAXONOMY;
  #ELSE
    SELF.TAXONOMY := (TYPEOF(SELF.TAXONOMY))'';
  #END
  #IF ( #TEXT(Input_TAXONOMY) <> '' )
    SELF.TAXONOMY_CODE := (TYPEOF(SELF.TAXONOMY_CODE))le.Input_TAXONOMY;
  #ELSE
    SELF.TAXONOMY_CODE := (TYPEOF(SELF.TAXONOMY_CODE))'';
  #END
  #IF ( #TEXT(Input_BDID) <> '' )
    SELF.BDID := (TYPEOF(SELF.BDID))le.Input_BDID;
  #ELSE
    SELF.BDID := (TYPEOF(SELF.BDID))'';
  #END
  #IF ( #TEXT(Input_SRC) <> '' )
    SELF.SRC := (TYPEOF(SELF.SRC))le.Input_SRC;
  #ELSE
    SELF.SRC := (TYPEOF(SELF.SRC))'';
  #END
  #IF ( #TEXT(Input_SOURCE_RID) <> '' )
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))le.Input_SOURCE_RID;
  #ELSE
    SELF.SOURCE_RID := (TYPEOF(SELF.SOURCE_RID))'';
  #END
  #IF ( #TEXT(Input_FAC_NAME) <> '' )
    SELF.FAC_NAME := (TYPEOF(SELF.FAC_NAME))'';
  #ELSE
    SELF.FAC_NAME := (TYPEOF(SELF.FAC_NAME))'';
  #END
  #IF ( #TEXT(Input_ADDR1) <> '' )
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))'';
  #ELSE
    SELF.ADDR1 := (TYPEOF(SELF.ADDR1))'';
  #END
  #IF ( #TEXT(Input_LOCALE) <> '' )
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))'';
  #ELSE
    SELF.LOCALE := (TYPEOF(SELF.LOCALE))'';
  #END
  #IF ( #TEXT(Input_ADDRESS) <> '' )
    SELF.ADDRES := (TYPEOF(SELF.ADDRES))'';
  #ELSE
    SELF.ADDRES := (TYPEOF(SELF.ADDRES))'';
  #END
	self.MatchRecords := match_Records;
	self.fullMatch    := full_match;
END;

#uniquename(pr)
%pr% := PROJECT(%apply_clean_cname%,%into%(LEFT)); // Into roxie input format
	
#uniquename(res_out)
%res_out% := Health_Facility_Services.MEOW_xLNPID (%pr%).Data_;

#uniquename(res_out_trim)
%res_out_trim% := sort(dedup(%res_out%, uniqueId, lnpid, weight), uniqueId, -weight);

// Added code to return multiple groups within distance
#uniquename(r0)
%r0% := record
	integer uniqueId;
	unsigned8 lnpid;
	integer weight;
end;

#uniquename(r1)
%r1% := record
	unsigned8 lnpid;
	integer weight;
end;

#uniquename(r2)
%r2% := record
	integer uniqueId;
	dataset(%r1%) DIDs {MAXCOUNT(100)};
end;

#uniquename(g1)
%g1% := group(sort(project(%res_out_trim%,%r0%), uniqueId, lnpid, weight), uniqueId,lnpid);

#uniquename(xform)
%r2% %xform%(recordof(%g1%) l, dataset(recordof(%g1%)) allRows) := transform
	maxScore := max(allrows, weight);
	self.uniqueId 	:= l.uniqueId;
	self.DIDs				:= choosen(PROJECT(allRows(weight >= %in_score% and weight >= (maxScore - %in_distance%)), %r1%), 100);
end;
#uniquename(res)
%res% := rollup(%g1%, group, %xform%(left, rows(left)));

#uniquename(xform1)
%r0% %xform1%(recordof(%res%) l, integer c) := transform
	self.uniqueId := l.uniqueId;
	self.lnpid := l.DIDs[c].lnpid;
	self.weight := l.DIDs[c].weight;
end;
#uniquename(res1)
%res1% := sort(normalize(%res%, count(left.dids), %xform1%(left, counter)), -weight);

// #uniquename(outfile)
outfile := join(%res_out%, %res1%, left.uniqueid = right.uniqueid and left.lnpid = right.lnpid and left.weight = right.weight);
endmacro;