// NOTE:  This is the DOC crim_offenses file
import Crim_Common, ut, hygenics_crim;

ds := dataset('~thor_data400::base::crim_offenses_' + hygenics_crim.Version.DOC_Offenses + '_new',
			hygenics_crim.Layout_Moxie_DOC_Offenses,flat,unsorted);

	Crim_Common.Layout_Moxie_DOC_Offenses.previous oldLayout(ds l):= transform
		self := l;
	end;
	
	oldOut := project(ds, oldLayout(left));

export File_DOC_Offenses := oldOut;