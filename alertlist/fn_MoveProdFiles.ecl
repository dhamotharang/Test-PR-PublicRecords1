Import ut, _control, business_header, sna;

/* This attribute monitors Prod Boca Thor for new Business Contacts and SNA Person Cluster files to bring over to the SNA thor. These files are used for Alert List. */

#WORKUNIT('name','SNA Person Cluster and Attributes, and Business Contacts File Monitor');

/* EXAMPLE foreign::10.241.20.205::thor_data400::base::business_header::20130125::contacts */
/* foreign::10.241.20.205::thor_data400::key::sna::20130201::person_cluster */
/* 'thor_data400::BASE::Business_Contacts' */

Current_Business_Contacts := fileservices.superfilecontents('~thordev_socialthor_50::base::Business_Contacts')[1].name;
Current_Business_Contacts_Version := Current_Business_Contacts[stringlib.stringfind(Current_Business_Contacts, '::', 3) + 2..stringlib.stringfind(Current_Business_Contacts, '::', 4)-1];

Prod_Business_Contacts1 := fileservices.superfilecontents(ut.foreign_prod + 'thor_data400::BASE::Business_Contacts')[1].name;// : RECOVERY(FailedRecoveryMessage,5);
Prod_Business_Contacts2 := fileservices.superfilecontents(ut.foreign_prod + Prod_Business_Contacts1[stringlib.stringfind(Prod_Business_Contacts1, '::', 2) + 2..])[1].name;
	Business_Contacts1_IsSuper := fileservices.LogicalFileList(Prod_Business_Contacts1[stringlib.stringfind(Prod_Business_Contacts1, '::', 2) + 2..],true,true,,_control.IPAddress.prod_thor_dali)[1].superfile;
	Prod_Business_Contacts := map(Business_Contacts1_IsSuper => Prod_Business_Contacts2, Prod_Business_Contacts1);
Prod_Business_Contacts_Version := Prod_Business_Contacts[stringlib.stringfind(Prod_Business_Contacts, '::', 5) + 2..stringlib.stringfind(Prod_Business_Contacts, '::', 6)-1];

Business_Contacts_Needed := Prod_Business_Contacts_Version <> Current_Business_Contacts_Version;

///////////////////////////////////////////////

Current_SNA_Person_Cluster := fileservices.superfilecontents('~thordev_socialthor_50::out::sna::person_cluster_qa')[1].name;
Current_SNA_Person_Cluster_Version := Current_SNA_Person_Cluster[stringlib.stringfind(Current_SNA_Person_Cluster, '::', 3) + 2..stringlib.stringfind(Current_SNA_Person_Cluster, '::', 4)-1];

Prod_SNA_Person_Cluster := fileservices.superfilecontents(ut.foreign_prod + 'thor_data400::key::sna::person_cluster_qa')[1].name;
Prod_SNA_Person_Cluster_Version := Prod_SNA_Person_Cluster[stringlib.stringfind(Prod_SNA_Person_Cluster, '::', 5) + 2..stringlib.stringfind(Prod_SNA_Person_Cluster, '::', 6)-1];

SNA_Person_Cluster_Needed := Prod_SNA_Person_Cluster_Version <> Current_SNA_Person_Cluster_Version;

///////////////////////////////////////////////

Current_SNA_Person_Cluster_Attr := fileservices.superfilecontents('~thordev_socialthor_50::out::sna::person_cluster_attributes_qa')[1].name;
Current_SNA_Person_Cluster_Attr_Version := Current_SNA_Person_Cluster_Attr[stringlib.stringfind(Current_SNA_Person_Cluster_Attr, '::', 3) + 2..stringlib.stringfind(Current_SNA_Person_Cluster_Attr, '::', 4)-1];

Prod_SNA_Person_Cluster_Attr := fileservices.superfilecontents(ut.foreign_prod + 'thor_data400::key::sna::person_cluster_attributes_qa')[1].name;
Prod_SNA_Person_Cluster_Attr_Version := Prod_SNA_Person_Cluster_Attr[stringlib.stringfind(Prod_SNA_Person_Cluster_Attr, '::', 5) + 2..stringlib.stringfind(Prod_SNA_Person_Cluster_Attr, '::', 6)-1];

