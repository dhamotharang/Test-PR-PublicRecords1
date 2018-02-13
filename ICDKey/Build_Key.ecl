import VersionControl;
export Build_Key(string pversion, boolean pUseProd = false) := module

				VersionControl.macBuildNewLogicalKey(Key(pversion,pUseProd).ref_icd10_key.New		,BuildKey	);

				export build_it :=
					if(VersionControl.IsValidVersion(pversion)
					,buildKey
					,output('No Valid version parameter passed, skipping key atribute')
					);
end;