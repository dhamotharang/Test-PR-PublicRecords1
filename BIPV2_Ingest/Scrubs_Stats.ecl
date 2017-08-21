import BIPV2_files; 
EXPORT Scrubs_Stats := Module 
shared A:=BIPV2_Ingest.Scrubs;
shared F:=BIPV2_files.files_ingest.DS_BASE;//or BIPV2_files.files_ingest.DS_BASE;
shared S:=A.FromNone(F); //FromNone
shared DS:=S.BitmapInfile(scrubsbits1<>0); 
//OUTPUT(DS,, '~thor_data400::bipv2_ingest::Scrubs::sample_with_bitmap',OVERWRITE,Compressed); //Save the bitmapInfile file


shared T:=A.FromBits(DS);//FromBits
shared AA:=T.ExpandedInfile(company_name_Invalid <> 0 or iscontact_Invalid<>0 or st_invalid<>0 or zip_invalid<>0 or zip4_invalid<>0 
                   or contact_ssn_invalid<>0 or active_duns_number_invalid<>0 or active_enterprise_number_invalid<>0
                     or ebr_file_number_invalid <>0 or active_domestic_corp_key_invalid<>0 or foreign_corp_key_invalid<>0
										 or fname_invalid <>0 or mname_invalid<>0 or lname_invalid<>0 or name_suffix_invalid<>0 or v_city_name_invalid<>0
										 or company_fein_invalid<>0 or company_phone_invalid<>0 or company_inc_state_invalid<>0 
										 or company_charter_number_invalid<>0 or contact_email_invalid<>0);//good for observe individual field

								
//output(choosen(AA,1000),named('SampleErrRecords'));

shared U:=A.FromExpanded(S.ExpandedInFile);
shared SumRec:=record
   string2 source;
   unsigned6 totalcnt;
   unsigned6 totalerr;
   //DECIMAL5_3 avg_err_per_record;
   integer8 iscontact_errcnt;
	 
	 integer8 actv_duns_errcnt;
	 integer8 actv_enterprise_errcnt;
	 integer8 ebr_file_errcnt;
	 integer8 actv_d_corpkey_errcnt;
	 integer8 foreign_corpkey_errcnt;
	 
	 
   integer8 fname_errcnt;
   integer8 mname_errcnt;
   integer8 lname_errcnt;
   integer8 name_suffix_errcnt;
   integer8 company_name_errcnt;
   integer8 v_city_name_errcnt;
   integer8 st_errcnt;
   integer8 zip_errcnt;
   integer8 zip4_errcnt;
   integer8 company_fein_errcnt;
   integer8 company_phone_errcnt;
	 
	 integer8 comp_inc_st_errcnt;
	 integer8 comp_charter_errcnt;
	 
   integer8 contact_ssn_errcnt;
	 integer8 contact_email_errcnt;
   end;
 shared SumProj:=project(U.SummaryStats, 
   								 transform(SumRec,
   								   self.source :=left.source;
   									 self.totalcnt :=left.totalcnt;
    									 self.totalerr :=left.iscontact_total_errorcount + left.active_duns_number_total_errorcount +
																			 left.active_enterprise_number_total_errorcount + left.ebr_file_number_total_errorcount +
																			 left.active_domestic_corp_key_total_errorcount + left.foreign_corp_key_total_errorcount +
																			   left.fname_allow_errorcount + left.mname_allow_errorcount +
      									                 left.lname_allow_errorcount + left.name_suffix_allow_errorcount + 
      																	 left.company_name_length_errorcount + left.v_city_name_total_errorcount +
      																	 left.st_total_errorcount + left.zip_total_errorcount + left.zip4_total_errorcount +
      																	 left.company_fein_allow_errorcount + left.company_phone_allow_errorcount + 
																			left.company_inc_state_total_errorcount + left.company_charter_number_allow_errorcount +
      																	 left.contact_ssn_total_errorcount + left.contact_email_total_errorcount;
/*       									 self.avg_err_per_record :=(left.iscontact_total_errorcount + left.active_duns_number_total_errorcount +
   																			 left.active_enterprise_number_total_errorcount + left.ebr_file_number_total_errorcount +
   																			 left.active_domestic_corp_key_total_errorcount + left.foreign_corp_key_total_errorcount +
   																			   left.fname_allow_errorcount + left.mname_allow_errorcount +
         									                 left.lname_allow_errorcount + left.name_suffix_allow_errorcount + 
         																	 left.company_name_length_errorcount + left.v_city_name_total_errorcount +
         																	 left.st_total_errorcount + left.zip_total_errorcount + left.zip4_total_errorcount +
         																	 left.company_fein_allow_errorcount + left.company_phone_allow_errorcount + 
   																			 left.company_inc_state_total_errorcount + left.company_charter_number_allow_errorcount +
         																	 left.contact_ssn_total_errorcount+ left.contact_email_total_errorcount)*1.0/left.totalcnt;
*/
   
   									 self.iscontact_errcnt :=left.iscontact_total_errorcount;
										 
										 self.actv_duns_errcnt :=left.active_duns_number_total_errorcount;
										 self.actv_enterprise_errcnt:=left.active_enterprise_number_total_errorcount;
										 self.ebr_file_errcnt:=left.ebr_file_number_total_errorcount;
										 self.actv_d_corpkey_errcnt:=left.active_domestic_corp_key_total_errorcount;
										 self.foreign_corpkey_errcnt:=left.foreign_corp_key_total_errorcount;
	 
   									 self.fname_errcnt :=left.fname_allow_errorcount;
   									 self.mname_errcnt :=left.mname_allow_errorcount;
     								 self.lname_errcnt :=left.lname_allow_errorcount;
   									 self.name_suffix_errcnt :=left.name_suffix_allow_errorcount;
   									 self.company_name_errcnt :=left.company_name_length_errorcount;
   									 self.v_city_name_errcnt :=left.v_city_name_total_errorcount;
   									 self.st_errcnt :=left.st_total_errorcount;
   									 self.zip_errcnt :=left.zip_total_errorcount;
   									 self.zip4_errcnt :=left.zip4_total_errorcount;
   									 self.company_fein_errcnt :=left.company_fein_allow_errorcount;
   									 self.company_phone_errcnt :=left.company_phone_allow_errorcount;
										 
										 self.comp_inc_st_errcnt	:=left.company_inc_state_total_errorcount;
										 self.comp_charter_errcnt :=left.company_charter_number_allow_errorcount;
		
   									 self.contact_ssn_errcnt :=left.contact_ssn_total_errorcount;
										 self.contact_email_errcnt:=left.contact_email_total_errorcount
   									)); 
  //output(SumProj,named('SummaryStats_smpl'));	
export SummaryStats:=U.SummaryStats;
export SummaryStats_smpl:=SumProj;
export BadValues:=U.BadValues;
export OrbitStats:=	U.OrbitStats();
export AllErrors:= U.AllErrors;  						
export SampleErrRecords:=AA;
//output(U.AllErrors,named('AllErrors'));
//output(U.BadValues,named('BadValues'));
//U.OrbitStats(4, (unsigned)'20161111');//give at most 10 exmples as defualt; OrbitStats(2) -- give at most 2 examples. date default to the process date.
//U.OrbitStats();
//FinalStat:=table(U.OrbitStats(),{recordstotal,processdate,sourcecode,ruledesc,errormessage,unsigned6 rulecnt:=sum(group,rulecnt), real8 rulepcnt:=sum(group,rulepcnt)}, recordstotal,processdate,sourcecode,ruledesc,errormessage);
//output(FinalStat, named('FinalStat'));

END;