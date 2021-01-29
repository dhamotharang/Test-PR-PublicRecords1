'''
Created on Jan 28 2019

@author: zsuffern

User Interface to allow easier access to run the HackOMatic
'''

from kivy.app import App
from kivy.lang import Builder
from kivy.uix.button import Button
from kivy.config import Config
from kivy.uix.floatlayout import FloatLayout
from kivy.uix.popup import Popup
from kivy.properties import ObjectProperty
from kivy.uix.gridlayout import GridLayout
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.checkbox import CheckBox
from kivy.uix.scrollview import ScrollView


from os import listdir 
from os import path as os_path

import Base_HackOMatic
import sys

kv_path = './kv/'
for kv in listdir(kv_path):
    Builder.load_file(kv_path+kv)

Config.set('input', 'mouse', 'mouse,multitouch_on_demand')
global help_dict 

help_dict = {   'Overwrite': "Allows for you to overwrite any _ORIG files if they exist"
                ,'Partial': "Normal behavior is if any hack fails, the entire process fails. This allows for those hacks that went through to be applied." 
                ,'Debug': "Debug mode, will show you what hacks worked or didn\'t work, but won\'t actually save the files."
                ,'Revert': "This option will revert hacks and reinstate your original code if _ORIG files exist. Does not require you to specify a hack file."
            } 

class LoadDialog(FloatLayout):
    load = ObjectProperty(None)
    cancel = ObjectProperty(None)

class InfoDialog(FloatLayout):
    cancel = ObjectProperty(None)

class Container(GridLayout):
    display = ObjectProperty()
    def on_start(self):
        pass

    def dismiss_popup(self):
        self._popup.dismiss()

    def show_load(self,text_id):
        content = LoadDialog(load=self.load, cancel=self.dismiss_popup)
        self._popup = Popup(title="Load file", content=content,
                            size_hint=(0.9, 0.9))
        self._id_popup = text_id #Tells code which box to put file in so I can reuse this code
        self._load_files = text_id == "hack_text"
        self._popup.open()
    
    def show_info(self,key):
        content = InfoDialog(cancel=self.dismiss_popup)
        content.ids['info'].text = help_dict[key]
        self._popup = Popup(title="Help", content=content,
                            size_hint=(0.40, 0.40))
        self._popup.open()

    def load(self, path, filename):
        try:
            self.ids[self._id_popup].text = unicode(os_path.join(path,filename[0]))
            if self._load_files:
                self.ids['folder_text'].text = path
        except:
            self.ids['out_screen'].text = 'Error in loading data'
        self.dismiss_popup()

    def run_Hack_O_Matic(self):
        self.ids['out_screen'].text =  Base_HackOMatic.HackOMatic(self.ids['folder_text'].text,self.ids['hack_text'].text ,self.ids['revert_opt'].active,self.ids['partial_opt'].active,self.ids['overwrite_opt'].active,self.ids['debug_opt'].active,True)

class HackOMaticApp(App):

    def build(self):
        self.title = 'Hack-O-Matic'
        return Container()


if __name__ == "__main__":
    app = HackOMaticApp()
    app.run()