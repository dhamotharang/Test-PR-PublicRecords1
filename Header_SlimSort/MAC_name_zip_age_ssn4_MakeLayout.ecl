export MAC_name_zip_age_ssn4_MakeLayout
(
	src_file_name,
	field_set,
	f_name,
	m_name,
	layout_name
) := MACRO

layout_name := RECORD
	src_file_name.lname;
	STRING first_name := src_file_name.f_name;
	UNSIGNED2 DIDCount := IF(COUNT(GROUP) > 655, 65535, COUNT(GROUP) * 100);
#if('M' IN field_set)
	STRING middle_name := src_file_name.m_name;
#end
#if('Z' IN field_set)
	src_file_name.zip;
#end
#if('A' IN field_set)
	UNSIGNED2 DIDCount2 := 0;
	src_file_name.age;
#end
#if('S' IN field_set)
	src_file_name.ssn4;
#end
END;

ENDMACRO;