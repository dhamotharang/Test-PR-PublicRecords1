/*
output(choosen(misc.eval_ssns,1000));
output(choosen(misc.eval_ssns(extract_ssn<>ssn and ssn<>''),1000));
output(choosen(misc.eval_ssns(extract_ssn<>ssn and extract_ssn<>''),1000));
output(choosen(misc.eval_ssns(extract_ssn=ssn),1000));
*/

output(choosen(misc.eval_ssns(extract_ssn<>ssn and ssn<>''),100));
output(count(misc.eval_ssns(extract_ssn<>ssn and ssn<>'')));
//
output(choosen(misc.eval_ssns(extract_ssn=ssn),100));
output(count(misc.eval_ssns(extract_ssn=ssn)));
