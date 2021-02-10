'''
Created on Jan 25 2018

@author: zsuffern
Base Function to run the HackOMatic either through the User Interface or the Terminal. 
'''
import argparse
import re
import os
from collections import defaultdict
import sys
import imp 
import logging
import datetime

from io import StringIO

#Helper Hack Class
class Hack:
  def __init__(self,regex,id,replace,comment=''):
    self.regex = re.compile(regex,flags= (re.MULTILINE|re.DOTALL|re.UNICODE|re.LOCALE))
    self.id_re = re.compile(id,flags=(re.MULTILINE|re.DOTALL|re.UNICODE|re.LOCALE))
    self.id = id
    self.replace = replace
    self.comment = comment

class Hack_Report:
  def __init__(self,file,debug,partial):
    self.file = file
    self.appliedHacks = defaultdict(list)
    self.debug = debug
    self.partial = partial

  def hackStatus(self,hack,res):
    self.appliedHacks[res].append(hack)

  #Better way to improve the logic
  def genereateReport(self,saveFiles):
    msg = ""
    if saveFiles or (self.debug and not False in self.appliedHacks):
      msg = "Finalizing hacks to: " + self.file + ".ecl"
      if False in self.appliedHacks and self.partial:
        msg = msg + " but Hack-O-Matic could not apply the following Hacks: " + ",".join(self.appliedHacks[False])
      elif self.debug:
        msg = "Tried F" + msg[1:] + " but could not because of debug mode!"
    else:
      msg = "Hacks failed in " + self.file +".ecl because "
      if self.partial and not True in self.appliedHacks:
        msg = msg + "the Hack-O-Matic could not apply any hacks!"
      elif False in self.appliedHacks:
        msg = msg + "the Hack-O-Matic could not apply the following Hacks: " + ",".join(self.appliedHacks[False])
      elif None in self.appliedHacks:
        msg = msg + "Hacks have already been applied to this file"
      else:
        msg = msg + "a Hack failed in another file"
    return msg

