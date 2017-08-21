import Health_Provider_Services,Health_Facility_Services,BIPV2_Company_Names, HealthCareFacility;

cutoff:='20041231';

rawKey:=Ingenix_NatlProf.Sanctioned_providers_Bdid;

//We do not want to include any Federal Records
rawKeyFiler:=rawKey(stringlib.StringToUpperCase(sanc_brdtype) <> 'FEDERAL BOARDS');
MyProviderTypes := RECORD
  string50 provtype;
	string2  state;
END;
/*There are a handful of other things here we are going to exclude
*/
dsFilterProvTypes := dataset([
																{'ACCOUNT/BOOKKPR/AUDI','*'},
																{'ACCOUNTANT','*'},
																{'ANCILLARY','*'},
																{'BUS DRIVER','*'},
																{'BUSINESS MANAGER','*'},
																{'CLERK/OTHER CLERICAL','*'},
																{'CONSULTANT','*'},
																{'CONSULTING FIRM','*'},
																{'CONTRACTING FIRM','*'},
																{'CONTRACTOR','*'},
																{'OTHER','*'},
																{'PRIVATE CIT/ENTITY','*'},
																{'PRIVATE CITIZEN','*'},
																{'SALES/MARKET/RETAIL','*'},
																{'SALES/MARKETING/RETAILING','*'},
																{'UNEMPLOYED','*'}
																],MyProviderTypes);
