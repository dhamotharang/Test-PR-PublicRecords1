export LinkId_Update_Batch_Service_Layouts := module

	export input_layout := record
		string20 acctno;
		string12 did;
	end;
	
	export output_layout := record
		string20 acctno;
		string12 current_did;
	end;

end;
