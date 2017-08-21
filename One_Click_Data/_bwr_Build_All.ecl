pversion 			:= '20100824'									;	// modify to current date
directory 		:= '/prod_data_build_10/production_data/business_headers/one_click_data/'		;
pSprayedFile	:= One_Click_Data.Files().Input.Using	;
pBaseFile			:= One_Click_Data.Files().Base.qa			;	// use qa base in new layout
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				One_Click_Data._Flags
/////////////////////////////////////////////////////////////

#workunit('name', 'One_Click_Data Build ' + pversion);
One_Click_Data.Build_All(
	 pversion
	,directory
	,pSprayedFile		:= pSprayedFile
	,pBaseFile			:= pBaseFile
);