// NOTE:  This is the DOC crim_offenses file
import Crim_Common, hygenics_crim;

ds := dataset('~thor_data400::base::crim_offenses_' + Version.DOC_Offenses+ '_new',
			hygenics_crim.Layout_Moxie_DOC_Offenses,flat,unsorted);

//Crim_Common.Layout_Moxie_DOC_Offenses.previous oldLayout(ds l):= transform - commented b/c offender_key is getting truncated.
	hygenics_Crim.Layout_In_DOC_Offenses.previous oldLayout(ds l):= transform
	
		self := l;
	end;
	
	oldOut := project(ds, oldLayout(left));

export File_DOC_Offenses := oldOut;