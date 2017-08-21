// PRTE2_LNProperty.NEW_Proc_Build_LNPropertyV2_keys
/* *********************************************************************************
RETURN THIS TO A BOCA TYPE BUILD AS SOON AS POSSIBLE.
1. IF any defines were moved from PRTE_CSV into here - put them back back into PRTE_CSV if that makes sense.
   (Make sure all key definitions, etc that Boca would expect in PRTE(_CSV) are there for them to edit if keys change)
2. Copy this to PRTE and confirm that the build and references all work
3. Set up the options in the function the same as we have other new builds to allow defaults but allow Alpha options needed.

OPTIONAL:
1. Remove all references in here as much as possible from the PRTE2_LNPROPERTY
********************************************************************************* */

EXPORT	NEW_Proc_Build_LNPropertyV2_Keys(string	pIndexVersion)	:= FUNCTION

		ExpandedLayout := layouts.layout_LNP_V2_expanded_payload;
		AlphaExpandedName := Files.AlphaExpandedName;
		AlphaDedupAuditFileName := Files.AlphaDedupAuditFileName;
		finalAllExpandedName := Files.finalAllExpandedName;

		BaseBoca := Get_payload.EXISTING_LNPROPERTYV2;
		BaseAlpha := Get_payload.NEW_LNPROPERTYV2(pIndexVersion) :PERSIST(AlphaExpandedName);

		F1 := dedup(project(BaseBoca,ExpandedLayout),RECORD,ALL);
		F2 := dedup(project(BaseAlpha,ExpandedLayout),RECORD,ALL) :PERSIST(AlphaDedupAuditFileName);

		All_Expanded := F1 + F2  :PERSIST(finalAllExpandedName);
		KeyDef := Keys(All_Expanded, pIndexVersion);

		return	sequential(
							OUTPUT('ready to build auto keys'),
							parallel(
										build(KeyDef.kKeyLNPropertyV2__autokey__address			,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__addressb2		,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__citystname		,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__citystnameb2	,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__fein2				,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__name					,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__nameb2				,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__namewords2		,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__payload			,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__phone2				,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__phoneb2			,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__ssn2					,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__stname				,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__stnameb2			,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__zip					,update),
										build(KeyDef.kKeyLNPropertyV2__autokey__zipb2				,update),
										build(KeyDef.kKeyLNPropertyV2__addlfaresdeed_fid			,update),
										build(KeyDef.kKeyLNPropertyV2__addlfarestax_fid			,update),
										build(KeyDef.kKeyLNPropertyV2__addllegal_fid					,update),
										build(KeyDef.kKeyLNPropertyV2__addr_search_fid				,update),
										build(KeyDef.kKeyLNPropertyV2__assessor_fid					,update),
										build(KeyDef.kKeyLNPropertyV2__assessor_parcelnum		,update),
										build(KeyDef.kKeyLNPropertyV2__deed_fid						  ,update),
										build(KeyDef.kKeyLNPropertyV2__deed_parcelnum				,update),
										build(KeyDef.kKeyLNPropertyV2__search_bdid						,update),
										build(KeyDef.kKeyLNPropertyV2__search_did						,update),
										build(KeyDef.kKeyLNPropertyV2__search_fid						,update),
										build(KeyDef.kKeyLNPropertyV2__search_fid_county			,update),
										build(KeyDef.kKeyLNPropertyV2__search_LinkIDs				,update),
										build(KeyDef.kKeyLNPropertyV2__search_fid_LinkIDs		,update),
										build(KeyDef.kKeyLNPropertyV2__addllegal_fid_fcra				,update),
										build(KeyDef.kKeyLNPropertyV2__addr_search_fid_fcra			,update),
										build(KeyDef.kKeyLNPropertyV2__assessor_fid_fcra					,update),
										build(KeyDef.kKeyLNPropertyV2__deed_fid_fcra						  ,update),
										build(KeyDef.kKeyLNPropertyV2__search_bdid_fcra					,update),
										build(KeyDef.kKeyLNPropertyV2__search_did_fcra						,update),
										build(KeyDef.kKeyLNPropertyV2__search_fid_fcra						,update),
										build(KeyDef.kKeyLNPropertyV2__search_fid_county_fcra		,update)
										)
							);
END;
