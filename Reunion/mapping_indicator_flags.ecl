import Infutor, Std;

EXPORT mapping_indicator_flags(unsigned1 mode, STRING sVersion) := MODULE

	main := reunion.files(mode).dMain;

	flags := Infutor.GetIndicatorFlags(main, adl, best_fname,best_mname,best_lname,best_name_suffix,best_city,best_st);

	reunion.layouts.l_flags t1(flags le) := transform
			self.main_adl   := intformat(le.LexId,12,1);
			self := le;
	END;


EXPORT all := PROJECT(flags, t1(left));

END;
