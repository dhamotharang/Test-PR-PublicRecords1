//--------Macro to calculate the bucketed date field with the distance between the max date per did and the record date
import ut, header;
export Mac_Bucket_Dates    (infile, 
														date_field,            //The main date field to bucket
														date_penalty = 0,
														alternate_date_field,  //Alternate date field to use if there the main field is blank
														alternate_date_penalty = 0,
														months_bucket,            //Bucket size. i.e.  if the bucket represents quarters the field is set to 3 
														out_field,
														outfile) := macro
#uniquename(slim_layout)
%slim_layout% := record
	unsigned did;
	unsigned usable_date_field;
end;

//--------slim file to get the max date and did
#uniquename(slim_file)
%slim_file% := project(infile, transform(%slim_layout%, 
																					self.usable_date_field := if(left.date_field > 0 , 
																																	     left.date_field - date_penalty, 
																																			 left.alternate_date_field - alternate_date_penalty),
																					self := left));


#uniquename(get_max_date)
%get_max_date% := dedup(sort(distribute(%slim_file%, hash(did)), did, -usable_date_field, local), did, local);


#uniquename(out_layout)
%out_layout% := record
	recordof(infile);
	unsigned out_field;
end;

//--------calculate bucket date
outfile := join(distribute(infile, hash(did)),
                                %get_max_date%,
																left.did = right.did,
																transform(%out_layout%,
																   
																					self.out_field := if (left.date_field > 0,
																					  											(header.ConvertYYYYMMToNumberOfMonths(right.usable_date_field) - header.ConvertYYYYMMToNumberOfMonths(left.date_field)) / months_bucket,
																																	(header.ConvertYYYYMMToNumberOfMonths(right.usable_date_field) - header.ConvertYYYYMMToNumberOfMonths(left.alternate_date_field)) / months_bucket),
																		
																					self := left),
																left outer,
																local);
endmacro;