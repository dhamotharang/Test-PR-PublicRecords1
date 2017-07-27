IMPORT Business_Header, Text, ut, risk_indicators, RoxieKeyBuild;

bh := Business_Header.File_Business_Header_FP;
NewName		:= business_header.keynames.NewConvention;
OldName		:= business_header.keynames.OldConvention;

layout_slim_bh := Business_Header_SS.layout_MakeCNameWords;

layout_slim_bh MungeName(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim := PROJECT(bh, MungeName(LEFT));

words_final := project(
	business_header_ss.Fn_MakeCNameWords(bh_slim),
	Business_Header_SS.Layout_Header_Word_Index
);

// Output the file to TEMP, we won't need it once the index is
// built on it.
//switching to base for now to match standard
ut.MAC_SF_BuildProcess(words_final, 'BASE::bh_co_name_words', o_wi, 2)

RoxieKeyBuild.Mac_SK_BuildProcess_Local( Key_Prep_BH_Header_Words,		NewName.Base.Conamewords.New,		'',i_wi);
RoxieKeyBuild.Mac_SK_Move_To_Built( NewName.Base.Conamewords.New		,OldName.Base.Conamewords.Root		,MoveKeyToBuilt1	);

// Now build the index


// Build an index on the business header file using
// the bdid as the primary field.
layout_slim_bh2 := RECORD
	bh.bdid;
	bh.city;
	bh.zip;
	bh.fein;
	bh.phone;
END;

layout_slim_bh2 SlimBH(bh l) := TRANSFORM
	SELF := l;
END;

bh_slim2 := PROJECT(bh, SlimBH(LEFT));
bh_slim_ded2 := DEDUP(bh_slim2, bdid, city, zip, fein, phone, ALL);

// Output the file to TEMP, we won't need it once the index is
// built on it.

ut.MAC_SF_BuildProcess(bh_slim_ded2, 'BASE::bh_bdid.city.zip.fein.phone', o_sbh, 2)

// Now build the index
RoxieKeyBuild.Mac_SK_BuildProcess_Local(Key_Prep_BH_BDID_City_Zip_Fein_Phone	,NewName.Base.BdidCityZipFeinPhone.New	,'',i_sbh);
RoxieKeyBuild.Mac_SK_Move_To_Built( 	NewName.Base.BdidCityZipFeinPhone.New	,OldName.Base.BdidCityZipFeinPhone.Root	,MoveKeyToBuilt2	);

all_stuff := SEQUENTIAL(
	PARALLEL(o_wi, o_sbh), 
	ut.SF_MaintBuilding('BASE::bh_co_name_words'),
	ut.SF_MaintBuilding('BASE::bh_bdid.city.zip.fein.phone'),
	PARALLEL(i_wi, i_sbh),
	ut.SF_MaintBuilt('BASE::bh_co_name_words'),
	ut.SF_MaintBuilt('BASE::bh_bdid.city.zip.fein.phone'),
	MoveKeyToBuilt1,
	MoveKeyToBuilt2
	);

export proc_build_Business_Search_Keys := parallel(all_stuff,risk_indicators.proc_build_hri_all);