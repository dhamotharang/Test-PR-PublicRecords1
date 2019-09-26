IMPORT  _control, MDR, ut, mdr, std, tools,_validate;
EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= function
thrive.layouts.base tPDMapping(thrive.layouts.input_PD L, C) := TRANSFORM
	SELF.src    := mdr.sourceTools.src_thrive_PD;							//	Code to indicate source: 'PD' or 'LT'
	SELF.persistent_record_id := 'PD'+filedate+ intformat(C,10,1);
	SELF.orig_Fname				  := trim(stringlib.stringtouppercase(L.orig_Fname),left, right);						//	LT & PD
	SELF.orig_Mname				  := trim(stringlib.stringtouppercase(L.orig_Mname),left, right);						//	PD	
	SELF.orig_Lname				  := trim(stringlib.stringtouppercase(L.orig_Lname),left, right);						//	LT & PD
	SELF.orig_Addr					  := trim(stringlib.stringtouppercase(L.orig_Addr),left, right);						//	LT & PD
	SELF.orig_City 				  := trim(stringlib.stringtouppercase(L.orig_City),left, right);      			//	LT & PD
	SELF.orig_State 				  := trim(stringlib.stringtouppercase(L.orig_State),left, right);       		//	LT & PD
	SELF.orig_zip5					:= trim(L.orig_zip5,left, right); //	LT & PD
	SELF.orig_zip4					:= trim(L.orig_zip4,left, right); //	LT & PD
	SELF.phone_work					:= trim(L.phone_work, left, right); //	LT & PD
	SELF.phone_home					:= trim(L.phone_home, left, right);//	PD
  SELF.phone_cell					:= trim(L.phone_cell, left, right);//	PD
	
	dob_no_special_char(string1 special_char) :=  function
	new_date := intformat((unsigned)L.dob[1..StringLib.StringFind(L.dob, special_char, 1)-1], 2,1) +
					intformat((unsigned)L.dob[StringLib.StringFind(L.dob, special_char, 1)+1..StringLib.StringFind(L.dob, special_char, 2)-1], 2,1) +		
          intformat((unsigned)L.dob[StringLib.StringFind(L.dob, special_char, 2)+1.. length(L.dob)], 4,1) ;
	return new_date;
	end;
	
	SELF.Dob						:=  if(StringLib.StringFind(L.dob, '/', 1) > 0,
													dob_no_special_char('/'),
													 if(StringLib.StringFind(L.dob, '-', 1) > 0,
													dob_no_special_char('-'),
													trim(Stringlib.StringFilter(L.DOB,'0123456789'), left, right)));//PD
	SELF.Email 				  := trim(stringlib.stringtouppercase(L.Email),left, right);						//	LT & PD
	SELF.Employer 		  := trim(stringlib.stringtouppercase(L.Employer),left, right);				//	LT & PD
	SELF.Income 			  := trim(L.Income_Monthly,left, right);	//	LT & PD
	SELF.Pay_Frequency  := trim(stringlib.stringtouppercase(L.Pay_Frequency),left, right);		//	PD
	SELF.Own_Home 			:= trim(stringlib.stringtouppercase(L.Own_Home),left, right);     		//	PD
	SELF.Is_Military		:= trim(stringlib.stringtouppercase(L.Is_Military),left, right);			//	PD		
	SELF.Drvlic_State		:= trim(stringlib.stringtouppercase(L.Dr),left, right);							//	PD	
	SELF.MonthsEmployed := trim(stringlib.stringtouppercase(L.Months_Employed),left, right);							//	PD	
	SELF.MonthsAtBank   := trim(stringlib.stringtouppercase(L.Months_At_Bank),left, right);							//	PD
	SELF.ip							:= trim(Stringlib.StringFilter(L.ip,'0123456789.: '),left, right);	//	PD
	SELF.DateCollected	:= trim(Stringlib.StringFilter(L.DT,'0123456789:-/ '),left, right);								//	LT & PD

	seen_date := if(std.date.ConvertDateFormat(L.DT,'%m/%d/%Y') between '19000101' and (string)std.date.today(),(unsigned)std.date.ConvertDateFormat(L.DT,'%m/%d/%Y'), 
														      if(std.date.ConvertDateFormat(L.DT,'%Y-%m-%d') between '19000101' and (string)std.date.today(),(unsigned)std.date.ConvertDateFormat(L.DT,'%Y-%m-%d'), 0));
	SELF.Dt_first_seen  := seen_date;
	SELF.Dt_last_seen   := seen_date;
	SELF.Dt_vendor_first_reported := (unsigned)filedate;
	SELF.Dt_vendor_last_reported := (unsigned)filedate;
	SELF.Clean_Phone_Work := if(ut.CleanPhone(L.Phone_Work) [1] not in ['0','1'],ut.CleanPhone(L.Phone_Work), '') ;
	SELF.Clean_Phone_Home := if(ut.CleanPhone(L.Phone_Home) [1] not in ['0','1'],ut.CleanPhone(L.Phone_Home), '') ;
	SELF.Clean_Phone_Cell := if(ut.CleanPhone(L.Phone_Cell) [1] not in ['0','1'],ut.CleanPhone(L.Phone_Cell), '') ;;
	SELF.clean_DOB := map(std.date.ConvertDateFormat(self.dob, '%Y%m%d') between '19000101' and (string)std.date.today() => std.date.ConvertDateFormat(self.dob, '%Y%m%d'),
												std.date.ConvertDateFormat(self.dob, '%m%d%Y') between '19000101' and (string)std.date.today() => std.date.ConvertDateFormat(self.dob, '%m%d%Y'),
												(self.dob[5..] + self.dob[1..2] + self.dob[3..4])between '19000101' and (string)std.date.today() => self.dob[5..] + self.dob[1..2] + self.dob[3..4],
												self.dob between '19000101' and (string)std.date.today() => self.dob, ''); 
											
	SELF  :=  L;
	SELF := [];
