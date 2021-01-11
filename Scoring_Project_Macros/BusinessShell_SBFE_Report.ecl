EXPORT BusinessShell_SBFE_Report := function
// #workunit('name', 'BusinessShell SBFE Report');
#OPTION('AllowAutoSwitchQueue', true);
#option('allowedClusters', 'thor50_dev02,thor50_dev');

import ut;
import std;
import scoring_project;

import Scoring_Project_Macros, Scoring_Project_DailyTracking, Scoring_QA_New_Bins;

dt := ut.getdate;


 filenames_details1 :=  OUTPUT(nothor(STD.File.LogicalFileList('scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_*_1')),,'~scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_file_' + dt, thor, overwrite );

 string lib_fileservices__fslogicalfilename := string{maxlength(255)};

layname := RECORD
   lib_fileservices__fslogicalfilename name;
  END;
lay1 := RECORD(layname)
  boolean superfile;
  integer8 size;
  integer8 rowcount;
  string19 modified;
  string owner{maxlength(255)};
  string cluster{maxlength(255)};
 END;
 

ds1 := DISTRIBUTE(dataset('~scoringqa::out::nonfcra::businessshell_xml_generic_attributes_v2_file_'+ dt , lay1, thor));


filelist1 := sort(ds1, -modified);
c_file_name1 := filelist1[1].name;
p_file_name1 := filelist1[2].name;


dt1_1 := c_file_name1[length(c_file_name1)-9.. length(c_file_name1)-2];
dt2_1 := 	p_file_name1[length(p_file_name1)-9.. length(p_file_name1)-2];

   					 
  new_bins_remove_file:= if(  STD.File.FileExists('~scoring_project::businessshell_SBFE_stats_'+ dt1_1) ,
   																				 
         	           sequential(FileServices.DeletelogicalFile('~scoring_project::businessshell_SBFE_stats_' + dt1_1)));
   															
   					
  old_bins_remove_file:= if(  STD.File.FileExists('~scoring_project::businessshell_SBFE_stats_'+ dt2_1) ,
   																				 
         	           sequential(FileServices.DeletelogicalFile('~scoring_project::businessshell_SBFE_stats_' + dt2_1)) 
   															);	
      			 
  new_bins:=  Scoring_Project.BusinessShell_SBFE_MACRO(dt1_1,dt2_1);	
                   																		 
  old_bins:=  Scoring_Project.BusinessShell_SBFE_MACRO(dt2_1,dt1_1);	


layout := RECORD
  string100 field_name;
  string100 category;
  string30 distribution_type;
  string50 attribute_value;
  decimal20_4 frequency;
 END;
					 

dset_curr1 := distribute(dataset('~scoring_project::businessshell_SBFE_stats_' + dt1_1, layout, thor),hash(field_name));
dset_prev1 := distribute(dataset('~scoring_project::businessshell_SBFE_stats_' + dt2_1, layout, thor),hash(field_name));
 
 lay := RECORD
	Scoring_Project_Macros.Global_Output_Layouts.BusinessShell_Attributes_V2_XML_Generic_Global_Layout;
END;
// zz_bbraaten2.Nonfcra_Businessshell_xml_layout;

nick_current_file := distribute(dataset( '~' + c_file_name1, lay, thor),(integer)acctno);
nick_previous_file := distribute(dataset( '~' + p_file_name1, lay, thor),(integer)acctno);

// nick_previous_file((integer)accountnumber>=50000);
// count(nick_previous_file);

aa1:=join(nick_current_file,nick_previous_file,left.acctno=right.acctno,inner);

matched_file_cnt:=count(aa1(acctno<>''));


//******************************************************//


cnt_prev := count(nick_previous_file);
cnt_curr := count(nick_current_file);

 
   compare_layout := RECORD
      string100 field_name;
			string100 category;
      string30 distribution_type;
			decimal20_4 p_file_count;
      decimal20_4 c_file_count;
      decimal20_4 file_count_diff;
			decimal20_4 matched_file_count;
      STRING50 attribute_value; 
      decimal20_4 p_frequency;
      decimal20_4 c_frequency;
      decimal20_4 frequency_diff;
			decimal20_4 perc_frequency_diff;
   	  decimal20_4 p_proportion;
      decimal20_4 c_proportion;
      decimal20_4 proportion_diff;
			decimal20_4 abs_proportion_diff;
			decimal20_4 perc_proportion_diff;
			decimal20_4 PSI;
 END;	
 
 
 
