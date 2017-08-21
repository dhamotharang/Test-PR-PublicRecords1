
export Layout_Risk_indicator_Telcordia_tpm_slim:=

RECORD
//maxlength(9999)
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
