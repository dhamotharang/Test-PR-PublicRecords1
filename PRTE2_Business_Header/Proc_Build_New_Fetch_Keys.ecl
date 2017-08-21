import prte_csv, tools, Business_Header;

export Proc_Build_New_Fetch_Keys(

	 string																													pversion										
	,dataset(Business_Header.Layout_Business_Header_Base_Plus_Orig)	pBH_base	= PRTE2_Business_Header.File_Business_Header_Base_For_Keybuild
	,dataset(business_header.Layout_SIC_Code)												pbdidsic	= BDID_Sic()

) :=
function
	
	//*** Business Header Fetch keys
	//change name of keys before building so don't interfere with production keys
	dbdidpl := pBH_base;
	dBHproj := project(dbdidpl	,transform(business_header.Layout_Business_Header_Base_Plus_Orig, self.rcid := counter; self := left; self := []; )) : global;
	dfetch 	:= PRTE2_Business_Header.File_business_header_fetch(dBHproj, PRTE2_business_header.persistnames().FileBusinessHeaderFetch + '.prcttest');

	//*** Building the Business Header Fetch keys
	build_keys 	:= business_header.proc_build_new_fetch_keys(pversion,dfetch,,,'prte',false).all;
	
	//*** Creating the sic code keys
	lroxiekeys	:= business_header.RoxieKeys(pversion,,false,,'prte',,pbdidsic,dBHproj).Sics;
	
	Build_Key1		:= tools.macf_WriteIndex('lroxiekeys.key_SicZip.New'			,true);
	Build_Key2		:= tools.macf_WriteIndex('lroxiekeys.key_SicCode.New'			,true);
	Build_Key3		:= tools.macf_WriteIndex('lroxiekeys.key_SicDescrip.New'	,true);
		                                                                          
	build_sic_keys := 
		parallel(
			 Build_Key1
			,Build_Key2
			,Build_Key3
		);
		
	return sequential( build_keys										
										,build_sic_keys
									 );

end;