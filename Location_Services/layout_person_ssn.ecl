export layout_person_ssn := record
	layout_ssn_info;
	boolean	recently_issued;
	boolean	issued_prior_to_DOB;
	boolean	deceased;
	unsigned3	last_reported;
end;