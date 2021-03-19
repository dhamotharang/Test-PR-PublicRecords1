export	layout_suppressionTPS	:=
module
	
	export	Base	:=
	record
		string3		Source;
		string10	PhoneNumber;		
	end;
	
	export	Building	:=
	record
		string10	PhoneNumber;		
	end;
	export Delta := 
    record
        string10	PhoneNumber;
        UNSIGNED4 dt_effective_first;
        UNSIGNED4 dt_effective_last;
        UNSIGNED1 delta_ind; 
    end;
end;
