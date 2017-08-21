import prte_csv,tools,business_header_ss;

// -- Business_Header.Key_Business_Contacts_FP
shared laypl	:= PRTE_CSV.Business_Header.rthor_data400__key__business_header__contacts__filepos;
shared dpl		:= PRTE_CSV.Business_Header.dthor_data400__key__business_header__contacts__filepos;

export prct_contacts_keys
(

	 string					pversion										
	,dataset(laypl)	pBC_FP		= dpl

) :=
function
	
	//change name of keys before building so don't interfere with production keys

	dBC_FP 	:= pBC_FP;
	dproj 	:= project(dBC_FP	,transform(Layout_Business_Contact_Plus_orig	,self.__filepos := counter;self := left;self := []; ));

	keyName			:= keynames(pversion,,,'prte').Contacts;
	rkeys				:= roxiekeys(pversion,,,,'prte',dproj).Contacts;

	Build_Key1	:= tools.macf_WriteIndex('rkeys.key_StateLfmname.New'	,true);
	Build_Key2	:= tools.macf_WriteIndex('rkeys.key_Ssn.New'					,true);
	Build_Key3	:= tools.macf_WriteIndex('rkeys.key_Bdid.New'					,true);
	Build_Key4	:= tools.macf_WriteIndex('rkeys.key_Filepos.New'			,true);
	Build_Key5	:= tools.macf_WriteIndex('rkeys.key_Did.New'			    ,true);
	Build_Key6	:= tools.macf_WriteIndex('rkeys.key_StateCityName.New',true);
	Build_Key7	:= tools.macf_WriteIndex('rkeys.key_BdidScore.New'    ,true);
	Build_Key8	:= tools.macf_WriteIndex('rkeys.key_Companytitle.New' ,true);
	
	build_keys :=
		parallel(
			 Build_Key1
			,Build_Key2
			,Build_Key3
			,Build_Key4
			,Build_Key5
			,Build_Key6
			,Build_Key7
			,Build_Key8
		);

	return sequential(
		 build_keys
	);

end;