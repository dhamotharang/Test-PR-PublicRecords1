import prte2_bkevents, PromoteSupers, prte2_bankruptcy, fcra;

basefile := project(Files.infile, Layouts.Base);

PromoteSupers.MAC_SF_BuildProcess(basefile, Constants.base_prefix_name + 'nonfcra::additionalevents', fileout,,,true);

EXPORT proc_build_base := fileout;
	