END;

dPDMapped := PROJECT(thrive.Files(filedate,pUseProd).input_PD, tPDMapping(LEFT, counter));

thrive.layouts.base tLTMapping(thrive.layouts.input_LT L, C) := TRANSFORM
  SELF.src    := mdr.sourceTools.src_thrive_LT;							//	Code to indicate source: 'PD' or 'LT'
	SELF.persistent_record_id := 'LT'+filedate+ intformat(C,10,1);
	SELF.orig_Fname				  := trim(stringlib.stringtouppercase(L.orig_Fname),left, right);						//	LT & PD
	SELF.orig_Lname				  := trim(stringlib.stringtouppercase(L.orig_Lname),left, right);						//	LT & PD
	SELF.orig_Addr					  := trim(stringlib.stringtouppercase(L.orig_Addr),left, right);						//	LT & PD
	SELF.orig_City 				  := trim(stringlib.stringtouppercase(L.orig_City),left, right);      			//	LT & PD
	SELF.orig_State 				  := trim(stringlib.stringtouppercase(L.orig_State),left, right);       		//	LT & PD
	SELF.orig_zip5					:= trim(L.orig_zip5,left, right); //	LT & PD
	SELF.orig_zip4					:= trim(L.orig_zip4,left, right); //	LT & PD
	SELF.Phone_Work 		:=  trim(L.Phone,left, right);
	SELF.Email 				  := trim(stringlib.stringtouppercase(L.Email),left, right);						//	LT & PD
	SELF.Employer 		  := trim(stringlib.stringtouppercase(L.Employer),left, right);				//	LT & PD
	SELF.YrsThere				:= trim(stringlib.stringtouppercase(L.YrsThere),left, right);								//	LT
	SELF.BestTime				:= trim(stringlib.stringtouppercase(L.BestTime),left, right);								//	LT
	SELF.Credit					:= trim(stringlib.stringtouppercase(L.Credit),left, right);								//	LT
	SELF.LoanAmt					:= trim(stringlib.stringtouppercase(L.LoanAmt),left, right);								//	LT
	SELF.LoanType				:= trim(stringlib.stringtouppercase(L.LoanType),left, right);								//	LT
	SELF.RateType				:= trim(stringlib.stringtouppercase(L.RateType),left, right);								//	LT
	SELF.MortRate		:= trim(stringlib.stringtouppercase(L.MortRate),left, right);								//	LT
	SELF.PropertyType		:= trim(stringlib.stringtouppercase(L.PropertyType),left, right);								//	LT
	SELF.DateCollected	:= trim(Stringlib.StringFilter(L.DT,'0123456789:-/ '),left, right);								//	LT & PD
	SELF.Dt_first_seen  := if(std.date.ConvertDateFormat(L.DT,'%m/%d/%Y') between '19000101' and (string)std.date.today(),(unsigned)std.date.ConvertDateFormat(L.DT,'%m/%d/%Y'), 0);
	SELF.Dt_last_seen   := if(std.date.ConvertDateFormat(L.DT,'%m/%d/%Y') between '19000101' and (string)std.date.today(),(unsigned)std.date.ConvertDateFormat(L.DT,'%m/%d/%Y'), 0);
	SELF.Dt_vendor_first_reported := (unsigned)filedate;
	SELF.Dt_vendor_last_reported := (unsigned)filedate;	
	SELF.Clean_Phone_Work := if(ut.CleanPhone(L.Phone)[1] not in ['0','1'],ut.CleanPhone(L.Phone), '') ;
	SELF  :=  L;
	SELF := [];
END;


dLTMapped := PROJECT(thrive.Files(filedate,pUseProd).input_LT,tLTMapping(LEFT, counter));

dCombined := dPDMapped + dLTMapped;

addGlobalSID 	:= MDR.macGetGlobalSid(dCombined, 'Thrive', '', 'global_sid'); //DF-25710: Populate Global_SIDs
																						
unique_recs 	:= dedup(sort(distribute(addGlobalSID,hash(Phone_Work)), record, except persistent_record_id, local),all, except persistent_record_id, local);
					
return unique_recs;
END;