
IMPORT address, ut, HEADER,NID,AID;


EXPORT Proc_Spray_Preprocess_ska_a(String filedate) := FUNCTION




decode_SpecDeptCode(string3 tid) := 
case(tid,                                             
           '' => 'Specialty Is Not Specified',        
         'ACU' => 'Acupuncturist',                    
         'ADD' => 'Addiction Medicine',               
         'ADO' => 'Adolescent Medicine',              
         'AER' => 'Aerospace Medicine',               
         'AIM' => 'Allergist/Immunologist',           
         'ALL' => 'Allergist',                        
         'ANS' => 'Anesthesiologist',                 
         'BAR' => 'Bariatrician',                     
         'CAR' => 'Cardiologist',                     
         'CCM' => 'Critical Care Specialist',         
         'CHP' => 'Child Psychiatrist',               
         'CHR' => 'Chiropractor',                     
         'CRS' => 'Colon/Rectal Surgeon',             
         'DBT' => 'Diabetes Specialist',              
         'DER' => 'Dermatologist',                    
         'DMT' => 'Dermatopathology',                 
         'DNT' => 'Dentist/Oral Surgeon',             
         'DOP' => 'Osteopathic Physician',            
         'DRD' => 'Diagnostic Radiologist',           
         'EMR' => 'Emergency Medicine Specialist',    
         'END' => 'Endocrinologist',                  
         'FMP' => 'Family Practitioner',              
         'FOR' => 'Forensic Psych',                   
         'GAS' => 'Gastroenterologist',               
         'GEN' => 'Genetics Specialist',              
         'GER' => 'Geriatrician',                     
         'GNP' => 'General Practitioner',             
         'GNS' => 'General Surgeon',                  
         'GPM' => 'Preventive Medicine Specialist',   
         'GYN' => 'Gynecologist',                     
         'GYO' => 'Gynecologic Oncologist',           
         'HDS' => 'Hand Surgeon',                     
         'HEM' => 'Hematologist',                     
         'HEP' => 'Hepatologist',                     
         'HNS' => 'Head & Neck Surgery',              
         'HTM' => 'Holistic Medicine',                
         'IMM' => 'Immunologist',                     
         'INF' => 'Infectious Disease Specialist',    
         'INT' => 'Internist',                        
         'MDT' => 'Medical Toxicology',               
         'NEO' => 'Neonatologist',                    
         'NEP' => 'Nephrologist',                     
         'NER' => 'Neuroradiology Specialist',        
         'NEU' => 'Neurologist',                      
         'NSG' => 'Neurosurgeon',                     
         'NUC' => 'Nuclear Medicine Specialist',      
         'OBG' => 'Obstetrician/Gynecologist',        
         'OCM' => 'Occupational Medicine Spec',       
         'OFA' => 'Orthopedic Foot & Ankle',          
         'ONC' => 'Oncologist/Hematologist',          
         'ONL' => 'Oncologist',                       
         'OPH' => 'Ophthalmologist',                  
         'OPT' => 'Optometrist',                      
         'ORC' => 'Orthopedic Reconstructive Sgn',    
         'ORS' => 'Orthopedic Surgeon',               
         'OSN' => 'Orthopedic Spine Surgeon',         
         'OTO' => 'Otolaryngologist',                 
         'PAI' => 'Pain Management Specialist',       
         'PDS' => 'Pediatric Surgeon',                
         'PED' => 'Pediatrician',                     
         'PHM' => 'Physical Medicine/Rehab Spec',     
         'PLS' => 'Plastic Surgeon',                  
         'POD' => 'Podiatrist',                       
         'PSC' => 'Psychologist',                     
         'PSY' => 'Psychiatrist',                     
         'PTH' => 'Pathologist',                      
         'PUL' => 'Pulmonologist',                    
         'RAD' => 'Radiologist',                      
         'RDO' => 'Radiation Oncologist',             
         'RET' => 'Retinal Specialist',               
         'RHU' => 'Rheumatologist',                   
         'SLP' => 'Sleep Medicine',                   
         'SPM' => 'Sport Medicine Specialist',        
         'THS' => 'Thoracic Surgeon',                 
         'TRA' => 'Transplant Surgeon',               
         'TRM' => 'Trauma Surgeon',                   
         'URG' => 'Urgent Care Specialist',           
         'URO' => 'Urologist',                        
         'VAS' => 'Vascular Surgeon',                 
         '');                                         


