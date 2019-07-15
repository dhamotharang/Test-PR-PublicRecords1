import Watchdog,ut;
EXPORT misty_phillipmorris := module

shared legal :=18;
shared adult :=21;
shared adultlimit :=34;


shared YYYYMMDDToDays(string pInput) :=  (((integer)(pInput[1..4])*365) + ((integer)(pInput[5..6])*30)+ ((integer)(pInput[7..8])));

shared today := YYYYMMDDToDays(ut.GetDate);

shared dAdults:=watchdog.File_Best(adl_ind='CORE',fname<>'',lname<>'',dob>0,ssn<>'',zip4<>'',(integer)((today - YYYYMMDDToDays((string)dob)) / 365) between adult and adultlimit);
shared dLegal:=watchdog.File_Best(adl_ind='CORE',fname<>'',lname<>'',dob>0,ssn<>'',zip4<>'',(integer)((today - YYYYMMDDToDays((string)dob)) / 365) between legal and adult-1);

export o_adult:=output(choosen(sample(dAdults,10,10),2000),{did
									,age:=(integer)((today - YYYYMMDDToDays((string)dob)) / 365)
									,fname,mname,lname,dob,ssn
									,Address_1:=stringlib.stringcleanspaces(trim(prim_range)
																						+' '+trim(predir)
																						+' '+trim(prim_name)
																						+' '+trim(suffix)
																						+' '+trim(postdir))
									,Address_2			:=	stringlib.stringcleanspaces(trim(unit_desig)
																						+' '+trim(sec_range))
																						,city_name,st,zip},'~thor400_data::PhilipMoris::ageAudit_adults.csv',csv(heading(single)),overwrite,compressed);
																						// ,city_name,st,zip},'~thor400_data::PhilipMoris::ageAudit_adults.csv',overwrite,compressed);
																						// ,city_name,st,zip});
export o_legal:=output(choosen(sample(dlegal,10,10),1000),{did
									,age:=(integer)((today - YYYYMMDDToDays((string)dob)) / 365)
									,fname,mname,lname,dob,ssn
									,Address_1:=stringlib.stringcleanspaces(trim(prim_range)
																						+' '+trim(predir)
																						+' '+trim(prim_name)
																						+' '+trim(suffix)
																						+' '+trim(postdir))
									,Address_2			:=	stringlib.stringcleanspaces(trim(unit_desig)
																						+' '+trim(sec_range))
																						,city_name,st,zip},'~thor400_data::PhilipMoris::ageAudit_legalnotadults.csv',csv(heading(single)),overwrite,compressed);
																						// ,city_name,st,zip},'~thor400_data::PhilipMoris::ageAudit_legalnotadults.csv',overwrite,compressed);
																						// ,city_name,st,zip});
																						
																						
end;
