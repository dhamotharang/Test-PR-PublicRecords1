import RoxieKeyBuild, business_header, ut, aca;

export proc_build_AreaCodeChange_keys (string filedate) := function
//NewName		:= business_header.keynames.NewConvention;
//OldName		:= business_header.keynames.OldConvention;

/////////////////////////////////////////////////////////////////////////////////
// -- Build Non-FCRA Keys
/////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_areacode_change,'~thor_data400::key::areacode_change','~thor_data400::key::business_header::'+filedate+'::hri::oldnpa.oldnxx',Buildkey3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_AreaCode_Change_plus,'~thor_data400::key::areacode_change_plus','~thor_data400::key::business_header::'+filedate+'::hri::oldnpa.oldnxx.fixeddates',Buildkey4);

//RoxieKeyBuild.Mac_SK_BuildProcess_Local( key_phone_table,				NewName.HRI.Phone10.New,		'',Buildkey5);


/////////////////////////////////////////////////////////////////////////////////
// -- Build FCRA Neutral Keys
/////////////////////////////////////////////////////////////////////////////////

//RoxieKeyBuild.Mac_SK_BuildProcess_Local( key_phone_table_filtered,			NewName.HRI.Phone10_filtered.New,	'',BuildFCRANeutralkey2);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Non-FCRA Keys to Built
/////////////////////////////////////////////////////////////////////////////////
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::areacode_change','~thor_data400::key::business_header::'+filedate+'::hri::oldnpa.oldnxx',MoveKeyToBuilt3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::areacode_change_plus','~thor_data400::key::business_header::'+filedate+'::hri::oldnpa.oldnxx.fixeddates',MoveKeyToBuilt4);
//RoxieKeyBuild.Mac_SK_Move_To_Built( NewName.HRI.Phone10.New,		OldName.HRI.Phone10.Root,		MoveKeyToBuilt5);
	
/////////////////////////////////////////////////////////////////////////////////
// -- Move FCRA Neutral Keys to Built
/////////////////////////////////////////////////////////////////////////////////

//RoxieKeyBuild.Mac_SK_Move_To_Built( NewName.HRI.Phone10_filtered.New,	OldName.HRI.Phone10_filtered.Root,	MoveFCRANeutralKeyToBuilt2);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Non-FCRA Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::areacode_change','Q',MoveKeyToQA3);
ut.mac_sk_move('~thor_data400::key::areacode_change_plus','Q',MoveKeyToQA4);
//ut.mac_sk_move(OldName.HRI.Phone10.Root,		'Q',MoveKeyToQA5);


/////////////////////////////////////////////////////////////////////////////////
// -- Move FCRA Neutral Keys to QA
/////////////////////////////////////////////////////////////////////////////////

//ut.mac_sk_move(OldName.HRI.Phone10_filtered.Root,	'Q',MoveFCRANeutralKeyToQA2);

build_Non_FCRA_keys := 
	parallel(

		Buildkey3
	   ,Buildkey4
		//,Buildkey5

	);
	
Move_keys_to_built :=
	sequential(

		MoveKeyToQA3
	   ,MoveKeyToBuilt4
		//,MoveKeyToBuilt5
		//,MoveFCRANeutralKeyToBuilt2
	); 
	
Move_keys_to_QA :=
	sequential(

		MoveKeyToQA3
	   ,MoveKeyToQA4
		//,MoveKeyToBuilt5
		//,MoveFCRANeutralKeyToBuilt2
	); 

do_all :=
	sequential(
         build_Non_FCRA_keys

		,Move_keys_to_built
		,Move_keys_to_QA
	);

return do_all;
end;