//We do not care about these Sanction Types
rawdata:=join(rawKeyFiler,dsFilterProvTypes,left.sanc_provType=right.provtype,transform(recordof(rawKeyFiler), self := left),left only);
rawdataBus := rawdata(sanc_busnme<>'' and sanc_lnme = '');
// rawdataBusDataStateOnlyCurrent := rawdataBus(sanc_sancdte_form>cutoff);//Only Current Business Sanctions
rawdataIndv := join(rawdata,rawdataBus,left.SANC_ID=right.SANC_ID,transform(recordof(rawdata), self := left), left only);
//These denote provider types that Enclarity has coverage and we do not want to include in the Sanction File
/* Possible Future Additions
																{'ADMINISTRATOR','*'},
																{'ADULT HOME','*'},
																{'AGENCY','*'},
																{'ALLIED HEALTH RELATED','*'},
																{'AMBULANCE COMPANY','*'},
																{'AMBULATORY SURGICAL CENTER','*'},
																{'AMBULATORY/PARAMEDIC','*'},
																{'ASSISTIVE CARE SERVICES','*'},
																{'AUDIOLOGY & SPEECH','*'},
																{'BEHAVIORAL HEALTH','*'},
																{'BILLING SERVICE CO','*'},
																{'BIRTH CENTER','*'},
																{'BLOOD SALESMAN','*'},
																{'CEO','*'},
																{'CERT. OCC. THERAPIST ASSISTANT','*'},
																{'CERTIFIED HOME HEALTH ASSISTANT','*'},
																{'CHIEF ENGINEER','*'},
																{'CHIROPRACTIC PRACT','*'},
																{'CHIROPRACTIC PRACTICE','*'},
																{'CLINIC','*'},
																{'COMM MNTL HLTH CNTR','*'},
																{'COMPANY','*'},
																{'COMPTROLLER','*'},
																{'COMPUTER RELATED','*'},
																{'COPES WORKER','*'},
																{'COUNSELING CENTER','*'},
																{'COUNTY HEALTH DEPARTMENT','*'},
																{'DENTAL ASSISTANT','*'},
																{'DENTAL HYGIENIST','*'},
																{'DENTAL PRACTICE','*'},
																{'DIALYSIS CENTER','*'},
																{'DIRECT CARE WORKER','*'},
																{'DME COMPANY','*'},
																{'DME/GENERAL','*'},
																{'DRUG COMPANY/SUPLIER','*'},
																{'DURABLE MEDICAL EQUIP.','*'},
																{'ELECTROLOGIST','*'},
																{'EMERG MED SPECIALIST','*'},
																{'EMERGENCY MEDICAL TECH.','*'},
																{'EMPLOYEE','*'},
																{'EMPLOYEE (FED GOVT)','*'},
																{'EMPLOYEE(NON-GOV'T)','*'},
																{'FACILITY','*'},
																{'FEDERALLY QUALIFIED HEALTH CENTER','*'},
																{'FISCAL AGENT','*'},
																{'FLORIDA SENIOR CARE','*'},
																{'FORMR FED EMPLOYEE','*'},
																{'GOVT EMP (STATE/LOC)','*'},
																{'GRANTEE','*'},
																{'HEALTH CARE AIDE','*'},
																{'HEARING AID COMPANY','*'},
																{'HHS EMPLOYEE-IHS','*'},
																{'HMO','*'},
																{'HOME & COMMUNITY-BASED SERVICES WAIVER','*'},
																{'HOME HEALTH AGENCY','*'},
																{'HOSPICE','*'},
																{'HOSPITAL','*'},
																{'HOUSEKEEPER','*'},
																{'HUMAN SERVICE WRK','*'},
																{'INTER CARE FACILITY','*'},
																{'INTERPRETER/TRANS','*'},
																{'JOB COACH','*'},
																{'LABORATORY','*'},
																{'LABORER','*'},
																{'LAWYER','*'},
																{'LICENSED PRACTICAL NURSE','*'},
																{'LICENSED PRACTITIONR','*'},
																{'LOCAL GOVT','*'},
																{'M H FAC','*'},
																{'MANAGEMENT SVCS CO','*'},
																{'MANUF/LESSOR SUPP/EQ','*'},
																{'MANUFACTURER/WHOLESALER','*'},
																{'MASSAGE THERAPIST','*'},
																{'MEDICAL ASSISTANT','*'},
																{'MEDICAL DOCTOR (UNLICENSED)','*'},
																{'MEDICAL GROUP','*'},
																{'MEDICAL PRACTICE, MD','*'},
																{'MENTAL HEALTH FAC','*'},
																{'MENTAL HEALTH FACILITY','*'},
																{'MENTAL HEALTH WORKER','*'},
																{'NONE GIVEN','*'},
																{'NURSE/NURSES AIDE','*'},
																{'NURSING ASSISTANT/NURSES AIDE','*'},
																{'NURSING FIRM','*'},
																{'NURSING HOME ADMINISTRATOR','*'},
																{'NURSING HOME FACILITY','*'},
																{'NURSING PROFESSION','*'},
																{'OCCUPATIONAL THERAPY ASSISTANT','*'},
																{'OFFICER/EXECUT/BOARD','*'},
																{'OPTOMETRIC PRACTICE','*'},
																{'ORDERLY','*'},
																{'OSTEOPATHIC PRAC','*'},
																{'OWNER','*'},
																{'PERSONAL CARE ATTENDANT','*'},
																{'PHARMACIST/PHARMACY','*'},
																{'PHARMACY','*'},
																{'PHYSICAL THERAPY ASSISTANT','*'},
																{'PHYSICIAN PRACTICE','*'},
																{'PODIATRY PRACTICE','*'},
																{'PORTABLE X-RAY COMPANY','*'},
																{'PRESCRIBED MEDICAL REHAB SERVICES (PPEC)','*'},
																{'PSYCHOLOGIC PRACTICE','*'},
																{'PSYCHOLOGIST ASSISTANT','*'},
																{'RECIPT/BENEFICIARY','*'},
																{'REGISTERED DENTAL ASSISTANT','*'},
																{'REGISTERED DENTAL HYGIENIST','*'},
																{'REHAB FACILITY','*'},
																{'REHAB FACILITY - GEN','*'},
																{'REHAB SPECIALIST','*'},
																{'REHABILITATION CENTER','*'},
																{'RENAL FACILITY','*'},
																{'REPRESENTATIVE PAYEE','*'},
																{'RESEARCH SCIENTIST','*'},
																{'RURAL HEALTH CLINIC','*'},
																{'SKILLED NURSING FAC','*'},
																{'SKILLED NURSING FACILITY','*'},
																{'SOCIAL WORK ASSOCIATE','*'},
																{'STATE GOV'T','*'},
																{'SUPERVISOR/FOREMAN','*'},
																{'SURGICAL ASSISTANT','*'},
																{'SURGICAL CENTER','*'},
																{'SWING BED FACILITY','*'},
																{'TECHNICIAN','*'},
																{'TRANSPORTATION CO','*'},
																{'UNKNOWN SPECIALTY','*'},
																{'UNLICENSED PHYS/GP','*'},
																{'Unknown Specialty','*'},
																{'VENDOR','*'},
																{'VISION','*'},
																{'WAGE GRADE','*'},
																{'WARD ATTENDANT','*'}
*/
dsMatchProvTypes := dataset([
																{'ACUPUNCTURIST','*'},
																{'ADVANCED NURSE PRACTITIONER','*'},
																{'ADVANCED PRACTICE NURSE','*'},
																{'ADVANCED PRACTICE REGISTERED NURSE','*'},
																{'ALLERGIST','*'},
																{'ANESTHESIOLOGIST','*'},
																{'ANESTHETIST','*'},
																{'ASSOCIATE CLINICAL SOCIAL WORKER','*'},
																{'AUDIOLOGIST','*'},
																{'CARDIOLOGIST','*'},
																{'CERT. MARRIAGE/FAM. THERAPIST','*'},
																{'CERTIFIED DIETITIAN','*'},
																{'CERTIFIED NURSE MIDWIFE','*'},
																{'CERTIFIED SOCIAL WORKER','*'},
																{'CHIROPRACTOR','*'},
																{'CLINICAL SOCIAL WORKER','*'},
																{'COUNSELOR','*'},
																{'DENTIST','*'},
																{'DERMATOLOGIST','*'},
																{'DIETITIAN','*'},
																{'DOCTOR','*'},
																{'DOCTOR OF NATUROPATHY','*'},
																{'DOCTOR OF OSTEOPATHY','*'},
																{'DOCTOR OF PODIATRIC MEDICINE','*'},
																{'ENDOCRINOLOGIST','*'},
																{'FAMILY PHYSICIAN/GP','*'},
																{'FAMILY PRACT PHYS\'N','*'},
																{'GASTROENTEROLOGIST','*'},
																{'GENERAL PRACT PHYS\'N','*'},
																{'GENERAL PRACTICE','*'},
																{'GERONTOLOGIST','*'},
																{'GYNECOLOGIST/OB','*'},
																{'INTERNIST/IM','*'},
																{'LANGUAGE SPEECH PATHOLOGIST','*'},
																{'LIC. MARRIAGE/FAM.THERAPIST','*'},
																{'LICENSED MASTER SOC. WORKER','*'},
																{'LICENSED PROF. COUNSELOR','*'},
																{'LICENSED SOCIAL WORKER','*'},
																{'LIMITED LICENSED PSYCHOLOGIST','*'},
																{'MARRIAGE/FAMILY THERAPIST','*'},
																{'MASTER SOCIAL WORKER','*'},
																{'MEDICAL DOCTOR','*'},
																{'MIDWIFE','*'},
																{'NATUROPATHIC DOCTOR','*'},
																{'NEPHROLOGIST','*'},
																{'NEUROLOGIST','*'},
																{'NURSE PRACTITIONER (ARNP)','*'},
																{'NUTRITION COUNSELOR','*'},
																{'OCCUPATIONAL THERAPIST','*'},
																{'ONCOLOGIST','*'},
																{'OPHTHALMOLOGIST','*'},
																{'OPTICIAN','*'},
																{'OPTOMETRIST','*'},
																{'ORTHOPEDIST','*'},
																{'ORTHOTIST','*'},
																{'OSTEOPATH','*'},
																{'OTORHINOLARYNGOLOST','*'},
																{'PATHOLOGIST','*'},
																{'PEDIATRICIAN','*'},
																{'PHARMACIST','*'},
																{'PHLEBOTOMIST','*'},
																{'PHYS/DENTIST/OTHER','*'},
																{'PHYSIATRIST','*'},
																{'PHYSICAL & OCCUPATIONAL THERAPIST','*'},
																{'PHYSICAL THERAPIST','*'},
																{'PHYSICIAN','*'},
																{'PHYSICIAN ASSISTANT','*'},
																{'PLASTIC SURGEON','*'},
																{'PODIATRIST','*'},
																{'PSYCHIATRIST','*'},
																{'PSYCHOLOGIST','*'},
																{'PULMONOLOGIST','*'},
																{'RADIOLOGIST','*'},
																{'REGISTERED NURSE','*'},
																{'REGISTERED SOCIAL WORKER','*'},
																{'RESPIRATORY CARE PRACTITIONER','*'},
																{'RESPIRATORY THERAPIST','*'},
																{'RHEUMATOLOGIST','*'},
																{'SOCIAL WORKER','*'},
																{'SPEECH THERAPIST','*'},
																{'SPEECH/LANGUAGE PATHOLOGIST','*'},
																{'SURGEON','*'},
																{'THERAPIST','*'},
																{'UROLOGIST','*'}
																],MyProviderTypes);
