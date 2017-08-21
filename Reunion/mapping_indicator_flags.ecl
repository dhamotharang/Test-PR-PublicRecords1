import Infutor, Std;

	main := reunion.files.dMain;

	flags := Infutor.GetIndicatorFlags(main, adl, best_fname,best_mname,best_lname,best_name_suffix,best_city,best_st);

	reunion.layouts.l_flags t1(flags le) := transform
			self.main_adl   := intformat(le.LexId,12,1);
			self := le;
	END;


EXPORT mapping_indicator_flags := PROJECT(flags, t1(left));
