import doxie;

export FetchI_Hdr_Batch_Biz(
	dataset(Layouts.Fetch_Hdr_Batch_Biz_Layout) indata) := function

	tempdata0 := project(indata,transform(Layouts.Fetch_Hdr_Biz_Working_Layout,
		self.cleaned_cname := datalib.companyclean(left.company_name_value),
		self := left,
		self := []));
	
	tempdata1 := FetchI_Hdr_Batch_Biz_FEIN(tempdata0);
	tempdata2 := FetchI_Hdr_Batch_Biz_Phone(tempdata1);
	tempdata3 := FetchI_Hdr_Batch_Biz_Street(tempdata2);
	tempdata4 := FetchI_Hdr_Batch_Biz_Address(tempdata3);
	tempdata5 := FetchI_Hdr_Batch_Biz_Zip(tempdata4);
	tempdata6 := FetchI_Hdr_Batch_Biz_Name(tempdata5);
	tempdata7 := FetchI_Hdr_Batch_Biz_StName(tempdata6);
	tempdata8 := FetchI_Hdr_Batch_Biz_StCityName(tempdata7);

	all_bdids := normalize(tempdata8,count(left.results.BDIDs) + if(left.results.errcode != Types.ErrCode.NONE,1,0),
		transform(Layouts.Fetch_Batch_PreOutput_Layout,
			self.acctno := left.acctno,
			self.errcode := if(counter > count(left.results.BDIDs),left.results.errcode,Types.ErrCode.NONE),
			self.id := if(counter > count(left.results.BDIDs),0,left.results.BDIDs[counter].bdid)))
      // add batch records which had BDID in the first place
      + project (indata (bdid_value != 0), 
                 transform (Layouts.Fetch_Batch_PreOutput_Layout,
                            self.errcode := Types.ErrCode.NONE,
                            self.id := left.bdid_value,
                            self.acctno := left.acctno));   
	return dedup (sort (all_bdids, acctno, id), acctno, id);
end;
