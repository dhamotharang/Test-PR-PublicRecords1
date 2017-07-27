export MAC_Header_Result_Rank(fname_field,mname_field,lname_field,
                              ssn_field,dob_field,did_field,
                              predir_field,prange_field,pname_field,suffix_field,postdir_field,sec_range_field,
                              city_field,county_field,state_field,zip_field,
                              phone_field,filter,company_name='',hasComapnyName=false) := MACRO
import ut,doxie;
rform := record
  unsigned2 penalt;
  fetched;
  end;
  
rform into(fetched le) :=  transform
self.penalt := doxie.FN_Tra_Penalty(le.fname_field,le.mname_field,le.lname_field,
                              le.ssn_field,(string)le.dob_field,(string)le.did_field,
                              le.predir_field,le.prange_field,le.pname_field,le.suffix_field,le.postdir_field,le.sec_range_field,
                              le.city_field,le.county_field,le.state_field,le.zip_field,
                              le.phone_field)
						+
#if(hasComapnyName)			
			IF(le.company_name<>'',ut.StringSimilar(le.company_name,comp_name_value),0);
#else
			0;
#end
self.did_field := if ( filter and self.penalt >= score_threshold_value, skip, le.did_field );
self := le;
end;						

      
outf1 := limit(project(fetched, into(left)),20000,FAIL(11, doxie.ErrorCodes(11)));


  endmacro;