//We may need to keep records for these before 2005..... for now we are getting rid of them.
rawdataIndvCoveredProviderTypes := join(rawdataIndv,dsMatchProvTypes,
													left.sanc_provType=right.provtype,
													transform(recordof(rawdata), 
																		self.SANC_ID := if(left.sanc_sancst = right.state or right.state = '*',left.SANC_ID,skip);
																		self:=left;));
rawdataIndvCoveredProviderTypesCurrent := rawdataIndvCoveredProviderTypes(sanc_sancdte_form>cutoff);//Only keep records that Enclarity has 
//Here is what Enclarity has coverage for... Keep all other provider types and all history on even the covered types that are no in the Enclarity covered data
rawdataIndvNonCoveredProviderTypes := join(rawdataIndv,rawdataIndvCoveredProviderTypesCurrent,left.SANC_ID=right.SANC_ID,transform(recordof(rawdataIndv), self := left), left only);
BaseFile := rawdataBus+rawdataIndvNonCoveredProviderTypes:PERSIST('~thor400_data::persist::INGENIXSanctionGap');

MyNewLayout := RECORD
	unsigned6 LNPID:=0;
  recordof(BaseFile);
END;
newFile:=project(baseFile,MyNewLayout);

fAppendLnpid1(DATASET(MyNewLayout) pDataset) := FUNCTION
	Health_Provider_Services.mac_get_best_lnpid_on_thor (
					pDataset
					,LNPID
					,Prov_Clean_fname
					,Prov_Clean_mname
					,Prov_Clean_lname
					,//clean_name.name_suffix
					,//GENDER
					,provco_address_clean_PRIM_Range
					,provco_address_clean_PRIM_Name
					,provco_address_clean_SEC_RANGE
					,provco_address_clean_v_city_name
					,provco_address_clean_ST
					,provco_address_clean_ZIP
					,//clean_SSN
					,sanc_dob
					,//clean_phone.phone
					,sanc_sancST
					,sanc_licnbr
					,sanc_tin
					,//DEA_REGISTRATION_NUMBER
					,//biog_number
					,//NPI
					,sanc_UPIN
					,DID
					,BDID
					,//SRC
					,//SOURCE_RID
					,dLnpidOut,false,38
					);
					
    RETURN PROJECT(dLnpidOut, MyNewLayout);
 END;

