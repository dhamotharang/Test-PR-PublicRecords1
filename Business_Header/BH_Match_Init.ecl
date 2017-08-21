import address, ut, text;

EXPORT BH_Match_Init(

	 dataset(Layout_Business_Header_New)	pBH_Initial_Base					= BH_Initial_Base	()
	,dataset(Layout_Business_Header_New)	pBH_Merged_Base						= BH_Merged_Base	()
	,string														pPersistname							= persistnames().BHMatchInit													
	,boolean													pShouldRecalculatePersist	= true													

) :=
function

// Change the BH_Init_Flag to TRUE to re-initialize BDID values
BH_File := if(Flags.Building.Initialize or Flags.Building.ResetBdids,
              pBH_Initial_Base,
			  pBH_Merged_Base);

// Parse geo info from company name
MAC_Parse_Geo(BH_File,
              company_name,
			  state,
			  match_geo_city,
              BH_Geo_Parsed)

// Parse branch number
MAC_Parse_Company_Branch(BH_Geo_Parsed,
                         company_name,
                         match_company_name,
                         match_branch_number,
                         match_branch_position,
                         match_branch_unit_desig,
                         match_branch_unit,
                         BH_Branch_Parsed)

Layout_Business_Header_Temp InitBHTemp(BH_Branch_Parsed L) := TRANSFORM
SELF := L;
END;

BH_Temp_Init := PROJECT(BH_Branch_Parsed, InitBHTemp(LEFT));

// Pre-Bdid groups where clean company name, branch unit and address are exact matches
BH_Temp1_Dist := DISTRIBUTE(BH_Temp_Init(zip <> 0), HASH(TRIM(match_company_name), trim(match_branch_unit), zip));
BH_Temp1_Sort := SORT(BH_Temp1_Dist, match_company_name, match_branch_unit, zip, prim_range, prim_name, bdid, LOCAL);
BH_Temp1_Group := GROUP(BH_Temp1_Sort, match_company_name, match_branch_unit, zip, prim_range, prim_name, LOCAL);

Layout_Business_Header_Temp CopyBDID(Layout_Business_Header_Temp L, Layout_Business_Header_Temp R) := TRANSFORM
SELF.bdid := IF(L.bdid = 0, R.bdid, L.bdid);
SELF := R;
END;

BH_Temp1_BDID := GROUP(ITERATE(BH_Temp1_Group, CopyBDID(LEFT, RIGHT)));

BH_Temp_BDID := BH_Temp1_BDID + BH_Temp_Init(zip = 0);

BH_Match_Init_persist := BH_Temp_BDID 
	: persist(pPersistname);
	
returndataset := if(pShouldRecalculatePersist = true, BH_Match_Init_persist
																										, persists().BHMatchInit
									);
									
return returndataset;

end;