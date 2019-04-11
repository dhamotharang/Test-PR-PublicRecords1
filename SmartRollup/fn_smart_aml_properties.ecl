
/*This function will add additional property information, length of ownership and owner occupied needed
// by the AML person reports. In addition the property records will be deduped based on logic created
// from risk_indicators boca shell. The logic for deduping is as follows
				1) Each prop record will be assinged a unique id based on street name and number which based
							on minnestoa teams research it is unique enough witin an indivuals property records.
				2) Sort on uniqueid, record type and source.
				3) Dedup on uniqueid and record type, with fares source (a) taking precedence over fidelity (b).
*/
import iesp, PersonReports, ut;
EXPORT fn_smart_aml_properties(dataset(iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord) inProps,
																PersonReports.IParam._smartlinxreport inParam) := FUNCTION
	
	prop_layout := RECORD
		STRING8 unique_prop_id;
		iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord;
	END;
			
	// "Owner occupied" means the Owner's mailing address is the same as the Property's street address.
	STRING1 isOwnerOccupied(iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord l) :=	FUNCTION
		
			// Combine and remove any extranneous characters to create address string
			clean_addr_string(iesp.share.t_Address inAddr) := FUNCTION
					addr_string := 
						StringLib.StringFilter(
								StringLib.StringToUpperCase(TRIM(inAddr.StreetNumber) + TRIM(inAddr.StreetName)
																					+ TRIM(inAddr.City) + TRIM(inAddr.State)),
								'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890');
					RETURN(addr_string);
			END;
			
			owner_addr_str := clean_addr_string(l.OwnerAddress);
			prop_addr_str := clean_addr_string(l.PropertyAddress);
		
			RETURN IF(owner_addr_str = prop_addr_str,'Y','N');			
	END;
	
	calcAge(iesp.share.t_Date inDate):= FUNCTION
			saleDate := INTFORMAT(inDate.Year,4,1) + INTFORMAT(inDate.Month,2,1) + INTFORMAT(inDate.Day,2,1);
			age := ut.GetAgeI((INTEGER)saleDate);
			return(age);
	END;
	
	STRING8 unique_property_id(STRING prim_range, STRING prim_name) := FUNCTION
			uid := StringLib.StringFilter(
								StringLib.StringToUpperCase(TRIM(prim_range) + TRIM(prim_name)),
					   'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'	);
			return(uid);			 
			
	END;
			
  prop_layout xfm_addAddnlInfo(iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord l) := TRANSFORM
			SELF.unique_prop_id := unique_property_id(l.PropertyAddress.StreetNumber,l.PropertyAddress.StreetName);
			SELF.OwnerOccupiedIndicator := isOwnerOccupied(l);
			saleDate := INTFORMAT(l.SaleDate.Year,4,1) + INTFORMAT(l.SaleDate.Month,2,1) + INTFORMAT(l.SaleDate.Day,2,1);
			SELF.LengthOfOwnership := (STRING) ut.Age((INTEGER)saleDate);
			SELF := l;
			self := [];
	END;
	
	add_props := PROJECT(inProps,xfm_addAddnlInfo(LEFT));
	
	// Sort and dedup on unique_id and data type (assessor, deed) and keep source a over b when deduping
	dedup_props := DEDUP(SORT(add_props,unique_prop_id,RecordType,DataSource),unique_prop_id,RecordType);
	
	// Drop Unique id and resort for output order
	outRecs := PROJECT(
									SORT(dedup_props,currentprior,propertyAddress.state),
							TRANSFORM(iesp.smartlinxreport.t_SLRPropertyAssessmentDeedsRecord, SELF := LEFT));
	
	RETURN(outRecs);
END;
