
import RoxieKeyBuild, business_header, ut, aca;

export proc_build_AreaCodeChange_FCRAkeys(string filedate) := function


/////////////////////////////////////////////////////////////////////////////////
// -- Build FCRA Keys
/////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key_AreaCode_Change_plus,'~thor_data400::key::fcra::areacode_change_plus','~thor_data400::key::business_header::'+filedate+'::hri::fcra::oldnpa.oldnxx.fixeddates',Buildkey1);


/////////////////////////////////////////////////////////////////////////////////
// -- Move FCRA Keys to Built
/////////////////////////////////////////////////////////////////////////////////
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::fcra::areacode_change_plus','~thor_data400::key::business_header::'+filedate+'::hri::fcra::oldnpa.oldnxx.fixeddates',MoveKeyToBuilt1);

/////////////////////////////////////////////////////////////////////////////////
// -- Move FCRA Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::fcra::areacode_change_plus','Q',MoveKeyToQA1);


build_FCRA_keys := 
	parallel(
		Buildkey1
	);
	
Move_keys_to_built :=
	sequential(
		MoveKeyToBuilt1
	); 
	
Move_keys_to_QA :=
	sequential(
		MoveKeyToQA1
	); 

do_all :=
	sequential(
         build_FCRA_keys

		,Move_keys_to_built
		,Move_keys_to_QA
	);

return do_all;
end;