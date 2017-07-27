import header,address,ut,LN_TU;

LN_TU.Layout_Normalized normalize_names(LN_TU.File_In_Base_All_UID_As_Input l, unsigned1 cnt) := TRANSFORM
  self.clean_name := choose(cnt, l.clean_name1, l.clean_name2, l.clean_name3, l.clean_name4);
  self := l;
end;

dNormalized := NORMALIZE(LN_TU.File_In_Base_All_UID_As_Input,4,normalize_names(left,counter));

export File_In_LN_TU_Normalized := dNormalized(clean_name[46..65]<>'' and clean[117..121]<>''):PERSIST('~thor_dell400_2::persist::File_LN_TU_Normalized_All');




