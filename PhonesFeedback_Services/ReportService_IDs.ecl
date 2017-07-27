
export ReportService_IDs := module
	export params := interface(AutoKey_IDs.params)
		export string15 Phone_number := '';
		export string12 in_DID:='';

	end;
		export val(params in_mod) := function
			Phone_number := dataset([{in_mod.Phone_number,in_mod.in_DID}],Layouts.rec_in_request);
			
			by_Phone_number := if(in_mod.Phone_number != '',PhonesFeedback_Services.Raw.byPhoneNumber(Phone_number));
			
			return by_Phone_number;
		
	end;
end;