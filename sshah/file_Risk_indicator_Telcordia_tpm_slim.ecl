//EXPORT file_Risk_indicator_Telcordia_tpm_slim := 'todo';

import risk_indicators;

key_in := risk_indicators.Key_FCRA_Telcordia_tpm_slim;



layout_out := RECORD
 string3 npa;
  string3 nxx;
  string1 tb;
  string1 dial_ind;
  string1 point_id;
  string2 nxx_type;
  //DATASET({ string5 zip }) zipcodes;
	string5 zip;
  //unsigned8 __internal_fpos__;
 END; 



 layout_out makekey (key_in  l) := transform
self:= l;
self.Zip:=	'Zip';

//self.__internal_fpos__:=	l.__internal_fpos__;

end;

export file_Risk_indicator_Telcordia_tpm_slim := project(key_in,makekey(left));
//output(file_liens_main_id);
