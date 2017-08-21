import versioncontrol;

export Promote_Built_To_QA := 
	sequential(
		 promote().buildfiles.QA2Prod
	);