export decode_Deptitle(string3 tid) := 
case(tid,                                                 
        'A_V' => 'Director Audio Visual/Media Svs',       
        'AAD' => 'Assistant Administrator',               
        'AAH' => 'Administrative Asst/Secretary',         
        'AAS' => 'Administrative Assistant',              
        'AAT' => 'Administrative Assistant',              
        'ACC' => 'Director of Patient Accounts',          
        'ADA' => 'Administrative Assistant',              
        'ADD' => 'Director of Admissions Svs',            
        'ADM' => 'Administrator',                         
        'ADN' => 'Administrator',                         
        'ADR' => 'Administrator',                         
        'AES' => 'Admin Secretary/Exec Assistant',        
        'AMB' => 'Director of Ambulance Services',        
        'AMS' => 'Director of Admissions',                
        'ANC' => 'Director of Ancillary Services',        
        'ANS' => 'Director of Anesthesiology',            
        'AST' => 'Assistant/Associate Pharmacist',        
        'AUD' => 'Director of Audiology',                 
        'AVM' => 'Advertising Manager',                   
        'BAT' => 'Buyer (Automation)',                    
        'BAU' => 'Buyer (Automobile)',                    
        'BAV' => 'Buyer (Audio/Video)',                   
        'BBH' => 'Buyer (Home Health)',                   
        'BBK' => 'Director of Blood Bank',                
        'BBP' => 'Buyer (Biotechnology Products)',        
        'BBV' => 'Buyer (Beverages)',                     
        'BBY' => 'Buyer (Baby Products)',                 
        'BCD' => 'Buyer (Candy)',                         
        'BES' => 'Buyer (Electrical Supplies)',           
        'BFD' => 'Buyer (Food)',                          
        'BGM' => 'Buyer (General Merchandise)',           
        'BHB' => 'Buyer (Health & Beauty)',               
        'BHS' => 'Buyer (Housewares)',                    
        'BIO' => 'Director of Laboratory Services',       
        'BJW' => 'Buyer (Jewelry)',                       
        'BME' => 'Director of Bio-Med Engineering',       
        'BMS' => 'Buyer (Miscellaneous)',                 
        'BOM' => 'Business Office Manager',               
        'BOT' => 'Buyer (OTC)',                           
        'BPH' => 'Buyer (Photo)',                         
        'BPU' => 'Buyer (Publications)',                  
        'BRX' => 'Buyer (Rx Drugs)',                      
        'BSM' => 'Business Manager',                      
        'BSP' => 'Buyer (Seasonal & Promotional)',        
        'BST' => 'Buyer (Stationery)',                    
        'BTB' => 'Buyer (Tobacco Products)',              
        'BTO' => 'Buyer (Toiletries)',                    
        'BTY' => 'Buyer (Toys)',                          
        'BUS' => 'Business Office Manager',               
        'CAM' => 'Corporate Advertising Manager',         
        'CAR' => 'Director of Cardiology Services',       
        'CCM' => 'Circulation Manager',                   
        'CEN' => 'Director Central/Sterile Supply',       
        'CEO' => 'Chief Executive Officer',               
        'CEP' => 'CEO/President',                         
        'CEX' => 'Chief Executive Officer',               
        'CFA' => 'Chief Information Officer',             
        'CFF' => 'Chief Financial Officer',               
        'CFI' => 'Chief Financial Officer',               
        'CFO' => 'CFO/Bookkeeper',                        
        'CFT' => 'Chief Financial Officer',               
        'CHE' => 'CEO/President',                         
        'CHF' => 'Chief Pharmacist',                      
        'CHI' => 'Chief Financial Officer',               
        'CHP' => 'Chief Pharmacist',                      
        'CIO' => 'Chief Information Officer',             
        'CLF' => 'Chief Financial Officer',               
        'CLM' => 'Claims Manager',                        
        'CLN' => 'Clinical Pharmacist',                   
        'CMA' => 'Medical Director',                      
        'CME' => 'Medical Staff Coordinator',             
        'CMG' => 'Case Manager',                          
        'CMR' => 'Clinical Coordinator',                  
        'CMS' => 'Chief of Medical Staff',                
        'CNO' => 'Chief Information Officer',             
        'COB' => 'Chairman of the Board',                 
        'COF' => 'Chief Financial Officer',               
        'CON' => 'Consulting Pharmacist',                 
        'COO' => 'Chief Operation Officer',               
        'COP' => 'Chief Operating Officer',               
        'CPO' => 'Chief Purchasing Officer',              
        'CPV' => 'Chief Privacy Officer',                 
        'CQA' => 'Quality Assurance Director',            
        'CRE' => 'Chief Resident/Residency Progrm',       
        'CSM' => 'Director of Case Management',           
        'CSN' => 'Case Manager',                          
        'CSV' => 'Customer Service Manager',              
        'CTH' => 'Director of Catheterization Lab',       
        'CTL' => 'Controller',                            
        'CXF' => 'Chief Executive Officer',               
        'CXO' => 'Chief Executive Officer',               
        'DBC' => 'Director Billing/Customer Svs',         
        'DBE' => 'Director Biomedical Engineering',       
        'DCP' => 'Director of Discharge Planning',        
        'DDP' => 'M.I.S. Director',                       
        'DEN' => 'Director of Dentistry',                 
        'DEV' => 'Director of Foundation',                
        'DHR' => 'Director of Human Resources',           
        'DHS' => 'Director of Health Services',           
        'DIQ' => 'Director of Quality Assurance',         
        'DMD' => 'Director of Medicare/Medicaid',         
        'DMG' => 'Director of Marketing',                 
        'DMH' => 'District Managers',                     
        'DMI' => 'Director MIS/Data Processing',          
        'DMM' => 'Director Supply/Materials Mgmt',        
        'DMR' => 'Director of Medical Records',           
        'DNS' => 'Director Patient Care/Nursing',         
        'DOD' => 'Director of Development',               
        'DOH' => 'Director of Human Resources',           
        'DOM' => 'Dir Marketing/Public Relations',        
        'DON' => 'Director of Nursing',                   
        'DOS' => 'Director of Sales',                     
        'DPH' => 'Dispensing Physician',                  
        'DPM' => 'Dir Purchasing/Materials Mgmt',         
        'DPP' => 'Director of Data Processing/MIS',       
        'DPR' => 'Director of Pharmacy Relations',        
        'DQA' => 'Director of Quality Assurance',         
        'DQU' => 'Director of Quality Assurance',         
        'DRG' => 'DRG/Coding Manager',                    
        'DTM' => 'Distribution Transportation Mgr',       
        'DUR' => 'Director of Utilization Review',        
        'EDC' => 'Professional Educ Coordinator',         
        'EMR' => 'Director of Emergency Room',            
        'ENG' => 'Dir of Engineering/Maintenance',        
        'EXD' => 'Executive Director',                    
        'EXE' => 'Chief Executive Officer',               
        'FAC' => 'Director of Housekeeping',              
        'FCO' => 'Formulary Committee Member',            
        'FDS' => 'Director of Food Services',             
        'FIN' => 'Chief Financial Officer',               
        'FMD' => 'Formulary Director',                    
        'FMP' => 'Director of Family Practice',           
        'FMY' => 'Chairman of Formulary Committee',       
        'FRD' => 'Formulary Director',                    
        'GIF' => 'Manager of the Gift Shop',              
        'GMD' => 'Physician',                             
        'GMG' => 'General Manager',                       
        'GST' => 'Director Volunteers/Auxiliary',         
        'GTP' => 'Director of Geriatric Programs',        
        'GUE' => 'Director of Social Services',           
        'HLS' => 'Hospitalist',                           
        'HMN' => 'Director of Human Resources',           
        'HOM' => 'Director of Home Healthcare',           
        'HOU' => 'Director of Environmental Svs',         
        'HPC' => 'Director of Hospice Services',          
        'HPL' => 'Hospitalist',                           
        'HUM' => 'Director of Human Resources',           
        'HUN' => 'Director of Human Resources',           
        'HUR' => 'Director of Personnel',                 
        'ICU' => 'Director ICU/Coronary Care Unit',       
        'IMM' => 'Inventory Management Manager',          
        'IND' => 'Chief of Infectious Diseases',          
        'INF' => 'Director of Infection Control',         
        'INT' => 'Director Internal Medicine Svs',        
        'ISE' => 'Director In-Service Education',         
        'ISS' => 'M.I.S. Director',                       
        'ISV' => 'Insurance/Billing Supervisor',          
        'LIB' => 'Medical Librarian',                     
        'LSV' => 'Director Of Laboratory',                
        'MAR' => 'Director of Marketing',                 
        'MAT' => 'Dir Materials Mgmt/Purchasing',         
        'MCC' => 'Dir of Managed Care Contracts',         
        'MCL' => 'Miscellaneous',                         
        'MCO' => 'Medicare Coordinator',                  
        'MCS' => 'Miscellaneous',                         
        'MDC' => 'Medical Director',                      
        'MDD' => 'Medical Director',                      
        'MDR' => 'Medical Director',                      
        'MDS' => 'Minimum Data Set Coordinator',          
        'MEA' => 'Medical Assistant',                     
        'MED' => 'Medical Director',                      
        'MEM' => 'Director Customer/Member Svc',          
        'MER' => 'Director of Medical Records',           
        'MES' => 'Miscellaneous',                         
        'MGR' => 'Pharmacy Manager',                      
        'MHP' => 'Dir Maternal Health Programs',          
        'MIC' => 'Miscellaneous',                         
        'MIM' => 'Marketing Information Manager',         
        'MIS' => 'Miscellaneous',                         
        'MKG' => 'VP/Director of Marketing',              
        'MKS' => 'Market Research Staff',                 
        'MKT' => 'Director of Marketing Services',        
        'MLL' => 'Miscellaneous',                         
        'MMD' => 'Director of Medicare/Medicaid',         
        'MNC' => 'Director of Managed Care',              
        'MPM' => 'Merchandise Planning Manager',          
        'MRC' => 'Director of Medical Records',           
        'MRK' => 'VP of Marketing',                       
        'MRS' => 'Supervisor of Medical Records',         
        'MSC' => 'Miscellaneous',                         
        'MSS' => 'Miscellaneous',                         
        'MTR' => 'Director of Market Research',           
        'NCS' => 'Nursing Care Svs/Dir of Nurs',          
        'NDH' => 'Director Dialysis/Hemodialysis',        
        'NEO' => 'Director of Neonatal Care',             
        'NEU' => 'Director of Neurology Services',        
        'NRE' => 'Nurse Recruiter',                       
        'NRP' => 'Nurse Practitioner',                    
        'NRS' => 'Nurse',                                 
        'NSD' => 'Nursing Services Director',             
        'NUR' => 'Director of Nursing Services',          
        'NUT' => 'Director of Food Services',             
        'OBG' => 'Director of OB/GYN Services',           
        'OBM' => 'Office Manager/Business Manager',       
        'ODS' => 'Over Counter Drug Supervisor',          
        'OFC' => 'Office Manager',                        
        'OFM' => 'Business Office Manager',               
        'ONC' => 'Director of Oncology Services',         
        'OPS' => 'Chief Operating Officer',               
        'ORN' => 'Director of Operating Room',            
        'OTP' => 'Director of Orthopedic Surgery',        
        'OTR' => 'Director of Outreach Services',         
        'OUT' => 'Director of Outpatient Services',       
        'OWC' => 'Owner/Chief Pharmacist',                
        'OWP' => 'Owner/Pharmacist',                      
        'PAP' => 'Physician Assistant',                   
        'PAS' => 'Director of Pastoral Care',             
        'PAT' => 'Director of Patient Education',         
        'PDT' => 'President',                             
        'PDU' => 'Product Manager',                       
        'PED' => 'Director of Pediatric Services',        
        'PER' => 'Personnel Director',                    
        'PHA' => 'VP of Pharmacy Affairs',                
        'PHC' => 'Pharmacist',                            
        'PHL' => 'Director of Provider Relations',        
        'PHM' => 'Staff Pharmacist',                      
        'PHR' => 'Director of Pharmacy Services',         
        'PHT' => 'Physical Therapist',                    
        'PHY' => 'Director of Physical Therapy',          
        'PLD' => 'Director of Planning',                  
        'PMR' => 'Purchasing Manager',                    
        'PNM' => 'Nurse Manager of Psych Unit',           
        'PPH' => 'Dir Psych Partial Hospital Svs',        
        'PRD' => 'President',                             
        'PRE' => 'Director Physician Recruitment',        
        'PRI' => 'President',                             
        'PRL' => 'Director of Patient Relations',         
        'PRS' => 'President',                             
        'PRY' => 'Pharmacy Manager',                      
        'PSA' => 'Patient Safety Officer',                
        'PSD' => 'President',                             
        'PST' => 'President',                             
        'PSV' => 'Pharmacy Services Director',            
        'PSY' => 'Director of Psychology',                
        'PTH' => 'Director of Pathology Services',        
        'PUB' => 'Director of Public Relations',          
        'PUG' => 'Purchasing Manager',                    
        'PUM' => 'Purchasing Manager',                    
        'PUR' => 'Purchasing Manager',                    
        'PVH' => 'Director of Preventive Health',         
        'PYD' => 'Pharmacy Director',                     
        'QAR' => 'Director of Quality Assurance',         
        'QLA' => 'Director of Quality Assurance',         
        'QUA' => 'Director of Quality Improvement',       
        'RAD' => 'Director of Radiology Services',        
        'RCD' => 'Director of Medical Records',           
        'RDI' => 'Registered Dietitian',                  
        'REC' => 'Director Activities/Recreation',        
        'REH' => 'Director of Physical Therapy',          
        'RES' => 'Director of Respiratory Therapy',       
        'RSH' => 'Director Research & Development',       
        'RSK' => 'Director of Risk Management',           
        'RSV' => 'Radiology/X-Ray Supervisor',            
        'RVP' => 'Regional Vice President',               
        'SCY' => 'Receptionist/Secretary',                
        'SEC' => 'Administrative Assistant',              
        'SFF' => 'Staff Pharmacist',                      
        'SGY' => 'Director of Surgery',                   
        'SKN' => 'Director of Skilled Nursing Svs',       
        'SMR' => 'Store Manager',                         
        'SOC' => 'Director of Social Services',           
        'SOW' => 'Social Worker',                         
        'SPT' => 'Director of Support Services',          
        'SSV' => 'Director of Security Services',         
        'STA' => 'Site Administrator',                    
        'STF' => 'Staff Physician',                       
        'STM' => 'Sales Training Manager',                
        'SUB' => 'Director of Substance Abuse',           
        'SWK' => 'Social Worker',                         
        'TCH' => 'Pharmacy Technician',                   
        'TCM' => 'Director of Telecommunications',        
        'TEC' => 'Technician',                            
        'TNG' => 'Director Inservice Training/Ed',        
        'TRD' => 'Dir Human Resources/Training',          
        'TSP' => 'Director Patient Transportation',       
        'UTL' => 'Director of Utilization Review',        
        'VCO' => 'VP/Chief Operating Officer',            
        'VNP' => 'VP of National Procurement',            
        'VPC' => 'Vice President',                        
        'VPH' => 'VP Merchandise',                        
        'VPM' => 'VP of Planning & Marketing',            
        'VPP' => 'Director of Purchasing',                
        'VPS' => 'VP of Marketing/Sales',                 
        'XTC' => 'X-Ray/Radiology Tech',                  
        '');                                              



