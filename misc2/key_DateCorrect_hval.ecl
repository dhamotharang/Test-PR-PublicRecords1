﻿import doxie,Data_Services, vault, _control;

in_ds := misc2.file_in_DateCorrect;

layout_out := record
	data16 hval;
	unsigned4 startDate;
  unsigned4 endDate;
 String2 state;
end;

layout_out in_to_base(in_ds l) := transform
	self.hval := stringlib.string2data(l.hval);
	self.startdate := (unsigned4) l.startdate;
	self.enddate := (unsigned4) l.enddate;
	self := l;
	end;
kf := project(in_ds, in_to_base(left));


#IF(_Control.Environment.onVault) // when running on vault cluster, we need to use the file pointer instead of the roxie key in boca
export Key_DateCorrect_hval  := vault.misc2.key_dateCorrect_hval;
#ELSE
export Key_DateCorrect_hval  := index(kf,{hval},{kf}, Data_Services.Data_location.Prefix()+'thor_data400::key::DateCorrect::hval_' + doxie.Version_SuperKey);
#END;


