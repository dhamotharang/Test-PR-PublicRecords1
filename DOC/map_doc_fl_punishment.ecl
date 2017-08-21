import Crim_common, Address, Ut, lib_stringlib;

input := DOC.file_doc_fl(regexfind('[0-9]', dc_number));

/////////////////
/*
history := dataset(ut.foreign_prod+'~thor_data400::in::fl_doc_punishment_history',
			crim_common.Layout_In_DOC_Punishment.previous, flat)(vendor = 'FL');

Crim_Common.Layout_Moxie_DOC_Punishment.previous dojoin(Crim_Common.Layout_Moxie_DOC_Punishment.previous r) := transform
	self := r;
end;

historyout := join(distribute(input, hash(dc_number)), distribute(history, hash(regexreplace('^[(FL)]', offender_key, ''))), left.dc_number = regexreplace('^(FL)', right.offender_key, ''), dojoin(right), right only, local);
*/
////////////////

input_new_layout := record, maxlength(7000) 
string	DART_ID;
string	Date_Added;
string	Date_Updated;
string	Website;
string	Search_Type;
string	Current_As_Of;
string	DC_Number;
string	Name;
string	Race;
string	Sex;
string	Hair_Color;
string	Eye_Color;
string	Height;
string	Weight;
string	Birth_Date;
string	Supervision_Begin_Date;
string	Current_Location;
string	Current_Status;
string	Warrant_Date;
string	Supervision_Type;
string	Initial_Receipt_Date;
string	Current_Facility;
string	Current_Classification_Status;
string	Current_Custody;
string	Current_Release_Date;
string	Scheduled_Termination_Date;
string	Release_Facility;
string	Custody;
string	Release_Date;
string	State_Residence_Upon_Release;
string	Current_Verified_Address;
string	Aliases;
string Community_Supervision_Case_No;
string Community_Supervision_County;
string Community_Supervision_Length;
string Community_Supervision_Offense;
string Community_Supervision_Offense_Date;
string Community_Supervision_Sentence_Date;
string Current_Prison_Sentence_Offense_Date;
string Current_Prison_Sentence_Offense;
string Current_Prison_Sentence_Date;
string Current_Prison_Sentence_County;
string Current_Prison_Sentence_Case_No;
string Current_Prison_Sentence_Length;
string Incarceration_History_Date_In_Custody;
string Incarceration_History_Date_Out_Of_Custody;
string Prior_Prison_Sentence_Offense_Date;
string Prior_Prison_Sentence_Offense;
string Prior_Prison_Sentence_Date;
string Prior_Prison_Sentence_County;
string Prior_Prison_Sentence_Case_No;
string Prior_Prison_Sentence_Length;
string Prior_Community_Supervision_Case_No;
string Prior_Community_Supervision_County;
string Prior_Community_Supervision_Length;
string Prior_Community_Supervision_Offense;
string Prior_Community_Supervision_Offense_Date;
string Prior_Community_Supervision_Sentence_Date;
string Detainer_Date;
string Detainer_Agency;
string Detainer_Type;
string Detainer_Date_Cancelled;
string Scars_Marks_and_Tattoos_Type;
string Scars_Marks_and_Tattoos_Location;
string Scars_Marks_and_Tattoos_Description;
string	Escape_Facility;
string	Escape_Notice;
string	Capture_Notice;
string	Date_of_Escape;
string	Date_of_Capture;
string	Special_Notes;
string	Scars_Marks_Tattoos_Other;
string	Offense_and_Sentence;
string	Last_Known_Location;
string	Work_Skills;
string	ImageName;
string	ImageDate; 
end;


