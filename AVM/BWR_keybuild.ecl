AVM_file :=AVM.File_Demo_counties_with_addr;

keyfields :={AVM_file.prim_name,AVM_file.prim_range,AVM_file.zip,AVM_file.zip4,AVM_file.sec_range};


VersionControl.macBuildKeyVersions(AVM_file, {keyfields},{AVM_file},avm.keynames.propval, prop_value);


VersionControl.macBuildNewLogicalKey(prop_value,avm.keynames.propval, build_prop_value_key);


prop_key := AVM.Filename_Utilities.Roxiekeys.avm_mod.prop_key._Superfiles._Promote();


sequential(build_prop_value_key ,prop_key.New2Built,prop_key.Built2QA2Father);