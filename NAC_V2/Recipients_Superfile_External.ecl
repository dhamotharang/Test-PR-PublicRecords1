    



IMPORT  NAC_V2, mdr, PromoteSupers, Header, STD;


STD.File.CreateSuperFile('~nac::external_email_distribution');
STD.File.CreateSuperFile('~nac::external_email_distribution_father');
STD.File.CreateSuperFile('~nac::external_email_distribution_grandfather');


 
	 
   ds_create := DATASET
   ( [
		{'AL01', 'Contributory File NCR Report', 'aaron.biggers@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'ann.york@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'ann.york@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'brandon.early@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'johnnie.cox@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'lorenzo.braxter@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'madhu.pusarla@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'robert.allgood@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File NCR Report', 'valerie.davis@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'aaron.biggers@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'ann.york@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'ann.york@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'brandon.early@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'johnnie.cox@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'lorenzo.braxter@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'madhu.pusarla@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'robert.allgood@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'Contributory File Rejected', 'valerie.davis@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'aaron.biggers@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'ann.york@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'ann.york@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'brandon.early@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'johnnie.cox@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'lorenzo.braxter@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'madhu.pusarla@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'robert.allgood@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'AL01', 'File Error', 'valerie.davis@dhr.alabama.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File NCR Report', 'barbara_roglieri@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File NCR Report', 'brenda_gilbert@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File NCR Report', 'lynn_rossow@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File NCR Report', 'vijay_muniswami@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File Rejected', 'barbara_roglieri@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File Rejected', 'brenda_gilbert@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File Rejected', 'lynn_rossow@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'Contributory File Rejected', 'vijay_muniswami@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'File Error', 'barbara_roglieri@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'File Error', 'brenda_gilbert@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'File Error', 'lynn_rossow@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'FL99', 'File Error', 'vijay_muniswami@dcf.state.fl.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File NCR Report', 'harrison@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File NCR Report', 'ssfrederick@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File NCR Report', 'wobradley@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File NCR Report', 'yadavenp@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File Rejected', 'harrison@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File Rejected', 'ssfrederick@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File Rejected', 'wobradley@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'Contributory File Rejected', 'yadavenp@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'File Error', 'harrison@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'File Error', 'ssfrederick@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'File Error', 'wobradley@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'GA01', 'File Error', 'yadavenp@dhr.state.ga.us', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'LA01', 'Contributory File NCR Report', 'michael.a.morris@la.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'LA01', 'Contributory File NCR Report', 'michael.dronet@la.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'LA01', 'Contributory File Rejected', 'michael.a.morris@la.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'LA01', 'Contributory File Rejected', 'michael.dronet@la.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'LA01', 'File Error', 'michael.a.morris@la.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'LA01', 'File Error', 'michael.dronet@la.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'MS01', 'Contributory File NCR Report', 'joel.savell@mdhs.ms.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'MS01', 'Contributory File NCR Report', 'karen.powell@mdhs.ms.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'MS01', 'Contributory File Rejected', 'joel.savell@mdhs.ms.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'MS01', 'Contributory File Rejected', 'karen.powell@mdhs.ms.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'MS01', 'File Error', 'joel.savell@mdhs.ms.gov', 'N', ((STRING8)Std.Date.Today())[1..8]},
		{'MS01', 'File Error', 'karen.powell@mdhs.ms.gov', 'N', ((STRING8)Std.Date.Today())[1..8]}	 
   ] , Layouts.rlExternalEmail);  


 
   
PromoteSupers.MAC_SF_BuildProcess(ds_create,'~nac::external_email_distribution',tntset,,,true, pVersion := Header.version_build);
 
EXPORT Recipients_Superfile_External := tntset;    







 