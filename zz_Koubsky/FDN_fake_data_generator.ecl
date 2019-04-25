// EXPORT FDN_fake_data_generator := 'todo';

import zz_Koubsky;

eyeball := 50;

// output(choosen(zz_Koubsky.FDN_fake_data.true_basefile, eyeball), named('true_basefile'));
output(choosen(zz_Koubsky.FDN_fake_data.fake_basefile, eyeball), named('fake_basefile'));
// output(choosen(zz_Koubsky.FDN_fake_data.appended_basefile, eyeball), named('appended_basefile'));
output(choosen(zz_Koubsky.FDN_fake_data.fake_MbsGcIdExclusion, eyeball), named('fake_MbsGcIdExclusion'));
output(choosen(zz_Koubsky.FDN_fake_data.fake_MbsIndTypeExclusion, eyeball), named('fake_MbsIndTypeExclusion'));
output(choosen(zz_Koubsky.FDN_fake_data.fake_MbsProductInclude, eyeball), named('fake_MbsProductInclude'));