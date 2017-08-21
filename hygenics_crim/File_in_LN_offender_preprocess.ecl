import Crim_Common, Address, nid;

lnOffender					:= hygenics_crim.File_In_Court_Offender + 
                       hygenics_crim.File_In_Arrest_Offender +
											 hygenics_crim.DOC_Offender_as_Offender2;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		////////////Include the LN files created from raw //////////////////////////////
		
		dCombined_DOC_and_CrimOffender2  := lnOffender;
 
    rNewOffenderLayout  :=   record
			hygenics_crim.Layout_Common_Crim_Offender_orig;
			string8	file_date; //new field
			string13	county_of_birth; //new field
			string13	current_residence_county; //new field
			string13	legal_residence_county; //new field
			string10	scars_marks_tattoos_1; //new field
			string10	scars_marks_tattoos_2; //new field
			string10	scars_marks_tattoos_3; //new field
			string10	scars_marks_tattoos_4; //new field
			string10	scars_marks_tattoos_5; //new field
			string10	_3g_offender; //new field
			string10	violent_offender; //new field
			string10	sex_offender; //new field
			string10	vop_offender; //new field
			string26	record_setup_date; //new field
		end;

    rNewOffenderLayout tCrimOffenderNewLayout(dCombined_DOC_and_CrimOffender2 pInput) :=   transform
			self.file_date:='';
			self.county_of_birth:='';
			self.current_residence_county:='';
			self.legal_residence_county:='';
			self.scars_marks_tattoos_1:='';
			self.scars_marks_tattoos_2:='';
			self.scars_marks_tattoos_3:='';
			self.scars_marks_tattoos_4:='';
			self.scars_marks_tattoos_5:='';
			self._3g_offender:='';
			self.violent_offender:='';
			self.sex_offender:='';
			self.vop_offender:='';
			self.record_setup_date:='';
			self.pgid:='';
			self.src_upload_date:='';
			self.age:='';
			self.image_link:='';
			self.nid:=0;
			self.ntype:='';
			self.nindicator:=0;
			//self.offender_persistent_id := 0;
			self := pInput;
		end ;

dConcatCrim_and_DOC_NewLayout := project(dCombined_DOC_and_CrimOffender2, tCrimOffenderNewLayout(left));

/////////////////////////////////////////////////////////////////////////
//Reclean names that appear to have an issue from the current LFM cleaner
/////////////////////////////////////////////////////////////////////////
vendor_exception_list := ['05','09','11','12','14','15','27','34','31','44','46','54','56','57','59','61','64','66','69','73','76','77','78','79','80','81','82','87','89','90','94','97','1D','1F','1G','1H'];

dNameHistoricalRecords     := dConcatCrim_and_DOC_NewLayout(vendor in vendor_exception_list);
dNameUpdatingRecords       := dConcatCrim_and_DOC_NewLayout(vendor not in vendor_exception_list);

dNameRecleanCandidates     := dNameUpdatingRecords(pty_nm_fmt = 'L' and regexfind('[A-Z]+[ ]+[A-Z]+', lname) = TRUE);
dNameRecleanNonCandidatesA := dNameUpdatingRecords(pty_nm_fmt = 'L' and regexfind('[A-Z]+[ ]+[A-Z]+', lname) = FALSE);
dNameRecleanNonCandidatesB := dNameUpdatingRecords(pty_nm_fmt != 'L');


dNameRecleanCandidates80     := dNameRecleanCandidates(regexfind('80', cleaning_score) and regexfind('[A-Z]+[ ]+[A-Z]+[ ]+[A-Z]+', lname) = FALSE);
dNameRecleanCandidatesNot80A := dNameRecleanCandidates(regexfind('80', cleaning_score) and regexfind('[A-Z]+[ ]+[A-Z]+[ ]+[A-Z]+', lname) = TRUE);
dNameRecleanCandidatesNot80B := dNameRecleanCandidates(cleaning_score != '80' and cleaning_score != '080');

dConcatCrim_and_DOC_NewLayout tNewNames(dNameRecleanCandidates80 input) := Transform

