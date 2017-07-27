import InfoUSA;

file_in   := infousa.File_ABIUS_Company_Data_In;

file_sort := sort(distribute(file_in, 
	hash(ABI_NUMBER, PRIMARY_SIC, CONTACT_NAME, COMPANY_NAME, STREET1,  CITY1, STATE1, ZIP1_5, PHONE, CONTACT_LNAME, CONTACT_FNAME)), record, except process_date, local);  


InfoUSA.Layout_ABIUS_Company_Data_In  rollupXform(InfoUSA.Layout_ABIUS_Company_Data_In l, InfoUSA.Layout_ABIUS_Company_Data_In r) := transform
		
		self.Process_date    := if(l.Process_date > r.Process_date, l.Process_date, r.Process_date);
		self := l;
end;

export Update_ABIUS := rollup(file_sort,rollupXform(LEFT,RIGHT),RECORD,
                                EXCEPT Process_date, local);



