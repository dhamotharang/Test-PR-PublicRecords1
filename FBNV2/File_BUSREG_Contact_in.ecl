import ut,BusReg;
	
B := fbnv2.File_BUSREG_Company_in(br_id>0);
Bd := dedup(sort(distribute(B,hash(br_id)),br_id,local),br_id,local);

pBaseFile := BusReg.Files(,true).Base.AID.QA;
C := BusReg.Split_Base(pBaseFile).Contacts(br_id>0);
Cd := distribute(C,hash(br_id));

//Pick up the business company_name and the company mail_zip_orig, to be used in 
//creating the tmsid.
tempLayout := record
recordof(C);
B.company_name;
B.mail_zip_orig;
end;

newContacts := join(Cd,Bd,
			 left.br_id = right.br_id,
			 transform(tempLayout,self := Left, 
								  self := Right),
			 inner,local);
			 			 
export File_BUSREG_Contact_in := newContacts;





