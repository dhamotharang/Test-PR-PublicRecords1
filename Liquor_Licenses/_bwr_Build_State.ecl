import VersionControl, _control;

shared pversion		:= '20070919'	;		// modify to current date
shared pState			:= 'PA'				;
shared pDirectory := '/prod_data_build_10/production_data/business_headers/liquor_licenses/pa/20070926';
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Liquor_Licenses._Flags
// --		4. replace the pState with the state you want to process
// --		5. Also do a replace in this builder window of PA with the state you want to process
/////////////////////////////////////////////////////////////
#workunit('name', Liquor_Licenses._Dataset.name + ' ' + pState + ' Build ' + pversion);

Liquor_Licenses.Build_State(pversion,PA,pState,pDirectory,Build_PA);

sequential(
	 Build_PA.all
);
