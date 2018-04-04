import Data_Services;
lfn := '~thor_data400::in::cortera::20170131::attributes';
root := data_services.foreign_prod + 'thor::cortera::in::';

EXPORT File_Attributes_In := dataset('~thor::cortera::attr_in',
																					cortera.Layout_Attributes, CSV(
																								SEPARATOR('|')
																							, TERMINATOR(['\n', '\r\n'])
																							, HEADING(1)
																							, MAXLENGTH(8192)
																							)
																				);
