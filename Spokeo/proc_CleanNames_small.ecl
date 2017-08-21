/*
use this for small files
*/
import Std, Address;

EXPORT proc_CleanNames_small(DATASET(Spokeo.Layout_temp) src) := FUNCTION
		Spokeo.Layout_temp xForm(Spokeo.Layout_temp src) := TRANSFORM
			clean_name := Address.cleanpersonfml73(src.Prepped_name);
		
			self.fname				:=	clean_name[6..25];
			self.mname				:=	clean_name[26..45];
			self.lname				:=	clean_name[46..65];
			self.name_suffix	:=	clean_name[66..70];

			self := src;
		END;
		
		return PROJECT(src, xform(left));

END;