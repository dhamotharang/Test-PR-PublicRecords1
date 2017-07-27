import LN_PropertyV2_Services;

export Layouts_Property_DZLD := module

	// Layout provided by client.
	export Batch_In := record
		string20 acctno;
		string5		zip;
		string20	loan_amount;
		string20	loan_date;
	end;
	
	// Layout as retrieved.
	export Batch_Pre_Out := record
		Batch_In.acctno;
		LN_PropertyV2_Services.layouts.fid;
	end;

end;