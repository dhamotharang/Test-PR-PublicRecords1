//Project input to inter  and classify based on LN_search_name_type of M,G or S 
import ut;

EXPORT dataset(MemberPoint.Layouts.BatchInter)  makeClassifiedBatchInter(dataset(MemberPoint.Layouts.BatchIn) BatchIn ) := function 


// // M might become 'D' in the future There should be no blanks

					MemberPoint.Layouts.BatchInter	xform(MemberPoint.Layouts.BatchIn L ) := transform
								age := ut.GetAgeI((integer)L.dob);
								isMinor := (L.dob <> '') and (age < MemberPoint.Constants.AdultAgeStart); 
								LN_search_name_type := map( Not isMinor => MemberPoint.Constants.LNSearchNameType.Adult,
																						isMinor and L.guardian_name_first <> '' => MemberPoint.Constants.LNSearchNameType.Guardian,
																						isMinor and L.guardian_name_first = '' => MemberPoint.Constants.LNSearchNameType.Minor, 
																						MemberPoint.Constants.LNSearchNameType.None);
								self.LN_search_name_type :=	LN_search_name_type;															
								self.LN_search_name := '';
								self := l;
								self := [];
						end;
						
					ClassifiedInter := project(BatchIn,xform(left));
					
return(ClassifiedInter);
end;