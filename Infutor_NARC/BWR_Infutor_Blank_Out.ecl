//Bug Ticket 203073
import Infutor_NARC, didville, ut, std;


string		pversion	:= '';
boolean  pUseProd  := true;
base := dataset('~thor_data400::base::infutor_narc::father', Infutor_NARC.layouts.orig_base, thor);

set_presence_child := ['Y','N',''];
set_nbrChild 			:= ['1','2','3','4','5','6','7','8','9'];
set_indicator 		:= ['Y',''];
set_mhv      			:= ['A','B','C','D','E','F','G','H','I'];
set_mor      			:= ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T'];
set_collar   			:= ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T'];
set_lat_long_lvl 	:= ['Z','R','4',''];
set_dwelling			:= ['A','B','C','D',''];
set_time_zone			:= ['2','3','4','5','6','7','8',''];
set_total_number  := ['0','1','2','3','4','5','6','7','8','9',''];
set_validation_flag := ['C','N',''];

fn_format_length_yrs(string years) := function
remove_alpha		:= REGEXREPLACE('([A-Z]+)', trim(years),'');
yrs_Decimal			:= (DECIMAL5_2)(trim(remove_alpha)+'.00');
yrs_Decimal_fmt	:= if(length(trim(remove_alpha)) > 2, REALFORMAT(yrs_Decimal/10,6,1), remove_alpha);
yrs_Duration		:= trim(yrs_Decimal_fmt,left,right); 
return yrs_Duration;
end;


Infutor_NARC.layouts.base				tBlankOutMapping(Base L) := TRANSFORM
 self.orig_TOT_MALES												    := if (trim(L.orig_TOT_MALES) not in set_total_number,'', L.orig_TOT_MALES);
 self.orig_TOT_FEMALES													:= if (trim(L.orig_TOT_FEMALES) not in set_total_number,'', L.orig_TOT_FEMALES);
 self.orig_GENDER																:= if (trim(L.orig_GENDER) not in ['F','M',''],'', L.orig_GENDER);		
 self.orig_AGE																	:= REGEXREPLACE('([A-Z]+)', trim(L.orig_age),'');
 self.orig_DOB																	:= REGEXREPLACE('([A-Z]+)', trim(L.orig_dob),'');
 self.orig_VACANT																:= if (trim(L.orig_VACANT) not in set_presence_child,'',L.orig_VACANT);
 self.orig_Time_Zone														:= if (trim(L.orig_Time_Zone) not in set_time_zone, '', L.orig_Time_Zone);
 self.orig_ValidationFlag_1											:= if (trim(L.orig_ValidationFlag_1) not in set_validation_flag,'', L.orig_ValidationFlag_1);
 self.orig_validationdate_1											:= if (trim(L.orig_validationdate_1) = '29000000','',L.orig_validationdate_1);
 self.orig_Lat_Long_Assignment_Level						:= if (trim(L.orig_Lat_Long_Assignment_Level) not in set_lat_long_lvl,'', L.orig_Lat_Long_Assignment_Level);
 // self.orig_Length_of_Residence									:= fn_format_length_yrs(L.orig_Length_of_Residence);
 self.orig_Length_of_Residence									:=  STD.Str.FilterOut(L.orig_Length_of_Residence, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
 self.orig_Homeowner														:= if (trim(L.orig_Homeowner) not in set_indicator,'', L.orig_Homeowner);
 self.orig_EstimatedIncome											:= if (trim(L.orig_EstimatedIncome) not in set_mhv,'',L.orig_EstimatedIncome);
 self.orig_Dwelling_Type												:= if (trim(L.orig_Dwelling_Type) not in set_dwelling,'', L.orig_Dwelling_Type);
 self.orig_Married															:= if (trim(L.orig_Married) not in set_indicator,'', L.orig_Married);
 self.orig_CHILD																:= if (trim(L.orig_CHILD) not in set_presence_child, '', L.orig_CHILD);
 self.orig_NBRCHILD															:= if (trim(L.orig_NBRCHILD) not in set_nbrChild, '', L.orig_NBRCHILD);
 self.orig_TeenCD																:= if (trim(L.orig_TeenCD) not in set_indicator, '', L.orig_TeenCD);
 self.orig_MHV																	:= if (trim(L.orig_MHV) not in set_mhv, '', L.orig_MHV);
 self.orig_MOR																	:= if (trim(L.orig_MOR) not in set_mor, '', L.orig_MOR);
 // self.orig_MEDSCHL															:= fn_format_length_yrs(L.orig_MEDSCHL);
 self.orig_MEDSCHL															:=  STD.Str.FilterOut(L.orig_MEDSCHL, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
 self.orig_Penetration_Range_WhiteCollar 				:= if (trim(L.orig_Penetration_Range_WhiteCollar) not in set_collar,'', L.orig_Penetration_Range_WhiteCollar);
 self.orig_Penetration_Range_BlueCollar					:= if (trim(L.orig_Penetration_Range_BlueCollar) not in set_collar,'', L.orig_Penetration_Range_BlueCollar);
 self.orig_Penetration_Range_OtherOccupation		:= if (trim(L.orig_Penetration_Range_OtherOccupation) not in set_collar,'', L.orig_Penetration_Range_OtherOccupation);
 SELF :=  L;
 SELF := [];
END;

ds_correct  := project(Base(orig_hhid not in ['Y000000325']and orig_pid not in ['0000000000023LA']), tBlankOutMapping(LEFT));

/*
temp_Layout := record
Infutor_NARC.layouts.base;
unsigned6 hhid := 0;
end;

dsFile_temp := project(ds_correct, temp_Layout);


 //append hhid 
append_value := 'HHID_PLUS';

//----Append HHID for recs with and without did
with_did 		:= dsFile_temp(did > 0);
without_did	:= dsFile_temp(did = 0);


didville.MAC_HHID_Append(with_did, append_value, 	Append_HHID1);

didville.MAC_HHID_Append_By_Address(without_did, Append_HHID2, hhid, lname, prim_range, prim_name, sec_range, st, zip);

infutor_narc_all := Append_HHID1+ Append_HHID2;

// output(count(infutor_narc_all(hhid > 0)));

file_hhid := project(infutor_narc_all, transform(Infutor_NARC.layouts.base, self.lexhhid := left.hhid, self := left));


output(count(file_hhid(lexhhid > 0)));
*/

EXPORT BWR_Infutor_Blank_Out := output(ds_correct,,'~thor_data400::base::infutor_narc::father_corrected',__compressed__,overwrite);
