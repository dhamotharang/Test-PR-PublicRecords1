# -*- coding: utf-8 -*-
"""
Created on Thu Aug  1 16:12:26 2019

@author: reddka01
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Jul 29 13:16:05 2019

@author: reddka01
"""

def Create_DataFrame(Attribute_Group, Attribute_Type, page_number):
    import requests
    import pandas as pd
    from pandas import DataFrame
     # Set the request parameters
    url = 'https://confluence.rsi.lexisnexis.com/rest/prototype/1/content/'+ page_number 
    user = 'reddka01@risk'
    pwd = 'Pioneer1&'
     
     # Set proper headers
    headers = {"Accept":"application/json"}
     
     # Do the HTTP request
    response = requests.get(url, auth=(user, pwd), headers=headers )
    #print(response.text)
    
    HTML_table=  response.json()['body']['value'] 
    
    p=pd.read_html(HTML_table)
    #print(p)
    
    df = DataFrame(p[0],columns=['Attribute Name','Attribute Description','Attribute Value','NextGenAttr','JIRA Ticket','Logic','Special Values','Output Values','Foundational Attribute','Prerequisite Attributes','Supporting Attributes','Search Key','Approved for FCRA','Development Layout','ECL Format','R Format','SAS Format','Drop Group','Monotonicity','Modeling Purpose','Predecessor Attribute Name','Predecessor Attribute Source','Priority','Risk'])
    export_csv = df.to_csv("C:\\Users\\reddka01\\Desktop\\Kel_Shell\\Rules\\" + Attribute_Type + '_' + Attribute_Group + '.csv', index = True, header=True) 
    #Don't forget to add '.csv' at the end of the path
    
    print (export_csv)
    df2=pd.read_csv("C:\\Users\\reddka01\\Desktop\\Kel_Shell\\Rules\\" + Attribute_Type + '_' + Attribute_Group + '.csv')
    
    print (df2)

    from pyhpcc.authentication import auth
    from pyhpcc.api import hpcc
    
    #import os
    import json
    import sys
    import logging
    logging.basicConfig(level=logging.INFO)
    logging.basicConfig(format='%(asctime)s %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p' , stream=sys.stdout)
    
    #username       = os.environ['HPCCUSER']
    #password       = os.environ['HPCCPASS']
    auth1          = auth('10.173.14.204', '8010', 'kreddy','Pioneer2',require_auth = True )
    
    
    fourway = hpcc(auth= auth1, timeout= 1200, response_type= '.json')
    
    filename = r'C:\\Users\\reddka01\\Desktop\\Kel_Shell\\Rules\\' + Attribute_Type + '_' + Attribute_Group + '.csv'
    
    files=  {'file': ('KEL_SHELL_QA_Confluence_'+Attribute_Type + '_' + Attribute_Group + '.csv', open(filename, 'rb'), 'application/vnd.ms-excel', {'Expires': '0'})}
    #landing zone ip address
    ip_address = '10.140.128.250'
    payload = {'upload_' : '' , 
               'rawxml_' : 1 , 
               'NetAddress': ip_address,
               'OS':2, 
               'Path': '''/data/''', 'files':files  }
    
    resp = fourway.UploadFile(**payload)
    print(resp.json())
    
    srcIPAddr='10.140.128.250'
    srcPathNam= '/data/'+ 'KEL_SHELL_QA_Confluence_'+Attribute_Type + '_' + Attribute_Group + '.csv'
    srcxml= ''
    maxRecordSize=8192
    formatSource='1'
    omitSeparator='\\,'
    srcCsvSeparator='\\,'
    srcCsvTerminator='\\n,\\r\\n'
    srcCsvQuote= '\"'
    srcCsvEscape=''
    srcRowTag=''
    destCluster='thor50_dev01'
    destFileName='kel_shell::in::' + 'KEL_SHELL_QA_Confluence_'+Attribute_Type + '_' + Attribute_Group +'_sprayed'
    overwrite='1'
    replicate='FALSE'
    maxConnections='1'
    noSplit=''
    compress='TRUE'
    failIfNoSrcFile= ''
    recordStrucPresent=''
    quotedTerminator=''
    srcRowPath=''
   
    resp =  fourway.sprayVariable( sourceIP = srcIPAddr,
                                   sourcePath = srcPathNam,
                                   srcxml = srcxml,
                                   sourceMaxRecordSize = maxRecordSize,
                                   sourceFormat = formatSource,
                                   NoSourceCsvSeparator = omitSeparator,
                                   sourceCsvSeparate = srcCsvSeparator,
                                   sourceCsvTerminate = srcCsvTerminator,
                                   sourceCsvQuote = srcCsvQuote,
                                   sourceCsvEscape = srcCsvEscape,
                                   sourceRowTag = srcRowTag,
                                   destGroup = destCluster,
                                   destLogicalName = destFileName,
                                   overwrite = overwrite,
                                   replicate = replicate,
                                   ReplicateOffset = '',
                                   maxConnections = maxConnections,
                                   throttle = '',
                                   transferBufferSize = '',
                                   prefix = '',
                                   nosplit = noSplit,
                                   noRecover = '',
                                   compress = compress,
                                   push = '',
                                   pull = '',
                                   encrypt = '',
                                   decrypt = '',
                                   failIfNoSourceFile = failIfNoSrcFile,
                                   recordStructurePresent = recordStrucPresent,
                                   quotedTerminator = quotedTerminator,
                                   sourceRowPath = srcRowPath,
                                   isJSON = '')

    resp = json.loads(resp.text)
    wuid_result = resp['SprayResponse']['wuid']
    print('\n' + '-' * 10)
    print('DFU WU ' + wuid_result + ' has been created.' )
    
    
    #fileSpray_variable(platform, srcIP, srcPath, destinationCluster, destinationName)
    
    # initialize list of lists 
import pandas as pd     
data_sheets =[
               ["Person","Professional License","50411612"],
               ["Person","Best PII","67266323"],
               ["Business","Assets","67266367"],
               ["Person","assets","50412528"],
               ["Person","Derogs -Bankruptcy History","46731237"],
               ["Person","Derogs -Criminal History","47613720"],
               ["Business","Business B2B Trade","67269494"],
               ["Business","Business LexID","53381983"],
               ["Business","Business Input Validation","67266393"],
               ["Person","Validation","52299221"]
              ] 
  
# Create the pandas DataFrame 
df = pd.DataFrame(data_sheets, columns = ['page_number','Attribute_Type', 'Attribute_Group']) 
#print(df)

for i in range(len(df)):
   #print(df.loc[i, "page_number"], df.loc[i, "Attribute_Type"], df.loc[i, "Attribute_Group"]) 
   Create_DataFrame(df.loc[i, "page_number"], df.loc[i, "Attribute_Type"], df.loc[i, "Attribute_Group"])
	



