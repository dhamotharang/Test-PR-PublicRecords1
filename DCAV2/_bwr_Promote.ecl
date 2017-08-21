sequential(
	 dcav2.Promote().Inputfiles.sprayed2using
	,dcav2.Promote().Inputfiles.using2used
	,dcav2.Promote(,'base').Buildfiles.Built2QA
	,dcav2.Promote(,'key').Buildfiles.Built2QA
);