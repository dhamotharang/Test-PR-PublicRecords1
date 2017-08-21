// When called will create the Moxie offenses file, dated per Version_Development
import lib_stringlib, hygenics_crim;

string8 fFixDate(string8 pDateIn)
 := if(lib_stringlib.stringlib.StringFilter(pDateIn,'0123456789') <> pDateIn
	or (integer8)pDateIn = 0,
	   '',
	   pDateIn
	  )
 ;
 
//Reformat to New DOC Offenses Layout 
Layout_In_DOC_Offenses.new tDOCOffensesNewLayout(File_In_DOC_Offenses pInput)
 :=
  transform
	self.total_num_of_offenses := '';
	self.off_of_record := '';
	self := pInput;
  end
  ;

dDOCNewLayout := project(File_In_DOC_Offenses,tDOCOffensesNewLayout(left));

dTXDOCOffenses := File_In_DOC_Offenses_TX_OAG;

dDOCConcat 	:= dDOCNewLayout + dTXDOCOffenses;

Layout_Moxie_DOC_Offenses.new tDOCOffensesInToOut(dDOCConcat pInput)
 :=
  transform
    self.off_date			:= fFixDate(pInput.off_date);
    self.arr_date			:= fFixDate(pInput.arr_date);
    self.arr_disp_date		:= fFixDate(pInput.arr_disp_date);
    self.ct_disp_dt			:= fFixDate(pInput.ct_disp_dt);
    self.stc_dt				:= fFixDate(pInput.stc_dt);
	self := pInput;
  end
 ;

dDOCOffensesO := project(dDOCConcat,tDOCOffensesInToOut(left));

//Hygenics DOC Offense Layout

	//Reformat to New DOC Offenses Layout 
	crossOffense_layout := record
		hygenics_crim.Layout_In_DOC_Offenses.new;
		string50  Parole;
		String50  Probation;
		String40  OffenseTown;
		String8   Convict_dt; 
		string40  Court_County;
	end;
	
	crossOffense_layout tDOCOffensesNew(dDOCOffensesO pInput):= transform
		self.total_num_of_offenses 		:= '';
		self.off_of_record 				:= '';
		self.parole						:= '';
		self.probation					:= '';
		self.offensetown				:= '';
		self.convict_dt					:= '';
		self.court_county				:= '';
		self 							:= pInput;
	end;

dDOCOffensesOut 		:= project(dDOCOffensesO, tDOCOffensesNew(left));

///////////////////////////////////////////////////////////////////////////

//Reformat to modified DOC Offenses Layout 
hygenics_crim.Layout_In_DOC_Offenses.previous tDOCOffensesOldLayout(dDOCOffensesOut pInput)
 :=
  transform
	self := pInput;
  end
 ;

dDOCOffensesOldLayout := project(dDOCOffensesOut,tDOCOffensesOldLayout(left));

//Output Old/New Offenses Formats
export Out_Moxie_DOC_Offenses
 := sequential(output(dDOCOffensesOldLayout,,Crim_Common.Name_Moxie_DOC_Offenses_Dev,overwrite); //old layout
			   output(dDOCOffensesOut,,Crim_Common.Name_Moxie_DOC_Offenses_Dev + '_new',overwrite)); //new layout