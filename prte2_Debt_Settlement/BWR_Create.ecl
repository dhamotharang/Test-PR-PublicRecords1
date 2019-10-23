
import STD, PRTE2, _control, PRTE; 

skipDOPS:=false;
string emailTo:='';
dops_name := 'Debt_SettlementKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

payloadbuild :=      DATASET([ ],layouts.payload_layout);
phoneb2build :=      DATASET([ ],layouts.phoneb2_layout);
addressb2build :=    DATASET([ ],layouts.addressb2_layout);

payloadkey := INDEX(payloadbuild,
{fakeid},{payloadbuild},
prte2.constants.prefix + 'key::debt_settlement::' + pversion + '::autokey::payload'); 

phoneb2key := INDEX(phoneb2build,
{p7,p3,cname_indic,cname_sec,st,bdid},{phoneb2build},
prte2.constants.prefix + 'key::debt_settlement::' + pversion + '::autokey::phoneb2');

addressb2key := INDEX(addressb2build,
{prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},{addressb2build},
prte2.constants.prefix + 'key::debt_settlement::' + pversion + '::autokey::addressb2'); 


	notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
	updatedops					:=	PRTE.UpdateVersion(dops_name, pversion, notifyEmail,'B','N','N');

	PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);


BUILD(payloadKey);
BUILD(phoneb2key);
BUILD(addressb2key);


PerformUpdateOrNot;

output ('successful');