input_new_layout Norm(input L, INTEGER C) := TRANSFORM
SELF := L;
	self.Community_Supervision_Case_No := choose(c, l.Community_Supervision_Case_No_1,  l.Community_Supervision_Case_No_2, l.Community_Supervision_Case_No_3, l.Community_Supervision_Case_No_4, l.Community_Supervision_Case_No_5);
	self.Community_Supervision_County := choose(c, l.Community_Supervision_County_1,  l.Community_Supervision_County_2, l.Community_Supervision_County_3, l.Community_Supervision_County_4, l.Community_Supervision_County_5);
	self.Community_Supervision_Length := choose(c, l.Community_Supervision_Length_1,  l.Community_Supervision_Length_2, l.Community_Supervision_Length_3, l.Community_Supervision_Length_4, l.Community_Supervision_Length_5);
	self.Community_Supervision_Offense := choose(c, l.Community_Supervision_Offense_1,  l.Community_Supervision_Offense_2, l.Community_Supervision_Offense_3, l.Community_Supervision_Offense_4, l.Community_Supervision_Offense_5);
	self.Community_Supervision_Offense_Date := choose(c, l.Community_Supervision_Offense_Date_1,  l.Community_Supervision_Offense_Date_2, l.Community_Supervision_Offense_Date_3, l.Community_Supervision_Offense_Date_4, l.Community_Supervision_Offense_Date_5);
	self.Community_Supervision_Sentence_Date := choose(c, l.Community_Supervision_Sentence_Date_1,  l.Community_Supervision_Sentence_Date_2, l.Community_Supervision_Sentence_Date_3, l.Community_Supervision_Sentence_Date_4, l.Community_Supervision_Sentence_Date_5);
	self.Current_Prison_Sentence_Offense_Date := choose(c, l.Current_Prison_Sentence_Offense_Date_1,  l.Current_Prison_Sentence_Offense_Date_2, l.Current_Prison_Sentence_Offense_Date_3, l.Current_Prison_Sentence_Offense_Date_4, l.Current_Prison_Sentence_Offense_Date_5);
	self.Current_Prison_Sentence_Offense := choose(c, l.Current_Prison_Sentence_Offense_1,  l.Current_Prison_Sentence_Offense_2, l.Current_Prison_Sentence_Offense_3, l.Current_Prison_Sentence_Offense_4, l.Current_Prison_Sentence_Offense_5);
	self.Current_Prison_Sentence_Date := choose(c, l.Current_Prison_Sentence_Date_1,  l.Current_Prison_Sentence_Date_2, l.Current_Prison_Sentence_Date_3, l.Current_Prison_Sentence_Date_4, l.Current_Prison_Sentence_Date_5);
	self.Current_Prison_Sentence_County := choose(c, l.Current_Prison_Sentence_County_1,  l.Current_Prison_Sentence_County_2, l.Current_Prison_Sentence_County_3, l.Current_Prison_Sentence_County_4, l.Current_Prison_Sentence_County_5);
	self.Current_Prison_Sentence_Case_No := choose(c, l.Current_Prison_Sentence_Case_No_1,  l.Current_Prison_Sentence_Case_No_2, l.Current_Prison_Sentence_Case_No_3, l.Current_Prison_Sentence_Case_No_4, l.Current_Prison_Sentence_Case_No_5);
	self.Current_Prison_Sentence_Length := choose(c, l.Current_Prison_Sentence_Length_1,  l.Current_Prison_Sentence_Length_2, l.Current_Prison_Sentence_Length_3, l.Current_Prison_Sentence_Length_4, l.Current_Prison_Sentence_Length_5);
	self.Incarceration_History_Date_In_Custody := choose(c, l.Incarceration_History_Date_In_Custody_1,  l.Incarceration_History_Date_In_Custody_2, l.Incarceration_History_Date_In_Custody_3, l.Incarceration_History_Date_In_Custody_4, l.Incarceration_History_Date_In_Custody_5);
	self.Incarceration_History_Date_Out_Of_Custody := choose(c, l.Incarceration_History_Date_Out_Of_Custody_1,  l.Incarceration_History_Date_Out_Of_Custody_2, l.Incarceration_History_Date_Out_Of_Custody_3, l.Incarceration_History_Date_Out_Of_Custody_4, l.Incarceration_History_Date_Out_Of_Custody_5);
	self.Prior_Prison_Sentence_Offense_Date := choose(c, l.Prior_Prison_Sentence_Offense_Date_1,  l.Prior_Prison_Sentence_Offense_Date_2, l.Prior_Prison_Sentence_Offense_Date_3, l.Prior_Prison_Sentence_Offense_Date_4, l.Prior_Prison_Sentence_Offense_Date_5);
	self.Prior_Prison_Sentence_Offense := choose(c, l.Prior_Prison_Sentence_Offense_1,  l.Prior_Prison_Sentence_Offense_2, l.Prior_Prison_Sentence_Offense_3, l.Prior_Prison_Sentence_Offense_4, l.Prior_Prison_Sentence_Offense_5);
	self.Prior_Prison_Sentence_Date := choose(c, l.Prior_Prison_Sentence_Date_1,  l.Prior_Prison_Sentence_Date_2, l.Prior_Prison_Sentence_Date_3, l.Prior_Prison_Sentence_Date_4, l.Prior_Prison_Sentence_Date_5);
	self.Prior_Prison_Sentence_County := choose(c, l.Prior_Prison_Sentence_County_1,  l.Prior_Prison_Sentence_County_2, l.Prior_Prison_Sentence_County_3, l.Prior_Prison_Sentence_County_4, l.Prior_Prison_Sentence_County_5);
	self.Prior_Prison_Sentence_Case_No := choose(c, l.Prior_Prison_Sentence_Case_No_1,  l.Prior_Prison_Sentence_Case_No_2, l.Prior_Prison_Sentence_Case_No_3, l.Prior_Prison_Sentence_Case_No_4, l.Prior_Prison_Sentence_Case_No_5);
	self.Prior_Prison_Sentence_Length := choose(c, l.Prior_Prison_Sentence_Length_1,  l.Prior_Prison_Sentence_Length_2, l.Prior_Prison_Sentence_Length_3, l.Prior_Prison_Sentence_Length_4, l.Prior_Prison_Sentence_Length_5);
	self.Prior_Community_Supervision_Case_No := choose(c, l.Prior_Community_Supervision_Case_No_1,  l.Prior_Community_Supervision_Case_No_2, l.Prior_Community_Supervision_Case_No_3, l.Prior_Community_Supervision_Case_No_4, l.Prior_Community_Supervision_Case_No_5);
	self.Prior_Community_Supervision_County := choose(c, l.Prior_Community_Supervision_County_1,  l.Prior_Community_Supervision_County_2, l.Prior_Community_Supervision_County_3, l.Prior_Community_Supervision_County_4, l.Prior_Community_Supervision_County_5);
	self.Prior_Community_Supervision_Length := choose(c, l.Prior_Community_Supervision_Length_1,  l.Prior_Community_Supervision_Length_2, l.Prior_Community_Supervision_Length_3, l.Prior_Community_Supervision_Length_4, l.Prior_Community_Supervision_Length_5);
	self.Prior_Community_Supervision_Offense := choose(c, l.Prior_Community_Supervision_Offense_1,  l.Prior_Community_Supervision_Offense_2, l.Prior_Community_Supervision_Offense_3, l.Prior_Community_Supervision_Offense_4, l.Prior_Community_Supervision_Offense_5);
	self.Prior_Community_Supervision_Offense_Date := choose(c, l.Prior_Community_Supervision_Offense_Date_1,  l.Prior_Community_Supervision_Offense_Date_2, l.Prior_Community_Supervision_Offense_Date_3, l.Prior_Community_Supervision_Offense_Date_4, l.Prior_Community_Supervision_Offense_Date_5);
	self.Prior_Community_Supervision_Sentence_Date := choose(c, l.Prior_Community_Supervision_Sentence_Date_1,  l.Prior_Community_Supervision_Sentence_Date_2, l.Prior_Community_Supervision_Sentence_Date_3, l.Prior_Community_Supervision_Sentence_Date_4, l.Prior_Community_Supervision_Sentence_Date_5);
	self.Detainer_Date := choose(c, l.Detainer_Date_1,  l.Detainer_Date_2, l.Detainer_Date_3, l.Detainer_Date_4, l.Detainer_Date_5);
	self.Detainer_Agency := choose(c, l.Detainer_Agency_1,  l.Detainer_Agency_2, l.Detainer_Agency_3, l.Detainer_Agency_4, l.Detainer_Agency_5);
	self.Detainer_Type := choose(c, l.Detainer_Type_1,  l.Detainer_Type_2, l.Detainer_Type_3, l.Detainer_Type_4, l.Detainer_Type_5);
	self.Detainer_Date_Cancelled := choose(c, l.Detainer_Date_Cancelled_1,  l.Detainer_Date_Cancelled_2, l.Detainer_Date_Cancelled_3, l.Detainer_Date_Cancelled_4, l.Detainer_Date_Cancelled_5);
	self.Scars_Marks_and_Tattoos_Type := choose(c, l.Scars_Marks_and_Tattoos_Type_1,  l.Scars_Marks_and_Tattoos_Type_2, l.Scars_Marks_and_Tattoos_Type_3, l.Scars_Marks_and_Tattoos_Type_4, l.Scars_Marks_and_Tattoos_Type_5);
	self.Scars_Marks_and_Tattoos_Location := choose(c, l.Scars_Marks_and_Tattoos_Location_1,  l.Scars_Marks_and_Tattoos_Location_2, l.Scars_Marks_and_Tattoos_Location_3, l.Scars_Marks_and_Tattoos_Location_4, l.Scars_Marks_and_Tattoos_Location_5);
	self.Scars_Marks_and_Tattoos_Description := choose(c, l.Scars_Marks_and_Tattoos_Description_1,  l.Scars_Marks_and_Tattoos_Description_2, l.Scars_Marks_and_Tattoos_Description_3, l.Scars_Marks_and_Tattoos_Description_4, l.Scars_Marks_and_Tattoos_Description_5);