def HackOMatic(folder_path,hack_path='',isRevert=False,isPartial=False,isOverwrite=False,isDebug=False,isVerbose=True):
  #Constants
  EXIT_STATEMENT = unicode("Hack-O-Matic Finished!")
  #Flag to check if we save files or not
  saveFiles = True
  HackReports = {}

  #Create Logger
  logger = logging.getLogger('HackOMaticLogger')
  logger.handlers = [] #Clear loggers in case of multiple runs
  
  fileLog = logging.FileHandler('HackOMaticLog.log')
  fileLog.setLevel(logging.DEBUG)
  sysLog = logging.StreamHandler(sys.stdout)

  viz = StringIO()
  vizLog = logging.StreamHandler(viz)
  if isDebug or isVerbose:
    sysLog.setLevel(logging.INFO)
    vizLog.setLevel(logging.INFO)
  else:
    sysLog.setLevel(logging.WARNING)
    vizLog.setLevel(logging.WARNING) 

  logger.addHandler(fileLog)
  logger.addHandler(sysLog)
  logger.addHandler(vizLog)
  logger.setLevel(logging.DEBUG)
  logger.debug(unicode("Date Run: " + str(datetime.datetime.now())))

  #Revert the hacks if flag is set
  if isRevert: 
    logger.warning(unicode("Reverting Hacks"))

    try:
      files = [file for file in os.listdir(folder_path) if file.endswith("_Orig.ecl")]
    except Exception, e:
      logger.error(unicode("Error in loading the Hacks: " + str(e)))
      logger.warning(EXIT_STATEMENT)
      return viz.getvalue()

    if not files:
      logger.error(unicode("No _Orig files to revert with"))
      logger.warning(EXIT_STATEMENT)
      return viz.getvalue()
    elif saveFiles:
      for file in files:
        logger.warning(unicode("Reverting " +  file[:-9] + '.ecl to original state'))
        filename = folder_path + "\\" + file 
        os.remove(filename[:-9]+ '.ecl')
        os.rename(filename,filename[:-9]+ '.ecl')
    logger.warning(EXIT_STATEMENT)
    return viz.getvalue()

  if isDebug:
    logger.warning(unicode("Debug mode active, will not apply hacks \n"))

  logger.warning(unicode("Applying hacks from " + hack_path + ' to ' + folder_path))

  #Load the hacks from the Hack File and get the files we will be editing
  files = defaultdict(list)
  try:
    Hacks = imp.load_source("Hacks",hack_path).getHacks
  except Exception, e:
    logger.error(unicode("Error in loading the Hacks: " + str(e)))
    logger.warning(EXIT_STATEMENT)

    return viz.getvalue()

  for h in Hacks:
    try:
      files[h[0]].append(Hack(h[1],h[2],h[3],h[4]))  
    except Exception, e:
      logger.error(unicode("Error with " + str(h[2]) + ": " + str(e)))
      saveFiles = False 


  #If errors in the hacks just stop the code
  if not saveFiles:
    logger.error(unicode("Errors with hacks, Hack-O-Matic is unable to continue. Please fix hacks before continuting."))
    logger.warning(EXIT_STATEMENT)
    return viz.getvalue()


  #Load each file from the Dir
  for file in files.keys():
    filename = folder_path + "\\" + file + ".ecl"

    try:
      text = open(filename,'r').read()
      logger.info(unicode("\nReading from file: " + filename))
      HackReports[file] = Hack_Report(file,partial=isPartial,debug=isDebug)


    except Exception, e:
      logger.error(unicode("Error with " + filename + ": " + str(e)))
      if not isPartial: 
        saveFiles = False 
      break

    #for each hack, run a regex replace
    for h in files[file]:
      #Check to see if we have already applied this hack or not
      if h.id_re.search(text) is None:
        #find where there is a match and replace the text 
        text,cnt = h.regex.subn(h.replace,text)
        #If we found a match and made a change
        if cnt > 0:
          logger.info(unicode("Applied Hack " + str(h.id) + " to " + file + ".ecl " + str(cnt) + " times"))
          HackReports[file].hackStatus(h.id,True)

        #If we did not find a match
        else:
          logger.info(unicode("Could not apply Hack " + str(h.id) + " to " + file + ".ecl"))
          HackReports[file].hackStatus(h.id,False)
          if not isPartial: 
            saveFiles = False 

      #we have applied this hack before so make a note of it and move on
      else:
        logger.info(unicode(str(h.id) + " has already been applied to " + file + ".ecl"))
        HackReports[file].hackStatus(h.id,None)
        if not isPartial: 
          saveFiles = False 
     
    #save the file to a temporary holding positon 
    open(filename[:-4]+ '_TempHacked.ecl','w').write(text)
   
  #Check to see if we are good for saving changes, else delete holding files
  logger.warning(unicode("\nUpdating Files"))
  files = [file for file in os.listdir(folder_path) if file.endswith("_TempHacked.ecl")]
  for file in files:
    filename = folder_path + "\\" + file 
    if saveFiles and not isDebug:
      #Check to see if we are overwriting the orig files or not and handle those edge cases
      if file[:-15]+ '_Orig.ecl' in os.listdir(folder_path) and isOverwrite:
        os.remove(filename[:-15]+ '_Orig.ecl')
      if file[:-15]+ '_Orig.ecl' not in os.listdir(folder_path) or isOverwrite:
        os.rename(filename[:-15]+ '.ecl',filename[:-15]+ '_Orig.ecl')     
      else:
        os.remove(filename[:-15]+ '.ecl')
      os.rename(filename,filename[:-15]+ '.ecl')
    elif not saveFiles or isDebug:
      os.remove(filename)
    logger.warning(unicode(HackReports[file[:-15]].genereateReport(saveFiles)))
      
  logger.warning(EXIT_STATEMENT)
  return viz.getvalue()
