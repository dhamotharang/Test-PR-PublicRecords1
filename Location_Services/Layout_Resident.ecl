export Layout_Resident := record
	string100	Full_Name;
	unsigned6	did;
	dataset(layout_person_ssn)		HRI_SSN			{ maxcount(consts.max_hri_ssn) };
	dataset(layout_person_phone)	Phone_Info	{ maxcount(consts.max_hri_phone) };
	unsigned3	dt_last_seen;
end;
