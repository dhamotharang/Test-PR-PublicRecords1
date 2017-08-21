/*2010-05-25T18:35:04Z (angela herzberg)
Bug 55364
*/
import Phonesplus, ut;
export Fn_Rollup_Base(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in) := function

//New weekly file - set current record flag to true
set_curr_version := project(phplus_in, transform(recordof(phplus_in), self.current_rec := true, 
                                                                    self.first_build_date := (unsigned)Phonesplus.version, 
																																		self.last_build_date := (unsigned)Phonesplus.version,
																																		self := left));
//Previous incremental base -  Reset current record flag to false																															
reset_prev_base := project(phonesplus_v2.File_Phonesplusv2_Base, transform(recordof(phplus_in), self.current_rec := false,
                                                                                                self := left));

//Concatenate new and previous base
current_and_prev := set_curr_version + reset_prev_base;


current_and_prev_d := distribute(current_and_prev, hash(phone7_rec_key));
current_and_prev_s := sort(current_and_prev_d, phone7_rec_key, 
								 phone10,
								 fname,
       					  mname,
								 lname,
								 prim_range,
								 prim_name,
								 sec_range,
								 zip5,
								 rules, 
								 in_flag,
								 -current_rec,
								-last_build_date, local);

//Rollup files to eliminate duplications and to keep history on when a record was first and last included in the build
recordof(phplus_in) tRollup(current_and_prev_s le, current_and_prev_s ri) := TRANSFORM
  SELF.first_build_date				  :=	ut.min2(le.first_build_date, ri.first_build_date);
  SELF.last_build_date			    :=	ut.max2(le.last_build_date, ri.last_build_date);
  SELF.current_rec              :=  if(le.current_rec > ri.current_rec, le.current_rec, ri.current_rec);
  SELF := le;
end;
	
	
Rollup_file   := ROLLUP(current_and_prev_s, tRollup(LEFT, RIGHT),
			           phone7_rec_key, 
								 phone10,
								 fname,
       					 mname,
								 lname,
								 prim_range,
								 prim_name,
								 sec_range,
								 zip5,
								 in_flag,
                                     
  local);
return(Rollup_file);
end;