import data_services;
//root := data_services.foreign_prod + 'thor::cortera::in::';
root := '~thor::cortera::in::';
// get a specific version of the attributes file.
EXPORT GetAttributesVersion(string8 version) := dataset(root + 'bugatti_stats_' + version + '_output.dat',
																					cortera.Layout_Attributes, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(8192)
																							)
																				);
