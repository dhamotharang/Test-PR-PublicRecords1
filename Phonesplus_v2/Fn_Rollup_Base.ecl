import Phonesplus, ut, header,mdr;
export Fn_Rollup_Base(dataset(recordof(Layout_In_Phonesplus.layout_in_common)) phplus_in, string file_type = '', string pversion) := function

//New weekly file - set current record flag to true
set_curr_version := project(phplus_in, transform(recordof(phplus_in), self.current_rec := true,
																																			self.first_build_date := (unsigned)pversion,
                                                                 			self.last_build_date := (unsigned)pversion,
																																			self := left));
																																			
																
																																			
//Previous incremental base -  Reset current record flag to false																															
reset_prev_base := if(file_type = 'phonesplus_main',
										project(phonesplus_v2.File_Phonesplus_Base, 
														transform(recordof(phplus_in), self.current_rec := false,
                                                           self := left)),
										project(phonesplus_v2.File_Royalty_Base, 
														transform(recordof(phplus_in), self.current_rec := false,
                                                           self := left)));

//Concatenate new and previous base
prev_without_old_util := reset_prev_base(~header.IsOldUtil(pversion,,DateVendorLastReported));
current_and_prev := set_curr_version + prev_without_old_util;


current_and_prev_d := distribute(current_and_prev, hash(CellPhoneIDKey));
current_and_prev_s := sort(current_and_prev_d, CellPhoneIDKey, 
								 cellphone,
								 rules,
								 src_all,
								 in_flag,
								 current_rec,
								 local);

//Rollup files to eliminate duplications and to keep history on when a record was first and last included in the build
recordof(phplus_in) tRollup(current_and_prev_s le, current_and_prev_s ri) := TRANSFORM
  SELF.current_rec              :=  if(le.current_rec > ri.current_rec, le.current_rec, ri.current_rec);
	SELF.DateFirstSeen						:=  ut.Min2(le.DateFirstSeen, ri.DateFirstSeen);
	SELF.DateLastSeen							:=  ut.Max2(le.DateLastSeen, ri.DateLastSeen);
	SELF.DateVendorFirstReported	:=  ut.Min2(le.DateVendorFirstReported, ri.DateVendorFirstReported);
	SELF.DateVendorLastReported	:=  ut.Max2(le.DateVendorLastReported, ri.DateVendorLastReported);
	SELF.first_build_date				  :=	ut.min2(le.first_build_date, ri.first_build_date);
  SELF.last_build_date			    :=	ut.max2(le.last_build_date, ri.last_build_date);
	SELF := ri;
end;
	
	
Rollup_file   := ROLLUP(current_and_prev_s, tRollup(LEFT, RIGHT),
			           CellPhoneIDKey, 
								 cellphone,
								 rules,
								 src_all,
								 in_flag,
                                     
  local);
return(Rollup_file);
end;