END;

normedINPUTp1 := dedup(sort(NORMALIZE(distribute(input, hash(DC_Number)), 5 ,Norm(LEFT,COUNTER)), record, local), record, local);

normedlayout := record, maxlength(7000) 
string	DART_ID;
string	Date_Added;
string	Date_Updated;
string	Website;
string	Search_Type;
string	Current_As_Of;
string	DC_Number;
string	Name;
string	Race;
string	Sex;
string	Hair_Color;
string	Eye_Color;
string	Height;
string	Weight;
string	Birth_Date;
string	Supervision_Begin_Date;
string	Current_Location;
string	Current_Status;
string	Warrant_Date;
string	Supervision_Type;
string	Initial_Receipt_Date;
string	Current_Facility;
string	Current_Classification_Status;
string	Current_Custody;
string	Current_Release_Date;
string	Scheduled_Termination_Date;
string	Release_Facility;
string	Custody;
string	Release_Date;
string	State_Residence_Upon_Release;
string	Current_Verified_Address;
string	Aliases;
string charge_type;
string Case_No;
string County;
string Sent_Length;
string Offense;
string Offense_Date;
string Sentence_Date;
string Detainer_Date;
string Detainer_Agency;
string Detainer_Type;
string Detainer_Date_Cancelled;
string Scars_Marks_and_Tattoos_Type;
string Scars_Marks_and_Tattoos_Location;
string Scars_Marks_and_Tattoos_Description;
string	Escape_Facility;
string	Escape_Notice;
string	Capture_Notice;
string	Date_of_Escape;
string	Date_of_Capture;
string	Special_Notes;
string	Scars_Marks_Tattoos_Other;
string	Offense_and_Sentence;
string	Last_Known_Location;
string	Work_Skills;
string	ImageName;
string	ImageDate; 
end;


