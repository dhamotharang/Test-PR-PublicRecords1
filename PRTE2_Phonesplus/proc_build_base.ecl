IMPORT PRTE2_PhonesPlus, PhonesPlus_V2, ut, PromoteSupers, PRTE2, STD, Address, AID_Support, AID, NID;

//Project Alpharetta file into a the base layout
	AlphaBase	:= PROJECT(Files.Alpharetta_base_in,
											TRANSFORM(PRTE2_PhonesPlus.Layouts.Base_ext, self.cellphoneidkey := [], self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(left.src),self := left, self := []));
	
//Project Phones History file into base layout
	PhonesHist_base	:= PROJECT(Files.PhonesHist_in,
														TRANSFORM(PRTE2_PhonesPlus.Layouts.Base_ext, self.cellphoneidkey := [], self.did := (unsigned6) left.did,  self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(left.src), self := left, self := []));

tempLayout := record
PRTE2_PhonesPlus.Layouts.Base_ext;
string50 concat_address1;
string dummy;
end;


	
//Project GE file into base layout
	pBocaGE	:= PROJECT(Files.Boca_GE_in, TRANSFORM(tempLayout, 
																																																self.cellphoneidkey := []; 
																																																self.did := (unsigned6) left.l_did;  
																																																self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(left.src); 
																																																self.concat_address1 := std.str.CleanSpaces(trim(left.address1)+ if(left.address2 <> '', ', '+ trim(left.address2),''));
																																																self := left; 
																																																self := []
																																																));



//uppercase and remove spaces from in files
	PRTE2.CleanFields(AlphaBase, CleanAlpha);
	PRTE2.CleanFields(PhonesHist_base, CleanHist);
	PRTE2.CleanFields(pBocaGE, CleanGEBase);
	
//Split into existing and new records file for name/address cleaning
	BocaGE_prev	:= project(CleanGEBase(DID <> 0 and trim(origname) <> 'ORIGNAME' and link_ssn not in prte2_phonesplus.constants.ssn_set_exception), PRTE2_PhonesPlus.Layouts.Base_ext);
	BocaGE_new		:= CleanGEBase(DID = 0 and trim(cust_name) <> '' and trim(origname) <> 'ORIGNAME'); //Added because somehow header records are getting into file
	BocaGE_xmatch		:= CleanGEBase(DID <> 0 and trim(cust_name) <> '' and trim(origname) <> 'ORIGNAME' and link_ssn in prte2_phonesplus.constants.ssn_set_exception); 

//Address Cleaning
 combine_file := BocaGE_new + BocaGE_xmatch;
 dAddressCleaned := PRTE2.AddressCleaner(combine_file,
																				['concat_address1'],
																				['dummy'], //blank field, not used but passed for attribute purposes
                                        ['OrigCity'],
                                        ['OrigState'],
                                        ['OrigZip'],
                                        ['clean_address'],
                                        ['addr_rawaid']);
																					
	PRTE2_PhonesPlus.Layouts.Base_ext xFrmBase(dAddressCleaned L) := TRANSFORM
		//Map Address
		SELF.state	:= L.clean_address.st;
		SELF.zip5		:= L.clean_address.zip;
		SELF				:= L.clean_address;
		SELF				:= L;
  END;
	
	pCleanAddr	:= PROJECT(dAddressCleaned, xFrmBase(LEFT));
	
//If parsed name is blank, clean, if not leave as is
	CleanName	:= pCleanAddr(lname <> '' and fname <> '');
	NoCleanName	:= pCleanAddr(lname = '' and fname = '');

	NID.Mac_CleanFullNames(NoCleanName, FileClnName, OrigName,  _nameorder := 'L',
											,includeInRepository:=false, normalizeDualNames:=false);
											
	PRTE2_PhonesPlus.Layouts.Base_ext xFrmCleanName(FileClnName L) := TRANSFORM
		SELF.title										:= l.cln_title;
    SELF.fname	      	:= l.cln_fname;      
    SELF.mname	      	:= l.cln_mname;      
    SELF.lname	      	:= l.cln_lname;
    SELF.name_suffix		:= l.cln_suffix;
    SELF.name_score	  := '';
		//SELF.clean_company	:= IF(SELF.lname = '',L.origname,''); //There are no company names in phonesplus
		SELF := L;
	END;
	
	pGEBase	:= CleanName + PROJECT(FileClnName, xFrmCleanName(LEFT));
		
//Combine input files and generate DID/BDID. Note - Alpharetta file processed independently in PRTE2_Phonesplus_Ins
	NewBocaBase		:= BocaGE_prev + pGEBase;
 	
	PRTE2_PhonesPlus.Layouts.Base_ext AddLinkID(NewBocaBase L) := TRANSFORM
	  SELF.did  := if(L.did > 0, L.did, prte2.fn_AppendFakeID.did(L.fname, L.lname, L.link_ssn, trim(L.link_dob), L.cust_name));
    //SELF.bdid := prte2.fn_AppendFakeID.bdid(L.clean_company,	L.prim_range,	L.prim_name, L.v_city_name, L.state, L.zip5, L.cust_name);
		self.append_ocn := L.orig_carrier_name;
		SELF			:= L;
  END;
	
	BocaBase := PROJECT(NewBocaBase, AddLinkID(LEFT)) + CleanHist;

	phonesplus_all := DEDUP(SORT(CleanAlpha + BocaBase,RECORD),ALL);
	
	PromoteSupers.MAC_SF_BuildProcess(phonesplus_all,Constants.BASE_PREFIX + 'base_all', writefile);

EXPORT proc_build_base := writefile;