SNA_Person_Cluster_Attr_Needed := Prod_SNA_Person_Cluster_Attr_Version <> Current_SNA_Person_Cluster_Attr_Version;

///////////////////////////////////////////////

Business_Header_Prod_File := DISTRIBUTE(Business_Header.File_Business_Contacts(bdid > 0), HASH(bdid)) + DISTRIBUTE(Business_Header.File_Business_Contacts(bdid = 0), HASH(did));
SNA_Person_Cluster_Prod_File := DISTRIBUTE(SNA.Key_Person_Cluster, HASH(associated_did));
SNA_Person_Cluster_Attr_Prod_File := DISTRIBUTE(SNA.Key_Person_Cluster_Attributes, HASH(cluster_id));

EXPORT fn_MoveProdFiles := PARALLEL(

	IF(Business_Contacts_Needed,
			SEQUENTIAL(
				OUTPUT('Business Contacts: Current Version - ' + Current_Business_Contacts_Version + ' to New Version - ' + Prod_Business_Contacts_Version);
				OUTPUT(Business_Header_Prod_File,,Prod_Business_Contacts[stringlib.stringfind(Prod_Business_Contacts, '::', 3) + 2..], overwrite, __Compressed__);
				fileservices.promotesuperfilelist(['~thordev_socialthor_50::base::Business_Contacts'], Prod_Business_Contacts[stringlib.stringfind(Prod_Business_Contacts, '::', 3) + 2..], true)
				),
			OUTPUT('Business Contacts: Current Version - ' + Current_Business_Contacts_Version + ' is the same as New Version - ' + Current_Business_Contacts_Version)
		);
				
	IF(SNA_Person_Cluster_Needed,
			SEQUENTIAL(
				OUTPUT('SNA Person Cluster: Current Version - ' + Current_SNA_Person_Cluster_Version + ' to New Version - ' + Prod_SNA_Person_Cluster_Version);
				OUTPUT(SNA_Person_Cluster_Prod_File,,'out::'+Prod_SNA_Person_Cluster[stringlib.stringfind(Prod_SNA_Person_Cluster, '::', 4) + 2..], overwrite, __Compressed__);
				fileservices.promotesuperfilelist(['~thordev_socialthor_50::out::sna::person_cluster_qa'], 'out::'+Prod_SNA_Person_Cluster[stringlib.stringfind(Prod_SNA_Person_Cluster, '::', 4) + 2..], true)
				),
			OUTPUT('SNA Person Cluster: Current Version - ' + Current_SNA_Person_Cluster_Version + ' is the same as New Version - ' + Prod_SNA_Person_Cluster_Version)
		);
				
	IF(SNA_Person_Cluster_Attr_Needed,
			SEQUENTIAL(
				OUTPUT('SNA Person Cluster Attributes: Current Version - ' + Current_SNA_Person_Cluster_Attr_Version + ' to New Version - ' + Prod_SNA_Person_Cluster_Attr_Version);
				OUTPUT(SNA_Person_Cluster_Attr_Prod_File,,'out::'+Prod_SNA_Person_Cluster_Attr[stringlib.stringfind(Prod_SNA_Person_Cluster_Attr, '::', 4) + 2..], overwrite, __Compressed__);
				fileservices.promotesuperfilelist(['~thordev_socialthor_50::out::sna::person_cluster_attributes_qa'], 'out::'+Prod_SNA_Person_Cluster_Attr[stringlib.stringfind(Prod_SNA_Person_Cluster_Attr, '::', 4) + 2..], true)
				),
			OUTPUT('SNA Person Cluster Attributes: Current Version - ' + Current_SNA_Person_Cluster_Attr_Version + ' is the same as New Version - ' + Prod_SNA_Person_Cluster_Attr_Version)
		)
		
	)
	/* uses separate launch script */
	// : WHEN(CRON('30 13 * * *')),
		// FAILURE(FileServices.SendEmail('cecelie.reid@lexisnexis.com, jo.prichard@lexisnexis.com', 
																	 // 'Failure - Restart WU ASAP - SNA Person Cluster and Business Contacts File Monitor', 
																	 // thorlib.wuid() + '\n\n' + FAILMESSAGE + '\n\nSNA THOR - http://10.239.227.24:8010/\n\nAlertList._BWR_Move_Files'));
;