import ut;

// After we start getting data this will be the expected layout
EXPORT File_inAddressFeedback :=  dataset('~thor_data400::in::AddressFeedback',
																					Layouts.Lay_AddressFeedback_in, CSV(Separator('~~')));//, Quote('"'), Terminator(['\r\n'])));
