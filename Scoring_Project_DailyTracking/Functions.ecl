EXPORT Functions := MODULE
Import scoring_project_ks,ut;
EXPORT diff_count_function(s2, s1, f1, Result) := MACRO

		#uniquename(tble2)
		%tble2% := TABLE(s2);

		#uniquename(tble1)
		%tble1% := TABLE(s1);

		#uniquename(cnt2)
		%cnt2% := COUNT(%tble2%);

		#uniquename(cnt1)
		%cnt1% := COUNT(%tble1%);

		#uniquename(diff)
		%diff%:= JOIN(%tble2%,%tble1%,LEFT.acCOUNTnumber=RIGHT.acCOUNTnumber and LEFT.#expand(f1)!=RIGHT.#expand(f1));
		 
		#uniquename(rc)
		%rc% := RECORD
				STRING Field_Name;
				STRING Difference_COUNT ;
				decimal19_2  Difference_Percent ;
		END;
						
		#uniquename(Bks_project)
		%Bks_project% := DATASET([{f1,COUNT(%diff%),(COUNT(%diff%)/%cnt2%)*100}],%rc%);

		result := %Bks_project%;
		

endmacro;

Export Date_form(string rel_date) := function
				a := Stringlib.StringFind(rel_date, '/', 1);
				b := Stringlib.StringFind(rel_date, '/', 2);
				c := b + 4;
				mo := intformat((integer)rel_date[1..(a-1)], 2, 1);
				dom := intformat((integer)rel_date[(a+1)..(b-1)], 2, 1);
				yr := intformat((integer)rel_date[(b+1)..c], 4, 1);
				return yr + mo + dom;
end;
		
Export Get_past_date( req_date)  := function

		all_days := scoring_project_ks.day_logic.day_search_map;

		number_today := all_days(DateKey = (string) ut.getdate);		

		day1 := number_today[1].id;
		
		number_previous := all_days(DateKey = (string) req_date);		

		day2 := number_previous[1].id;
		

		req_day_id := ((integer) day1 - (integer)day2 ) ;

	return req_day_id;

end;


END;