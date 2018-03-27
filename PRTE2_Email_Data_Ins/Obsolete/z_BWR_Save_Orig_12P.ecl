IMPORT ut, _control;

fp := ut.foreign_prod;
dali := _control.IPAddress.prod_thor_dali;
FNto := 'prte::ct::base::email_data_Alpha12_SAVE';
FNfrom := 'prte::ct::base::email_data_w20130919-151650';

// on prod it is sitting on a 400 node so we need to copy it to another 400 node.
// if you run the script on thor400_dev then you can use these two lines.
// ThorName := ThorLib.Cluster();
// Act1 := fileservices.copy('~'+FNfrom,ThorName,'~'+FNto,dali,,,,true,true)

// otherwise you have to use this version if you run it on another cluster
dest := 'thor400_dev';
Act1 := fileservices.copy('~'+FNfrom,dest,'~'+FNto,dali,,,,true,true)
SEQUENTIAL(Act1);