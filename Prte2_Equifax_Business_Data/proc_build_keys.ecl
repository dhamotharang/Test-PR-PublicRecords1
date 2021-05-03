import PRTE, _control, STD,prte2,tools,PRTE2_Common,dops,Orbit3;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function

nullfile := dataset([], layouts.equifax_layout);

outKey := INDEX(nullfile,
{ ultid;
  orgid;
  seleid;
  proxid;
  powid;
  empid;
  dotid;},{nullfile},
	'~prte::key::equifax_business_data::' + filedate + '::linkids');
	
	key_out:= BUILDindex(outkey);
  
  key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));	
		
	build_key:=sequential(key_out,key_validation,build_orbit(filedate));
	
	return build_key;
	
	end;
	