export MAC_Name_Clean(docfile,partyfile,state,cty,filedate,outfle) := macro
/* Line1-72 Party Clean */

import lib_stringlib,ut,Address,lib_AddrClean,NID;

 prepnamerec := record
  official_records.Layout_In_preclean_party;
	string2	xname_type;
	string1	xpty_typ;
	string175	xname;
	 Address.Layout_Clean182_fips clean_address;
  Address.Layout_Clean_Name    clean_name;
end;

prepnamerec   tPrepName(official_records.Layout_In_preclean_party l) := transform
self.xname_type := 'E1';
self.xpty_typ := l.entity_nm_format;
self.xname := l.entity_nm;
self := l;
self := [];

end;

dPrepName := project(partyfile,tPrepName(LEFT));


//remove etal,etux,estate
prepnamerec  filterout(dPrepName l) := transform
valid_xname := official_records.get_valid_name(l.xname);
self.xname := valid_xname;
self := l;
self := [];
end;

dPrepInput := project(dPrepName,filterout(LEFT));


//ut.Mac_Clean_Dual_Names(File_EName,xname,File_Person_CleanName,xpty_typ,false);

//NID.Mac_CleanFullNames( dPrepInput,dCleanfile, xname, ,xpty_typ,,,,,,,,,,,,,true);


  NID.Mac_CleanFullNames(dPrepInput, dCleanfile,xname,,,,,,,,,,,,,,,,xpty_typ);


  // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	// this type of definition - action must precede an expression."
	
	keywords := '( AND | AND/ | & | &/ |  OR )' ;

official_records.Layout_In_Party CleanName(dCleanfile l) := transform
 self.title1           := if( l.nametype = 'P' , l.cln_title,'');                    
 self.fname1           := if( l.nametype = 'P' , l.cln_fname,'');					
 self.mname1           := if( l.nametype = 'P' , l.cln_mname,'');					
 self.lname1           :=  if( l.nametype = 'P' , l.cln_lname,'');
 self.suffix1          := if( l.nametype = 'P' , l.cln_suffix,'');
 self.pname1_score     := '';
 self.title2           := if( l.nametype = 'P' , l.cln_title2,'');
 self.fname2           := if( l.nametype = 'P' , l.cln_fname2,'');
 self.mname2           := if( l.nametype = 'P' , l.cln_mname2,'');
 self.lname2           :=  if( l.nametype = 'P' , l.cln_lname2,'');
 self.suffix2          :=  if( l.nametype = 'P' , l.cln_suffix2,'');
 self.pname2_score     := '';                   
 self.entity_nm        := trim(l.xname[1..80],left,right);
 self.cname1           := map(l.nametype <> 'P' and regexfind(keywords,l.xname,0)  <> '' => l.xname[1..StringLib.StringFind( l.xname,trim(regexfind(keywords,l.xname,0)),1)],
                               l.nametype <> 'P' and regexfind(keywords,l.xname,0)  = '' => l.xname,''  );
 self.cname2           := if(l.nametype <> 'P' and regexfind(keywords,l.xname,0)  <> '',l.xname[StringLib.StringFind( l.xname,trim(regexfind(keywords,l.xname,0)),1)+ length(regexfind(keywords,l.xname,0))..],
                               ''  );
 self                  := l;
 self                  := [];
end;

dParsedfile := project(dCleanfile,CleanName(LEFT)) : persist('~thor_200::persist::official_records_'+state+'_'+cty+'_party_clean');

Outpartyfile := output(dParsedfile,,'~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_party',overwrite);

superfile_transaction_party := sequential(FileServices.StartSuperFileTransaction(),
	                                      FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_grandfather'),
				                          FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_grandfather','~thor_200::base::official_records_'+state+'_'+cty+'_party_father',, true),
				                          FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_father'),
				                          FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_father', '~thor_200::base::official_records_'+state+'_'+cty+'_party',, true),
				                          FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party'),
				                          FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party', '~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_party'),
				                          FileServices.FinishSuperFileTransaction());

/*Line 72 - 123 Party Clean */

official_records.Layout_In_preclean_document tdocclean(docfile l) := transform

	self.consideration_amt     := if(trim(l.consideration_amt) = '0','',l.consideration_amt);
	self.intangible_tax_amt    := map(trim(l.intangible_tax_amt,left,right) = '0.00' or trim(l.intangible_tax_amt,left,right) = '0' => '',
                               trim(l.intangible_tax_amt,left,right) = '000' => '',l.intangible_tax_amt);

	self.documentary_stamps_fee := map(trim(l.documentary_stamps_fee,left,right) = '0.00' or trim(l.documentary_stamps_fee,left,right) = '0' => '',
                               trim(l.documentary_stamps_fee,left,right) = '000' => '',l.documentary_stamps_fee);
							   
	self.excise_tax_amt         := 	map(trim(l.excise_tax_amt,left,right) = '0.00' or trim(l.excise_tax_amt,left,right) = '0' => '',
                               trim(l.excise_tax_amt,left,right) = '000' => '',l.excise_tax_amt);

	self.book_num               := if(trim(l.book_num) = '0','',l.book_num);
	self.page_num               := if(trim(l.page_num) = '0','',l.page_num);	
	self := l;
end;

dCleandoc := project(	docfile,	tdocclean(LEFT));

dWithAddress := dCleandoc(address_1 <> '' or address_2 <> '' or address_3 <> '' or address_4 <> '');
dWithoutAddress := dCleandoc(~(address_1 <> '' or address_2 <> '' or address_3 <> '' or address_4 <> ''));

//clean address call macro

Layout_In_Pepped_addr := record
	official_records.Layouts_document;
end;


Official_Records.Layout_In_Document tcleanaddr(dWithoutAddress l) := transform
	
	self := l;
	self := [];

end;

dWithoutAddr := project(dWithoutAddress,tcleanaddr(LEFT));

Official_Records.Layout_In_Document blankaddr(dCleandoc l) := transform
	
	self := l;
	self := [];
end;

dFull_No_Addr := project(dCleandoc,blankaddr(LEFT));

official_records.MAC_App_AID(dWithAddress,filedate,cleanaddr,state,cty);

do_clean_addr := if(count(dWithAddress) > 0 ,(dWithoutAddr + cleanaddr),dFull_No_Addr) : persist('~thor_200::persist::official_records_'+state+'_'+cty+'_document_clean');	

Outdocfile := Output(do_clean_addr,,'~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_document',overwrite);

superfile_transaction_document := sequential(FileServices.StartSuperFileTransaction(),
				                             FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_grandfather'),
				                             FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_grandfather','~thor_200::base::official_records_'+state+'_'+cty+'_document_father',, true),
				                             FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_father'),
				                             FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_father', '~thor_200::base::official_records_'+state+'_'+cty+'_document',, true),
				                             FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document'),
				                             FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document', '~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_document'),
				                             FileServices.FinishSuperFileTransaction());
  outfle :=  sequential(Outdocfile,superfile_transaction_document,Outpartyfile,superfile_transaction_party);				
 
 endmacro;
  