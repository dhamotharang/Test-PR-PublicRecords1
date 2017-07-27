
/*
DRAFT IMPORTED FROM AL_DISTRIX  as template 

BUILD common offenses from file_doc_ri
Author: Jayant Sardeshmukh 
Code Started on: Dec 4, 2007
Code Finished on: Dec 4, 2007
Code Reviewd/QA :
Release to Production: 
//-------------------------------------------------------------------
LOGIC OVERVIEW
==============
1. Looks like a strightforward  mapping of FILE_DOC_RI to Common Offense Format
   with code translations(That are still pending clarification from customer)
//-------------------------------------------------------------------
DOCUMENTING USED/UNUSED FIELDS from supplied input
String received_date;
String ID;
xString LastName;
xString FirstName;
xString MiddleInitial;
xString NameType;
xString Race;
xString Sex;
xString Age;
xString LastResidence;
xString Security;
String Sentence_CaseNo;
String Sentence_Count;
String Sentence_DateImposed;
xString Sentence_RetroDate;
xString Sentence_SenStatus;
String Sentence_Term_YR_MO_DAY;
String Sentence_Desc;
xString Sentence_GoodTimeReleaseDate;
xString Charges_CommitDate;
String Charges_CaseNumber;
String Charges_BailType;
String Charges_BailAmount;
String Charges_Disposition;
String Charges_Description;
String Charges_DispositionDate;
END;
//

//Transforms
*/
import crim_common;

//Smart Strings
VARSTRING sentence_descr(string stc) := FUNCTION
stcpattern:='([0-9]*)-([0-9]*)-([0-9]*)';//'39y-LIFE' or '15y-25y'
years:=REGEXFIND(stcpattern,stc,1);
months:=REGEXFIND(stcpattern,stc,2);
days:=REGEXFIND(stcpattern,stc,3);
return if(years > '0' ,years+' Years ','') + if(months > '0' , months+ ' Months ','') +if(days > '0' ,days + ' Days ','') ;

END;



offenses_combo := file_doc_RI(sentence_caseno<>'');
//
crim_common.Layout_Moxie_DOC_Offenses.previous transform_RI_offenses(RECORDOF(offenses_combo) L) := 
TRANSFORM
    blnk := ['0','','00','000'];
		self.process_date 		:= L.received_date;
		self.offender_key 		:= 'RIDOC' + trim(L.ID,left, right);
		self.vendor 			:= 'RI';
		self.source_file 		:= 'RI-courtventures-DOC';
		self.offense_key 		:= '';// No Code Supplied.. but description is.. see below
		self.stc_comp 			:= '';
		self.inc_adm_dt 		:= '';//commonFn.DateToStandard(L.BookingDate);// 
		self.stc_dt 			:= commonFN.DateToStandard(L.Charges_DispositionDate); //commonFn.DateToStandard(L.Sentence_DateImposed);
		self.off_date 			:= commonFn.DateToStandard(L.charges_CommitDate);
		self.arr_date			:= '';
		self.case_num			:= L.Charges_CaseNumber; //L.Sentence_CaseNo;
		self.num_of_counts		:= ''; //L.Sentence_Count;
		self.off_code			:= '';
		self.chg				:= '';	//L.CourtInfoNumber; 
		self.chg_typ_flg		:= '';		
		self.off_desc_1 		:= L.Charges_Description; 
		self.off_desc_2			:= ''; 
		self.add_off_cd 		:= ''; 
		self.add_off_desc		:= ''; 
		self.off_typ			:= '';
		self.off_lev			:= '';
		self.arr_disp_date		:= '';
		self.arr_disp_cd		:= '';
		self.arr_disp_desc_1	:= '';
		self.arr_disp_desc_2	:= '';
		self.arr_disp_desc_3	:= '';
		self.court_cd			:= '';
		self.court_desc			:= ''; 
		self.ct_dist			:= '';
		self.ct_fnl_plea_cd		:= '';   
		self.ct_fnl_plea		:= '';      
		self.ct_off_code		:= '';       
		self.ct_chg				:= ''; //L.CourtInfoNumber;
		self.ct_chg_typ_flg		:= '';
		self.ct_off_desc_1		:= '';
		self.ct_off_desc_2		:= '';
		self.ct_addl_desc_cd	:= '';
		self.ct_off_lev			:= '';

		self.ct_disp_dt			:= ''; 
		self.ct_disp_cd			:= '';
		self.ct_disp_desc_1	    := '';
		self.ct_disp_desc_2	    := '';
		self.cty_conv_cd		:= ''; 
		self.cty_conv 			:= '';
		self.adj_wthd			:= '';
		self.stc_cd			    := '';
		self.stc_desc_1			:= L.Charges_disposition+' - '+ L.Charges_bailtype+': '+L.Charges_bailamount; //L.Sentence_Desc;
		self.stc_desc_2			:= '';
		self.stc_desc_3			:= '';
		self.stc_desc_4			:= '';
		
		self.stc_lgth			:= ''; //L.Sentence_Term_YR_MO_DAY;		
		//
		self.stc_lgth_desc	:= ''; //sentence_descr(L.Sentence_Term_YR_MO_DAY);
		self.min_term		:= '';
		self.min_term_desc	:= '';
		self.max_term		:= '';
		self.max_term_desc	:= '';
end;

ds_offense_mapped := project(offenses_combo,transform_RI_offenses(left));
ds_offense_sorted := sort(distribute(ds_offense_mapped,hash(offender_key)), offender_key,stc_dt, off_date, case_num, off_desc_1, stc_desc_1,stc_lgth_desc,process_date,local) ;
ds_offense_dedup  := dedup(ds_offense_sorted,offender_key,stc_dt, off_date, case_num, off_desc_1, stc_desc_1,stc_lgth_desc,right, local);


//Mapped Output 
export map_doc_RI_offenses := ds_offense_dedup:PERSIST('~thor_data400::persist::doc::map_RI_offenses');