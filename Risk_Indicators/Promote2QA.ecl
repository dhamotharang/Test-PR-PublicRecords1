import aca;

// -- promote all files and keys to qa versions

export Promote2QA :=
sequential(
	 Promote().Built2QA
	,ACA.Promote().Built2QA
);