decode_Depfile(string3 tid) := 
case(tid,                                              
        'A_V' => 'Hospital',                           
        'AAD' => 'Nursing Home',                       
        'AAH' => 'Home Health',                        
        'AAS' => 'Hospital Mgmt Corp',                 
        'AAT' => 'Nursing Home',                       
        'ACC' => 'Hospital',                           
        'ADA' => 'Pharmaceutical Companies',           
        'ADD' => 'Hospital',                           
        'ADM' => 'Hospital',                           
        'ADN' => 'Nursing Home',                       
        'ADR' => 'GMP',                                
        'AES' => 'HMO',                                
        'AMB' => 'Hospital',                           
        'AMS' => 'Nursing Home',                       
        'ANC' => 'Hospital',                           
        'ANS' => 'Hospital',                           
        'AST' => 'Pharmacy',                           
        'AUD' => 'GMP',                                
        'AVM' => 'Pharmaceutical Companies',           
        'BAT' => 'Pharmacy Chain HQ',                  
        'BAU' => 'Pharmacy Chain HQ',                  
        'BAV' => 'Pharmacy Chain HQ',                  
        'BBH' => 'Pharmacy Chain HQ',                  
        'BBK' => 'Hospital',                           
        'BBP' => 'Pharmacy Chain HQ',                  
        'BBV' => 'Pharmacy Chain HQ',                  
        'BBY' => 'Pharmacy Chain HQ',                  
        'BCD' => 'Pharmacy Chain HQ',                  
        'BES' => 'Pharmacy Chain HQ',                  
        'BFD' => 'Pharmacy Chain HQ',                  
        'BGM' => 'Pharmacy Chain HQ',                  
        'BHB' => 'Pharmacy Chain HQ',                  
        'BHS' => 'Pharmacy Chain HQ',                  
        'BIO' => 'Hospital',                           
        'BJW' => 'Pharmacy Chain HQ',                  
        'BME' => 'Hospital',                           
        'BMS' => 'Pharmacy Chain HQ',                  
        'BOM' => 'Nursing Home',                       
        'BOT' => 'Pharmacy Chain HQ',                  
        'BPH' => 'Pharmacy Chain HQ',                  
        'BPU' => 'Pharmacy Chain HQ',                  
        'BRX' => 'Pharmacy Chain HQ',                  
        'BSM' => 'GMP',                                
        'BSP' => 'Pharmacy Chain HQ',                  
        'BST' => 'Pharmacy Chain HQ',                  
        'BTB' => 'Pharmacy Chain HQ',                  
        'BTO' => 'Pharmacy Chain HQ',                  
        'BTY' => 'Pharmacy Chain HQ',                  
        'BUS' => 'Hospital',                           
        'CAM' => 'Pharmacy Chain HQ',                  
        'CAR' => 'Hospital',                           
        'CCM' => 'Pharmaceutical Companies',           
        'CEN' => 'Hospital',                           
        'CEO' => 'Hospital',                           
        'CEP' => 'Home Health',                        
        'CEX' => 'Pharmacy Chain HQ',                  
        'CFA' => 'GMP',                                
        'CFF' => 'Pharmaceutical Companies',           
        'CFI' => 'Pharmacy Chain HQ',                  
        'CFO' => 'Nursing Home',                       
        'CFT' => 'Hospital Mgmt Corp',                 
        'CHE' => 'Nursing Home',                       
        'CHF' => 'Pharmacy',                           
        'CHI' => 'HMO',                                
        'CHP' => 'Home Health',                        
        'CIO' => 'Hospital',                           
        'CLF' => 'GMP',                                
        'CLM' => 'HMO',                                
        'CLN' => 'Pharmacy',                           
        'CMA' => 'Hospital',                           
        'CME' => 'Hospital',                           
        'CMG' => 'HMO',                                
        'CMR' => 'Pharmacy',                           
        'CMS' => 'Hospital',                           
        'CNO' => 'Pharmacy Chain HQ',                  
        'COB' => 'Hospital',                           
        'COF' => 'Home Health',                        
        'CON' => 'Pharmacy',                           
        'COO' => 'GMP',                                
        'COP' => 'Pharmacy Chain HQ',                  
        'CPO' => 'Nursing Home',                       
        'CPV' => 'Hospital',                           
        'CQA' => 'Pharmaceutical Companies',           
        'CRE' => 'Hospital',                           
        'CSM' => 'Hospital',                           
        'CSN' => 'Nursing Home',                       
        'CSV' => 'Pharmaceutical Companies',           
        'CTH' => 'Hospital',                           
        'CTL' => 'Hospital',                           
        'CXF' => 'GMP',                                
        'CXO' => 'Hospital Mgmt Corp',                 
        'DBC' => 'Home Health',                        
        'DBE' => 'Home Health',                        
        'DCP' => 'Hospital',                           
        'DDP' => 'HMO',                                
        'DEN' => 'Hospital',                           
        'DEV' => 'Hospital',                           
        'DHR' => 'Hospital Mgmt Corp',                 
        'DHS' => 'HMO',                                
        'DIQ' => 'Home Health',                        
        'DMD' => 'HMO',                                
        'DMG' => 'Nursing Home',                       
        'DMH' => 'Pharmacy Chain HQ',                  
        'DMI' => 'Hospital Mgmt Corp',                 
        'DMM' => 'Hospital Mgmt Corp',                 
        'DMR' => 'Home Health',                        
        'DNS' => 'Hospital',                           
        'DOD' => 'Home Health',                        
        'DOH' => 'Home Health',                        
        'DOM' => 'Home Health',                        
        'DON' => 'GMP',                                
        'DOS' => 'Home Health',                        
        'DPH' => 'Pharmacy',                           
        'DPM' => 'Home Health',                        
        'DPP' => 'Hospital',                           
        'DPR' => 'Pharmaceutical Companies',           
        'DQA' => 'HMO',                                
        'DQU' => 'Hospital Mgmt Corp',                 
        'DRG' => 'Hospital',                           
        'DTM' => 'Pharmacy Chain HQ',                  
        'DUR' => 'HMO',                                
        'EDC' => 'Pharmaceutical Companies',           
        'EMR' => 'Hospital',                           
        'ENG' => 'Hospital',                           
        'EXD' => 'HMO',                                
        'EXE' => 'HMO',                                
        'FAC' => 'Nursing Home',                       
        'FCO' => 'Hospital',                           
        'FDS' => 'Nursing Home',                       
        'FIN' => 'Hospital',                           
        'FMD' => 'HMO',                                
        'FMP' => 'Hospital',                           
        'FMY' => 'Hospital',                           
        'FRD' => 'Hospital Mgmt Corp',                 
        'GIF' => 'Hospital',                           
        'GMD' => 'GMP',                                
        'GMG' => 'Pharmaceutical Companies',           
        'GST' => 'Hospital',                           
        'GTP' => 'Hospital',                           
        'GUE' => 'Nursing Home',                       
        'HLS' => 'Hospital',                           
        'HMN' => 'Pharmaceutical Companies',           
        'HOM' => 'Hospital',                           
        'HOU' => 'Hospital',                           
        'HPC' => 'Hospital',                           
        'HPL' => 'GMP',                                
        'HUM' => 'Hospital',                           
        'HUN' => 'Pharmacy Chain HQ',                  
        'HUR' => 'Nursing Home',                       
        'ICU' => 'Hospital',                           
        'IMM' => 'Pharmacy Chain HQ',                  
        'IND' => 'Hospital',                           
        'INF' => 'Hospital',                           
        'INT' => 'Hospital',                           
        'ISE' => 'Nursing Home',                       
        'ISS' => 'Pharmaceutical Companies',           
        'ISV' => 'GMP',                                
        'LIB' => 'Hospital',                           
        'LSV' => 'GMP',                                
        'MAR' => 'GMP',                                
        'MAT' => 'Hospital',                           
        'MCC' => 'Hospital',                           
        'MCL' => 'HMO',                                
        'MCO' => 'Nursing Home',                       
        'MCS' => 'Hospital Mgmt Corp',                 
        'MDC' => 'Home Health',                        
        'MDD' => 'HMO',                                
        'MDR' => 'Nursing Home',                       
        'MDS' => 'Nursing Home',                       
        'MEA' => 'GMP',                                
        'MED' => 'GMP',                                
        'MEM' => 'HMO',                                
        'MER' => 'HMO',                                
        'MES' => 'Pharmacy Chain HQ',                  
        'MGR' => 'Pharmacy',                           
        'MHP' => 'Hospital',                           
        'MIC' => 'GMP',                                
        'MIM' => 'Pharmacy Chain HQ',                  
        'MIS' => 'Nursing Home',                       
        'MKG' => 'HMO',                                
        'MKS' => 'Pharmaceutical Companies',           
        'MKT' => 'Hospital',                           
        'MLL' => 'Home Health',                        
        'MMD' => 'Hospital',                           
        'MNC' => 'HMO',                                
        'MPM' => 'Pharmacy Chain HQ',                  
        'MRC' => 'Hospital',                           
        'MRK' => 'Pharmacy Chain HQ',                  
        'MRS' => 'GMP',                                
        'MSC' => 'Hospital',                           
        'MSS' => 'Pharmaceutical Companies',           
        'MTR' => 'Pharmaceutical Companies',           
        'NCS' => 'HMO',                                
        'NDH' => 'Hospital',                           
        'NEO' => 'Hospital',                           
        'NEU' => 'Hospital',                           
        'NRE' => 'Hospital',                           
        'NRP' => 'GMP',                                
        'NRS' => 'GMP',                                
        'NSD' => 'Home Health',                        
        'NUR' => 'Nursing Home',                       
        'NUT' => 'Hospital',                           
        'OBG' => 'Hospital',                           
        'OBM' => 'HMO',                                
        'ODS' => 'Pharmacy',                           
        'OFC' => 'GMP',                                
        'OFM' => 'Home Health',                        
        'ONC' => 'Hospital',                           
        'OPS' => 'Hospital',                           
        'ORN' => 'Hospital',                           
        'OTP' => 'Hospital',                           
        'OTR' => 'Hospital',                           
        'OUT' => 'Hospital',                           
        'OWC' => 'Pharmacy',                           
        'OWP' => 'Pharmacy',                           
        'PAP' => 'GMP',                                
        'PAS' => 'Hospital',                           
        'PAT' => 'Hospital',                           
        'PDT' => 'Pharmaceutical Companies',           
        'PDU' => 'Pharmaceutical Companies',           
        'PED' => 'Hospital',                           
        'PER' => 'GMP',                                
        'PHA' => 'Pharmacy Chain HQ',                  
        'PHC' => 'GMP',                                
        'PHL' => 'HMO',                                
        'PHM' => 'Pharmacy',                           
        'PHR' => 'Hospital',                           
        'PHT' => 'GMP',                                
        'PHY' => 'Nursing Home',                       
        'PLD' => 'Hospital',                           
        'PMR' => 'Pharmaceutical Companies',           
        'PNM' => 'Hospital',                           
        'PPH' => 'Hospital',                           
        'PRD' => 'GMP',                                
        'PRE' => 'Hospital',                           
        'PRI' => 'HMO',                                
        'PRL' => 'Hospital',                           
        'PRS' => 'Hospital',                           
        'PRY' => 'Nursing Home',                       
        'PSA' => 'Hospital',                           
        'PSD' => 'Hospital Mgmt Corp',                 
        'PST' => 'Pharmacy Chain HQ',                  
        'PSV' => 'Home Health',                        
        'PSY' => 'Hospital',                           
        'PTH' => 'Hospital',                           
        'PUB' => 'Hospital',                           
        'PUG' => 'HMO',                                
        'PUM' => 'Hospital Mgmt Corp',                 
        'PUR' => 'GMP',                                
        'PVH' => 'HMO',                                
        'PYD' => 'HMO',                                
        'QAR' => 'GMP',                                
        'QLA' => 'Nursing Home',                       
        'QUA' => 'Hospital',                           
        'RAD' => 'Hospital',                           
        'RCD' => 'Nursing Home',                       
        'RDI' => 'GMP',                                
        'REC' => 'Nursing Home',                       
        'REH' => 'Hospital',                           
        'RES' => 'Hospital',                           
        'RSH' => 'Pharmaceutical Companies',           
        'RSK' => 'Hospital',                           
        'RSV' => 'GMP',                                
        'RVP' => 'Pharmaceutical Companies',           
        'SCY' => 'GMP',                                
        'SEC' => 'Hospital',                           
        'SFF' => 'Home Health',                        
        'SGY' => 'Hospital',                           
        'SKN' => 'Hospital',                           
        'SMR' => 'Pharmacy',                           
        'SOC' => 'Hospital',                           
        'SOW' => 'GMP',                                
        'SPT' => 'Hospital',                           
        'SSV' => 'Hospital',                           
        'STA' => 'Home Health',                        
        'STF' => 'Hospital',                           
        'STM' => 'Pharmaceutical Companies',           
        'SUB' => 'Hospital',                           
        'SWK' => 'Home Health',                        
        'TCH' => 'Pharmacy',                           
        'TCM' => 'Hospital',                           
        'TEC' => 'GMP',                                
        'TNG' => 'Hospital',                           
        'TRD' => 'HMO',                                
        'TSP' => 'Hospital',                           
        'UTL' => 'Hospital',                           
        'VCO' => 'Home Health',                        
        'VNP' => 'Pharmacy Chain HQ',                  
        'VPC' => 'Hospital Mgmt Corp',                 
        'VPH' => 'Pharmacy Chain HQ',                  
        'VPM' => 'Hospital Mgmt Corp',                 
        'VPP' => 'Hospital Mgmt Corp',                 
        'VPS' => 'Pharmaceutical Companies',           
        'XTC' => 'GMP',                                
        '');                                           



