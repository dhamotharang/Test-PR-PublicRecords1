Append Business GSA ReadMe
Version 1.0

===========================================================
                      Plugin Type
===========================================================
This is a COMPUTE plugin.

===========================================================
                      Plugin Description
===========================================================
This plugin returns 2 different output. 
A main output for which a flag is appended showing whether a business has sanction and a
field indicating which level of BIP (Prox or Sele) the sanction was found on and
a details output with GSA sanctions details as well as any columns from the input that 
the user wants in the details output. The details output is meant to be used with a graph 
to show details about an entity in the graph. As such it is normalized by entities.

This plugin first attempts to find matching records at the Prox level and if we can't 
find records at the Prox level, records at the Sele level are appended.

===========================================================
                    What to Input
===========================================================

The Prefix input will be appended to the front of the newly created fields for the main output

The dsInput is the input dataset.

All these columns need to be specified by the user from the input dataset:
	UltID
	OrgID
	SeleID
	ProxID
	Business Name Fields - The list of Ult, Sele and Prox level business name columns
	Business Address Fields - The list of Ult, Sele and Prox level business address columns
	Graph Id Fields - The list of Ult, Sele and Prox level entity context UID columns
	Append Fields - Any columns that should be in the details output layout

The following options are currently required regardless of the data not needing restrictions
	DPPA Purpose
	GLB Purpose
	Data Restriction Mask
These variables will typically be set as global variables and passed in through the whole composition 
and should be known beforehand.

===========================================================
                      Output
===========================================================

For the main output, dsOutput, this plugin appends the following columns
	HasGsa - an integer displaying 1 if the business has GSA.
    	BipLevel - Prox if we matched at the ProxID Level, Sele if we matched at the SeleID level and 
	blank if we didn't match

For the details output, dsDetails, this plugin returns the following columns.
This output is created for use in a graph
	Append Fields - any columns selected in the Append Fields input
	GsaName - the business with GSA sanctions name
	GsaClassification - Populated in GSA Business data 100%
	GsaCTType - Populated in GSA Business data 100%
	GsaDescription - Populated in GSA Business data 36%
	GsaActionDate - Populated in GSA Business data 99%
	GsaTermDate - Populated in GSA Business data 32%
	GsaTermDateIndefinite - Populated in GSA Business data 71%
	GsaCTCode - Populated in GSA Business data 67%
	GsaAgencyComponent - Populated in GSA Business data 99%
	GsaExclusionType - Populated in GSA Business data 100%
	GsaSamNumber - Populated in GSA Business data 100%
	GraphId - the entity context UID
	BusinessName - the entity business name
	BusinessAddress - the entity business address
	BusinessHasGsa - an indicator that the entity business has a GSA record
	BusinessHasGsaDescription - 'Y' if the business entity has a GSA record, 'N' otherwise

===========================================================
                      Side Effects
===========================================================
Hit Rate: Counts of how many records had a Gsa match either by Prox or by Sele, check these to make sure that 
it matches your expectation based on the input.
