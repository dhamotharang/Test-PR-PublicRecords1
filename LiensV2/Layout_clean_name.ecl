export Layout_clean_name := module


export clean_debtor_name := record

string5   			clean_debtor_title := ''						;
string20 	 		clean_debtor_fname := ''						;
string20  			clean_debtor_mname := ''						;
string20 			clean_debtor_lname := ''						;
string5  		 	clean_debtor_name_suffix := ''					;
string3     		clean_debtor_score 	 := ''   		;

end;

export clean_creditor_name := record

string5   			clean_creditor_title := ''						;
string20 	 		clean_creditor_fname := ''						;
string20  			clean_creditor_mname := ''						;
string20 			clean_creditor_lname	:= ''					;
string5  		 	clean_creditor_name_suffix 	:= ''				;
string3     		clean_creditor_score 	:= ''    		;
end;

export clean_attorney_name := record

string5   			clean_atty_title			:= ''			;
string20 	 		clean_atty_fname			:= ''			;
string20  			clean_atty_mname			:= ''			;
string20 			clean_atty_lname			:= ''			;
string5  		 	clean_atty_name_suffix    := ''			;
string3     		clean_atty_score 	    	:= ''	;
end;

export clean_third_party_name := record

string5   			clean_thd_title				:= ''		;
string20 	 		clean_thd_fname				:= ''		;
string20  			clean_thd_mname				:= ''		;
string20 			clean_thd_lname				:= ''		;
string5  		 	clean_thd_name_suffix 		:= ''			;
string3     		clean_thd_score 	    	:= ''	;

end;

end;