ds_ska := BusData.File_In_SKA_A;
// output(ds_ska,named('ska'));
trim2Upper( string incode ) := function
	return StringLib.StringToUpperCase ( trim(incode));
end;

temprec := record
	layouts_ska.raw;
	string73 name;
end;

temprec t_Name_ska(ds_ska le) := TRANSFORM
	self.name := trim(le.FIRST_NAME) + ' '+ trim(le.MIDDLE) + ' '+ trim(le.LAST_NAME);
	self      := le;
end;

d_ska_name := project(ds_ska,t_Name_ska(left));

Clean_Name_ska(DATASET(temprec) pInput) := FUNCTION
	NID.Mac_CleanFullNames(pInput, cleaned_names,name);
	RETURN cleaned_names;
end;

CleanName_owner	:= Clean_Name_ska(d_ska_name) ;

layouts_ska.parserec t_CleanName_ska(CleanName_owner le) := TRANSFORM
    self.PRENAME                 := le.PRENAME;
    self.FIRST_NAME              := le.FIRST_NAME;
    self.MIDDLE                  := le.MIDDLE;
    self.LAST_NAME               := le.LAST_NAME;
    self.TITLE                   := le.TITLE;
    self.DO                      := le.DO;
    self.KEY_CODE                := le.KEY_CODE;
    self.KEY_TITLE               := le.KEY_TITLE;
    self.KEY_FILE                := trim2Upper(decode_Depfile(le.KEY_CODE));
    self.COMPANY                 := le.COMPANY;
    self.ADDRESS                 := le.ADDRESS;
    self.CITY                    := le.CITY;
    self.STATE                   := le.STATE;
    self.ZIP                     := le.ZIP;
    self.ADDRESS2                := le.ADDRESS2;
    self.CITY2                   := le.CITY2; 
    self.STATE2                  := le.STATE2;
    self.ZIP2                    := le.ZIP2;
    self.FIPS                    := le.FIPS;
    self.PHONE                   := le.PHONE;
    self.SPEC                    := le.SPEC; 
    self.SPEC_EXPL               := le.SPEC_EXPL;
    self.SPEC2                   := le.SPEC2;
    self.SPEC2_EXPL              := trim2Upper(decode_SpecDeptCode(le.SPEC2));
    self.SPEC3                   := le.SPEC3;
    self.SPEC3_EXPL              := trim2Upper(decode_SpecDeptCode(le.SPEC3));
    self.ID                      := le.ID;
    self.PERSID                  := le.PERSID;
    self.OWNER                   := le.OWNER;
    self.clntitle                := if ( le.nametype = 'P',le.cln_title,'');           
    self.fname                   := if ( le.nametype = 'P',le.cln_fname,'') ;        
    self.mname                   := if ( le.nametype = 'P',le.cln_mname,'');         
    self.lname                   := if ( le.nametype = 'P',le.cln_lname,'');         
    self.name_suffix             := if ( le.nametype = 'P',le.cln_suffix,'');         
    self.name_score              := '';         
		self := [];
