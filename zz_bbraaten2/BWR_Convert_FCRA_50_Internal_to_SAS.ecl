import RiskProcessing;

eyeball := 25;
testfilename := '~scoringqa::out::fcra::bocashell_50_historydate_999999_cert_20170612_1';

Layout3 := zz_bbraaten2.Boca_41_Non_Cert_lay_new;   //NonFCRA



f := dataset(testfilename, Layout3, thor);

Output(f);

clean_ds_baseline_full := project(f, transform(RiskProcessing.Layouts.Layout_Internal_Shell_nodatasets,self := left, self := []));

isFCRA := true;

DataRestriction :='0000000000000'; 

edina := Risk_Indicators.ToEdina_v50(PROJECT(clean_ds_baseline_full,RiskProcessing.Layouts.Layout_Internal_Shell_nodatasets), isFCRA, DataRestriction);



output(choosen(edina,eyeball), named('FCRA_edina'));


boca_sas := zz_bbraaten2.Internal_edina_sas_Boca_50_FCRA(edina, isFCRA);

outfile_name := 'bbraaten::BocaShell_50_sas_out_csv_20170612';
outfile_name2 := 'bbraaten::BocaShell_50_sas_out_thor_20170612';


output(boca_sas,, outfile_name2, thor, overwrite);
// output(boca_sas,, outfile_name,CSV, OVERWRITE);
output(boca_sas,, outfile_name,csv(heading(single), quote('"')), overwrite);