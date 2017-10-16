/*
This assumes all names and addresses have been cleaned
And that the file is already linked
*/
EXPORT reprocessFile(dataset(spokeo.Layout_Temp) ds) := FUNCTION

	fixed := PROJECT(ds(address_source<>'L'), TRANSFORM(spokeo.Layout_Temp,
									self.address_source := '';
									self.deceased := false;
									self.dt_first_seen := 0;
									self.dt_last_seen := 0;
									self.current_address_flag := '';
									self.confirmed_address_flag := '';
									self.better_address_flag := '';

									self.judgments := '';
									self.civilCourtRecords := '';
									self.crimCourtRecords := '';
									self.curr_incar_flag := '';
									self.foreclosures := '';
									self.bankruptcy := '';
									self := left;));
	
		verified := Spokeo.proc_verifyAddr(fixed);
		better := Spokeo.proc_GetBetterAddress(verified) : PERSIST('~thor::spokeo::persist::better');
		current := Spokeo.proc_flagCurrentRecords(better);
		imputed := Spokeo.proc_imputeCurrentRecords(current);
		defunct := Spokeo.proc_getDeceased(imputed);
		bestaddr := Spokeo.proc_IsBestAddressAvailable(defunct);
		bestname := Spokeo.proc_GetBestName(bestaddr);
		result := Spokeo.proc_GetFlags(bestname);

		return result;

END;