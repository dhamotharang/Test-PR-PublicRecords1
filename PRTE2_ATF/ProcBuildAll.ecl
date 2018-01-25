/** 
 * PRTE2_ATF::ProcBuildAll is utilized in order to do the following for the PRTE2_ATF build:
 *	* Spray up the raw file.
 *	* Build the base file.
 * 	* Build the keys.
 * @param {string} file_name - Either the entire file name, or a distinguishable portion.
 * @param {string} host_name - The remote host in which to retrieve the file from.
 * @param {string} directory - The directory on the remote host in which to retrieve the file from.
 * @requires STD
 * @requires PRTE2
 * @requires PRTE2_ATF
 */
IMPORT $, STD, PRTE2;

EXPORT procBuildAll (
	STRING file_name,
	STRING host_name,
	STRING directory
) := FUNCTION

	version := REGEXFIND('\\d{8}',file_name, 0);

	RETURN SEQUENTIAL(
		PRTE2.SprayFiles.Spray_Raw_Data(
			file_name,
			'firearms',
			'atf',
			FALSE,
			host_name,
			directory,
			'.txt'
		),
		proc_build_base(version), 
		proc_build_keys(version)
	);

END;