final_results:= join(dset_curr1,dset_prev1,               left.field_name = right.field_name and
																								left.category  = right.category and
         									                      left.distribution_type = right.distribution_type and
         																	      left.attribute_value = right.attribute_value 
   																							,transform(	compare_layout, 
																								                            self.field_name:=if(left.field_name='',right.field_name,left.field_name),
																																						self.category:=if(left.category='',right.category,left.category),
                  			 			                                              self.distribution_type:=if(left.distribution_type='',right.distribution_type,left.distribution_type),
																																						self.p_file_count:=cnt_prev,
																																						self.c_file_count:=cnt_curr,
																																						self.file_count_diff:=cnt_curr - cnt_prev ,//calculating prev - curr
																																						self.matched_file_count:=matched_file_cnt;
               																														  self.attribute_value:=if(left.attribute_value='',right.attribute_value,left.attribute_value),
      																																		  self.p_frequency:=right.frequency,
                  			 			                                              self.c_frequency:=left.frequency,
               																														  self.frequency_diff:=left.frequency-right.frequency, //modified from (prev - curr) to (curr - prev) as per Ben's request on 04/18/2014
																																						self.perc_frequency_diff:=if(right.frequency= 0 and left.frequency !=0,1,(left.frequency-right.frequency)/right.frequency),
   																																					self.p_proportion:=right.frequency/matched_file_cnt,
                  			 			                                              self.c_proportion:=left.frequency/matched_file_cnt,
               																														  self.proportion_diff:=(left.frequency/matched_file_cnt) - (right.frequency/matched_file_cnt),
																																						self.abs_proportion_diff:=abs((left.frequency/matched_file_cnt) - (right.frequency/matched_file_cnt)),
																																						self.perc_proportion_diff:=if(right.frequency = 0 and left.frequency !=0,1,((left.frequency/matched_file_cnt) - (right.frequency/matched_file_cnt))/(right.frequency/matched_file_cnt)),
																																						self.PSI := ((right.frequency/matched_file_cnt)-(left.frequency/matched_file_cnt))*ln(((right.frequency/matched_file_cnt)/(left.frequency/matched_file_cnt)))
																																						),full outer );
																																
			

rd := record
 final_results.field_name;
 final_results.category;
 final_results.distribution_type;
 sumofPSI := sum(group, final_results.PSI);
END;	
 
 tb := table(final_results, rd, final_results.field_name,final_results.category, final_results.distribution_type); 

   compare_layout_3 := RECORD
      string100 field_name;
			// string100 category;
      string30 distribution_type;
			decimal20_4 p_file_count;
      decimal20_4 c_file_count;
      decimal20_4 file_count_diff;
			decimal20_4 matched_file_count;
      STRING50 attribute_value; 
      decimal20_4 p_frequency;
      decimal20_4 c_frequency;
      decimal20_4 frequency_diff;
			decimal20_4 perc_frequency_diff;
   	  decimal20_4 p_proportion;
      decimal20_4 c_proportion;
      decimal20_4 proportion_diff;
			decimal20_4 abs_proportion_diff;
			decimal20_4 perc_proportion_diff;
			decimal20_4 PSI;
			 decimal20_4 sumofPSI;
			Integer warning_flag;
 END;	
 
 jn := JOIN(final_results, tb, left.field_name = right.field_name and
															 left.category = right.category and
															 left.distribution_type = right.distribution_type,
															 TRANSFORM(compare_layout_3,
															 					self.field_name := stringlib.StringFindReplace(right.field_name, 'sbfe.', '');
																				self.sumofPSI := right.sumofPSI;
																				self.warning_flag := If(right.sumofPSI > 0.1 , 1, 0);
																																						self := left;));
																																

			out_file := output(choosen(jn,all), ,'~scoring_project::businessShell_SBFE_results_new_' + dt1_1, CSV(heading(single), quote('"')), overwrite );
			
			
				string out_file_layout := '';
      outfile := dataset('~scoring_project::businessShell_SBFE_results_new_' + dt1_1, typeof(out_file_layout));
			

        no_of_records := count(outfile);
      			
      	
       			myrec := record, maxlength(9999999) 
         			unsigned code0; 
         			unsigned code1;
         			string line;
      				end;
         
         			myrec ref(outfile l, integer c) := transform 
         			self.code0 := c; 
         			self.code1 := c + 1 ;
         			self := l; 
      				end;
         
         			outputs := project(outfile, ref(left, counter));
         			
         			// outputs;
         
         			MyRec Xform(myrec L,myrec R) := TRANSFORM
         			SELF.line := trim(L.line, left, right) + '\n' + trim(R.line, left, right); 
         			self := l;
         			END;
         
         			XtabOut := iterate(outputs,Xform(left,right));
         			
//***************************************************//							
							
 distro :=  SEQUENTIAL(out_file,	fileservices.SendEmailAttachText(Scoring_Project_DailyTracking.email_distribution.business_reports_detailed,					
					   'BusinessShell SBFE Attribute Distribution Report',
																				'BusinessShell SBFE Attribute Distribution Report '+ dt1_1 + ' vs ' + dt2_1 + '\n Please view attachment.',
																				 XtabOut[no_of_records].line ,
																				 'text/plain; charset=ISO-8859-3', 
																				'BusinessShell SBFE Attributes Comparing ' + dt1_1 + '_vs_' + dt2_1 + '.csv',
																				 ,
																				 ,
																				 'Scoring_QA@risk.lexisnexis.com'));


final := sequential( filenames_details1, new_bins_remove_file,old_bins_remove_file,new_bins,old_bins,distro):
	
// seq: WHEN(CRON('00 10 * * *')),
 FAILURE(FileServices.SendEmail(Scoring_Project_DailyTracking.email_distribution.Bocashell_collections_fail_list,'BusinessShell SBFE Attributes Macro Call and Distribution Report failed','The failed workunit is:' + workunit + FailMessage));


return final;
end;