normedlayout Norm2(normedINPUTp1 L, INTEGER C) := TRANSFORM
	SELF := L;
	self.charge_type := choose(c, 'CM', 'CPR', 'PPR', 'PCM');
	self.Case_No := choose(c, l.Community_Supervision_Case_No, l.Current_Prison_Sentence_Case_No, l.Prior_Prison_Sentence_Case_No, l.Prior_Community_Supervision_Case_No);
	self.County := choose(c, l.Community_Supervision_County, l.Current_Prison_Sentence_County, l.Prior_Prison_Sentence_County, l.Prior_Community_Supervision_County);
	self.Sent_Length := choose(c, l.Community_Supervision_Length, l.Current_Prison_Sentence_Length, l.Prior_Prison_Sentence_Length, l.Prior_Community_Supervision_Length);
	self.Offense := choose(c, l.Community_Supervision_Offense, l.Current_Prison_Sentence_Offense, l.Prior_Prison_Sentence_Offense, l.Prior_Community_Supervision_Offense);
	self.Offense_Date := choose(c, l.Community_Supervision_Offense_Date, l.Current_Prison_Sentence_Offense_Date, l.Prior_Prison_Sentence_Offense_Date, l.Prior_Community_Supervision_Offense_Date);
	self.Sentence_Date := choose(c, l.Community_Supervision_Sentence_Date, l.Current_Prison_Sentence_Date, l.Prior_Prison_Sentence_Date, l.Prior_Community_Supervision_Sentence_Date);
END;

normedINPUTp2 := dedup(sort(NORMALIZE(distribute(normedINPUTp1, hash(DC_Number)), 4 ,Norm2(LEFT,COUNTER)), record, local), record, local);

punishment := file_doc_wv;
Crim_Common.Layout_Moxie_DOC_Punishment.previous tFL(normedINPUTp2 L) := TRANSFORM

