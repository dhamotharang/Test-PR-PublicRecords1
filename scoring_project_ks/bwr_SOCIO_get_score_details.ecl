EXPORT bwr_SOCIO_get_score_details (lay, field_name, date_in, retvalfinal) := MACRO


//reading the file
#UNIQUENAME(file_table)
%file_table%  := dataset( '~ScoringQA::out::' + lay + '_' + date_in,  #expand(lay) ,thor );

// %file_table%  := dataset('~sghatti::out::' + lay + '_' + date_in,  #expand(lay) , CSV(heading(single), quote('"')) );

//get the standrs deviation, mean, max, min etc


#UNIQUENAME(table_in2)
%table_in2%   := table (%file_table% , {acctno, lay, field_name,  string80 score:= scoring_project_ks.bwr_SOCIO_get_score( lay,(string) #expand(field_name))  } ) :independent ;


   #UNIQUENAME(stat_group)
   %stat_group% := record
   
     string80 flagship := lay;
                
     mean      := ave(group, (integer8) %table_in2%.score );
     std_dev   := sqrt(variance(group, (integer8) %table_in2%.score ));
     max_value := max(group, (integer8) %table_in2%.score );
     min_value := min(group, (integer8) %table_in2%.score );
                
   end;
    

			
   #UNIQUENAME(stat_data)
   %stat_data%   := table ( %table_in2%( (integer8) score > 0 )  , %stat_group% );
   
   
   
   
   // #UNIQUENAME(stat_group2)
   // %stat_group2% := record
   
     // string80 flagship := lay;
     // num_of_invalid                      := count(group, (integer) %table_in2%.score = -1 );
                // num_of_exception     := count(group, (integer) %table_in2%.score = -2 );
   // end;
   
   // #UNIQUENAME(stat_data2)
   // %stat_data2%   := table ( %table_in2%( (integer8) score < 0 )  , %stat_group2% );
   
   
   // #UNIQUENAME(stat_datas)
   // %stat_datas% := join(%stat_data%, %stat_data2%, left.flagship = right.flagship , lookup );
   
   
   //filtering the required column
   
   #UNIQUENAME(table_in)
   %table_in%   := table ( %file_table% , { scoring_project_ks.bwr_SOCIO_get_score_bin( lay,(string) #expand(field_name)) } );
   
   
   #UNIQUENAME(table_count)
   %table_count% := count(%table_in%(bwr_SOCIO_get_score_bin<>'NULL'));
   
   
   //grouping the bins
   
   #UNIQUENAME(rec_group)
   %rec_group% := record
   
   %table_in%.bwr_SOCIO_get_score_bin;
   string80 flagship := lay;
   string80 score_name := field_name;
   integer8 file_count := %table_count%;
   date_in;
   
   cnt_grp := count(group);
   
   end;
   
   #UNIQUENAME(table_grp)
   %table_grp%   := table ( %table_in% , %rec_group%, bwr_SOCIO_get_score_bin);
   
   
   #UNIQUENAME(table_joins)
   %table_joins%  := join( %table_grp%, %stat_data% , left.flagship = right.flagship, lookup  );
   
   
   // #UNIQUENAME(table_joins2)
   // %table_joins2%  := join( %table_joins% , %stat_data2%, left.flagship = right.flagship, lookup  );
   
   
   //for join with min, max etc
   
                                #UNIQUENAME(FileName)
                                %FileName%:= if(fileservices.fileexists('~ScoringQA::bins::socio_ks::' + date_in + '_results')=false,
                                FileServices.CreateSuperFile('~ScoringQA::bins::socio_ks::' + date_in + '_results'));             
                                                                                                                                                                                                                                                                                                 
                                #UNIQUENAME(FileNameNewLogical)
                                %FileNameNewLogical%:= '~ScoringQA::bins::socio_ks::' + date_in + '_results' + '_' + lay + '_' + field_name  ;
   
                
                                #UNIQUENAME(SaveNewFile) 
                                %SaveNewFile% :=
                                                output(%table_joins%, , %FileNameNewLogical%, 
                                                                                                 CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(10240)),
                                                                                                 overwrite,EXPIRE(10));
                                #UNIQUENAME(res)                                                                       
                                %res%:=FileServices.AddSuperFile( '~ScoringQA::bins::socio_ks::' + date_in + '_results' , %FileNameNewLogical%) ; //change names to Socio
                                                                                                                                                                                                                                                
                                                                                                                                                                                                 
       //for raw data 
                                
                                #UNIQUENAME(FileName1)
                                %FileName1%:=               if(fileservices.fileexists('~ScoringQA::bins::socio_ks::' + date_in + '_data')=false,
                                                                                      FileServices.CreateSuperFile('~ScoringQA::bins::socio_ks::' + date_in + '_data'));     
                                                                                                                                                                                                                                                                                                 
                                #UNIQUENAME(FileNameNewLogical1)
                                %FileNameNewLogical1%:= '~ScoringQA::bins::socio_ks::' + date_in + '_data' + '_' + lay + '_' + field_name  ;
   
                
                                #UNIQUENAME(SaveNewFile1) 
                                %SaveNewFile1% :=
                                                output(%table_in2%, , %FileNameNewLogical1%, 
                                                                                                 CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(10240)),
                                                                                                overwrite,EXPIRE(10));
                                                                                                 
                                #UNIQUENAME(res1)                                                                    
                                %res1%:=FileServices.AddSuperFile( '~ScoringQA::bins::socio_ks::' + date_in + '_data' , %FileNameNewLogical1%)              ;                               
                                
                                
                                //for #of exceptions and invalids
                                
                                // #UNIQUENAME(FileName2)
                                // %FileName2%:=          if(fileservices.fileexists('~sghatti::bins::ks1::' + date_in + '_datas')=false,
                                                                                                                                            // FileServices.CreateSuperFile('~sghatti::bins::ks1::' + date_in + '_datas')); 
                                                                                                                                                                                                                                                                                                 
                                // #UNIQUENAME(FileNameNewLogical2)
                                // %FileNameNewLogical2%:= '~sghatti::bins::ks1::' + date_in + '_datas' + '_' + lay + '_' + field_name  ;
   
                
                                // #UNIQUENAME(SaveNewFile2)            
                                // %SaveNewFile2% :=
                                                // output(%stat_data2%, , %FileNameNewLogical2%, 
                                                                                                 // CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(10240)),
                                                                                                 // overwrite);
                                                                                                 
                                // #UNIQUENAME(res2)                                                                
                                // %res2%:=FileServices.AddSuperFile( '~sghatti::bins::ks1::' + date_in + '_datas' , %FileNameNewLogical2%)              ;               
   
                                retvalfinal := SEQUENTIAL(%FileName%,%SaveNewFile%,%res%, %FileName1%,%SaveNewFile1%, %res1%); 

                                // RETURN retvalfinal;
                                //RETURN %file_table%;
                                // retvalfinal := sequential(%FileName%,%SaveNewFile%,%res%, %FileName1%,%SaveNewFile1%, %res1%, %FileName2%,%SaveNewFile2%, %res2%);            

ENDMACRO;



