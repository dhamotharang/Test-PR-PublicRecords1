import ut,Std;

string8 fn_the_work(string8 pInput) := function

 string8 v_date := pInput;
    
 string4 v_yy := v_date[1..4];
 string2 v_mm := v_date[5..6];
 string2 v_dd := v_date[7..8];
  
 string2 v_mm2 := if(v_mm>'12' or trim(v_mm)='','00',v_mm);
 string2 v_dd2 := if(v_dd>'31' or trim(v_dd)='','00',v_dd);
  
 string v_out := if(trim(pInput)='','',
                 if(v_yy>(string)((integer)((string8)Std.Date.Today())[1..4]+(integer)1) or v_yy<'1900','',
				 v_yy+v_mm2+v_dd2));
				 
 
return v_out;

end;


export fn_fix_dates(dataset(recordof(marriage_divorce_v2.layout_mar_div_intermediate)) int0)
	:=
function

recordof(int0) t_fix_dates(recordof(int0) le) := transform

 string8 v_marriage_filing_dt := fn_the_work(le.marriage_filing_dt);
 string8 v_marriage_dt        := fn_the_work(le.marriage_dt);
 string8 v_divorce_filing_dt  := fn_the_work(le.divorce_filing_dt);
 string8 v_divorce_dt         := fn_the_work(le.divorce_dt); 
 
 self.party1_dob                  := fn_the_work(le.party1_dob);
 self.party1_last_marriage_end_dt := fn_the_work(le.party1_last_marriage_end_dt);
 self.party2_dob                  := fn_the_work(le.party2_dob);
 self.party2_last_marriage_end_dt := fn_the_work(le.party2_last_marriage_end_dt);
 
 self.marriage_filing_dt          := if(v_marriage_filing_dt<>'' and v_marriage_dt<>'' and v_marriage_filing_dt=v_marriage_dt,'',v_marriage_filing_dt);
 self.marriage_dt                 := v_marriage_dt;
 self.divorce_filing_dt           := if(v_divorce_filing_dt<>'' and v_divorce_dt<>'' and v_divorce_filing_dt=v_divorce_dt,'',v_divorce_filing_dt);
 self.divorce_dt                  := v_divorce_dt;

 self := le;
 
end;

p_fix_dates := project(int0,t_fix_dates(left));

return p_fix_dates;

end;
 

