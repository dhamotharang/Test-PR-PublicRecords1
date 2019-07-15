import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'ICDKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

Diag:=RECORD
  string7 diag_cd;
  string60 desc_short;
  string8 effective_dt;
  string8 termination_dt;
  unsigned8 __internal_fpos__;
 END;

dkeybuild :=    DATASET([ ],Diag);

diagKey := INDEX(dkeybuild,{diag_cd},{dkeybuild},prte2.constants.prefix + 'key::std_icd_diag_codes::' + pversion + '::diag_code'); 


//---------- making DOPS optional -------------------------------
	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILD(diagKey);

PerformUpdateOrNot;

output ('successful');

