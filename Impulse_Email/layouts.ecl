﻿EXPORT layouts := MODULE

IMPORT AID;

	EXPORT layout_Impulse_Email_Slim
		:=
			RECORD, MAXLENGTH(8192)
				string8	 version_date,
				string8	 file_date,
				unsigned4	DateVendorFirstReported,
				unsigned4	DateVendorLastReported,
				string SOURCENAME,
				string EMAIL,
				string FIRSTNAME,
				string MIDDLENAME,
				string LASTNAME,
				string ADDRESS1,
				string ADDRESS2,
				string CITY,
				string STATE,
				string ZIP,
				string HOMEPHONE,
				string DOB,
				string CREATED,
				string SITEID,
				string SSN,
				string CAMPAIGNID,
				string LASTMODIFIED,
				string IPADDRESS,
				string TOTALINCOME,
				string CELLPHONE,
				string YEAROB,
				string FRAUD,
				string DAYOB,
				string MONTHOB,
				string BIGHIP_DBLOPT,
				string LICENSE_NUM,
				string LICENSE_STATE,
				string INCOME_MONTHLY_NET,
				string INCOME_DIRECTDEPOSIT,
				string REJECTEDREASON,
				string INCOME_MONTHLY,
				string ANNUAL_INCOME,
				string ERRORFLAG,
				string MONTHSALARY,
				string GROSSMONTHLYINCOME,
				string KRAFTBLOCK,
				string SCRAPED,
			END;
	
	EXPORT layout_Impulse_Email_v2
		:=
			RECORD
				string sourcename,
				string created,
				string lastmodified,
				string campaignid,
				string accountid,
				string siteid,
				string sourceid,
				string ipaddress,
				string title,
				string firstname,
				string lastname,
				string address1,
				string address2,
				string city,
				string state,
				string zip,
				string homephone,
				string workphone,
				string cellphone,
				string email,
				string dob,
				string ssn,
				string residence_type,
				string residence_time,
				string license_state,
				string license_num,
				string job_time,
				string job_title,
				string job_employer,
				string job_employer_address1,
				string job_employer_city,
				string job_employer_state,
				string job_employer_zip,
				string job_employer_phone,
				string job_supervisor,
				string bank_name,
				string bank_phone,
				string bank_aba,
				string bank_account_num,
				string bank_account_type,
				string time_at_bank,
				string income_pay_frequency,
				string income_monthly_net,
				string income_directdeposit,
				string income_source,
				string income_nextpayday1,
				string income_nextpayday2,
				string income_nextpayday3,
				string income_nextpayday4,
				string reference1_firstname,
				string reference1_lastname,
				string reference1_relation,
				string reference1_phone,
				string reference2_firstname,
				string reference2_lastname,
				string reference2_relation,
				string reference2_phone,
				string requested_amount,
				string military,
				string contact_time,
				string scraped,
				string status,
				string url,
				string payout,
				string buyer_id,
				string cid,
				string progress,
				string tier,
				string redirected,
				string snipped,
				string sourceid2,
				string rejectedreason,
				string bankruptcy,
				string cosigner,
				string monthlyincome,
				string howlongwithemployer,
				string yourjobtitle,
				string employername,
				string monthlypayment,
				string rent_or_own,
				string howlongathomeaddress,
				string authorizecredit,
				string year,
				string make,
				string model,
				string car_trim,
				string exterior,
				string interior,
				string pay_method,
				string buy_time,
				string bonus_offer,
				string dealer_post,
				string buyer,
				string cali_agree,
				string citizen,
				string netspend,
				string offer1,
				string activechecking,
				string credit_score,
				string exc,
				string response,
				string ping_id,
				string server_addr,
				string offer2,
				string offer3,
				string offer4,
				string offer5,
				string transaction_id,
				string termsagreement,
				string cmg_response,
				string cmg,
				string idt_response,
				string img_terms,
				string product,
				string grade,
				string offer_name,
				string redir_url,
				string sale,
				string mothersmaiden,
				string state_exclusion,
				string cip_transaction_id,
				string customer_acct_num,
				string cip_response,
				string brnv_response,
				string uc_response,
				string offer_approved,
				string cip_ping_times,
				string day,
				string result,
				string client,
				string middlename
			END;
		
	EXPORT layout_Impulse_Email
		:=
			RECORD, MAXLENGTH(8192) //MAXLENGTH(10155)
				string SOURCENAME,
				string EMAIL,
				string FIRSTNAME,
				string MIDDLENAME,
				string LASTNAME,
				string ADDRESS1,
				string ADDRESS2,
				string CITY,
				string STATE,
				string ZIP,
				string HOMEPHONE,
				string WORKPHONE,
				string DOB,
				string CREATED,
				string SITEID,
				string SSN,
				string CAMPAIGNID,
				string PASSTHROUGH,
				string ACCOUNTID,
				string LASTMODIFIED,
				string PROGRESSION,
				string WEBSERVER,
				string ALLOWEDREAPPLY,
				string VENDORSEQUENCE,
				string CREDITOFFERSOPTIN,
				string IPADDRESS,
				string MOTHERSMAIDEN,
				string TERMSAGREEMENT,
				string BANKRUPTCY,
				string BANKRUPTCYDISCHARGED,
				string TOTALINCOME,
				string AMERINETID,
				string INCREASECREDITLIMIT,
				string THANKYOUMAILED,
				string DECLINEREASON,
				string RECORDID,
				string STATUS,
				string FASTCASH,
				string PRIVACY,
				string OFBIRTH,
				string CONFIRM,
				string CELLPHONE,
				string NO,
				string TITLE,
				string YEAROB,
				string FRAUD,
				string DAYOB,
				string MONTHOB,
				string PAGEID,
				string CASHADVANCE,
				string HOWGETPAY,
				string BIGHIP_DBLOPT,
				string OFFEROPTIN,
				string RESIDENCE_TYPE,
				string CURRENT_ADDRESS_START,
				string LICENSE_NUM,
				string LICENSE_STATE,
				string INCOME_PAY_FREQUENCY,
				string INCOME_MONTHLY_NET,
				string INCOME_NEXTPAYDAY1,
				string INCOME_NEXTPAYDAY2,
				string INCOME_DIRECTDEPOSIT,
				string JOB_EMPLOYER,
				string JOB_HIRE_START,
				string JOB_EMPLOYER_ADDRESS1,
				string JOB_EMPLOYER_CITY,
				string JOB_EMPLOYER_STATE,
				string JOB_EMPLOYER_ZIP,
				string JOB_EMPLOYER_PHONE,
				string REFERENCE1_FIRSTNAME,
				string REFERENCE1_LASTNAME,
				string REFERENCE1_RELATION,
				string REFERENCE1_PHONE,
				string REFERENCE2_FIRSTNAME,
				string REFERENCE2_LASTNAME,
				string REFERENCE2_RELATION,
				string REFERENCE2_PHONE,
				string ACCEPTED,
				string RESPONSE,
				string URL,
				string JOB_TITLE,
				string JOB_SUPERVISOR,
				string INCOME_SOURCE,
				string CITIZEN,
				string BESTTIME,
				string TIER_ACCEPTED,
				string CALI_AGREE,
				string INCOME_NEXTPAYDAY3,
				string INCOME_NEXTPAYDAY4,
				string NATIONAL_PLATINUM_CARD,
				string MONTHLY_EXPENSES,
				string MAIN_CREDITOR_BALANCE,
				string MAIN_CREDITOR,
				string UNSECURED_DEBT,
				string OVER10000DEBT,
				string DEBT_STATUS,
				string WIRELESS,
				string SECRETCASHCARD,
				string BUYER_ID,
				string PAYOUT,
				string FEDERALSTUDENTLOANS,
				string AGREEMENT,
				string COSIGNER,
				string CREDITRATE,
				string AUTOLOAN,
				string MONTHLYHOMEPAYMENT,
				string BID,
				string ICLEANCREDIT,
				string DESCRIPTION,
				string VALIDLEAD,
				string PIN,
				string CID,
				string MOTHER,
				string IMAGINE_CARD,
				string IMAGINE_CARD_ACCEPT,
				string POST_OFFER3,
				string POST_OFFER2,
				string POST_OFFER1,
				string ITP_RETURN,
				string NOITP,
				string DAY,
				string TIME_AT_JOB,
				string TMP,
				string PROGRESS,
				string MILITARY,
				string PLASMA_TV_OFFER,
				string CONTACT_TIME,
				string RESIDENCE_TIME,
				string JOB_TIME,
				string FAX_REPOST,
				string GRANT_OFFER_ACCEPT,
				string GRANT_OFFER,
				string REQUESTED_AMOUNT,
				string TIME_AT_BANK,
				string ACCESS_OFFER,
				string ACCESS_RESPONSE,
				string TIER,
				string REDIRECTED,
				string QID_2000286,
				string QID_2000287,
				string QID_2000288,
				string QID_2000376,
				string QID_2000295,
				string QID_2000313,
				string QID_2000314,
				string COUNTRY,
				string LASHBACK_RETURN,
				string PHONE,
				string TRANSACTION_ID,
				string MORTGAGE,
				string PDLOAN,
				string SENDMECARD,
				string SME_RESPONSE,
				string REJECTEDREASON,
				string MONTHLYINCOME,
				string HOWLONGWITHEMPLOYER,
				string YOURJOB,
				string EMPLOYERNAME,
				string MONTHLYPAYMENT,
				string RENT_OR_OWN,
				string HOWLONGATHOMEADDRESS,
				string AUTHORIZECREDIT,
				string YEAR,
				string MAKE,
				string MODEL,
				string TRIMFIELD,
				string EXTERIOR,
				string INTERIOR,
				string PAY_METHOD,
				string BUY_TIME,
				string BONUS_OFFER,
				string DEALER_POST,
				string BUYER,
				string SOURCEID2,
				string APT_NUMBER,
				string CREDIT_OFFERS,
				string CALLPHONE,
				string DIRECT_DEPOSIT,
				string POST_URL,
				string LEAD,
				string REFERRER,
				string IMPID,
				string FREEOFFERS,
				string GENDER,
				string OFFER_CHOICE,
				string REDIRECT_URL,
				string POSTID,
				string REDIRECT_QA,
				string REDIRECT_URL2,
				string SOURCEID,
				string EXC,
				string BANK_NAME,
				string BANK_PHONE,
				string BANK_ABA,
				string BANK_ACCOUNT_NUM,
				string BANK_ACCOUNT_TYPE,
				string GOLDOFFER,
				string GOLDOFFERACCEPTED,
				string ACTIVECHECKING,
				string OFFERTERMS,
				string BESTTIMETOCALL,
				string CREDITPROBLEM,
				string POSTBACK,
				string UNSECUREDCARD,
				string POSTRESULT,
				string STUDENTLOANDEBT_POST,
				string STUDENTLOANDEBT,
				string POST_RESULT,
				string TOTALUNSECDEBT,
				string CREDITOR,
				string GET1500BYTOMORROW,
				string GETFREECREDITCONSUL,
				string CONSUL_POST,
				string CELLOFFER,
				string CELL_POST,
				string LOWERSCOREHELP,
				string CONSULFEE,
				string CCDEBT,
				string USDEBT,
				string LEXINGTON,
				string RETURN,
				string LEX_POST,
				string NEWWINOW_ACY,
				string PRODUCT,
				string AGREE_OFFERS_CREDIT,
				string CFE_DISCLOSURES,
				string AGREE_OFFERS_PFDE,
				string SSN4,
				string AFFORD_PAY1,
				string AFFORD_PAY2,
				string AFFORD_PAY3,
				string CC_DEBT,
				string CRED_GRADE,
				string PYMT_AGING,
				string UNSEC_DEBT,
				string REJECTREASON,
				string BALANCE,
				string AGREEGETFREEDEBT,
				string DAYSLATE,
				string BESTTIMETOCONTACT,
				string EMPLOYED,
				string CDEBT_RETURN,
				string SRLP,
				string TOTALDEBT,
				string FYC_OFFER,
				string FYC_ERROR_RESPONSE,
				string OFFER,
				string LEADS360_UNDER,
				string LEADS360_OVER,
				string FYC_RESPONSE,
				string PAYCYCLE,
				string RECEIVEPAY,
				string INCOME_MONTHLY,
				string MAIDENNAME,
				string OFFER1_RESPONSE,
				string OFFER1_STATUS,
				string PREMIER,
				string OFFER1,
				string PPSAGREEMENT,
				string CCTYPE,
				string CCNUMBER,
				string CCEXPIRE_MONTH,
				string CCEXPIRE_YEAR,
				string CCCVV,
				string CMG_SALE_PRICE,
				string REFERRING,
				string CONTIN_DUPCK_RETURN,
				string TOTLE_DUPCK_RETURN,
				string OFFER_NAME,
				string GRADE,
				string ANNUAL_INCOME,
				string MORTGAGE_PAST7YRS,
				string CARLOAN_PAST7YRS,
				string CREDITCARD_PAST7YRS,
				string LAMONT3_HEALTH,
				string LAMONT2_GOLD,
				string LAMONT1_DEBT,
				string COMPLETED,
				string EMPLOYMENT,
				string HAVECHECKING,
				string VALIDSSN,
				string DEBTCONSOLIDATION,
				string UNSECUREDDEBT,
				string OWNORRENT,
				string MONTHSBEHIND,
				string CONTACTTIME,
				string MORTGAGEQUOTE,
				string RATEYOURCREDIT,
				string BANKRUPTCYDISCHARGEDLENGTH,
				string HOMEOWNER,
				string CONTACTPHONE,
				string MORTGAGEAMOUNT,
				string PROPERTYVALUE,
				string DESIREDLOANAMOUNT,
				string CURRENTRATE,
				string HOMELOAN_CONTACTTIME,
				string YEAROFHOUSEPURCHASE,
				string WORK,
				string DISCOUNTEINFO,
				string LOWERINTERESTRATE,
				string FREECONSOLIDATION,
				string LID,
				string WIRELESSOFFEROPTIN,
				string CA_RETURN,
				string OVER18,
				string ITP,
				string CWS_RETURN,
				string ZIP_PLUS,
				string MOBILE_CARRIER,
				string MOBILE_OTHER,
				string ACCEPTDEBIT,
				string NWC_SELECT,
				string OFFEROPTIN2,
				string TERMSAGREE,
				string AGREETOPOLICY,
				string SSN3,
				string SSN2,
				string SSN1,
				string FC_POST_OK,
				string BONUSOFFER,
				string RESIDENCE_YEAR,
				string RESIDENCE_MONTH,
				string JOB_HIRE_YEAR,
				string JOB_HIRE_MONTH,
				string ADDRESSID,
				string AFFILIATEPROGRAM,
				string AGEGROUP,
				string BUSINESSPURPOSE,
				string CURRENTNODE,
				string DESIREDINCOME,
				string DESIREDTIME,
				string EMPLOYMENTLENGTH,
				string FRIEND1,
				string FRIEND2,
				string FRIEND3,
				string FRIEND4,
				string HAVESPOUSE,
				string HOURSTOWORK,
				string INITIALNODE,
				string LENGTHATRESIDENCE,
				string PREVIOUSNODE,
				string RECEIVEDRESULTS,
				string ROOMNUMBER,
				string TIMEAVAILABLE,
				string PROGRAM,
				string WSTATE,
				string WZIP,
				string PHONE1,
				string PHONE2,
				string PHONE3,
				string NPHONE1,
				string NPHONE2,
				string NPHONE3,
				string RETURN_MESSAGE,
				string ERRORFLAG,
				string MONTHSALARY,
				string HOWMUCHCANSPEND,
				string WORKDOING,
				string REASONTOSTART,
				string BATCHED,
				string BBTIMEZONE,
				string Q001,
				string Q002,
				string Q003,
				string Q004,
				string Q005,
				string Q006,
				string SUBMISSIONID,
				string WORKPHONE_EXT,
				string PAYPERIOD,
				string NEXTPAY,
				string SECPAY,
				string ISUSRESIDENT,
				string EMPLOYER,
				string YEARSATJOB,
				string MONTHSATJOB,
				string RESIDENTIAL,
				string EMPLOYERADDRESS,
				string EMPLOYERCITY,
				string EMPLOYERSTATE,
				string EMPLOYERZIP,
				string EMPLOYERPHONE,
				string SUPERVISORNAME,
				string YEARLYINCOME,
				string REFERENCE1NAME,
				string REFERENCE1PHONE,
				string REFERENCE1RELATION,
				string REFERENCE2NAME,
				string REFERENCE2PHONE,
				string REFERENCE2RELATION,
				string HASDEBT,
				string SWITCHED2APP,
				string POST_STATUS,
				string APP_,
				string ALTERNATEPHONE,
				string AMOUNTOWED,
				string HOME,
				string FREEMORTGAGEQUOTE,
				string CREDITRATING,
				string GROSSMONTHLYINCOME,
				string BANKRUPTCYDISCHARGE,
				string BANKRUPTCYDISCHARGEDURATION,
				string CREDITATTORNEY,
				string FUNNYOFFER,
				string NUMBEROFCREDITORS,
				string PROPERTYTYPE,
				string LOANTYPE,
				string LOANREQUESTED,
				string SAVE50ONPHONEBILL,
				string AGREECONTACT,
				string CONNECTIONTYPE,
				string VONAGE_RETURN,
				string LAMONT1,
				string LAMONT2,
				string POSTCODE,
				string HOMEPHONE2,
				string HOMEPHONE1,
				string CNTY,
				string ALTERPHONE,
				string VALIDWIRELESSLEAD,
				string POSTWIRELESS,
				string ZZ,
				string SUBMITPOP_URL,
				string POPUNDER_URL,
				string TERMS,
				string CHECK_RESPONDED,
				string PAYMENTMETHOD,
				string EBAY,
				string EBAY_MSG,
				string CA_POST_OK,
				string AGREE_SPRINT_TERMS,
				string AGREE_TERMS_PRIVACY,
				string FREE_RAZOR_NUMBER,
				string RAZR_POSTED,
				string ACSVERIFICATIONID,
				string XID,
				string ECICODE,
				string REASONCODE,
				string EBAYSTATUS,
				string PAGE,
				string CONSUMER_DIRECT,
				string EGG_RETURN,
				string ITP_OFFER,
				string CUST_DIRECT_RETURN,
				string DB_ID_NUMBER,
				string PROC_STAT,
				string PROCID,
				string ZZ_RETURN,
				string ZZMDS_RETURN,
				string MERIT_RETURN,
				string MERIT_STATUS,
				string MERIT_RESPONSE,
				string PWLSS_RETURN,
				string COVERAGE,
				string REDIR_ID,
				string YRSATEMPLOYER,
				string MOSATEMPLOYER,
				string YRSATADDRESS,
				string MOSATADDRESS,
				string RENTOWN,
				string RENTPAYMENT,
				string OTHERINCOME,
				string OTHERINCOMEAMT,
				string EMP,
				string CREDITCHECK,
				string COSIGNER_AVAILABLE,
				string DECLARED_BANKRUPTCY,
				string MONTHLY_RENT,
				string INCOME_MONTHLY_GROSS,
				string JOB_EMPLOYER2,
				string TOCALL,
				string RESIDENCESINCE,
				string EMPLOYEDSINCE,
				string DEP_ACCOUNT,
				string HOW_OFTEN,
				string ACCEPT_IMAGINE,
				string CHECKBOX3,
				string BANKPRIVACY,
				string NETSALARY,
				string NAME,
				string DOB1,
				string PREVIOUSZIP,
				string PREVIOUSSTATE,
				string PREVIOUSCITY,
				string PREVIOUSADDRESS2,
				string PREVIOUSADDRESS1,
				string TIMEATRESIDENCE,
				string TENNIS_BRACELET_OFFER,
				string USEDEFAULT,
				string VIP_OFFER_ACCEPT,
				string VIP_OFFER,
				string ONGAURD,
				string NETSPEND,
				string CC,
				string CMG,
				string CMG_RESPONSE,
				string ESPANOL,
				string LASTCHANGED,
				string PIN_NUM,
				string AGREETERMS,
				string RUSHPROCESSING,
				string EXPORTFIELD,
				string CURL_RETURN,
				string RET,
				string MAIDEN_NAME,
				string IDENTITY_STATUS,
				string NAME_ON_ACCOUNT,
				string CREDIT,
				string REPORT,
				string CASH,
				string TERMS2,
				string DEBT_ACCEPT,
				string DEBT,
				string DEBT_REJECT,
				string CC_NAME,
				string CC_NUMBER,
				string CC_TYPE,
				string CC_VERIFICATION,
				string CC_MONTH,
				string CC_YEAR,
				string TITANIUM_SKIP,
				string REWARDS_RESPONSE,
				string MOGUL,
				string MOGUL_RETURN,
				string NOMOGUL,
				string DRIVERSLICENSE,
				string WORKEXT,
				string HOME_TIME,
				string HOME_TYPE,
				string PAYFREQUENCY,
				string EMPLOYMENTPOSITION,
				string NETINCOME,
				string LASTPAYDATE_Y,
				string LASTPAYDATE_M,
				string LASTPAYDATE_D,
				string NEXTPAYDATE_Y,
				string NEXTPAYDATE_M,
				string NEXTPAYDATE_D,
				string DIRECTDEPOSIT,
				string REFERENCE1FIRSTNAME,
				string REFERENCE2FIRSTNAME,
				string REFERENCE1LASTNAME,
				string REFERENCE2LASTNAME,
				string REFERENCE1RELATIONSHIP,
				string REFERENCE2RELATIONSHIP,
				string CHKMCS,
				string CHKIAGREE,
				string HOME_MONTHS,
				string HOME_YEARS,
				string PAYDATE3_YEAR,
				string PAYDATE3_DAY,
				string PAYDATE3_MONTH,
				string PAYDATE2_YEAR,
				string PAYDATE2_DAY,
				string PAYDATE2_MONTH,
				string SUPERVISOR,
				string INCOMETYPE,
				string HIRED_DAY,
				string HIRED_MONTH,
				string HIRED_YEAR,
				string DUPCHECK_OK,
				string IERMSAGREEMENT,
				string PW_RETURN,
				string PREMIER_PIXEL_FIRE,
				string PREMIER_URL,
				string OPTINBOX,
				string SESSIONID,
				string MARKETERID,
				string HITID,
				string SHIPPING,
				string COAPP_FIRSTNAME,
				string AMOUNT,
				string COAPP_LASTNAME,
				string COAPP_YEAROB,
				string COAPP_MONTHOB,
				string COAPP_DAYOB,
				string COAPP_SSN,
				string OFFER__POST,
				string REJECT_REASON,
				string ACCOUNT_ABA,
				string ACCOUNT_NUMBER,
				string CARDTYPE,
				string FREEPHONECONSULT,
				string OFFER_CELLPHONE,
				string LEADID,
				string PASSWORD,
				string CUSTOMERID,
				string SALEID,
				string UPSELL,
				string PROGRAM_ID,
				string SHIPADDRESS1,
				string SHIPADDRESS2,
				string SHIPCITY,
				string SHIPSTATE,
				string SHIPZIP,
				string USEASSHIPADDR,
				string KRAFTBLOCK,
				string ATTEMPTS,
				string VERIFICATION,
				string AMERINETVALIDATED,
				string AMERINETREJECTED,
				string REJECTCODE,
				string CANCELLED,
				string LASTREBILLED,
				string SUBSCRIPTIONID,
				string CHECKVALIDATED,
				string RESPONSECODE,
				string FREEMOTOMP3,
				string PAYMENT,
				string CURRENTLY_EMPLOYED,
				string MAKE_1200_PER_MONTH,
				string US_CITIZEN,
				string PANHANDLER,
				string BEST_CALL_TIME,
				string WORK_STATUS,
				string REDIR_LINK,
				string HAS_CHECKING_ACCOUNT,
				string NO_ITP,
				string EXT_WORK,
				string SSNLAST4,
				string PREVZIP,
				string PREVSTATE,
				string PREVCITY,
				string PREVADDRESS1,
				string PREVADDRESS2,
				string MOTHERS_MADIEN_NAME,
				string IGCFEE,
				string IGCACCEPT,
				string IMAGINEGOLD,
				string CR_POST_OK,
				string CREDITREPAIR,
				string CREDITISSUE,
				string DAYPHONE,
				string NOCELLPHONE,
				string POSTLEADS,
				string FREECELLMP3,
				string PM3_RETURN,
				string LICENSE,
				string ACCOUNTNOW_RETURN,
				string POSTED_URL,
				string FREECB,
				string GIFTCARD,
				string EMPLOYER_NAME,
				string ACCEPT_SUPERIOR,
				string FA_POST_OK,
				string OUTSCHOOL_GRADUATE6M,
				string LOANSINDEFAULT,
				string IMAGINE_ERROR,
				string EPCARD_RETURN,
				string VACLEADS,
				string CELLLEADS,
				string DEBTLEADS,
				string TERMSAGREEMENT2,
				string APPPASSWORD,
				string CELL_POST_OK,
				string DEBT_POST_OK,
				string PAST_DUE,
				string EMPLOYEED,
				string CREDIT_CARD_DEBT,
				string VAC_POST_OK,
				string CONFIRM_PASSWORD,
				string CELL_STEP_1_2_OK,
				string PCB_RETURN,
				string CELL_STEP_3_OK,
				string CONFIRM_PASSWORD_BAD,
				string CALEADS,
				string FALEADS,
				string BESTTIME_CALL,
				string AUTHORIZE_AGREE,
				string AGREE_IMAGINE,
				string APPLYIMAGINE,
				string CREDITBUILDER,
				string OFFER_DIRECT_DEPOSIT,
				string REQUEST_IMAGINE,
				string BPPAGREEMENT,
				string PRE_ZIP,
				string PRE_STATE,
				string PRE_CITY,
				string PRE_ADDRESS2,
				string PRE_ADDRESS1,
				string HOWLONGLIVEADDR,
				string IGC_POST,
				string IGC_POST_OK,
				string TIME_AT_RESIDENCE,
				string OFFER_MP3,
				string MP3,
				string CONTINENTAL,
				string PVC_DEAL_ACCEPT,
				string PVC_DEAL,
				string SUFIX,
				string SUFFIX,
				string POST_MCC_100,
				string MY_COMPUTER_CLUB_ACCEPT,
				string MY_COMPUTER_CLUB,
				string ITPPAGREEMENT,
				string CARRIER,
				string VCODE,
				string FREEVI660MP3,
				string SELECT_6827,
				string SELECT_6821,
				string SELECT_6828,
				string SELECT_6832,
				string GETVACATIONINFO,
				string FREEDEBT,
				string FREEWEBSITE,
				string DESTINATION,
				string SEASON,
				string GETCASHADV1500,
				string MAKE1500MORE,
				string PAYDIRECTDEPOSIT,
				string OUTSTANDINGLOAN,
				string CASH_RETURN,
				string FV_RETURN,
				string EBAY_RETURN,
				string CAOFFERSOPTIN,
				string FVOFFEROPTIN,
				string VONAGEOFFERSOPTIN,
				string TRIED_OTHER_DIETS,
				string DIETCOACH,
				string AMOUNT_WILLING_TO_SPEND,
				string AL_POST_OK,
				string RESIDENCEMONTHLYPAYMENT,
				string NEEDACARLOAN,
				string OWNRENTHOME,
				string OCCUPATION,
				string YEARSEMPLOYED,
				string MONTHSEMPLOYED,
				string YEARSATRESIDENCE,
				string MONTHSATRESIDENCE,
				string VERIPHONE,
				string COUNSELOR,
				string DROPOFFERS,
				string GRADLOAN_CONFIRM,
				string GRADLOAN_DEGREE,
				string GRADLOAN_DEFAULTLOAN,
				string REDUCEMSLPAY,
				string GRADLOAN_HAVELOAN,
				string GL_POST_OK,
				string CREDITREPAIR_POST,
				string BUSINESS_NAME,
				string BUSINESS_CREDIT,
				string BUSINESS_YEARS,
				string BUSINESS_REVENUE,
				string UNSECURED,
				string STUDENT_LOAN_RECENT,
				string LOANS_IN_DEFAULT,
				string GRADUATED_NEXT_6MS,
				string LOANS_10000_MORE,
				string OF_POST_OK,
				string HAVE_STUDENT_LOAN,
				string GLL_POST_OK,
				string EVENINGPHONE,
				string CREDIT_RATING,
				string LOAN_AMOUNT,
				string PROPERTY_TYPE,
				string LOAN_PURPOSE,
				string GREENLIGHT_LOAN,
				string AGREE_TERMS_PPS,
				string DEBT_AMOUNT,
				string GETDEGREEONLINE,
				string INTERESTEDAREA,
				string EDU_RETURN,
				string WIRELESS_RETURN,
				string FREEC290MP3,
				string SECRETCASH,
				string QUESTIONFULLTIME,
				string QUESTIONDEFAULT,
				string ACCOUNT_TYPE,
				string ACTIVE,
				string CANCELDATE,
				string NOTES,
				string UPSELLRES,
				string SENTREBILL,
				string ORIG_CUSTID,
				string FULFILLED,
				string FULFILLED_DATE,
				string VACATIONINFO,
				string INCOME,
				string STUDENTLOAN,
				string ALT_EMAIL,
				string NEEDED_MONEY,
				string MONTHS_AT_ADDRESS,
				string DRIVER_LICENSE_ID,
				string DRIVER_LICENSE_,
				string MONTHS_EMPLOYED,
				string INCOME_TYPE,
				string HOW_OFTEN_BE_PAID,
				string HOW_GET_CHECK,
				string AMOUNT_LAST_CHECK,
				string MONTHLY_INCOME,
				string PAYDATE1,
				string PAYDATE2,
				string MONTHS_AT_BANK,
				string SENDMEOFFERS,
				string DECLINED_REASON,
				string YOURJOBTITLE,
				string SCRAPED,
				string SNIPPED,
				string KEY,
				string WORKSTATE,
				string CITYOFBIRTH,
				string SECPAY2,
				string BANKRUPTCYDISCHARGESTATUS,
				string BANKRUPTCYSTATUS,
				string EMPLOYMENTSTATUS,
				string HOMESTATUS,
				string EMPTITLE,
				string MOTHERSMAIDENNAME,
				string RESIDENTIALSTATUS,
				string LICENSESTATE,
				string OFFER_CELLPHONE_POST,
				string GET1500IN24HR,
				string DRIVERSLICENSENUMBER,
				string DRIVERSLICENSESTATE,
				string PAYMENTSTATUS,
				string DRIVER_LICENSE_STATE,
				string JOB_EMPLOYER1,
				string LEAD360,
				string CARD,
				string POST,
				string TYPEOFPHONE,
				string REFERRINGSITEID,
				//Additional fields included in new layout
				string CAR_TRIM,
				string CREDIT_SCORE,
				string PING_ID,
				string SERVER_ADDR,
				string OFFER2,
				string OFFER3,
				string OFFER4,
				string OFFER5,
				string IDT_RESPONSE,
				string IMG_TERMS,
				string REDIR_URL,
				string SALE,
				string STATE_EXCLUSION,
				string CIP_TRANSACTION_ID,
				string CUSTOMER_ACCT_NUM,
				string CIP_RESPONSE,
				string BRNV_RESPONSE,
				string UC_RESPONSE,
				string OFFER_APPROVED,
				string CIP_PING_TIMES,
				string RESULT,
				string CLIENT
			END;
			
	EXPORT layout_Impulse_Email_Dates
		:=
			RECORD
				string8	 	version_date,
				string8	 	file_date,
				unsigned4	DateVendorFirstReported,
				unsigned4	DateVendorLastReported
			END;
			
	EXPORT layout_Impulse_Email_Dates_append
		:=
			RECORD, MAXLENGTH(8192)
				layout_Impulse_Email_Dates,
				layout_Impulse_Email,
				AID.Common.xAID	RawAID
			END;
			
	EXPORT layout_Impulse_Email_cleaner_input
		:=
			RECORD
				string		FIRSTNAME,
				string		MIDDLENAME,
				string		LASTNAME,
				string		SSN,
				string 		DOB,
				string		HOMEPHONE,
				string		ADDRESS1,
				string		ADDRESS2,
				string		CITY,
				string		STATE,
				string		ZIP
			END;
			
	EXPORT layout_Impulse_Email_Prepped_DID_AID
		:=
			RECORD
				AID.Common.xAID	RawAID,
				string		Append_Prep_Address1,
				string		Append_Prep_Address_Last,
				// AID.Common.xAID	AID,
				string10	cln_PRIM_RANGE,
				string28	cln_PRIM_NAME,
				string8		cln_SEC_RANGE,
				string2		cln_ST,
				string5		cln_ZIP,
				string78	clean_name,				
				integer8	DID,
				integer8	DID_Score,
				string20	cln_FNAME,
				string20	cln_MNAME,
				string20	cln_LNAME,
				string5		cln_NAME_SUFFIX
			END;
			
	EXPORT layout_Impulse_Email_In
		:=
			RECORD, MAXLENGTH(8192)
				unsigned6 append_seqNum,
				string8	 	version_date,
				string8	 	file_date,
				unsigned4	DateVendorFirstReported,
				unsigned4	DateVendorLastReported,
				layout_Impulse_Email
			END;
			
	EXPORT layout_Impulse_Email_Slim_AID
		:=
			RECORD
				unsigned6 append_seqNum,
				string		FIRSTNAME,
				string		MIDDLENAME,
				string		LASTNAME,
				string		SSN,
				string 		DOB,
				string		HOMEPHONE,
				string		ADDRESS1,
				string		ADDRESS2,
				string		CITY,
				string		STATE,
				string		ZIP
			END;
			
	EXPORT layout_Impulse_Email_AID_Slim_Prepped
		:=
			RECORD
				AID.Common.xAID	RawAID,
				string		Append_Prep_Address1,
				string		Append_Prep_Address_Last,
				layout_Impulse_Email_Slim_AID
			END;

	EXPORT layout_Impulse_Email_AID_Parsed
		:=
			RECORD
				// AID.Common.xAID	RawAID,			
				string10 	prim_range,
				string2 	predir,
				string28 	prim_name,
				string4 	addr_suffix,
				string2 	postdir,
				string10 	unit_desig,
				string8 	sec_range,
				string25 	p_city_name,
				string25 	v_city_name,
				string2 	st,
				string5 	zip5,
				string4 	zip4,
				string4 	cart,
				string1 	cr_sort_sz,
				string4 	lot,
				string1 	lot_order,
				string2 	dbpc,
				string1 	chk_digit,
				string2 	rec_type,
				string5 	county,
				string10 	geo_lat,
				string11 	geo_long,
				string4 	msa,
				string7 	geo_blk,
				string1 	geo_match,
				string4 	err_stat,
				string78	clean_name,
				layout_Impulse_Email_AID_Slim_Prepped
			END;

	EXPORT layout_Impulse_Email_DID_Prepped
		:=
			RECORD
				integer8	DID,
				integer8	DID_Score,
				string20	cln_FNAME,
				string20	cln_MNAME,
				string20	cln_LNAME,
				string5		cln_NAME_SUFFIX,
				layout_Impulse_Email_AID_Parsed
			END;

	EXPORT layout_Impulse_Email_DID_cln_parsed
		:=
			RECORD, MAXLENGTH(8192)
				integer8	DID,
				integer8	DID_Score,
				string20	cln_FNAME,
				string20	cln_MNAME,
				string20	cln_LNAME,
				string5		cln_NAME_SUFFIX,
				layout_Impulse_Email_In
			END;
			
	EXPORT layout_Impulse_Email_final
		:=
			RECORD, MAXLENGTH(8192)
				integer8	DID,
				integer8	DID_Score,
				string1		RECORD_TYPE,
				string20	cln_FNAME,
				string20	cln_MNAME,
				string20	cln_LNAME,
				string5		cln_NAME_SUFFIX,
				AID.Common.xAID RawAID,
				string10 	prim_range,
				string2 	predir,
				string28 	prim_name,
				string4 	addr_suffix,
				string2 	postdir,
				string10 	unit_desig,
				string8 	sec_range,
				string25 	p_city_name,
				string25 	v_city_name,
				string2 	st,
				string5 	zip5,
				string4 	zip4,
				string4 	cart,
				string1 	cr_sort_sz,
				string4 	lot,
				string1 	lot_order,
				string2 	dbpc,
				string1 	chk_digit,
				string2 	rec_type,
				string5 	county,
				string10 	geo_lat,
				string11 	geo_long,
				string4 	msa,
				string7 	geo_blk,
				string1 	geo_match,
				string4 	err_stat,
				string9		ln_SSN,
				string8		ln_DOB,
				integer		ln_ANNUALINCOME,
				layout_Impulse_Email_In,
				string2   source := '',
				//Added for CCPA-108 
				unsigned4 global_sid;
				unsigned8 record_sid;
			END;
		
		EXPORT layout_Impulse_Email_Did_Key
			:=
				RECORD, MAXLENGTH(15000)
					integer8	DID,
					integer8	DID_Score,
					string20	cln_FNAME,
					string20	cln_MNAME,
					string20	cln_LNAME,
					string5		cln_NAME_SUFFIX,
					//Changed aid field to match previous to avoid key mismatch, this should be changed with the next Roxie release
					// AID.Common.xAID	RawAID,
					unsigned4	AID;
					// string10 	prim_range,
					// string2 	predir,
					// string28 	prim_name,
					// string4 	addr_suffix,
					// string2 	postdir,
					// string10 	unit_desig,
					// string8 	sec_range,
					// string25 	p_city_name,
					// string25 	v_city_name,
					// string2 	st,
					// string5 	zip5,
					// string4 	zip4,
					// string4 	cart,
					// string1 	cr_sort_sz,
					// string4 	lot,
					// string1 	lot_order,
					// string2 	dbpc,
					// string1 	chk_digit,
					// string2 	rec_type,
					// string5 	county,
					// string10 	geo_lat,
					// string11 	geo_long,
					// string4 	msa,
					// string7 	geo_blk,
					// string1 	geo_match,
					// string4 	err_stat,
					string10	cln_PRIM_RANGE,
					string28	cln_PRIM_NAME,
					string8		cln_SEC_RANGE,
					string2		cln_ST,
					string5		cln_ZIP,
					string9		ln_SSN,
					string8		ln_DOB,
					integer		ln_ANNUALINCOME,
					string6	 ProcessDate,
					unsigned3	DateVendorFirstReported,
					unsigned3	DateVendorLastReported,
					string SOURCENAME,
					string EMAIL,
					string FIRSTNAME,
					string MIDDLENAME,
					string LASTNAME,
					string ADDRESS1,
					string ADDRESS2,
					string CITY,
					string STATE,
					string ZIP,
					string HOMEPHONE,
					string DOB,
					string CREATED,
					string SITEID,
					string SSN,
					string CAMPAIGNID,
					string LASTMODIFIED,
					string IPADDRESS,
					string TOTALINCOME,
					string CELLPHONE,
					string YEAROB,
					string FRAUD,
					string DAYOB,
					string MONTHOB,
					string BIGHIP_DBLOPT,
					string LICENSE_NUM,
					string LICENSE_STATE,
					string INCOME_MONTHLY_NET,
					string INCOME_DIRECTDEPOSIT,
					string REJECTEDREASON,
					string INCOME_MONTHLY,
					string ANNUAL_INCOME,
					string ERRORFLAG,
					string MONTHSALARY,
					string GROSSMONTHLYINCOME,
					string KRAFTBLOCK,
					string SCRAPED,
					string2 SOURCE := '';
					//Added for CCPA-108
					unsigned4 global_sid;
					unsigned8 record_sid;
				END;
		
END;