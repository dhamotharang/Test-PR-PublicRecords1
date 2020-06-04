import  STD,PRTE2, _control, PRTE;  

skipDOPS:=false;
string emailTo:='';
dops_name := 'SNAKeys';

pversion:=(string8)STD.Date.CurrentDate(True);

Person_Cluster_Att_Build :=   DATASET([ ],Layouts.Person_Cluster_Att);
Person_Cluster_Build :=   DATASET([ ],Layouts.Person_Cluster);
Cluster_Stats_Build :=   DATASET([ ],Layouts.Cluster_Stats);
Tran_Stats_Build :=   DATASET([ ],Layouts.Tran_Stats);

Person_Cluster_Att_Key := INDEX(Person_Cluster_Att_Build,
{cluster_id},{Person_Cluster_Att_Build},
prte2.constants.prefix + 'key::sna::' + pversion + '::person_cluster_attributes'); 

Person_Cluster_Key := INDEX(Person_Cluster_Build,
{cluster_id},{Person_Cluster_Build},
prte2.constants.prefix + 'key::sna::' + pversion + '::person_cluster'); 

Cluster_Stats_Key := INDEX(Cluster_Stats_Build,
{cluster_id},{Cluster_Stats_Build},
prte2.constants.prefix + 'key::sna::' + pversion + '::property_ownership_cluster_stats'); 
	
Tran_Stats_Key := INDEX(Tran_Stats_Build,
{ln_fares_id},{Tran_Stats_Build},
prte2.constants.prefix + 'key::sna::' + pversion + '::property_transaction_stats'); 
		
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops          :=  PRTE.UpdateVersion(dops_name, pversion, notifyEmail, l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

BUILDIndex(Person_Cluster_Att_key);
BUILDIndex(Person_Cluster_key);
BUILDIndex(Cluster_Stats_key);
BUILDIndex(Tran_Stats_key);

PerformUpdateOrNot;

output ('successful');


