// When called will create the Moxie offenses file, dated per Version_Development
/* 
import lib_stringlib;

string8 fFixDate(string8 pDateIn)
 := if(lib_stringlib.stringlib.StringFilter(pDateIn,'0123456789') <> pDateIn
	or (integer8)pDateIn = 0,
	   '',
	   pDateIn
	  )
 ;

Layout_Moxie_Court_Offenses tCourtOffensesInToOut(Layout_In_Court_Offenses pInput)
 :=
  transform
    self.offender_key       := StringLib.StringToUpperCase(pInput.offender_key);
    self.off_date			:= fFixDate(pInput.off_date);
    self.arr_date			:= fFixDate(pInput.arr_date);
    self.arr_disp_date		:= fFixDate(pInput.arr_disp_date);
    self.court_disp_date	:= fFixDate(pInput.court_disp_date);
    self.sent_date			:= fFixDate(pInput.sent_date);
    self.appeal_date		:= fFixDate(pInput.appeal_date);
	self := pInput;
  end
 ;

dCourtOffensesOut := project(File_In_Court_Offenses,tCourtOffensesInToOut(left));
dArrestOffensesOut:= project(File_In_Arrest_Offenses,tCourtOffensesInToOut(left));

dCombinedOffensesOut
 := dCourtOffensesOut
 +	dArrestOffensesOut
 ;

//--- EXPUNGE RECORDS 20070111 CNG

expunge_offender_key_layout
 :=
  record
	string60 offender_key;
  end;

expunge_offender_key := dataset('~thor_data400::in::expunge_offender_key', expunge_offender_key_layout, flat);

//dedup_expunge_offender_key:= dedup(Crim_Common.Expunge_Offender_Key_List, ALL);
dedup_expunge_offender_key:= dedup(expunge_offender_key, ALL);

Crim_Common.Layout_Moxie_Court_Offenses JoinKeys(Crim_Common.Layout_Moxie_Court_Offenses L, expunge_offender_key_layout R) 
 := TRANSFORM
	self := L;
 end;

dCombinedOffensesOut2 :=
	JOIN(dCombinedOffensesOut, dedup_expunge_offender_key, 
			LEFT.offender_key=RIGHT.offender_key, JoinKeys(left, right), left only, lookup);
			
//END EXPUNGE

export Out_Moxie_Court_Offenses
 := output(dCombinedOffensesOut2,,Crim_Common.Name_Moxie_Court_Offenses_Dev,overwrite);
 
 */