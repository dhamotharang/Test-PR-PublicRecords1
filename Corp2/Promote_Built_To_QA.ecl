import versioncontrol;

export Promote_Built_To_QA := 
	sequential(
		 promote().buildfiles.Built2QA
	);