temp_input_pty_nm := regexreplace(',Jr\\.|,JR\\.| \\.JR | JR\\., | JR,\\. | JR\\. | JR, | JR | \\.SR | SR\\., | SR,\\. | SR\\. | SR, | SR | \\.III | III\\., | III,\\. | III\\. | III, | III | \\.IV | IV\\., | IV,\\. | IV\\. | IV, | IV | 2ND | 3RD ', input.pty_nm, ' ');

PreName_Lname := if(regexfind(',', input.pty_nm) = TRUE,
                    //if(stringlib.stringfindcount(input.pty_nm,',') >= 2, 
										//temp_input_pty_nm[1..DataLib.StringFind(temp_input_pty_nm,',',2) - 1],
                    temp_input_pty_nm[1..DataLib.StringFind(temp_input_pty_nm,',',1) - 1],
                    if(regexfind('^MC |^DE |^ST |^LA |^VAN', temp_input_pty_nm) = TRUE, temp_input_pty_nm[1..DataLib.StringFind(temp_input_pty_nm,' ',2) - 1],
										                                                                    temp_input_pty_nm[1..DataLib.StringFind(temp_input_pty_nm,' ',1) - 1]));

PreName_FMname := if(regexfind(',', input.pty_nm) = TRUE, 
                     //if(stringlib.stringfindcount(input.pty_nm,',') >= 2,
                     //temp_input_pty_nm[DataLib.StringFind(temp_input_pty_nm,',',2)+1..35],
										 temp_input_pty_nm[DataLib.StringFind(temp_input_pty_nm,',',1)+1..35],
										 if(regexfind('^MC |^DE |^ST |^LA |^VAN', temp_input_pty_nm) = TRUE, temp_input_pty_nm[DataLib.StringFind(temp_input_pty_nm,' ',2)+1..35],
										                                                                     temp_input_pty_nm[DataLib.StringFind(temp_input_pty_nm,' ',1)+1..35]));

PreName_Suffix := if(regexfind(',Jr\\.|,JR\\.| \\.JR | JR\\., | JR,\\. | JR\\. | JR, | JR | \\.SR | SR\\., | SR,\\. | SR\\. | SR, | SR | \\.III | III\\., | III,\\. | III\\. | III, | III | \\.IV | IV\\., | IV,\\. | IV\\. | IV, | IV |2ND|3RD ', input.pty_nm) = TRUE,
                     regexfind(',Jr\\.|,JR\\.| \\.JR | JR\\., | JR,\\. | JR\\. | JR, | JR | \\.SR | SR\\., | SR,\\. | SR\\. | SR, | SR | \\.III | III\\., | III,\\. | III\\. | III, | III | \\.IV | IV\\., | IV,\\. | IV\\. | IV, | IV |2ND|3RD ', input.pty_nm, 0), '');


ReCleanedName	:= Address.CleanPersonFMl73(PreName_FMname + ' ' + PreName_Lname + ' ' + PreName_Suffix);						

//self.case_name := trim(input.pty_nm, LEFT, RIGHT);
//self.pty_nm   := trim(PreName_FMname, LEFT, RIGHT) + ' ' + trim(PreName_Lname, LEFT, RIGHT);						
self.title 			:= ReCleanedName[1..5];
self.fname 			:= ReCleanedName[6..25];
self.mname 			:= ReCleanedName[26..45];
self.lname 			:= ReCleanedName[46..65];
self.name_suffix 	:= ReCleanedName[66..70];
self.cleaning_score := ReCleanedName[71..73];
self				:= input; 

end;

NewCleanNames := project(dNameRecleanCandidates80,tNewNames(left));

dReCleanNamesAll := dNameHistoricalRecords + dNameRecleanNonCandidatesA + dNameRecleanNonCandidatesB + dNameRecleanCandidatesNot80A + dNameRecleanCandidatesNot80B + NewCleanNames;

EXPORT File_in_LN_offender_preprocess := dReCleanNamesAll;