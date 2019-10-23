
import ut, header,header_slimsort;

src_cluster := header_slimsort.cluster.cluster_66;
src_cluster_name := '~' + src_cluster + '::';

	c1 := fileservices.clearsuperfile('~thor_Data400::base::hss_name_address');
	c2 := fileservices.clearsuperfile('~thor_Data400::base::hss_name_ssn');
	c3 := fileservices.clearsuperfile('~thor_Data400::base::HSS_Name_Dayob');
	c4 := fileservices.clearsuperfile('~thor_Data400::base::HSS_Name_phone');
	c5 := fileservices.clearsuperfile('~thor_Data400::base::HSS_Name_Zip_Age_Ssn4');
	c6 := fileservices.clearsuperfile('~thor_Data400::base::HSS_household');
	c7 := fileservices.clearsuperfile('~thor_Data400::base::HSS_name_source');
	
	a1 := fileservices.addsuperfile('~thor_Data400::base::hss_name_address',src_cluster_name + 'BASE::HSS_Name_Address' );
	a2 := fileservices.addsuperfile('~thor_Data400::base::hss_name_ssn',src_cluster_name + 'BASE::HSS_Name_SSN');
	a3 := fileservices.addsuperfile('~thor_Data400::base::HSS_Name_Dayob',src_cluster_name + 'BASE::HSS_Name_Dayob');
	a4 := fileservices.addsuperfile('~thor_Data400::base::HSS_Name_phone',src_cluster_name + 'BASE::HSS_Name_phone');
	a5 := fileservices.addsuperfile('~thor_Data400::base::HSS_Name_Zip_Age_Ssn4',src_cluster_name + 'BASE::HSS_Name_Zip_Age_Ssn4');
	a6 := fileservices.addsuperfile('~thor_Data400::base::HSS_household',src_cluster_name + 'BASE::HSS_household');
	a7 := fileservices.addsuperfile('~thor_Data400::base::HSS_name_source',src_cluster_name + 'BASE::HSS_name_source');

export add_Superfile_for_keybuild := sequential(parallel(c1,c2,c3,c4,c5,c6,c7),
                                                parallel(a1,a2,a3,a4,a5,a6,a7));