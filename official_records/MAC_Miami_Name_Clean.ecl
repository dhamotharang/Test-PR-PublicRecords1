export MAC_Miami_Name_Clean(docfile,partyfile,state,cty,filedate,outfle) := macro

import lib_stringlib,lib_AddrClean,ut,Address,NID;
Layout_valid_name := record
official_records.Layout_In_preclean_party;
string13 key;
string1 transaction_type;
string2	xname_type;
string1	xpty_typ;
string175	xname;
end;

Layout_valid_name tvalidname(partyfile l) := transform
self.xname_type := 'E1';
self.xpty_typ := l.entity_nm_format;
self.xname := l.entity_nm;
self.key := l.key;
self.transaction_type := l.transaction_type;
self := l;
end;

File_new_pty := project(partyfile,tvalidname(LEFT));


//remove etal,etux,estate
Layout_valid_name tr_remove(File_new_pty l) := transform
valid_xname := official_records.get_valid_name(l.xname);
self.xname := valid_xname;
self := l;
end;

dPrepInput := project(File_new_pty,tr_remove(LEFT));

//call Macro to differentiate company vs person


//Seperate Company and person from outfile




//ut.Mac_Clean_Dual_Names(File_EName,xname,File_Person_CleanName,xpty_typ,false);

 NID.Mac_CleanFullNames(dPrepInput, dCleanfile,xname,,,,,,,,,,,,,,,,xpty_typ);


//Process company records




keywords := '( AND | AND/ | & | &/ |  OR )' ;

official_records.Layout_In_Miami_dade_Party CleanName(dCleanfile l) := transform
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

dParsedfile := project(dCleanfile,CleanName(LEFT)) ;


sort_clean_all := sort(dParsedfile,record);

dedup_clean_all := dedup(sort_clean_all,all) : persist('~thor_200::persist::official_records_'+state+'_'+cty+'_party_clean');

Outpartyfile := output(dedup_clean_all,,'~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_party',overwrite);

superfile_transaction_party := sequential(FileServices.StartSuperFileTransaction(),
	                                      FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_grandfather'),
				                          FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_grandfather','~thor_200::base::official_records_'+state+'_'+cty+'_party_father',, true),
				                          FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_father'),
				                          FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party_father', '~thor_200::base::official_records_'+state+'_'+cty+'_party',, true),
				                          FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party'),
				                          FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_party', '~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_party'),
				                          FileServices.FinishSuperFileTransaction());

/////////////////////////document clean///////////////////////////////////////////

Layout_Miami_document := record
Layout_In_preclean_document;
string13 key;
string1 transaction_type;
end;
Layout_Miami_document tdocclean(docfile l) := transform

self.consideration_amt := if(trim(l.consideration_amt) = '0','',l.consideration_amt);
self.intangible_tax_amt := map(trim(l.intangible_tax_amt,left,right) = '0.00' or trim(l.intangible_tax_amt,left,right) = '0' => '',
                               trim(l.intangible_tax_amt,left,right) = '000' => '',l.intangible_tax_amt);

self.documentary_stamps_fee := map(trim(l.documentary_stamps_fee,left,right) = '0.00' or trim(l.documentary_stamps_fee,left,right) = '0' => '',
                               trim(l.documentary_stamps_fee,left,right) = '000' => '',l.documentary_stamps_fee);
							   
self.excise_tax_amt := 		map(trim(l.excise_tax_amt,left,right) = '0.00' or trim(l.excise_tax_amt,left,right) = '0' => '',
                               trim(l.excise_tax_amt,left,right) = '000' => '',l.excise_tax_amt);

self.book_num := if(trim(l.book_num) = '0','',l.book_num);
self.page_num := if(trim(l.page_num) = '0','',l.page_num);	
self := l;
end;

dCleandoc := project(	docfile,	tdocclean(LEFT));

dWithAddress := dCleandoc(address_1 <> '' or address_2 <> '' or address_3 <> '' or address_4 <> '');
dWithoutAddress := dCleandoc(~(address_1 <> '' or address_2 <> '' or address_3 <> '' or address_4 <> ''));

//clean address call macro

Layout_In_Pepped := record
official_records.Layout_In_Miami_dade_document;
end;

Layout_In_Pepped tcleanaddr(dWithoutAddress l) := transform

self := l;
self := [];
end;

dWithoutAddr:= project(dWithoutAddress,tcleanaddr(LEFT));

Layout_In_Pepped tcleanaddr1(dCleandoc l) := transform


self := l;
self := [];
end;

dFull_No_Address := project(dCleandoc,tcleanaddr1(LEFT));

official_records.MAC_Mdade_AID(dWithAddress,filedate,cleanout);

do_clean_addr := if(count(dWithAddress) > 0 ,(dWithoutAddr + cleanout),dFull_No_Address);	

Outdocfile := Output(do_clean_addr,,'~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_document',overwrite);

superfile_transaction_document := sequential(FileServices.StartSuperFileTransaction(),
				                             FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_grandfather'),
				                             FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_grandfather','~thor_200::base::official_records_'+state+'_'+cty+'_document_father',, true),
				                             FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_father'),
				                             FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document_father', '~thor_200::base::official_records_'+state+'_'+cty+'_document',, true),
				                             FileServices.ClearSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document'),
				                             FileServices.AddSuperFile('~thor_200::base::official_records_'+state+'_'+cty+'_document', '~thor_200::in::official_records_'+state+'_'+cty+'_'+filedate+'_document'),
				                             FileServices.FinishSuperFileTransaction());
 outfle := sequential(Outdocfile,superfile_transaction_document,Outpartyfile,superfile_transaction_party);				
 
 endmacro;
  