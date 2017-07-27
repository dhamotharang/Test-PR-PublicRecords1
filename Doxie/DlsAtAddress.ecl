//for all of the addresses return the driver licenses at each
import ut, doxie, doxie_Raw, DriversV2_Services, DriversV2,
			Autokey_batch, BatchServices, AutokeyB2, iesp, header;

export DlsAtAddress(dataset(doxie.Layout_Comp_Addresses) ds_in,integer numberAddresses=5,
										integer dateRangeAddresses=0,
										boolean returnTheSubject=false,
										integer countPerAddress=10) := function;
//dateRangeAddresses form of YYYYMM	
doxie.MAC_Header_Field_Declare(); //dppa_purpose only
validDateRange := if(dateRangeAddresses > 190000 and dateRangeAddresses < 204000,dateRangeAddresses,0);
doxie_raw.MAC_ENTRP_CLEAN(ds_in,dt_last_seen,ds_entrp);
ds := IF(ut.IndustryClass.is_entrp,ds_entrp,ds_in);
number_ds := choosen(sort(ds,-dt_last_seen),numberAddresses);
dateRange_ds := ds(dt_last_seen >= validDateRange);
filterByDate := if(count(dateRange_ds) > 0 , dateRange_ds, ds);
// list of addresses to consider
filtered_ds := map(numberAddresses = 0 and validDateRange = 0 => ds,
										numberAddresses > 0 and validDateRange = 0 =>number_ds,
										numberAddresses = 0 and  validDateRange > 0 => filterByDate	,
										choosen(sort(dateRange_ds,-dt_last_seen),numberAddresses));

Autokey_batch.Layouts.rec_inBatchMaster b_trans(filtered_ds L) := transform
	self.acctno := (string8)l.address_seq_no;
	self.z5 := L.zip;
	self.addr_suffix := L.suffix;
	self.p_city_name := L.city_name;
	self.did := 0;
	self := L;
end;
b_ds := project(filtered_ds,b_trans(LEFT));
// load batch layout request with addresses
ds_batch_in := b_ds;
	
	ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export UseAllLookUps := TRUE;
			export skip_set := Driversv2.Constants.autokey_skipSet;
	END;
							 
  ak_input := PROJECT(ds_batch_in,Autokey_batch.Layouts.rec_inBatchMaster);
	
	ak_key := DriversV2.Constants.autokey_qa_Keyname;
  ak_out := Autokey_batch.get_fids(ak_input, ak_key, ak_config_data);
	
	outpl_rec :=DriversV2.File_DL_base_for_Autokeys;
	AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec, outpl,did,zero,'DL');

	ak_ids := DEDUP(SORT(project(ungroup(outpl),DriversV2_Services.layouts.seq),dl_seq),dl_seq);
	ak_acct_rec := RECORD
	  integer2 acctno := 0;
		unsigned6   DID := 0;
		string24  dl_number := ''; 
		string2  dlstate := ''; 
    string15	dl_seq := '';		
	END;

  ak_acctno :=  DEDUP(SORT(project(ungroup(outpl),TRANSFORM(ak_acct_rec,SELF.dl_seq := (string)LEFT.dl_seq,self.acctno := (integer2)left.acctno,sELF := LEFT,SELF := []))
	                   ,acctno,dl_seq),acctno,dl_seq);

	in_acctno := SORT(ak_acctno ,acctno,dl_seq);

  dids    := PROJECT(ak_acctno,doxie.layout_references);	
	
  seqs := ak_ids ; 
	// retrieve results
	rpen_s := DEDUP(SORT(DriversV2_Services.DLRaw.narrow_view.by_seq(seqs),dl_seq),dl_seq);
	final_layout := RECORD
	   integer2 acctno := 0;
  	 rpen_s;
	END;
  
	final_layout xfm_final(ak_acct_rec l,rpen_s r) := TRANSFORM
		 SELF := R;
		 SELF := L;
	END;
  //removing historicals - join results of dls with the accont numbers
	out_acctno_3 := JOIN(in_acctno,rpen_s(history = '')
											 ,(string)LEFT.dl_seq =(string) RIGHT.dl_seq
											 ,xfm_final(LEFT,RIGHT)
											);
	DriversV2_Services.layouts.result_wide exact_sec(	out_acctno_3 l,b_ds	r) := transform
		self.addr_no := l.acctno;
		self := l;
		self := [];
	end;
	// join dls with the address list ensuring sec range match and remove subject
  integer subjectDID := ds[1].did;
	out_acctno_1 := join(out_acctno_3,b_ds,left.acctno = (integer2)right.acctno and left.sec_range = right.sec_range and ((left.did <> subjectDid and ut.dppa_ok(dppa_purpose,header.constants.checkRNA)) or returnTheSubject),exact_sec(left,right));
	
  out_acctno := SORT(DEDUP(SORT(out_acctno_1(dl_number<>''),addr_no,dl_number,-expiration_date),addr_no,dl_number,keep(2))											
                +
								DEDUP(SORT(out_acctno_1(dl_number='' and (string)did <>''),addr_no,did,-expiration_date),addr_no,did,keep(2)),addr_no,-expiration_date);											
	final_out := if(countPerAddress > 0,dedup(out_acctno,addr_no,keep(countPerAddress)),out_acctno);						
	iesp_out := iesp.transform_dl(final_out);
return iesp_out;								
end;
