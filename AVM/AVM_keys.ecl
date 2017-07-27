import versioncontrol;

export AVM_keys := module


	shared AVM_file :=AVM.File_Demo_counties_with_addr;
	shared keyfields :={AVM_file.prim_name,AVM_file.prim_range,AVM_file.zip,AVM_file.zip4,AVM_file.sec_range};
	
	VersionControl.macBuildKeyVersions(AVM_file, {keyfields},{AVM_file},avm.keynames.propval, prop_value);
	
	
end;