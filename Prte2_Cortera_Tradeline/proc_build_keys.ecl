import PRTE, _control, STD,prte2,tools,PRTE2_Common,dops,Orbit3;

EXPORT proc_build_keys(string filedate1, boolean skipDOPS=FALSE, string emailTo='') := function

is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS := is_running_in_prod AND NOT skipDOPS;

nullfile1 := dataset([], layouts.tradeline_linkids);

nullfile2 := dataset([], {unsigned8 record_sid, unsigned4 dt_effective_first, unsigned4 dt_effective_last });

outKey := INDEX(nullfile1,
{  ultid;
   orgid;
   seleid;
   proxid;
   powid;
   empid;
   dotid
	},{nullfile1},
  '~prte::key::cortera_tradeline::'+ filedate1 + '::linkids');
	
outKey2 := INDEX(nullfile2,
{record_sid},{nullfile2},
  '~prte::key::cortera_tradeline::'+ filedate1 + '::delta_rid');
	
	key_out:= BUILDindex(outkey);
	key_out2:= BUILDindex(outkey2);
	
		//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion(constants.dops_name,filedate1,notifyEmail,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
		PerformUpdateOrNot 	:= IF(doDOPS,updatedops,NoUpdate);
		//--------------------------------------------------------------------------------------
	 
  key_validation :=  output(dops.ValidatePRCTFileLayout(filedate1, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));	
		
	build_key:=sequential(key_out,key_out2, key_validation,PerformUpdateOrNot,build_orbit(filedate1));
		
	return build_key;
	
	end;
	


