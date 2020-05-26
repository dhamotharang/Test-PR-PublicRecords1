	
Import data_services,doxie;
	nvprec := RECORD
		string name;
		string value;
		END;

	r:=RECORD
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
		unsigned8 __internal_fpos__;
	 END;

	d	:=dataset([],r);

	EXPORT Key_entityprofile	:= Index(d,{customerid,industrytype,entitycontextuid},{d},
																										 data_services.Data_location.Prefix('FraudGov') + 'thor_data400::key::fraudgov::' 
																										 + doxie.Version_SuperKey +'::kel::entityprofile');

