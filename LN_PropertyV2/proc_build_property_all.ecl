export proc_build_property_all(filedate) := macro

	import LN_PropertyV2,RoxieKeyBuild;

		
	Proc_Build_Base				:= LN_PropertyV2.Proc_build_base		       : success(output('PropertyV2 Base Files created successfully.'));
	Proc_Build_Keys				:= LN_PropertyV2.proc_build_keys(filedate)     : success(output('PropertyV2 Keys created successfully.'));
	
	 sequential(Proc_Build_Base,Proc_Build_Keys);
endmacro;
 