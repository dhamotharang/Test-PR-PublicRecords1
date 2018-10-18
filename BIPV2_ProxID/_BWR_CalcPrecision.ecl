import wk_ut,tools,std;
dsetupprecision := BIPV2_ProxID.files().precision.qa;
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 4. Execute below.  Passing in empty set because it will output the code with the set that should be passed in.
// --    Once all iterations for the build are finished, run this on the above dataset to construct the set to pass into the second call to this macro.
////////////////////////////////////////////////////////////////////////////////////////////////////////
wk_ut.mac_SALT_Precision(dsetupprecision,[],false);
/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
// -- 5. Copy the output of the above call, and paste it below and run it.  It will output the precision worksheet and the precision itself.
////////////////////////////////////////////////////////////////////////////////////////////////////////
setiters := ['20130521','35','20130521','34','20130521','33','20130521','32','20130521','31','20130521','30','20130330','29','20130330','27','20130330','26','20130330','25','20130212','24','20130212','23','20130212','22','20130212','21','20130212','20','20130212','19','20130212','18','20130212','17','20130212','16','20130212','15','20130212','14','20130212','13','20130212','12','20130212','11','20130212','10','20130212','9','20130212','8','20130212','7','20130212','6','20130212','5','20130212','4','20130212','3','20130212','2','20130212','1'];
wk_ut.mac_SALT_Precision(dsetupprecision,setiters,false);
*/
