IMPORT PRTE2_PhonesPlus, PhonesPlus_V2, ut, PromoteSupers, PRTE2, STD, Address, AID_Support, AID, NID;

//Project Alpharetta file into a the base layout
	AlphaBase	:= PROJECT(Files.Alpharetta_base_in,
											TRANSFORM(PRTE2_PhonesPlus.Layouts.Base_ext, self.cellphoneidkey := [], self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(left.src),self := left, self := []));
	
//Project Phones History file into base layout
	PhonesHist_base	:= PROJECT(Files.PhonesHist_in,
														TRANSFORM(PRTE2_PhonesPlus.Layouts.Base_ext, self.cellphoneidkey := [], self.did := (unsigned6) left.did,  self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(left.src), self := left, self := []));
	
//Project GE file into base layout
	pBocaGE	:= PROJECT(Files.Boca_GE_in,
											TRANSFORM(PRTE2_PhonesPlus.Layouts.Base_ext, self.cellphoneidkey := [], self.did := (unsigned6) left.l_did,  self.src_all := phonesplus_v2.translation_codes.source_bitmap_code(left.src), self := left, self := []));

//uppercase and remove spaces from in files
	PRTE2.CleanFields(AlphaBase, CleanAlpha);
	PRTE2.CleanFields(PhonesHist_base, CleanHist);
	PRTE2.CleanFields(pBocaGE, CleanGEBase);
	
//Split into existing and new records file for name/address cleaning
BocaGE_prev	:= CleanGEBase(trim(lname) <> '');
BocaGE_new	:= CleanGEBase(trim(lname) = '');

//Clean input name	
NID.Mac_CleanFullNames(BocaGE_new, FileClnName, OrigName,  _nameorder := 'L',
											,includeInRepository:=false, normalizeDualNames:=false);
											
	PRTE2_PhonesPlus.Layouts.Base_ext xFrmCleanName(FileClnName L) := TRANSFORM
		SELF.title					:= l.cln_title;
    SELF.fname	      	:= l.cln_fname;      
    SELF.mname	      	:= l.cln_mname;      
    SELF.lname	      	:= l.cln_lname;
    SELF.name_suffix		:= l.cln_suffix;
    SELF.name_score	  	:= '';
		SELF.clean_company	:= IF(SELF.lname = '',L.origname,'');
		SELF := L;
	END;
	
pCleanName	:= PROJECT(FileClnName, xFrmCleanName(LEFT));

//Address Cleaning
 dAddressCleaned := PRTE2.AddressCleaner(pCleanName,
																					['address1'],
																					['address2'], //blank field, not used but passed for attribute purposes
                                          ['OrigCity'],
                                          ['OrigState'],
                                          ['OrigZip'],
                                          ['clean_address'],
                                          ['addr_rawaid']);
																					
	PRTE2_PhonesPlus.Layouts.Base_ext xFrmBase(dAddressCleaned L) := TRANSFORM
		//Clean name
		// clean_name					:= Address.Clean_n_Validate_Name(L.origname, 'L').CleanNameRecord;
		// SELF.title					:= clean_name.title;
    // SELF.fname	      	:= clean_name.fname;      
    // SELF.mname	      	:= clean_name.mname;      
    // SELF.lname	      	:= clean_name.lname;
    // SELF.name_suffix		:= clean_name.name_suffix;
    // SELF.name_score	  	:= clean_name.name_score;
		// SELF.clean_company	:= IF(SELF.lname = '',L.origname,'');
		
		//Map Address
		SELF.state					:= L.clean_address.st;
		SELF.zip5						:= L.clean_address.zip;
		SELF								:= L.clean_address;
		SELF				:= L;
  END;
	
	pGEBase	:= PROJECT(dAddressCleaned, xFrmBase(LEFT)); 
		
//Combine input files and generate DID/BDID. Note - Alpharetta file processed independently in PRTE2_Phonesplus_Ins
	NewBocaBase		:= BocaGE_prev + pGEBase;
 	
	PRTE2_PhonesPlus.Layouts.Base_ext AddLinkID(NewBocaBase L) := TRANSFORM
	  SELF.did  := prte2.fn_AppendFakeID.did(L.fname, L.lname, L.link_ssn, L.link_dob, L.cust_name);
    SELF.bdid := prte2.fn_AppendFakeID.bdid(L.clean_company,	L.prim_range,	L.prim_name, L.v_city_name, L.state, L.zip5, L.cust_name);
		SELF				:= L;
  END;
	
	BocaBase := PROJECT(NewBocaBase, AddLinkID(LEFT)) + CleanHist;

	phonesplus_all := DEDUP(SORT(CleanAlpha + BocaBase,RECORD,LOCAL),RECORD, LOCAL);
	
	PromoteSupers.MAC_SF_BuildProcess(phonesplus_all,Constants.BASE_PREFIX + 'base_all', writefile);

EXPORT proc_build_base := writefile;