SELF := le;

END;	  

name_clean_ska := project(CleanName_owner, t_CleanName_ska(LEFT));

// ADD CLEAN ADDRESS

layout_addr_in_mailing := record
	name_clean_ska;
	string addr_line1;
end;

layout_addr_in_mailing get_addr_mailing(name_clean_ska l) := transform
	self.addr_line1 := trim(l.CITY) + ' '+ trim(l.STATE) + ' '+ trim(l.ZIP);
	self := l;
end;

la_raw_addr_ska := project(name_clean_ska, get_addr_mailing(left));

address.mac_address_clean(la_raw_addr_ska,ADDRESS, addr_line1,true,la_clean_addr_ska_a); 

layout_addr_clean := record
	name_clean_ska;
	
end;

layout_addr_clean get_parserecd_addr(la_clean_addr_ska_a l) := Transform
	self.clean_address := l.clean;
	self := l;
end;

name_clean2_ska := project(la_clean_addr_ska_a, get_parserecd_addr(left)) : persist('~thor_data400::persist::ska_clean');
// ADD CLEAN ADDRESS2

layout_addr2_in_mailing := record
	name_clean2_ska;
	string addr_line1;
end;

layout_addr2_in_mailing get_addr_mailing2(name_clean2_ska l) := transform
	self.addr_line1 := trim(l.CITY2) + ' '+ trim(l.STATE2) + ' '+ trim(l.ZIP2);
	self := l;
