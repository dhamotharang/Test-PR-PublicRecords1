import Risk_Indicators, UT;

export TPM_Map(string filedate) :=

function

S_TPM 					:= sort(Risk_Indicators.FILE_TPM, OCN); 
S_OCN 				:= sort(Risk_Indicators.FILE_OCN, OCN);
S_PLNAME 	:= dedup(sort(Risk_Indicators.FILE_PLNAME,place_abbr,state),place_abbr,state);

Risk_Indicators.Layout_TPM.J_TPM_OCN T_J1(S_TPM L, S_OCN R) := Transform
 self 																:= L;
 self.ocn_ocn 									:= R.OCN;
 self.ocn_co_name 					:= R.co_name;
 self.ocn_change_code 	:= R.change_code;
 self.ocn_filler 								:= R.filler;
 self.ocn_crlf 									:= R.crlf;
end;

J_TPM_OCN 		:= join(S_TPM, S_OCN, left.OCN=right.OCN, T_J1(left, right)); 
S_TPM_OCN 	:= sort(J_TPM_OCN,place_name,state);
 
Risk_Indicators.Layout_TPM.J_TPM_PLNAME T_J2(S_TPM_OCN L, S_PLNAME R) := Transform
 self := L;
 self.PLNAME_state 							:= R.state;
 self.PLNAME_filler1 						:= R.filler1;
 self.PLNAME_place_abbr 		:= R.place_abbr;
 self.PLNAME_filler2 						:= R.filler2;
 self.PLNAME_place_name 	:= R.place_name;
 self.PLNAME_crlf 								:= R.crlf
end;

J_TPM_PLNAME	:= join(S_TPM_OCN, S_PLNAME, left.place_name=right.place_abbr and left.state=right.state, T_J2(left, right)); 

Risk_Indicators.Layout_TPM.TPM_OUT T_J2_OUT(J_TPM_PLNAME input) := Transform
 self.npa											:= input.npa;
 self.nxx											:= input.nxx;
 self.tb							:= input.block_id;
 self.city											:= input.PLNAME_place_name;
 self.st												:= input.PLNAME_state;
 self.ocn											:= input.ocn_co_name;
 self.company_type			:= input.company_type;
 self.nxx_type							:= input.nxx_type;
 self.dial_ind					:= input.dialable_ind;
 self.point_id								:= input.point_id;
 self.lf													:= input.lf;  
end;

T_J2_OUT1 	:= sort(project(J_TPM_PLNAME, T_J2_OUT(left)),npa,nxx,tb);
F_J2_OUT2	:= T_J2_OUT1(tb = 'A');

Risk_Indicators.Layout_TPM.TPM_OUT norm_tpm(F_J2_OUT2 L, integer cnt) := transform
self.tb 	:= (string)(cnt - 1);
self 	:= L;
end;

N_TPM		:= normalize(F_J2_OUT2(tb <> ''), 10, norm_tpm(left, counter));

Risk_Indicators.Layout_TPM.TPM_OUT T_J3_OUT(T_J2_OUT1 L, N_TPM R) := Transform
 self.npa											:= if(L.npa <> '', L.npa, R.npa);
 self.nxx											:= if(L.nxx <> '', L.nxx, R.nxx);
 self.tb							:= if(L.tb <> '', L.tb, R.tb);
 self.city											:= if(L.city <> '', L.city, R.city);
 self.st												:= if(L.st <> '', L.st, R.st);
 self.ocn											:= if(L.ocn <> '', L.ocn, R.ocn);
 self.company_type			:= if(L.company_type <> '', L.company_type, R.company_type);
 self.nxx_type							:= if(L.nxx_type <> '', L.nxx_type, R.nxx_type);
 self.dial_ind					:= if(L.dial_ind <> '', L.dial_ind, R.dial_ind);
 self.point_id								:= if(L.point_id <> '', L.point_id, R.point_id);
 self.lf													:= L.lf;  
end;

J_TPM_FINAL := join(T_J2_OUT1, N_TPM, left.npa=right.npa and left.nxx=right.nxx and left.tb=right.tb, T_J3_OUT(left, right), full outer);

RETURN output(J_TPM_FINAL,, '~thor_data400::in::tpmdata_'+filedate);

END;























