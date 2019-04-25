#workunit('name','chase bnk4 Attributes');
import risk_indicators, ut, ashirey, scoring_project_Macros, Scoring_Project_PIP,Business_Header;


eyeball := 30;

input_layout := scoring_project_Macros.Global_Output_Layouts.NONFCRA_Chase_BNK4_Global_Layout;

prii_layout := RECORD
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.bus_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
 END;
   	a:= ut.GetDate;
	
fn_LastTwoMonths(string10 date_inp,integer offset) := function
res  := GLOBAL(ut.DateFrom_DaysSince1900(ut.DaysSince1900(date_inp[1..4], date_inp[5..6], date_inp[7..8]) - offset));
return res[1..8];
end;

b:=fn_LastTwoMonths(a,1);
	
b1:='20171225_1';
	
	a1:= '20171226_1';



basefilename := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_'+b1;        // Only Batch
testfilename := '~scoringqa::out::nonfcra::bnk4_xml_chase_bd3605_0_'+a1;

pii_name := scoring_project_pip.Input_Sample_Names.BC10_Scores_Chase_BNK4_infile;

ds_baseline := dataset(basefilename,input_layout, thor);
ds_new := dataset(testfilename,input_layout, thor);
ds_pii := dataset(pii_name, prii_layout, thor);


	clean_ds_baseline := ds_baseline(errorcode='');
	clean_ds_new := ds_new(errorcode='');
	
slim := record
string acctno;
string riskwiseid;
string15 verfirst ;
string20 verlast ;
	string50 veraddr ;
	string30 vercity ;
	string2 verstate ;
	string9 verzip ;
	string10 verhphone ;
	string9 versocs ;
	string20 verdrlc ;
	string8 verdob ;
	string30 vercmpy ;
	string50 vercmpyaddr ;
	string30 vercmpycity ;
	string2 vercmpystate ;
	string9 vercmpyzip ;
	string10 vercmpyphone ;
	string20 verfin ;
string ecovariables;

end;
	
	


slim_base := project(clean_ds_baseline, transform(slim,self := left, self := []));
output(choosen(slim_base, 10));

slim_second := project(clean_ds_new, transform(slim,self := left, self := []));
output(choosen(slim_second, 10));



j4 := join(slim_base, slim_second, left.acctno = right.acctno
					AND LEFT.ecovariables > RIGHT.ecovariables
					and (integer)left.riskwiseid = 0 and (integer)right.riskwiseid <> 0,
					TRANSFORM(slim, SELF := right));

OUTPUT(count(j4), NAMED('riskwiseid_all_count'));
OUTPUT(CHOOSEN(j4, 25), named('riskwiseid_all'));


//need to sandbox Business_Header_SS.Key_BH_BDID_pl
// last line change to '~foreign::' + _control.IPAddress.prod_thor_dali + '::'+'thor_data400::key::business_header:://*Build Version*//::search::bdid.pl');
//need to import _control
results_Cert_Key_BH_BDID_pl := pull(Business_Header_SS.Key_BH_BDID_pl);			//need to sandbox to run
output(choosen(results_Cert_Key_BH_BDID_pl, 25));



Cert_Key_BH_BDID_pl_distr := distribute(results_Cert_Key_BH_BDID_pl, hash64(bdid));

t1_daily := project(j4, transform({integer bdid}, self.bdid:= (integer) left.riskwiseid));

s1_daily := set(t1_daily, (integer)bdid);



results_daily_cert := Cert_Key_BH_BDID_pl_distr(bdid in s1_daily );
output(choosen(results_daily_cert, all));







tbl_did_new_cert := table(results_daily_cert, {mysrc := source; _count := count(group)}, source, local);
cert_table	:= table(tbl_did_new_cert, {mysrc; rec_count := sum(group, _count)}, mysrc);
output(choosen(cert_table, all));


