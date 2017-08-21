#workunit('name', 'PRCT-Add File To Peson Header');
Import PRTE_CustomerFiles, ut;

/* Spray customer tab delimitted file to thor and using Naming Convention: 'prte::in::customer_filedate_bugnum.txt'
   This program will remove duplicate records from input file and generate compressed flat file 
   Use ECL Watch to add the compressed flate file to applicable header superfile (based on customername) */

//modify to match sprayed file
customer 		:= 'citi';  
filedate 		:= '20150513';
bugnum	 		:= '180511';
RealPhones	:= 'YES';  		//set to 'YES' if customer supplied real phone numbers and/or phones should be ommitted from header recs
													//set to 'NO' if customer supplied phones are fake and should be inlcuded in header recs

cust_layout := record,MAXLENGTH(10000)
			string fname;
			string lname;
			string mname;
			string suffix; 			
			string addr;
			string filler1; //may be populated with date_first_seen
			string filler2; //may be populated with date_last_seen
			string city;
			string2 st;
			string5 zip;
			string10 phone;
			string8 dob;
			string9 ssn;
	end;

//sprayed customer input file
cust_file := dataset('~prte::in::'+customer+'_'+filedate+'_'+bugnum+'.txt', cust_layout, CSV(heading(1),separator(['\t']),terminator(['\r\n']),MAXLENGTH(10000)));

//dedup customer file to remove duplicates based SSN, Name and Address
ddp_cust_file := dedup(sort(distribute(cust_file, hash(ssn)), ssn, lname, fname, mname, addr, skew(1.0), local), ssn, lname, fname, mname, addr, local);

output(count(cust_file), named('CustomerFileRecs'));
output(count(ddp_cust_file), named('DedupedCustomerRecords'));
output(cust_file, named('SampleCustomerSampleRecs'));
output(ddp_cust_file, named('SampleDedupCustomerRecs'));

hdr_layout := record,MAXLENGTH(10000)
		string fname;
		string lname;
		string mname;
		string addr;
		string filler1;
		string filler2;
		string city;
		string st;
		string zip;
		string phone;
		string dob;
		string ssn;
END;

hdr_layout addtohdr(ddp_cust_file le) := transform
	self.phone := MAP((RealPhones='YES') => '',
										(RealPhones='NO') => le.phone,
										'');
	self.filler1 := '';
	self.filler2 := '';
	self := le;
	end;


//output deduped customer recs into header flat file format. Add this output file to the appropriate header superfile
hdr_file := Project(ddp_cust_file, addtohdr(left));
output(hdr_file,, '~prte::in::header::'+customer+'_'+filedate+'_file_flat', compressed,overwrite);