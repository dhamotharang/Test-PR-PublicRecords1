import InfoUSA, Business_HeaderV2;

file_in   := Business_HeaderV2.Source_Files.abius.BusinessHeader;
file_dist := distribute(file_in, hash(ABI_NUMBER, CONTACT_NAME, COMPANY_NAME, STREET1));
file_sort := sort(file_dist, record, except process_date, local);  

InfoUSA.Layout_ABIUS_Company_Data_In  rollupXform(InfoUSA.Layout_ABIUS_Company_Data_In l, InfoUSA.Layout_ABIUS_Company_Data_In r) := transform
		
		self.Process_date    := if(l.Process_date > r.Process_date, l.Process_date, r.Process_date);
		self := l;
end;

export Update_ABIUS := rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_date, local);



