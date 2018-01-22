 EXPORT CROSSTAB_MACRO( indata1, indata2, unique_fields,filter_field) := MACRO
 
 // projecting all current dataset numeric fields and previous dataset numeric fields with multiple join coditions
 
  LOADXML('<xml/>');
  #exportxml(diffs, recordof(indata1) )

  #declare(sort_fields)
  #declare(join_condition)

  #declare(i)
  #set(i,1)
  #loop
    #if(%i% > count(unique_fields))
      #break
    #elseif(%i%=1)
      #set(join_condition, 'left.' + unique_fields[%i%] + '=right.' + unique_fields[%i%] )
      #set(sort_fields, unique_fields[%i%] )
      #set(i,%i%+1)
    #else
      #append(join_condition, ' AND left.' + unique_fields[%i%] + '=right.' + unique_fields[%i%] )
      #append(sort_fields, ', ' + unique_fields[%i%] )
      #set(i,%i%+1)
    #end
  #end

 #uniquename(joined1_lay)
 %joined1_lay%:=record
 string field_name;
 real8 field_value;
 end;
 
#uniquename(joined1)
 %joined1% := join( indata1, indata2, %join_condition%,transform(recordof(%joined1_lay%),self.field_name:=filter_field ;self.field_value:=	(real8)right.#expand(filter_field) -(real8)left.#expand(filter_field)));

// difference detail report generation

#uniquename(j_left_lay)
%j_left_lay%:=record
recordof(indata1);   

end;
#uniquename(j_left)
 %j_left% := join(indata1, indata2,  %join_condition% and 					
					left.#expand(filter_field) <> right.#expand(filter_field),
					transform( %j_left_lay%, self := left)
);
#uniquename(j_right)
 %j_right% := join(indata1, indata2,  %join_condition%
					and left.#expand(filter_field) <> right.#expand(filter_field),
					transform(%j_left_lay%, self := right));


			
j_1 := choosen(join(%j_left%, %j_right%,  %join_condition%,
					transform( {dataset (%j_left_lay%) res}, self.res := left + right) ),20);

	
//inner join	
	
inner_jn := join( indata1, indata2, %join_condition%);
	
// output(%joined1%);

// creating tabler report  
	
scoring_qa.table_macro(%joined1%,'field_name','field_value',op);
 
 // output(op);
 
 // calculating pct  
 
#uniquename(MyFormat)	
  %MyFormat% := RECORD
   op.field_name;
   op.total;
   op.total_change;
   decimal10_2 pct := (op.total_change/count(inner_jn))*100;
   END;
#uniquename(result_Table)	
  %result_Table% := sort(TABLE(op,%MyFormat%),total);
	 
// output(%result_Table%);

// all outputs	 

output(choosen(indata1,20),named('dset_baseline'));
output(choosen(indata2,20),named('dset_new'));
output(count(indata1),named('dset_baseline_cnt'));
output(count(indata2),named('dset_new_cnt'));
output(count(inner_jn),named('matched_cnt'));
output(%result_Table%,named('stats_ttl'));
output(if(count(j_1)>0,choosen(j_1,20)),named('diff_detail'));
output(if(count(j_1)>0,'0','dsets are identical'));	 

ENDMACRO;

//******************************example**********************************************************
// import Scoring_Project_PIP;
// input_lay := { integer AccountNumber, string fname, string1 lname , integer score};
// ds_baseline := dataset( [ {1,'john','s',800}, {2,'jane','n',700}, {3,'bob','s',690}, {4,'betty','p',750} ], input_lay );
// ds_new := dataset( [ {1,'john','s',1000}, {2,'jane','s',900}, {3,'bob','s',0}, {4,'betty','s',750} ], input_lay );

// Scoring_Project_PIP.CROSSTAB_MACRO( ds_baseline, ds_new, ['AccountNumber'],'score');

