/*2007-06-15T13:55:01Z (ananth_p venkatachalam)
2007-06-15T13:54:35Z, Copied with AMT from Attribute Modified by Ananth Vankatachalam
*/
import text_search;

string_rec3 := record
		unsigned integer8 maxdocfreq;
		unsigned integer8 maxfreq;
		integer8 meandocsize;
		integer8 uniquenominals;
	end;

export File_Boolean_dstat1(string dname) := dataset('~thor_data400::base::'+dname+'::qa::dstat',string_rec3,thor);