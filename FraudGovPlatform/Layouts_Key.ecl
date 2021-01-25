﻿EXPORT Layouts_Key := MODULE 

	shared flagsrec := RECORD
		string indicator;
		string value;
  END;

	EXPORT Cluster_Exp1_	:= RECORD
		string entity_context_uid_;
		unsigned1 __entity_context_uid__flags;
		unsigned2 date_first_seen_;
		unsigned2 date_last_seen_;
		integer8 __recordcount;
	END;
	
	EXPORT ClusterDetails	:=	RECORD
		integer8 customer_id_;
		integer8 industry_type_;
		string100 entity_context_uid_;
		string100 tree_uid_;
		unsigned8 source_customer_;
		unsigned1 __source_customer__flags;
		unsigned1 __customer_id__flags;
		unsigned1 __industry_type__flags;
		unsigned1 __tree_uid__flags;
		unsigned1 __entity_context_uid__flags;
		unsigned2 date_first_seen_;
		unsigned2 date_last_seen_;
		integer8 __recordcount;
		integer8 entity_type_;
		string label_;
		unsigned1 __label__flags;
		integer8 score_;
		unsigned1 __score__flags;
		integer8 cluster_score_;
		unsigned1 __cluster_score__flags;
		integer8 cl_event_count_;
		integer8 cl_identity_count_;
		integer8 cl_address_count_;
		integer8 deceased_match_;
		integer8 death_prior_to_all_events_;
		integer8 nas9_flag_;
		integer8 nap3_flag_;
		DATASET(RECORD
		 string entity_context_uid_;
		 unsigned1 __entity_context_uid__flags;
		 unsigned2 date_first_seen_;
		 unsigned2 date_last_seen_;
		 integer8 __recordcount;
		END) exp1_;
		unsigned1 __exp1__flags;
		real8 latitude_;
		unsigned1 __latitude__flags;
		real8 longitude_;
		unsigned1 __longitude__flags;
		string street_address_;
		unsigned1 __street_address__flags;
		string vanity_city_;
		unsigned1 __vanity_city__flags;
		string state_;
		unsigned1 __state__flags;
		integer8 zip_;
		unsigned1 __zip__flags;
		integer8 person_count_;
		integer8 high_frequency_flag_;
		integer8 high_risk_death_prior_to_all_events_percent_flag_;
		integer8 all_high_risk_death_prior_to_all_events_person_percent_flag_;
		integer8 deceased_person_count_;
		DATASET(flagsrec) flags;
	END; 

	EXPORT ElementPivot	:= RECORD
		integer8 customer_id_;
		integer8 industry_type_;
		string100 entity_context_uid_;
		unsigned8 entityhash;
		string field;
		string200 value;
		string indicatortype;
		string indicatordescription;
		string label;
		string fieldtype;
		unsigned8 risklevel;
		integer8 recs;
	END;
	
	EXPORT ScoreBreakdown	:= RECORD
		integer8 customer_id_;
		integer8 industry_type_;
		string100 entity_context_uid_;
		string indicatortype;
		string indicatordescription;
		integer8 risklevel;
		string populationtype;
		integer8 value;
	END;
	
	EXPORT WeightingChart	:= RECORD
		string200 field;
		integer8 entitytype;
		string value;
		decimal64_32 low;
		decimal64_32 high;
		integer8 risklevel;
		integer8 weight;
		string uidescription;
	END;
	
	shared nvprec := RECORD
   string name;
   string value;
  END;

	EXPORT EntityProfile	:=RECORD
  integer8 customerid;
  integer8 industrytype;
  string100 entitycontextuid;
  integer1 entitytype;
  integer8 recordid;
  unsigned4 eventdate;
  string caseid;
  string label;
  integer1 riskindx;
  integer1 aotkractflagev;
  integer1 aotsafeactflagev;
  integer1 aotcurrprofflag;
  integer8 t_personuidecho;
  string t_inpclnfirstnmecho;
  string t_inpclnlastnmecho;
  string t_inpclnssnecho;
  integer8 t_inpclndobecho;
  string t_inpclnaddrprimrangeecho;
  string t_inpclnaddrpredirecho;
  string t_inpclnaddrprimnmecho;
  string t_inpclnaddrsuffixecho;
  string t_inpclnaddrpostdirecho;
  string t_inpclnaddrunitdesigecho;
  string t_inpclnaddrsecrangeecho;
  string t_inpclnaddrcityecho;
  string t_inpclnaddrstecho;
  string t_inpclnaddrzip5echo;
  string t_inpclnipaddrecho;
  string t18_ipaddrispnm;
  string t18_ipaddrcountry;
  string t_inpclnphnecho;
  string t_inpclnemailecho;
  string t19_bnkacctbnknm;
  string t_inpclnbnkacctecho;
  string t_inpclnbnkacctrtgecho;
  string t_inpclndlstecho;
  string t_inpclndlecho;
  unsigned8 event30count;
  unsigned8 eventcount;
  integer8 personeventcount;
  string100 deviceid;
  DATASET(nvprec) nvp;
 END;

 EXPORT ConfigAttributes := Record
  integer8 entitytype;
  string200 field; 
  string250 value; 
  decimal low;
  decimal high; 
  integer risklevel; 
  string indicatortype;
  string indicatordescription;
  integer weight; 
  string uidescription;
  unsigned customerid;
  unsigned industrytype;
 END;

 EXPORT ConfigRules := Record
  unsigned8 customerid;
  unsigned8 industrytype;
  integer1 entitytype;
  string100 rulename;
  string description;
  string200 field;
  string value;
  decimal low;
  decimal high;
  integer8 risklevel;
 END;

 EXPORT DisposableEmailDomains := Record
  string200 DisposableEmailDomain;
 END;
END;