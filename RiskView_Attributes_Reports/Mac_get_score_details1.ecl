EXPORT Mac_get_score_details1( lay, field_name, date_in, retvalfinal ) := macro


import sghatti;


//////////////////////////////////////////////////////////////////////////////////////////////


//reading the file
#UNIQUENAME(file_table)
%file_table%  := dataset('~nkoubsky::out::' + lay + date_in,  #expand(lay) , CSV(heading(single), quote('"')) );

// %file_table%  := dataset('~nkoubsky::out::' + lay + '_' + date_in,  #expand(lay) , CSV(heading(single), quote('"')) );


//get the standrs deviation, mean, max, min etc


#UNIQUENAME(table_in2)
%table_in2%   := table ( %file_table% , { acctno, lay, field_name,  string80 score:= sghatti.get_score( lay, #expand(field_name))  } ) :independent ;


#UNIQUENAME(stat_group)
%stat_group% := record

  string80 flagship := lay;
	
  mean 			:= ave(group, (integer8) %table_in2%.score );
	std_dev   := sqrt(variance(group, (integer8) %table_in2%.score ));
  max_value := max(group, (integer8) %table_in2%.score );
	min_value := min(group, (integer8) %table_in2%.score );
	
end;
	
#UNIQUENAME(stat_data)
%stat_data%   := table ( %table_in2%( (integer8) score > 0 )  , %stat_group% );




// #UNIQUENAME(stat_group2)
// %stat_group2% := record

  // string80 flagship := lay;
  // num_of_invalid 		:= count(group, (integer) %table_in2%.score = -1 );
	// num_of_exception 	:= count(group, (integer) %table_in2%.score = -2 );
// end;

// #UNIQUENAME(stat_data2)
// %stat_data2%   := table ( %table_in2%( (integer8) score < 0 )  , %stat_group2% );


// #UNIQUENAME(stat_datas)
// %stat_datas% := join(%stat_data%, %stat_data2%, left.flagship = right.flagship , lookup );


//filtering the required column

#UNIQUENAME(table_in)
%table_in%   := table ( %file_table% , { sghatti.get_score_bin( lay, #expand(field_name)) } );


#UNIQUENAME(table_count)
%table_count% := count(%table_in%);


//grouping the bins

#UNIQUENAME(rec_group)
%rec_group% := record

%table_in%.get_score_bin;
string80 flagship := lay;
string80 score_name := field_name;
integer8 file_count := %table_count% ;
date_in;

cnt_grp := count(group);

end;

#UNIQUENAME(table_grp)
%table_grp%   := table ( %table_in% , %rec_group%, get_score_bin );


#UNIQUENAME(table_joins)
%table_joins%  := join( %table_grp%, %stat_data% , left.flagship = right.flagship, lookup  );


// #UNIQUENAME(table_joins2)
// %table_joins2%  := join( %table_joins% , %stat_data2%, left.flagship = right.flagship, lookup  );


   //for join with min, max etc

		#UNIQUENAME(FileName)
		%FileName%:=	if(fileservices.fileexists('~nkoubsky::bins::' + date_in + '_results')=false,
										 FileServices.CreateSuperFile('~nkoubsky::bins::' + date_in + '_results'));	
																		 
		#UNIQUENAME(FileNameNewLogical)
		%FileNameNewLogical%:= '~nkoubsky::bins::' + date_in + '_results' + '_' + lay + '_' + field_name  ;

	
		#UNIQUENAME(SaveNewFile)	
		%SaveNewFile% :=
			output(%table_joins%, , %FileNameNewLogical%, 
						 CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(10240)),
						 overwrite);
		#UNIQUENAME(res)					 
		%res%:=FileServices.AddSuperFile( '~nkoubsky::bins::' + date_in + '_results' , %FileNameNewLogical%)	;					
															
												 
    //for raw data 
		
		#UNIQUENAME(FileName1)
		%FileName1%:=	if(fileservices.fileexists('~nkoubsky::bins::' + date_in + '_data')=false,
										 FileServices.CreateSuperFile('~nkoubsky::bins::' + date_in + '_data'));	
																		 
		#UNIQUENAME(FileNameNewLogical1)
		%FileNameNewLogical1%:= '~nkoubsky::bins::' + date_in + '_data' + '_' + lay + '_' + field_name  ;

	
		#UNIQUENAME(SaveNewFile1)	
		%SaveNewFile1% :=
			output(%table_in2%, , %FileNameNewLogical1%, 
						 CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(10240)),
						 overwrite);
						 
		#UNIQUENAME(res1)					 
		%res1%:=FileServices.AddSuperFile( '~nkoubsky::bins::' + date_in + '_data' , %FileNameNewLogical1%)	;		
		
		
		//for #of exceptions and invalids
		
		// #UNIQUENAME(FileName2)
		// %FileName2%:=	if(fileservices.fileexists('~nkoubsky::bins::' + date_in + '_datas')=false,
										 // FileServices.CreateSuperFile('~nkoubsky::bins::' + date_in + '_datas'));	
																		 
		// #UNIQUENAME(FileNameNewLogical2)
		// %FileNameNewLogical2%:= '~nkoubsky::bins::' + date_in + '_datas' + '_' + lay + '_' + field_name  ;

	
		// #UNIQUENAME(SaveNewFile2)	
		// %SaveNewFile2% :=
			// output(%stat_data2%, , %FileNameNewLogical2%, 
						 // CSV(heading(0), SEPARATOR('|'), QUOTE(''), TERMINATOR('\n'), MAXLENGTH(10240)),
						 // overwrite);
						 
		// #UNIQUENAME(res2)					 
		// %res2%:=FileServices.AddSuperFile( '~nkoubsky::bins::' + date_in + '_datas' , %FileNameNewLogical2%)	;	

		retvalfinal := sequential(%FileName%,%SaveNewFile%,%res%, %FileName1%,%SaveNewFile1%, %res1%);	

		// retvalfinal := sequential(%FileName%,%SaveNewFile%,%res%, %FileName1%,%SaveNewFile1%, %res1%, %FileName2%,%SaveNewFile2%, %res2%);	

endmacro;