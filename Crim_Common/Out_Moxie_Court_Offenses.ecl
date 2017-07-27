// When called will create the Moxie offenses file, dated per Version_Development
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

export Out_Moxie_Court_Offenses
 := output(dCombinedOffensesOut,,Crim_Common.Name_Moxie_Court_Offenses_Dev,overwrite);