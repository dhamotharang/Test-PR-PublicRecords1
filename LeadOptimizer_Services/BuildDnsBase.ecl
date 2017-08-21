IMPORT IDLExternalLinking, IDL_Header, _control, RoxieKeyBuild, Insurance_iesp, ut, lib_date, address;
//
// Process the sprayed lead distribution list exported file and create a base file
//
EXPORT BuildDnsBase(string build_date) := FUNCTION

bFileName := buildConstants().lead_dns_file;
SprayedDNSFileC  := DATASET(BuildConstants(bFileName).spray_subfile, BuildLayouts.Layout_DNS_Rec_Spray,
                            CSV(SEPARATOR(BuildConstants().MBSI_FieldSeparator),TERMINATOR(BuildConstants().RecordTerminator), MAXLENGTH(1000100),NOTRIM));

cleanstring(STRING s) := stringlib.stringfindreplace(stringlib.stringfindreplace(s,'\\N','  '),'\\\\','\\');

BuildLayouts.Layout_dns_Rec tSprayedDNSFile(BuildLayouts.Layout_DNS_Rec_Spray L) := transform
																Self.IDL								:= 0;
																Self.Customer_Number		:= cleanstring(L.Customer_Number);
																Self.First_Name					:= cleanstring(L.First_name);
																Self.Middle_Name				:= cleanstring(L.middle_name);
																self.Last_Name					:= cleanstring(L.last_name);
																self.Suffix							:= cleanstring(L.suffix);
																self.AddressLine				:= cleanstring(L.AddressLine);
																self.City								:= cleanstring(L.city);
																self.State							:= cleanstring(L.state);
																self.Zip								:= cleanstring(L.zip);
																self.Zip4								:= cleanstring(L.zip4);
																self.Date_of_birth			:= cleanstring(L.date_of_birth);
																self.SSN								:= cleanstring(L.ssn);
																self.Driver_License_Number:= cleanstring(L.Driver_license_number);
																self.Driver_License_State:= cleanstring(L.driver_license_state);
																self.Phone							:= cleanstring(L.phone);
// Lets clean the address here..and assign to cleaned fields..... assuming only US addresses																
														    Address1 := Address.Addr1FromComponents('', '', cleanstring(L.AddressLine), '', '', '', '');
														    Address2 := Address.Addr2FromComponents(cleanstring(L.city), cleanstring(L.state), cleanstring(L.zip));
																CleanAddress := Address.cleanaddress182(Address1, Address2);
																Cleaned := transfer(CleanAddress, address.Layout_Clean182);
																self.CleanedAddressLine := stringlib.StringCleanSpaces(Cleaned.prim_range + ' ' + Cleaned.PREDIR + ' ' + Cleaned.PRIM_NAME + ' ' + 
																																													   Cleaned.ADDR_SUFFIX + ' ' + Cleaned.postdir + ' ' + Cleaned.sec_range);
                                self.CleanedCity        := Cleaned.v_city_name;
																self.CleanedState       := Cleaned.st;
																self.CleanedZip         := Cleaned.Zip;
																self.CleanedZip4        := Cleaned.Zip4;
																self                    := [];

End;
//Convert the strings into number etc. over here..... 
SprayedDNSFile := Project(SprayedDNSFileC, tSprayedDNSFile(left));

//Lets try to get an IDL here .... 
IDLExternalLinking.mac_xlinking_on_thor(SprayedDNSFile, IDL, Suffix, First_Name, Middle_Name, Last_Name, , ,
																				AddressLine, , , CITY, State, ZIP, SSN, Date_of_birth, Driver_License_State, Driver_License_Number, , , 
																				Sprayed_IDLed_From_Macro);
sprayed_IDLedProd_PERSIST      := Sprayed_IDLed_From_Macro:PERSIST('~THOR::PERSIST::LEAD::DNS_IDL','thor400_64');
sprayed_IDLedDEV_PERSIST       := Sprayed_IDLed_From_Macro:PERSIST('~THOR::PERSIST::LEAD::DNS_IDL','thor400_72');
daily_DNS_IDLed                := IF (_control.ThisEnvironment.Name = 'Prod', sprayed_IDLedProd_PERSIST, sprayed_IDLedDEV_PERSIST);	

//We are supposed to get a full extract everytime so we dont need to do any processing with the existing file just distribute by customernum and build the file
output(SprayedDNSFile);
NewDNSFile_D := distribute(daily_DNS_IDLed,hash64(Customer_Number));

// Deltabase_Report := Files.DS_BASE_DELTA_REPORT;
// D_Deltabase_Report := sorted(DISTRIBUTED(Deltabase_Report,HASH64(Reference_Num)),Reference_Num);
// Sorted_Daily_DeltaReport := SORT(Daily_DeltaReport,Reference_Num,local);
// D_DeltaReport := MERGE(D_Deltabase_Report, Sorted_Daily_DeltaReport,
                       // SORTED(Reference_Num),
											 // DEDUP,
											 // LOCAL);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(NewDNSFile_D, Files.BASE_PREFIX_NAME, Files.SUFFIX_NAME_DNS_FILE, build_date, DNSFileBase, 3, false, true);

RETURN DNSFileBase;
END;
