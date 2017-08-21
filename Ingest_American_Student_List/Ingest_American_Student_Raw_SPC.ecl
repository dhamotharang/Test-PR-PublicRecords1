MODULE:Ingest_American_Student_List
FILENAME:American_Student_List_Raw

FIELD:name:TYPE(STRING):0,0
FIELD:first_name:TYPE(STRING):0,0
FIELD:last_name:TYPE(STRING):0,0
FIELD:address_1:TYPE(STRING):0,0
FIELD:address_2:TYPE(STRING):0,0
FIELD:city:TYPE(STRING):0,0
FIELD:state:TYPE(STRING):0,0
FIELD:z5:TYPE(STRING):0,0
FIELD:zip_4:TYPE(STRING):0,0
FIELD:crrt_code:TYPE(STRING):0,0
FIELD:delivery_point_barcode:TYPE(STRING):0,0
FIELD:zip4_check_digit:TYPE(STRING):0,0
FIELD:address_type:TYPE(STRING):0,0
FIELD:county_number:TYPE(STRING):0,0
FIELD:county_name:TYPE(STRING):0,0
FIELD:gender:TYPE(STRING):0,0
FIELD:age:TYPE(STRING):0,0
FIELD:birth_date:TYPE(STRING):0,0
FIELD:telephone:TYPE(STRING):0,0
FIELD:class:TYPE(STRING):0,0
FIELD:college_class:TYPE(STRING):0,0
FIELD:college_name:TYPE(STRING):0,0
FIELD:college_major:TYPE(STRING):0,0
FIELD:college_code:TYPE(STRING):0,0
FIELD:college_type:TYPE(STRING):0,0
FIELD:head_of_household_first_name:TYPE(STRING):0,0
FIELD:head_of_household_gender:TYPE(STRING):0,0
FIELD:income_level:TYPE(STRING):0,0
FIELD:file_type:TYPE(STRING):0,0


SOURCERIDFIELD:name:CONSISTENT(address_1,address_2,city,state,z5)
INGESTFILE:NEWFILE:NAMED(American_student_list.File_American_Student_in)
