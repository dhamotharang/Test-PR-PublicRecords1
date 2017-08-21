IMPORT PRTE2_DCA;

EXPORT BWR_ONE_TIME_CODE := MODULE

	SHARED MakeSuperKeys(string name) := FUNCTION
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
		RETURN 'SUCCESS';
	END;

	SHARED MakeSuperFiles(string name) := FUNCTION
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_built'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_father'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_grandfather'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, '_delete'));
		FileServices.CreateSuperFile (RegExReplace('@version@', name, ''));
		RETURN 'SUCCESS';
	END;

	EXPORT DO := FUNCTION
		MakeSuperKeys (Constants.dca_keyname + 'autokey::@version@::addressb2');
		MakeSuperKeys (Constants.dca_keyname + 'autokey::@version@::citystnameb2');
		MakeSuperKeys (Constants.dca_keyname + 'autokey::@version@::nameb2');
		MakeSuperKeys (Constants.dca_keyname + 'autokey::@version@::namewords2');
		MakeSuperKeys (Constants.dca_keyname + 'autokey::@version@::payload');
		MakeSuperKeys (Constants.dca_keyname + 'autokey::@version@::stnameb2');
		MakeSuperKeys (Constants.dca_keyname + 'autokey::@version@::zipb2');
		MakeSuperKeys (Constants.dca_keyname + '@version@::entnum');
		MakeSuperKeys (Constants.dca_keyname + '@version@::entnum_nonfilt');
		MakeSuperKeys (Constants.dca_keyname + '@version@::hierarchy_parent_to_child_entnum');
		MakeSuperKeys (Constants.dca_keyname + '@version@::linkids');
		MakeSuperKeys (Constants.dca_keyname + '@version@::bdid');
		MakeSuperKeys (Constants.dca_keyname + '@version@::hierarchy_bdid');
		MakeSuperKeys (Constants.dca_keyname + '@version@::hierarchy_parent_to_child_root_sub');
		MakeSuperKeys (Constants.dca_keyname + '@version@::hierarchy_root_sub');
		MakeSuperKeys (Constants.dca_keyname + '@version@::root_sub');

		MakeSuperFiles (Constants.base_dca + '@version@');

		FileServices.CreateSuperFile (Constants.in_dca);

		RETURN 'SUCCESS';
	End; //Do Function

End;