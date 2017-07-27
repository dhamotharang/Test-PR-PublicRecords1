//////////////////////////////////////////////////////////////////////////////

//	This function is used to change, append the version of the superkey 
// 	to reflect to both new and old naming conventions.
//	Example:	
//	Old format - 'thor_data400::key::bankrupt_did_qa'
//	check_replace_version('thor_data400::key::bankrupt_did','qa')
//	New format - 'thor_data400::key::bankrupt::qa::did'
//  check_replace_version('thor_data400::key::bankrupt::@version@::did','qa')

//////////////////////////////////////////////////////////////////////////////

export check_replace_version(string keyname, string ver) :=
function

str := if (regexfind('@version@',keyname),regexreplace('@version@',keyname,ver),keyname + '_' + ver);

return str;

end;