fAppendLnpid2(DATASET(MyNewLayout) pDataset) := FUNCTION
	Health_Facility_Services.mac_get_best_lnpid_on_thor (
					pDataset
					,LNPID
					,sanc_busnme											
					,provco_address_clean_prim_range
					,provco_address_clean_PRIM_Name
					,provco_address_clean_SEC_RANGE
					,provco_address_clean_v_city_name
					,provco_address_clean_ST
					,provco_address_clean_ZIP
					,sanc_tin
					,//Input_FEIN
					,//Input_PHONE
					,//Input_FAX
					,sanc_sancst
					,sanc_licnbr
					,//Input_DEA_NUMBER
					,//Input_VENDOR_ID
					,//Input_NPI_NUMBER
					,//Input_CLIA_NUMBER
					,//Input_MEDICARE_FACILITY_NUMBER
					,//Input_MEDICAID_NUMBER
					,//Input_NCPDP_NUMBER
					,//Input_Taxonomy
					,BDID
					,//SRC
					,//SOURCE_RID
					,dLnpidOut
					,false
					,30
					);

    RETURN PROJECT(dLnpidOut, MyNewLayout);
 END;

dsAppendLnpid1 := fAppendLnpid1(newFile(sanc_busnme=''));
dsAppendLnpid2 := fAppendLnpid2(newFile(sanc_busnme<>''));
dsAppendLnpid := dsAppendLnpid1 + dsAppendLnpid2;

EXPORT File_EnclaritySanctionGap := dsAppendLnpid  : PERSIST('~thor400_data::persist::INGENIXSanctionGap_with_LNPID');