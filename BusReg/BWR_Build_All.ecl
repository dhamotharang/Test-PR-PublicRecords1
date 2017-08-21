pversion 		:= '20170802'	;		// modify to current date
FileDate 		:= '20170801'  ;  //vendor raw input folder date 
directory 	:= '/prod_data_build_10/production_data/business_headers/accutrend/out/'+filedate;
moxie_mount:= '/bus_reg_3210/'																										;

/////////////////////////////////////////////////////////////
// -- Quick Documentation
// -- 	1. Put the Build Date in the pversion attribute above
// --		2. Make sure the following attribute contains your email address sandboxed(do not check in!)
// --				_control.MyInfo.EmailAddressNotify
// --			 You will receive build emails to this address
// --		3. Check the following attribute to make sure it is correct:
// --				Busreg._Flags
// --  4. Email List: provided list of people will receive scrubsPlus report on BusReg Vender Data!!
/////////////////////////////////////////////////////////////

#workunit('name', Busreg._Dataset().Name + ' Build ' + pversion);
Busreg.proc_Build_All(pversion, moxie_mount, directory).all;