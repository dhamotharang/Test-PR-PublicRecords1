import Data_Services;
//lfn := Data_Services.foreign_dataland + 'thor_data400::in::cortera::20170131::header';
lfn := '~thor::cortera::in::header::';
//'bugatti_hdr_' + version + '_output.dat'
root := '~thor::cortera::in::';

EXPORT File_Header_In(string8 version) := dataset(root + 'bugatti_hdr_' + version + '_output.dat', 
																		cortera.Layout_Header, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(1024)
																							)
																				);
