import data_services;
//root := data_services.foreign_prod + 'thor::cortera::in::';
root := '~thor::cortera::in::';
// get a specific version of the Cortera header file
EXPORT GetHeaderVersion(string8 version) := dataset(root + 'bugatti_hdr_' + version + '_output.dat', 
																		cortera.Layout_Header, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							)
																				);
																				