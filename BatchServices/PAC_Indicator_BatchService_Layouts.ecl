import Autokey_batch, Address, Debt_Settlement, BatchServices;

export PAC_Indicator_BatchService_Layouts := MODULE

	export rec_batch_input := record
			string20	 	acctno := '';
			string16   	phoneno:= '';
			string100  	addr:= '';
			STRING10 		prim_range := '';
			STRING2 		predir := '';
			STRING28 		prim_name := '';
			STRING4 		addr_suffix := '';
			string2 		postdir := '';
			string10 		unit_design := '';
			STRING8 		sec_range := '';
			string40   	city:= '';
			string2    	st:= '';
			string5    	z5:= '';
	end;
	
	export joined_layout := record
			string20 MatchCode;
			string20 acctno;
			Debt_Settlement.Layouts.Base;
	end;
	
	export out_layout := record
			string20 acctno;
			string1  PAC_Indicator_Flag;
			string2	 PAC_Match_Code;
			string80 PAC_Contact_Name;
			string16 PAC_Contact_Phone;
	end;
	
END;