string clean_length(String s) := function
	one := regexreplace('D', regexreplace('M', regexreplace('Y', regexreplace('( 0Y)|( 0 +Y)|( 0M)|( 0D)', stringlib.stringtouppercase(s), ''), ' YEARS'), ' MONTHS'), ' DAYS');
	two := if(regexfind('(DAYS +TO +LI)', one), 'LIFE', one);
	three := if(regexfind(';', two), two[1..stringlib.stringfind(two, ';', 1)-1], two);
	return three;
	end;

	self.process_date := Crim_Common.Version_In_DOC_Offender;
	self.offender_key := 'FL' +  trim(l.DC_Number,left, right); /*+ hash(trim(l.Birth_Date, left, right), trim(L.Name, left, right));*/
	self.vendor := 'FL';
	self.source_file := 'FL-doc';
	self.offense_key 		:= 'FL' +  trim(l.DC_Number,left, right) + l.case_no + l.charge_type + hash(trim(l.offense, left, right), trim(l.Birth_Date, left, right), trim(L.Name, left, right));
    self.event_dt 			:= if(regexfind('RELEAS', l.search_type) and ~regexfind('[^0-9]', l.release_date) and length(trim(l.release_date)) = 8, l.release_date,
								if(regexfind('ABSCOND', stringlib.stringtouppercase(l.search_type)) and ~regexfind('[^0-9]', l.Supervision_Begin_Date) and length(trim(l.Supervision_Begin_Date)) = 8, l.Supervision_Begin_Date,
								if(regexfind('ESCAP', l.search_type) and ((~regexfind('[^0-9]', l.Date_of_Capture) and length(trim(l.Date_of_Capture)) = 8) or (~regexfind('[^0-9]', l.Date_of_Escape) and length(trim(l.Date_of_Escape)) = 8)), if(l.Date_of_Capture > l.Date_of_Escape, l.Date_of_Capture, l.Date_of_Escape),
								if(regexfind('SUPERV', l.search_type) and ~regexfind('[^0-9]', l.Supervision_Begin_Date) and length(trim(l.Supervision_Begin_Date)) = 8, l.release_date,
								L.Current_As_Of)))); //
    self.punishment_type 	:= 'I';
    self.sent_length 		:= '';  
    self.sent_length_desc   :=  if(regexfind('(DAYS +TO +LI)', clean_length(l.Sent_Length)), 'LIFE', clean_length(l.Sent_Length));
    self.cur_stat_inm 		:= '';
    self.cur_stat_inm_desc  := if(l.Current_Classification_Status = '', l.Search_Type, l.Current_Classification_Status);
    self.cur_loc_inm_cd 	:= '';
    self.cur_loc_inm 		:= l.current_facility;
    self.inm_com_cty_cd 	:= '';
    self.inm_com_cty 		:= ''; 
    self.cur_sec_class_dt   := '';
    self.cur_loc_sec 		:= '';
    self.gain_time 			:= ''; 
    self.gain_time_eff_dt   := '';
    self.latest_adm_dt 		:= '';
    self.sch_rel_dt 		:= if(regexfind('[^a-zA-Z]', l.current_release_date), l.current_release_date,  '');
    self.act_rel_dt 		:= if(~regexfind('(RELEASE)', stringlib.stringtouppercase(l.release_date)) and ~regexfind('[a-zA-Z]', l.release_date) and l.release_date < Crim_Common.Version_In_DOC_Offender, l.release_date,  '');
    self.ctl_rel_dt 		:= '';
    self.presump_par_rel_dt := '';
    self.mutl_part_pgm_dt   := ''; 
    self.par_cur_stat 		:= '';						 
    self.par_cur_stat_desc  := '';
    self.par_st_dt 			:= L.Current_As_Of;
    self.par_sch_end_dt		:= '';
    self.par_act_end_dt 	:= '';
    self.par_cty_cd 		:= '';
    self.par_cty 		    := '';
END;


precs := project(normedINPUTp2, tFL(left));  

outfile := dedup(
				sort(
					distribute(precs, hash(offender_key))
				,offender_key, event_dt,latest_adm_dt,local)
		  ,offender_key,event_dt,right,local);

Crim_Common.Layout_Moxie_DOC_Punishment.previous tClear(outfile L) := TRANSFORM
   self.par_st_dt 			:= ''; 
   self := l;
END;

outfile2 := project(outfile, tClear(left));

export map_doc_fl_punishment := outfile2 :PERSIST('~thor_data400::persist::doc::map_fl_punishment');