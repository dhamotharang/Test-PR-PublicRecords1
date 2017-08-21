IMPORT _control, lib_FileServices;
// This module enables purging/cloning of account_monitoring environments.
// It is also useful for creating a sandbox environment.
// 
//
EXPORT FLN_Utils := MODULE

	EXPORT Purge_Pseudo( UNSIGNED1 pseudo_environment,
												STRING cluster_prefix = thorlib.cluster(),
												BOOLEAN delete_superfiles = FALSE
	                    ) := 
	FUNCTION
		// ECL Snippet to purge superfiles and their contents from an environment
		// 
		// 1) Get LogicalFileList of SUPERFILES corresponding to source env (dev, cert, prod, etc)
		// 2) Using APPLY, Clear superfile (and delete subfile)
		//
		// delete_superfiles true means actually remove the superfiles this to true if you want to 
		// actually delete all of the supers from disk, not simply remove subfiles.
		// Standard behavior is to simply remove/delete the subfiles


		STRING purge_env := '::'+ TRIM(StringLib.StringToLowerCase(AccountMonitoring.constants.PSEUDO_EXT(pseudo_environment)));
		string src_mask := '*' + cluster_prefix + '*account_monitoring' + purge_env + '*';
		ds_in := FileServices.LogicalFileList (src_mask, false, true, true);
		filerec := lib_FileServices.FsLogicalFileInfoRecord;

		r := record
			string src_super;
			string src_logical;
		end;

		// use transform to create a nice dataset of our src superfiles and logical superfiles.
		r ChooseFiles (filerec L) := transform
			Self.src_super := '~' + L.name;
			Self.src_logical := '~' + FileServices.GetSuperFileSubName(Self.src_super, 1);
		end; // transform

		ds_files := PROJECT (ds_in, ChooseFiles (Left));

		ClearSuperFile (string src_super) := IF(src_super <> '~', FileServices.ClearSuperFile(src_super, TRUE));
		DeleteSuperFile (string src_super) := IF(src_super <> '~', FileServices.DeleteSuperFile(src_super, TRUE));

		// finally, use APPLY to execute a the copy commands...
		ExecStmts := NOTHOR (APPLY( ds_files, IF(delete_superfiles, DeleteSuperFile(src_super), ClearSuperFile(src_super))));
		DoWork := SEQUENTIAL(OUTPUT(ds_files), 
			IF(cluster_prefix = 'thorwatch' AND RegexFind('^(.*)(prod)', purge_env, NOCASE),
				FAIL('Calling Error. You are not allowed to use this function to purge THORWATCH/PROD.'),
				ExecStmts));

		RETURN DoWork;
	END;

	EXPORT Clone_Pseudo( UNSIGNED1 src_pseudo,
												UNSIGNED1 dst_pseudo,
												STRING src_cluster_prefix = thorlib.cluster(),
												STRING dst_cluster_prefix = thorlib.cluster(), 
												BOOLEAN clone_father = false,
												BOOLEAN clone_grandfather = false,
												BOOLEAN only_supers = false
	                    ) := 
	FUNCTION

		// ECL Snippet to clone superfiles and their contents
		// 
		// 1) Get LogicalFileList of SUPERFILES corresponding to source env (dev, cert, prod, etc)
		// 2) For each file, transform to create values for dest superfile and dest logical file
		// 3) Using APPLY, Create superfile (if not exist), copy src_logical to dst_logical, 
		//    and replace dst_superfile contents with dst_logical.
		//

		// normally we would use thorlib.cluster() -- however, this ECL can clone across clusters
		// for example you can clone from thorwatch to thor_10_219. 
				
		string src_env := '::'+ TRIM(StringLib.StringToLowerCase(AccountMonitoring.constants.PSEUDO_EXT(src_pseudo)));
		string dst_env := '::'+ TRIM(StringLib.StringToLowerCase(AccountMonitoring.constants.PSEUDO_EXT(dst_pseudo)));

		string src_mask := '*' + src_cluster_prefix + '*account_monitoring' + src_env + '*';
		ds_in := FileServices.LogicalFileList (src_mask, false, true, true);
		filerec := lib_FileServices.FsLogicalFileInfoRecord;

		r := record
			string src_super;
			string src_logical;
			string dst_super;
			string dst_logical;
			boolean is_father;
			boolean is_grandfather;
		end;

		// use transform to create a nice dataset of our src/dest superfiles and logical superfiles.
		r ChooseFiles (filerec L) := transform
			Self.src_super := '~' + L.name;
			Self.src_logical := '~' + FileServices.GetSuperFileSubName(Self.src_super, 1);
			Self.dst_super := '~' + RegexReplace(src_cluster_prefix, RegexReplace(src_env, L.name, dst_env, NOCASE), dst_cluster_prefix, NOCASE);
			Self.dst_logical := RegexReplace(src_cluster_prefix, RegexReplace(src_env, Self.src_logical, dst_env, NOCASE), dst_cluster_prefix, NOCASE);
			Self.is_father := RegexFind('^(.*)_father$', Self.src_super, NOCASE);
			Self.is_grandfather := RegexFind('^(.*)_grandfather$', Self.src_super, NOCASE);
		end; // transform

		ds_files := PROJECT (ds_in, ChooseFiles (Left));

		CreateDestSuper(string dst_super) := IF(NOT FileServices.SuperFileExists(dst_super), FileServices.CreateSuperFile(dst_super));
		CopyIfHasNode (string src_logical, string dst_logical, string dst_super, boolean is_father, boolean is_grandfather, boolean only_supers) := 
			IF(only_supers = false AND (src_logical <> '~') AND (src_logical <> dst_logical) 
			AND (is_father = false OR clone_father)
			AND (is_grandfather = false OR clone_grandfather),
				SEQUENTIAL(
				IF(NOT FileServices.FileExists(dst_logical), 
					FileServices.Copy(src_logical, dst_cluster_prefix, dst_logical,,,,,TRUE,FALSE,FALSE,TRUE)),
				FileServices.StartSuperFileTransaction(),
				FileServices.ClearSuperFile(dst_super),
				FileServices.AddSuperFile(dst_super, dst_logical),
				FileServices.FinishSuperFileTransaction())
				);

		// finally, use APPLY to execute a the copy commands...
		ExecStmts := NOTHOR (APPLY( ds_files, CreateDestSuper(dst_super), CopyIfHasNode(src_logical, dst_logical, dst_super, is_father, is_grandfather, only_supers)));

		DoWork := SEQUENTIAL(OUTPUT(ds_files), 
			IF( (dst_cluster_prefix = 'thorwatch' AND RegexFind('^(.*)(prod)', dst_env, NOCASE))
					OR (src_env = dst_env AND src_cluster_prefix = dst_cluster_prefix),
				FAIL('Calling Error. You are either overwriting THORWATCH/PROD or Source/Dest cluster/environment are the same.'),
				ExecStmts));
			RETURN DoWork;
END;

END;
