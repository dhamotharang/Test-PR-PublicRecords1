/*
This will return the superfile of all daily updates for the given month
*/
import ut;
EXPORT GetDailyUpdates(string version) := dataset(			// version format: YYYYMM
				ut.foreign_prod + 'thor::in::gong::targus::daily::' + version,
						layout_neustar,
						 CSV(
									SEPARATOR('|')
								, TERMINATOR(['\n', '\r\n'])
								, MAXLENGTH(2500)
								)
					);