end;

la_raw_addr2_ska := project(name_clean2_ska, get_addr_mailing2(left));

address.mac_address_clean(la_raw_addr2_ska,ADDRESS2, addr_line1,true,la_clean2_addr_ska_a); 

layout_addr_clean2 := record
	name_clean2_ska;
end;

layouts_ska.parserec get_parserecd_addr2(la_clean2_addr_ska_a l) := Transform
	self.clean2_address := l.clean;
	self := l;
end;

la_parserecddr := project(la_clean2_addr_ska_a, get_parserecd_addr2(left)) ;

BusData.Layout_SKA_Verified_In t_Convfinal( la_parserecddr l) := transform
  self.title                   := l.clntitle;                      
  self.mail_prim_range          := l.clean_address[1..10]      ;	 
  self.mail_predir              := l.clean_address[11..12]     ;	 
  self.mail_prim_name           := l.clean_address[13..40]     ;	 
  self.mail_addr_suffix         := l.clean_address[41..44]  	 ;   
  self.mail_postdir             := l.clean_address[45..46]    	;  
  self.mail_unit_desig          := l.clean_address[47..56]  	 ;   
  self.mail_sec_range           := l.clean_address[57..64]  	 ;   
  self.mail_p_city_name         := l.clean_address[65..89]  	 ;   
  self.mail_v_city_name         := l.clean_address[90..114] 	 ;   
  self.mail_st                  := l.clean_address[115..116]   ;	 
  self.mail_zip                 := l.clean_address[117..121]   ;	 
  self.mail_zip4                := l.clean_address[122..125]   ;	 
  self.mail_cart                := l.clean_address[126..129]   ;	 
  self.mail_cr_sort_sz          := l.clean_address[130]     	 ;   
  self.mail_lot                 := l.clean_address[131..134]   ;	 
  self.mail_lot_order           := l.clean_address[135]     	 ;   
  self.mail_dbpc                := l.clean_address[136..137]   ;	 
  self.mail_chk_digit           := l.clean_address[138]     	 ;   
  self.mail_rec_type            := l.clean_address[139..140]   ;   
  self.mail_ace_fips_state      :=  l.clean_address[141..142]  ;   
  self.mail_county              := l.clean_address[143..145]  	;  
  self.mail_geo_lat             := l.clean_address[146..155]  	;  
  self.mail_geo_long            := l.clean_address[156..166]   ;	 
  self.mail_msa                 := l.clean_address[167..170]  	;  
  self.mail_geo_blk             := l.clean_address[171..177]   ;   
  self.mail_geo_match           := l.clean_address[178]     	 ;	 
  self.mail_err_stat            := l.clean_address[179..182] ;	   
  self.alt_prim_range           := l.clean2_address[1..10]      ;  
  self.alt_predir               := l.clean2_address[11..12]     ;  
  self.alt_prim_name            := l.clean2_address[13..40]     ;  
  self.alt_addr_suffix          := l.clean2_address[41..44]  	 ;   
  self.alt_postdir              := l.clean2_address[45..46]    	;  
  self.alt_unit_desig           := l.clean2_address[47..56]  	 ;   
  self.alt_sec_range            := l.clean2_address[57..64]  	 ;   
  self.alt_p_city_name          := l.clean2_address[65..89]  	 ;   
  self.alt_v_city_name          := l.clean2_address[90..114] 	 ;   
  self.alt_st                   := l.clean2_address[115..116]   ;  
  self.alt_zip                  := l.clean2_address[117..121]   ;  
  self.alt_zip4                 := l.clean2_address[122..125]   ;  
  self.alt_cart                 := l.clean2_address[126..129]   ;  
  self.alt_cr_sort_sz           := l.clean2_address[130]     	 ;   
  self.alt_lot                  := l.clean2_address[131..134]   ;  
  self.alt_lot_order            := l.clean2_address[135]     	 ;   
  self.alt_dbpc                 := l.clean2_address[136..137]   ;  
  self.alt_chk_digit            := l.clean2_address[138]     	 ;   
  self.alt_rec_type             := l.clean2_address[139..140]   ;  
  self.alt_ace_fips_state       := l.clean2_address[141..142]   ;  
  self.alt_county              := l.clean2_address[143..145]  	;  
  self.alt_geo_lat             := l.clean2_address[146..155]  	;  
  self.alt_geo_long            := l.clean2_address[156..166]   ;   
  self.alt_msa                 := l.clean2_address[167..170]  	;  
  self.alt_geo_blk             := l.clean2_address[171..177]   ;   
  self.alt_geo_match           := l.clean2_address[178]     	 ;	 
  self.alt_err_stat            := l.clean2_address[179..182] ;     
  self.company_title            := l.TITLE;                        
  self.company_name             := l.company;                      
  self.address1                 := l.address;                      
  self.lf                       := '';                             
  self := l;                                                       

end;

dSKAVerified := project( la_parserecddr,t_Convfinal( left));


ska_final := output(dSKAVerified,,'~thor_data400::base::ska_'+filedate,overwrite);

super_file := sequential(
							FileServices.ClearSuperFile('~thor_data400::base::ska'),
							FileServices.addSuperFile('~thor_data400::base::ska','~thor_data400::base::ska_'+filedate)
				);

return Sequential(BusData.Proc_SKA_Spray_In(filedate).spray_all_a,ska_final,super_file);

end;

