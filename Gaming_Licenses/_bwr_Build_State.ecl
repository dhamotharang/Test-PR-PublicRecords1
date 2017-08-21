import VersionControl, _control;

shared pversion		:= '20080502'	;		// modify to current date
shared pState			:= 'NJ'				;
shared pDirectory := '/prod_data_build_10/production_data/business_headers/gaming_licenses/nj/20080415';
/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Gaming_Licenses._Flags
// --		4. replace the pState with the state you want to process
// --		5. Also do a replace in this builder window of NJ with the state you want to process
/////////////////////////////////////////////////////////////
#workunit('name', Gaming_Licenses._Dataset.name + ' ' + pState + ' Build ' + pversion);

Gaming_Licenses.Build_State(pversion,NJ,pState,pDirectory,Build_NJ);

sequential(
	 Build_NJ.all
);
